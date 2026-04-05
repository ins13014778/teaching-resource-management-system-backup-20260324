@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

set "JAR_FILE=%ROOT_DIR%\ruoyi-admin\target\ruoyi-admin.jar"

echo.
echo [INFO] Prepare to start backend...

for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$proc = Get-CimInstance Win32_Process | Where-Object { ($_.Name -in 'java.exe','javaw.exe') -and $_.CommandLine -match 'ruoyi-admin\.jar' } | Select-Object -First 1; if($proc){ 'RUNNING:' + $proc.ProcessId } else { 'FREE' }"`) do set "BACKEND_PROCESS_STATUS=%%I"
if /I "!BACKEND_PROCESS_STATUS:~0,8!"=="RUNNING:" (
  echo [INFO] Backend is already running with PID !BACKEND_PROCESS_STATUS:~8!.
  exit /b 0
)

for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "$listener = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1; if(-not $listener){ 'FREE' } else { $proc = Get-CimInstance Win32_Process -Filter ('ProcessId=' + $listener.OwningProcess); $name = if($proc){ $proc.Name } else { 'unknown' }; $cmd = if($proc){ $proc.CommandLine } else { '' }; if($cmd -match 'ruoyi-admin\.jar'){ 'RUNNING:' + $listener.OwningProcess } else { 'OCCUPIED:' + $listener.OwningProcess + ':' + $name } }"`) do set "BACKEND_PORT_STATUS=%%I"
if /I "!BACKEND_PORT_STATUS:~0,9!"=="OCCUPIED:" (
  echo [ERROR] Port 8080 is occupied by another process: !BACKEND_PORT_STATUS:~9!
  exit /b 1
)
if /I "!BACKEND_PORT_STATUS:~0,8!"=="RUNNING:" (
  echo [INFO] Backend is already listening on 8080 with PID !BACKEND_PORT_STATUS:~8!.
  exit /b 0
)

if not defined JAVA_CMD (
  echo [ERROR] java.exe not found. Please install Java or update bin\env.cmd
  exit /b 1
)

set "BACKEND_MODE=run"
if /I "%REBUILD%"=="1" set "BACKEND_MODE=build-and-run"
if not exist "%JAR_FILE%" set "BACKEND_MODE=build-and-run"

if /I "%BACKEND_MODE%"=="build-and-run" if not defined MVN_CMD (
  echo [ERROR] mvn.cmd not found and no runnable jar exists.
  echo [HINT] Install Maven or build ruoyi-admin\target\ruoyi-admin.jar first.
  exit /b 1
)

if "%DRY_RUN%"=="1" (
  echo [DRY RUN] start "TRMS-Backend" "%COMSPEC%" /k call "%~dp0backend-console.bat" %BACKEND_MODE%
  exit /b 0
)

start "TRMS-Backend" "%COMSPEC%" /k call "%~dp0backend-console.bat" %BACKEND_MODE%
echo [INFO] Waiting for backend to listen on port 8080...

set "BACKEND_STARTED="
for /l %%I in (1,1,180) do (
  for /f "usebackq delims=" %%J in (`powershell -NoProfile -Command "$listener = Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1; if($listener){ 'LISTEN:' + $listener.OwningProcess } else { 'WAIT' }"`) do set "BACKEND_LISTEN_STATUS=%%J"
  if /I "!BACKEND_LISTEN_STATUS:~0,7!"=="LISTEN:" (
    set "BACKEND_STARTED=1"
    set "BACKEND_PID=!BACKEND_LISTEN_STATUS:~7!"
    goto backend_ready
  )
  timeout /t 1 /nobreak >nul
)

echo [ERROR] Backend failed to listen on port 8080 within 180 seconds. Please check the new TRMS-Backend window output.
exit /b 1

:backend_ready
echo [SUCCESS] Backend is listening on port 8080 with PID !BACKEND_PID!.
exit /b 0
