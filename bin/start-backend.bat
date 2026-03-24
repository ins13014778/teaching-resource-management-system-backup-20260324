@echo off
setlocal

call "%~dp0env.cmd"

set "JAR_FILE=%ROOT_DIR%\ruoyi-admin\target\ruoyi-admin.jar"

echo.
echo [INFO] Prepare to start backend...

for /f %%I in ('powershell -NoProfile -Command "$p=Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue; if($p){1}else{0}"') do set "BACKEND_RUNNING=%%I"
if "%BACKEND_RUNNING%"=="1" (
  echo [INFO] Port 8080 is already in use. Backend may already be running.
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
  echo [DRY RUN] start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%"" ^&^& call ""%MVN_CMD%"" -T 1C -DskipTests package ^&^& cd /d ""%ROOT_DIR%\ruoyi-admin\target"" ^&^& ""%JAVA_CMD%"" -jar ruoyi-admin.jar"
  exit /b 0
)

start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%"" && call ""%MVN_CMD%"" -T 1C -DskipTests package && cd /d ""%ROOT_DIR%\ruoyi-admin\target"" && ""%JAVA_CMD%"" -jar ruoyi-admin.jar"
echo [SUCCESS] Backend start command executed.
exit /b 0

:run_jar
if "%DRY_RUN%"=="1" (
  echo [DRY RUN] start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%\ruoyi-admin\target"" ^&^& ""%JAVA_CMD%"" -jar ruoyi-admin.jar"
  exit /b 0
)

start "TRMS-Backend" cmd /k "cd /d ""%ROOT_DIR%\ruoyi-admin\target"" && ""%JAVA_CMD%"" -jar ruoyi-admin.jar"
echo [SUCCESS] Backend start command executed.
exit /b 0
