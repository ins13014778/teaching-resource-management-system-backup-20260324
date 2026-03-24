@echo off
setlocal

call "%~dp0env.cmd"

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
echo [SUCCESS] Frontend start command executed.
exit /b 0
