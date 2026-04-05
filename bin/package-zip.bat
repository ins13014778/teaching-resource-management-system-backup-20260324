@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT_DIR=%%~fI"

set "DB_NAME=%~1"
if not defined DB_NAME set "DB_NAME=ry-vue"

set "DB_SQL_FILE=%~2"
if not defined DB_SQL_FILE set "DB_SQL_FILE=backup\2026-03-26\database\ry-vue-full-20260326.sql"

for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "STAMP=%%I"

set "RELEASE_DIR=%ROOT_DIR%\release"
set "STAGE_DIR=%RELEASE_DIR%\teaching-resource-management-system-release-clean-%STAMP%"
set "ZIP_FILE=%RELEASE_DIR%\teaching-resource-management-system-release-clean-%STAMP%.zip"

echo.
echo ==========================================
echo   Teaching Resource Management System
echo   Package Clean Release ZIP
echo ==========================================
echo.
echo [INFO] This script creates a clean release package only.
echo [INFO] It does NOT package node_modules, logs, .git, release, or source-only cache artifacts.
echo [INFO] Step 1/5: Initialize database and services...
call "%SCRIPT_DIR%init-all.bat" "%DB_NAME%" "%DB_SQL_FILE%"
if errorlevel 1 (
  echo [ERROR] init-all.bat failed.
  exit /b 1
)

echo [INFO] Step 2/5: Stop running services before packaging...
call "%SCRIPT_DIR%stop-all.bat"
if errorlevel 1 (
  echo [ERROR] stop-all.bat failed.
  exit /b 1
)

echo [INFO] Step 3/5: Build backend jar...
cd /d "%ROOT_DIR%"
call mvn -pl ruoyi-admin -am -DskipTests package
if errorlevel 1 (
  echo [ERROR] Backend package build failed.
  exit /b 1
)

echo [INFO] Step 4/5: Build frontend dist...
cd /d "%ROOT_DIR%\ruoyi-ui"
call npm run build:prod
if errorlevel 1 (
  echo [ERROR] Frontend build failed.
  exit /b 1
)

echo [INFO] Step 5/5: Assemble release files and compress zip...
if exist "%STAGE_DIR%" rmdir /s /q "%STAGE_DIR%"
if not exist "%RELEASE_DIR%" mkdir "%RELEASE_DIR%"
mkdir "%STAGE_DIR%"
mkdir "%STAGE_DIR%\backend"
mkdir "%STAGE_DIR%\frontend"
mkdir "%STAGE_DIR%\bin"
mkdir "%STAGE_DIR%\docs"

copy /y "%ROOT_DIR%\ruoyi-admin\target\ruoyi-admin.jar" "%STAGE_DIR%\backend\" >nul
xcopy /e /i /y "%ROOT_DIR%\ruoyi-ui\dist" "%STAGE_DIR%\frontend\dist" >nul
copy /y "%ROOT_DIR%\bin\init-db.bat" "%STAGE_DIR%\bin\" >nul
copy /y "%ROOT_DIR%\bin\init-all.bat" "%STAGE_DIR%\bin\" >nul
copy /y "%ROOT_DIR%\bin\start-all.bat" "%STAGE_DIR%\bin\" >nul
copy /y "%ROOT_DIR%\bin\restart-all.bat" "%STAGE_DIR%\bin\" >nul
copy /y "%ROOT_DIR%\bin\stop-all.bat" "%STAGE_DIR%\bin\" >nul
copy /y "%ROOT_DIR%\docs\deployment-guide.md" "%STAGE_DIR%\docs\" >nul

powershell -NoProfile -Command "if(Test-Path '%ZIP_FILE%'){ Remove-Item -LiteralPath '%ZIP_FILE%' -Force }; Compress-Archive -Path '%STAGE_DIR%\*' -DestinationPath '%ZIP_FILE%' -Force"
if errorlevel 1 (
  echo [ERROR] ZIP compression failed.
  exit /b 1
)

echo.
echo [SUCCESS] ZIP package created.
echo [SUCCESS] ZIP file : %ZIP_FILE%
echo [SUCCESS] Stage dir: %STAGE_DIR%
echo.
exit /b 0
