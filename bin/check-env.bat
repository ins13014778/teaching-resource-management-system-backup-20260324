@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

set /a MISSING_COUNT=0

echo.
echo ==========================================
echo   Windows 环境检测
echo ==========================================
echo [信息] 项目根目录 : %ROOT_DIR%
echo [信息] 仓库地址   : %REPO_URL%
if exist "%~dp0env.local.cmd" (
  echo [信息] 本地配置   : %~dp0env.local.cmd
) else (
  echo [警告] 本地配置   : 未找到，当前使用 env.cmd 默认值
)
echo.

call :CheckTool "Git" "%GIT_CMD%" "--version"
call :CheckTool "Java" "%JAVA_CMD%" "-version"
call :CheckTool "Maven" "%MVN_CMD%" "-v"
call :CheckTool "Node.js" "%NODE_CMD%" "-v"
call :CheckTool "npm" "%NPM_CMD%" "-v"
call :CheckTool "MySQL" "%MYSQL_EXE%" "--version"
call :CheckTool "Redis" "%REDIS_SERVER_EXE%" "--version"

echo.
if %MISSING_COUNT% gtr 0 (
  echo [警告] 缺失工具数量: %MISSING_COUNT%
  echo [提示] 请先运行 bin\setup-env.bat 生成 env.local.cmd，再安装缺失工具。
  exit /b 1
)

echo [成功] 必需工具已检测到。
exit /b 0

:CheckTool
set "TOOL_NAME=%~1"
set "TOOL_CMD=%~2"
set "TOOL_ARGS=%~3"
set "TOOL_VERSION="
set "TOOL_VERSION_FILE=%TEMP%\tool-version-%RANDOM%%RANDOM%.txt"

if not defined TOOL_CMD (
  echo [缺失] %TOOL_NAME%
  set /a MISSING_COUNT+=1
  exit /b 0
)

call "%TOOL_CMD%" %TOOL_ARGS% > "%TOOL_VERSION_FILE%" 2>&1
for /f "usebackq delims=" %%I in ("%TOOL_VERSION_FILE%") do if not defined TOOL_VERSION set "TOOL_VERSION=%%I"
del /q "%TOOL_VERSION_FILE%" >nul 2>nul
if not defined TOOL_VERSION set "TOOL_VERSION=Detected"

echo [正常] %TOOL_NAME% : !TOOL_VERSION!
exit /b 0
