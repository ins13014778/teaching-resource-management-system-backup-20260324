@echo off
setlocal

if not "%~1"=="" (
  set "INIT_DB_NAME=%~1"
) else (
  set "INIT_DB_NAME=ry-vue"
)

if not "%~2"=="" (
  set "INIT_DB_SQL_FILE=%~2"
) else (
  set "INIT_DB_SQL_FILE=backup\2026-03-26\database\ry-vue-full-20260326.sql"
)

echo.
echo ==========================================
echo   Teaching Resource Management System
echo   Full Initialization and Startup
echo ==========================================
echo.
echo [INFO] Database : %INIT_DB_NAME%
echo [INFO] SQL File : %INIT_DB_SQL_FILE%
echo.

call "%~dp0init-db.bat" "%INIT_DB_NAME%" "%INIT_DB_SQL_FILE%"
if errorlevel 1 (
  echo [ERROR] Database initialization failed.
  exit /b 1
)

call "%~dp0start-all.bat"
if errorlevel 1 (
  echo [ERROR] Service startup failed.
  exit /b 1
)

echo.
echo [SUCCESS] Full initialization and startup completed.
echo [INFO] Frontend URL: http://127.0.0.1/
echo [INFO] Backend URL : http://127.0.0.1:8080/swagger-ui.html
echo.
exit /b 0
