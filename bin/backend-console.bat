@echo off
setlocal

call "%~dp0env.cmd"

set "JAVA_OPTS=-Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8"
set "JAR_FILE=%ROOT_DIR%\ruoyi-admin\target\ruoyi-admin.jar"
set "MODE=%~1"

if not defined JAVA_CMD (
  echo [ERROR] java.exe not found. Please install Java or update bin\env.cmd
  exit /b 1
)

if /I "%MODE%"=="build-and-run" (
  if not defined MVN_CMD (
    echo [ERROR] mvn.cmd not found. Please install Maven or update bin\env.cmd
    exit /b 1
  )
  echo [INFO] Building backend package...
  cd /d "%ROOT_DIR%"
  call "%MVN_CMD%" -T 1C -DskipTests package
  if errorlevel 1 (
    echo [ERROR] Backend package build failed.
    exit /b 1
  )
)

if not exist "%JAR_FILE%" (
  echo [ERROR] Backend jar not found: %JAR_FILE%
  exit /b 1
)

cd /d "%ROOT_DIR%\ruoyi-admin\target"
echo [INFO] Starting backend from %CD%
"%JAVA_CMD%" %JAVA_OPTS% -jar ruoyi-admin.jar
set "EXIT_CODE=%ERRORLEVEL%"

echo.
echo [ERROR] Backend process exited with code %EXIT_CODE%.
exit /b %EXIT_CODE%
