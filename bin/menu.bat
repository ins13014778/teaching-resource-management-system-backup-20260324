@echo off
setlocal
set "NONINTERACTIVE=0"

:menu
cls
call "%~dp0env.cmd"

echo ==========================================
echo   Windows 项目控制台
echo ==========================================
echo [信息] 项目名称 : %PROJECT_NAME%
echo [信息] 根目录   : %ROOT_DIR%
echo.
echo [1] 检测环境
echo [2] 配置本地环境
echo [3] 拉取或更新项目
echo [4] 安装项目依赖
echo [5] 初始化数据库
echo [6] 启动 Redis
echo [7] 启动后端
echo [8] 启动前端
echo [9] 一键启动全部
echo [10] 重启全部
echo [11] 停止全部
echo [12] 退出
echo.

set "MENU_CHOICE="
if not "%~1"=="" (
  set "NONINTERACTIVE=1"
  set "MENU_CHOICE=%~1"
) else (
  set /p MENU_CHOICE=请输入菜单编号: 
)

if "%MENU_CHOICE%"=="1" call "%~dp0check-env.bat"
if "%MENU_CHOICE%"=="2" call "%~dp0setup-env.bat"
if "%MENU_CHOICE%"=="3" call "%~dp0clone-project.bat"
if "%MENU_CHOICE%"=="4" call "%~dp0install-deps.bat"
if "%MENU_CHOICE%"=="5" call "%~dp0init-db.bat"
if "%MENU_CHOICE%"=="6" call "%~dp0start-redis.bat"
if "%MENU_CHOICE%"=="7" call "%~dp0start-backend.bat"
if "%MENU_CHOICE%"=="8" call "%~dp0start-frontend.bat"
if "%MENU_CHOICE%"=="9" call "%~dp0start-all.bat"
if "%MENU_CHOICE%"=="10" call "%~dp0restart-all.bat"
if "%MENU_CHOICE%"=="11" call "%~dp0stop-all.bat"
if "%MENU_CHOICE%"=="12" exit /b 0

if not "%MENU_CHOICE%"=="1" if not "%MENU_CHOICE%"=="2" if not "%MENU_CHOICE%"=="3" if not "%MENU_CHOICE%"=="4" if not "%MENU_CHOICE%"=="5" if not "%MENU_CHOICE%"=="6" if not "%MENU_CHOICE%"=="7" if not "%MENU_CHOICE%"=="8" if not "%MENU_CHOICE%"=="9" if not "%MENU_CHOICE%"=="10" if not "%MENU_CHOICE%"=="11" (
  echo.
  echo [警告] 无效菜单编号: %MENU_CHOICE%
)

if "%NONINTERACTIVE%"=="1" exit /b 0

echo.
pause
goto menu
