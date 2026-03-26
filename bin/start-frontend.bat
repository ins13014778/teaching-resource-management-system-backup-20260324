@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

set "FRONTEND_PORT=80"

echo.
echo [INFO] Prepare to start frontend...

if not defined NPM_CMD (
  echo [ERROR] npm.cmd not found. Please install Node.js/npm or update bin\env.cmd
  exit /b 1
)

if not exist "%ROOT_DIR%\ruoyi-ui\package.json" (
  echo [ERROR] Frontend project not found: %ROOT_DIR%\ruoyi-ui
  exit /b 1
)

for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$root = [regex]::Escape('%ROOT_DIR%'); $listener = Get-NetTCPConnection -LocalPort %FRONTEND_PORT% -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1; if(-not $listener){ 'FREE' } else { $proc = Get-CimInstance Win32_Process -Filter ('ProcessId=' + $listener.OwningProcess) -ErrorAction SilentlyContinue; $name = if($proc){ $proc.Name } else { 'unknown' }; $cmd = if($proc){ [string]$proc.CommandLine } else { '' }; if($cmd -match $root -or $cmd -match 'vue-cli-service' -or $cmd -match 'npm(.cmd)? run dev'){ 'RUNNING:' + $listener.OwningProcess } else { 'OCCUPIED:' + $listener.OwningProcess + ':' + $name } }"`) do set "FRONTEND_PORT_STATUS=%%I"
if /I "!FRONTEND_PORT_STATUS:~0,8!"=="RUNNING:" (
  echo [INFO] Frontend is already listening on port %FRONTEND_PORT% with PID !FRONTEND_PORT_STATUS:~8!.
  exit /b 0
)
if /I "!FRONTEND_PORT_STATUS:~0,9!"=="OCCUPIED:" (
  echo [ERROR] Port %FRONTEND_PORT% is occupied by another process: !FRONTEND_PORT_STATUS:~9!
  exit /b 1
)

if exist "%ROOT_DIR%\ruoyi-ui\node_modules" (
  set "FRONTEND_CMD=cd /d ""%ROOT_DIR%\ruoyi-ui"" && call ""%NPM_CMD%"" run dev"
) else (
  set "FRONTEND_CMD=cd /d ""%ROOT_DIR%\ruoyi-ui"" && call ""%NPM_CMD%"" install && call ""%NPM_CMD%"" run dev"
)

if "%DRY_RUN%"=="1" (
  echo [DRY RUN] start "TRMS-Frontend" cmd /k "%FRONTEND_CMD%"
  exit /b 0
)

start "TRMS-Frontend" cmd /k "%FRONTEND_CMD%"
echo [INFO] Waiting for frontend to listen on port %FRONTEND_PORT%...

set "FRONTEND_STARTED="
for /l %%I in (1,1,180) do (
  for /f "usebackq delims=" %%J in (`powershell -NoProfile -Command "$listener = Get-NetTCPConnection -LocalPort %FRONTEND_PORT% -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1; if($listener){ 'LISTEN:' + $listener.OwningProcess } else { 'WAIT' }"`) do set "FRONTEND_LISTEN_STATUS=%%J"
  if /I "!FRONTEND_LISTEN_STATUS:~0,7!"=="LISTEN:" (
    set "FRONTEND_STARTED=1"
    set "FRONTEND_PID=!FRONTEND_LISTEN_STATUS:~7!"
    goto frontend_ready
  )
  timeout /t 1 /nobreak >nul
)

echo [ERROR] Frontend failed to listen on port %FRONTEND_PORT% within 180 seconds. Please check the new TRMS-Frontend window output.
exit /b 1

:frontend_ready
echo [SUCCESS] Frontend is listening on port %FRONTEND_PORT% with PID !FRONTEND_PID!.
exit /b 0
