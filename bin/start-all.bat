@echo off
setlocal

echo.
echo ==========================================
echo   Teaching Resource Management System
echo   One-click Startup
echo ==========================================
echo.

call "%~dp0start-redis.bat"
if errorlevel 1 (
  echo [ERROR] Redis start failed.
  exit /b 1
)

timeout /t 2 /nobreak >nul

call "%~dp0start-backend.bat"
if errorlevel 1 (
  echo [ERROR] Backend start failed.
  exit /b 1
)

timeout /t 3 /nobreak >nul

call "%~dp0start-frontend.bat"
if errorlevel 1 (
  echo [ERROR] Frontend start failed.
  exit /b 1
)

echo.
echo [SUCCESS] Redis, backend, and frontend start commands have all been executed.
echo [INFO] Frontend URL: http://127.0.0.1/
echo [INFO] Backend URL : http://127.0.0.1:8080/
echo.
exit /b 0
