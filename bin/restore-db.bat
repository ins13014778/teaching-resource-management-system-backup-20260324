@echo off
setlocal

call "%~dp0env.cmd"

if not "%~1"=="" set "DB_NAME=%~1"
if not "%~2"=="" set "DB_SQL_FILE=%~2"
set "TMP_SQL_FILE=%TEMP%\%DB_NAME%-restore-%RANDOM%%RANDOM%.sql"

echo.
echo [INFO] Start restoring database...
echo [INFO] Database : %DB_NAME%
echo [INFO] SQL File : %DB_SQL_FILE%
echo.

if not defined MYSQL_EXE (
  echo [ERROR] mysql.exe not found. Please check MySQL installation or update bin\env.cmd
  exit /b 1
)

if not exist "%DB_SQL_FILE%" (
  echo [ERROR] SQL backup file not found: %DB_SQL_FILE%
  exit /b 1
)

echo [INFO] MySQL client: %MYSQL_EXE%
echo [INFO] Creating database if not exists...
"%MYSQL_EXE%" -h%DB_HOST% -P%DB_PORT% %MYSQL_AUTH_ARGS% -e "CREATE DATABASE IF NOT EXISTS `%DB_NAME%` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
if errorlevel 1 (
  echo [ERROR] Failed to create database. Check MySQL service, account, password, or port.
  exit /b 1
)

echo [INFO] Converting SQL file to UTF-8 temp file...
powershell -NoProfile -Command "$src='%DB_SQL_FILE%'; $dst='%TMP_SQL_FILE%'; $content = Get-Content -LiteralPath $src -Raw; $enc = New-Object System.Text.UTF8Encoding($false); [System.IO.File]::WriteAllText($dst, $content, $enc)"
if errorlevel 1 (
  echo [ERROR] Failed to convert SQL file encoding.
  exit /b 1
)

echo [INFO] Importing SQL, please wait...
"%MYSQL_EXE%" --binary-mode=1 --default-character-set=utf8mb4 -h%DB_HOST% -P%DB_PORT% %MYSQL_AUTH_ARGS% --database=%DB_NAME% < "%TMP_SQL_FILE%"
if errorlevel 1 (
  del /q "%TMP_SQL_FILE%" >nul 2>nul
  echo [ERROR] Import failed. Check SQL file, database privilege, or connection config.
  exit /b 1
)

del /q "%TMP_SQL_FILE%" >nul 2>nul

echo.
echo [SUCCESS] Database restore completed.
echo [SUCCESS] Target DB: %DB_NAME%
echo.
exit /b 0
