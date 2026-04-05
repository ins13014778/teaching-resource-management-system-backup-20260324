@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

if not "%~1"=="" set "DB_NAME=%~1"
if not "%~2"=="" set "DB_SQL_FILE=%~2"

echo.
echo ==========================================
echo   Teaching Resource Management System
echo   Database Initialization
echo ==========================================
echo.
echo [INFO] Target database : %DB_NAME%
echo [INFO] SQL file        : %DB_SQL_FILE%
echo.

if not defined MYSQL_EXE (
  echo [ERROR] mysql.exe not found. Please check MySQL installation or update bin\env.cmd
  exit /b 1
)

if not exist "%DB_SQL_FILE%" (
  echo [ERROR] SQL backup file not found: %DB_SQL_FILE%
  exit /b 1
)

set "MYSQL_SERVICE_NAME="
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$svc = Get-Service | Where-Object { $_.Name -match 'mysql|mysqld' -or $_.DisplayName -match 'MySQL' } | Select-Object -First 1 -ExpandProperty Name; if($svc){ $svc }"`) do set "MYSQL_SERVICE_NAME=%%I"

if defined MYSQL_SERVICE_NAME (
  for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$svc = Get-Service -Name '%MYSQL_SERVICE_NAME%' -ErrorAction SilentlyContinue; if($svc){ $svc.Status }"`) do set "MYSQL_SERVICE_STATUS=%%I"
  if /I not "!MYSQL_SERVICE_STATUS!"=="Running" (
    echo [INFO] Starting MySQL service: %MYSQL_SERVICE_NAME%
    powershell -NoProfile -Command "Start-Service -Name '%MYSQL_SERVICE_NAME%'"
    if errorlevel 1 (
      echo [ERROR] Failed to start MySQL service: %MYSQL_SERVICE_NAME%
      exit /b 1
    )
    timeout /t 3 /nobreak >nul
  ) else (
    echo [INFO] MySQL service is already running: %MYSQL_SERVICE_NAME%
  )
) else (
  echo [WARN] No MySQL Windows service found. Will try to connect directly.
)

echo [INFO] Checking MySQL connectivity...
"%MYSQL_EXE%" -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASS% -e "SELECT 1;" >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Unable to connect to MySQL at %DB_HOST%:%DB_PORT%.
  echo [HINT] Check MySQL service, host, port, username, and password in bin\env.cmd
  exit /b 1
)

call "%~dp0restore-db.bat" "%DB_NAME%" "%DB_SQL_FILE%"
if errorlevel 1 (
  echo [ERROR] Database restore failed.
  exit /b 1
)

echo [INFO] Verifying imported tables...
set "TABLE_LIST_FILE=%TEMP%\%DB_NAME%-tables-%RANDOM%%RANDOM%.txt"
set "SYS_USER_FILE=%TEMP%\%DB_NAME%-sys-user-%RANDOM%%RANDOM%.txt"

"%MYSQL_EXE%" --batch --skip-column-names -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASS% -D %DB_NAME% -e "SHOW TABLES;" > "%TABLE_LIST_FILE%" 2>nul
if errorlevel 1 (
  del /q "%TABLE_LIST_FILE%" >nul 2>nul
  del /q "%SYS_USER_FILE%" >nul 2>nul
  echo [ERROR] Failed to query tables from database %DB_NAME%.
  exit /b 1
)

for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "(Get-Content -LiteralPath '%TABLE_LIST_FILE%' | Where-Object { $_.Trim().Length -gt 0 }).Count"`) do set "TABLE_COUNT=%%I"
if not defined TABLE_COUNT set "TABLE_COUNT=0"
if "!TABLE_COUNT!"=="0" (
  del /q "%TABLE_LIST_FILE%" >nul 2>nul
  del /q "%SYS_USER_FILE%" >nul 2>nul
  echo [ERROR] No tables found in database %DB_NAME%.
  exit /b 1
)

"%MYSQL_EXE%" --batch --skip-column-names -h%DB_HOST% -P%DB_PORT% -u%DB_USER% -p%DB_PASS% -D %DB_NAME% -e "SELECT COUNT(*) FROM sys_user;" > "%SYS_USER_FILE%" 2>nul
if not errorlevel 1 (
  set /p SYS_USER_COUNT=<"%SYS_USER_FILE%"
)

del /q "%TABLE_LIST_FILE%" >nul 2>nul
del /q "%SYS_USER_FILE%" >nul 2>nul

echo.
echo [SUCCESS] Database initialization completed.
echo [SUCCESS] Database   : %DB_NAME%
echo [SUCCESS] Table count: !TABLE_COUNT!
if defined SYS_USER_COUNT (
  echo [SUCCESS] sys_user rows: !SYS_USER_COUNT!
) else (
  echo [WARN] Could not query %DB_NAME%.sys_user. Please verify manually.
)
echo.
exit /b 0
