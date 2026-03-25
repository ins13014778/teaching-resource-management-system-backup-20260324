@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

set "JAR_FILE=%ROOT_DIR%\ruoyi-admin\target\ruoyi-admin.jar"
set "JAVA_OPTS=-Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8"

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

if /I "%REBUILD%"=="1" goto build_and_run
if exist "%JAR_FILE%" goto run_jar

:build_and_run
if not defined MVN_CMD (
  echo [ERROR] mvn.cmd not found and no runnable jar exists.
  echo [HINT] Install Maven or build ruoyi-admin\target\ruoyi-admin.jar first.
  exit /b 1
)

if "%DRY_RUN%"=="1" (
  echo [DRY RUN] start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%"" ^&^& call ""%MVN_CMD%"" -T 1C -DskipTests package ^&^& cd /d ""%ROOT_DIR%\ruoyi-admin\target"" ^&^& ""%JAVA_CMD%"" %JAVA_OPTS% -jar ruoyi-admin.jar"
  exit /b 0
)

start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%"" && call ""%MVN_CMD%"" -T 1C -DskipTests package && cd /d ""%ROOT_DIR%\ruoyi-admin\target"" && ""%JAVA_CMD%"" %JAVA_OPTS% -jar ruoyi-admin.jar"
echo [SUCCESS] Backend start command executed.
exit /b 0

:run_jar
if "%DRY_RUN%"=="1" (
  echo [DRY RUN] start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%\ruoyi-admin\target"" ^&^& ""%JAVA_CMD%"" %JAVA_OPTS% -jar ruoyi-admin.jar"
  exit /b 0
)

start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%\ruoyi-admin\target"" && ""%JAVA_CMD%"" %JAVA_OPTS% -jar ruoyi-admin.jar"
echo [SUCCESS] Backend start command executed.
exit /b 0
