@echo off
setlocal

call "%~dp0env.cmd"

set "DRY_RUN=0"
if /I "%~1"=="--dry-run" set "DRY_RUN=1"

if not defined MVN_CMD (
  echo [错误] 未找到 mvn.cmd，请先安装 Maven 或配置 MAVEN_HOME。
  exit /b 1
)

if not defined NPM_CMD (
  echo [错误] 未找到 npm.cmd，请先安装 Node.js 或配置 NODE_HOME。
  exit /b 1
)

if "%DRY_RUN%"=="1" (
  echo [DRY RUN] "%MVN_CMD%" -pl ruoyi-admin -am -DskipTests compile
  echo [DRY RUN] cd /d "%ROOT_DIR%\ruoyi-ui"
  echo [DRY RUN] "%NPM_CMD%" install
  exit /b 0
)

echo.
echo [信息] 正在下载后端依赖并编译模块...
cd /d "%ROOT_DIR%"
call "%MVN_CMD%" -pl ruoyi-admin -am -DskipTests compile
if errorlevel 1 (
  echo [错误] Maven 编译失败。
  exit /b 1
)

echo.
echo [信息] 正在安装前端依赖...
cd /d "%ROOT_DIR%\ruoyi-ui"
call "%NPM_CMD%" install
if errorlevel 1 (
  echo [错误] npm install 执行失败。
  exit /b 1
)

echo.
echo [成功] 项目依赖安装完成。
exit /b 0
