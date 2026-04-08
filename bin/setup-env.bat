@echo off
setlocal EnableDelayedExpansion

call "%~dp0env.cmd"

set "TARGET_FILE=%~dp0env.local.cmd"

echo.
echo ==========================================
echo   环境配置助手
echo ==========================================
echo [信息] 此脚本会把本机配置写入:
echo [信息] %TARGET_FILE%
echo.
echo [信息] 如需保留当前值，直接回车即可。
echo.

set "INPUT_VALUE="
set /p INPUT_VALUE=JAVA_HOME [%JAVA_HOME%]: 
if defined INPUT_VALUE set "JAVA_HOME=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=MAVEN_HOME [%MAVEN_HOME%]: 
if defined INPUT_VALUE set "MAVEN_HOME=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=NODE_HOME [%NODE_HOME%]: 
if defined INPUT_VALUE set "NODE_HOME=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=MYSQL_HOME [%MYSQL_HOME%]: 
if defined INPUT_VALUE set "MYSQL_HOME=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=REDIS_HOME [%REDIS_HOME%]: 
if defined INPUT_VALUE set "REDIS_HOME=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=DB_HOST [%DB_HOST%]: 
if defined INPUT_VALUE set "DB_HOST=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=DB_PORT [%DB_PORT%]: 
if defined INPUT_VALUE set "DB_PORT=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=DB_NAME [%DB_NAME%]: 
if defined INPUT_VALUE set "DB_NAME=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=DB_USER [%DB_USER%]: 
if defined INPUT_VALUE set "DB_USER=%INPUT_VALUE%"

set "INPUT_VALUE="
set /p INPUT_VALUE=DB_PASS [不会显示当前值]: 
if defined INPUT_VALUE set "DB_PASS=%INPUT_VALUE%"

> "%TARGET_FILE%" (
  echo @echo off
  if defined JAVA_HOME echo set "JAVA_HOME=%JAVA_HOME%"
  if defined MAVEN_HOME echo set "MAVEN_HOME=%MAVEN_HOME%"
  if defined NODE_HOME echo set "NODE_HOME=%NODE_HOME%"
  if defined MYSQL_HOME echo set "MYSQL_HOME=%MYSQL_HOME%"
  if defined REDIS_HOME echo set "REDIS_HOME=%REDIS_HOME%"
  if defined DB_HOST echo set "DB_HOST=%DB_HOST%"
  if defined DB_PORT echo set "DB_PORT=%DB_PORT%"
  if defined DB_NAME echo set "DB_NAME=%DB_NAME%"
  if defined DB_USER echo set "DB_USER=%DB_USER%"
  if defined DB_PASS echo set "DB_PASS=%DB_PASS%"
)

echo.
echo [成功] 本地环境配置已写入。
echo [信息] 下一步可运行: bin\check-env.bat
exit /b 0
