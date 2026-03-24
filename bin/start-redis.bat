@echo off
setlocal

call "%~dp0env.cmd"

echo.
echo [INFO] Prepare to start Redis...

if exist "%REDIS_CLI_EXE%" (
  for /f "delims=" %%I in ('"%REDIS_CLI_EXE%" -h 127.0.0.1 -p 6379 ping 2^>nul') do set "REDIS_PING=%%I"
  if /I "%REDIS_PING%"=="PONG" (
    echo [INFO] Redis is already running.
    exit /b 0
  )
)

if not defined REDIS_SERVER_EXE (
  echo [ERROR] redis-server.exe not found. Please update bin\env.cmd
  exit /b 1
)

if "%DRY_RUN%"=="1" (
  if defined REDIS_CONF (
    echo [DRY RUN] start "TRMS-Redis" cmd /k ""%REDIS_SERVER_EXE%" "%REDIS_CONF%""
  ) else (
    echo [DRY RUN] start "TRMS-Redis" cmd /k ""%REDIS_SERVER_EXE%""
  )
  exit /b 0
)

if defined REDIS_CONF (
  start "TRMS-Redis" cmd /k ""%REDIS_SERVER_EXE%" "%REDIS_CONF%""
) else (
  start "TRMS-Redis" cmd /k ""%REDIS_SERVER_EXE%""
)

echo [SUCCESS] Redis start command executed.
exit /b 0
