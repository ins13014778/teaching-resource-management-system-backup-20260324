@echo off
setlocal

call "%~dp0env.cmd"

if not defined NPM_CMD (
  echo [ERROR] npm.cmd not found. Please install Node.js/npm or update bin\env.cmd
  exit /b 1
)

if not exist "%ROOT_DIR%\ruoyi-ui\package.json" (
  echo [ERROR] Frontend project not found: %ROOT_DIR%\ruoyi-ui
  exit /b 1
)

cd /d "%ROOT_DIR%\ruoyi-ui"

if not exist "%ROOT_DIR%\ruoyi-ui\node_modules" (
  echo [INFO] node_modules not found, installing dependencies...
  call "%NPM_CMD%" install
  if errorlevel 1 (
    echo [ERROR] npm install failed.
    exit /b 1
  )
)

echo [INFO] Starting frontend from %CD%
call "%NPM_CMD%" run dev
set "EXIT_CODE=%ERRORLEVEL%"

echo.
echo [ERROR] Frontend process exited with code %EXIT_CODE%.
exit /b %EXIT_CODE%
