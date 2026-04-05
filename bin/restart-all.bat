@echo off
setlocal

set "LOG_DIR=%~dp0..\logs"

echo.
echo ==========================================
echo   Teaching Resource Management System
echo   Restart All Services
echo ==========================================
echo.

call "%~dp0stop-all.bat"
if errorlevel 1 (
  echo [ERROR] Failed while stopping services.
  exit /b 1
)

echo [INFO] Cleaning runtime log files...
if exist "%LOG_DIR%" (
  del /q "%LOG_DIR%\backend*.out.log" >nul 2>nul
  del /q "%LOG_DIR%\backend*.err.log" >nul 2>nul
  del /q "%LOG_DIR%\frontend*.out.log" >nul 2>nul
  del /q "%LOG_DIR%\frontend*.err.log" >nul 2>nul
  del /q "%LOG_DIR%\redis.out.log" >nul 2>nul
  del /q "%LOG_DIR%\redis.err.log" >nul 2>nul
)

echo [INFO] Starting all services...
call "%~dp0start-all.bat"
if errorlevel 1 (
  echo [ERROR] Failed while starting services.
  exit /b 1
)

echo.
echo [SUCCESS] Restart completed.
echo [INFO] Frontend URL: http://127.0.0.1/
echo [INFO] Backend URL : http://127.0.0.1:8080/swagger-ui.html
echo.
exit /b 0
