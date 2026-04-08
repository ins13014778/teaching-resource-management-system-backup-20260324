@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

set "DRY_RUN=0"
if /I "%~1"=="--dry-run" (
  set "DRY_RUN=1"
  shift
)

set "TARGET_DIR=%~1"
if not defined TARGET_DIR (
  set /p TARGET_DIR=请输入目标目录: 
)

if not defined TARGET_DIR (
  echo [错误] 目标目录不能为空。
  exit /b 1
)

if not defined GIT_CMD (
  echo [错误] 未找到 git.exe，请先安装 Git。
  exit /b 1
)

echo.
echo [信息] 仓库地址 : %REPO_URL%
echo [信息] 分支名称 : %REPO_BRANCH%
echo [信息] 目标目录 : %TARGET_DIR%

if exist "%TARGET_DIR%\.git" (
  if "%DRY_RUN%"=="1" (
    echo [DRY RUN] git -C "%TARGET_DIR%" fetch origin
    echo [DRY RUN] git -C "%TARGET_DIR%" pull --ff-only origin "%REPO_BRANCH%"
    exit /b 0
  )

  call "%GIT_CMD%" -C "%TARGET_DIR%" fetch origin
  if errorlevel 1 exit /b 1

  call "%GIT_CMD%" -C "%TARGET_DIR%" pull --ff-only origin "%REPO_BRANCH%"
  exit /b %ERRORLEVEL%
)

if exist "%TARGET_DIR%" (
  set "DIR_COUNT="
  for /f %%I in ('dir /a /b "%TARGET_DIR%" 2^>nul ^| find /c /v ""') do set "DIR_COUNT=%%I"
  if defined DIR_COUNT if not "!DIR_COUNT!"=="0" (
    echo [错误] 目标目录已存在且非空: %TARGET_DIR%
    exit /b 1
  )
)

if "%DRY_RUN%"=="1" (
  echo [DRY RUN] git clone --branch "%REPO_BRANCH%" "%REPO_URL%" "%TARGET_DIR%"
  exit /b 0
)

call "%GIT_CMD%" clone --branch "%REPO_BRANCH%" "%REPO_URL%" "%TARGET_DIR%"
exit /b %ERRORLEVEL%
