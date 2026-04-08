@echo off

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT_DIR=%%~fI"

if not defined PROJECT_NAME set "PROJECT_NAME=Teaching Resource Management System"
if not defined REPO_URL set "REPO_URL=https://github.com/ins13014778/teaching-resource-management-system-backup-20260324.git"
if not defined REPO_BRANCH set "REPO_BRANCH=main"

if not defined DB_HOST set "DB_HOST=127.0.0.1"
if not defined DB_PORT set "DB_PORT=3306"
if not defined DB_NAME set "DB_NAME=ry-vue"
if not defined DB_USER set "DB_USER=root"
if not defined DB_PASS set "DB_PASS="

if not defined DB_SQL_FILE if exist "%ROOT_DIR%\sql\ry-vue.sql" set "DB_SQL_FILE=%ROOT_DIR%\sql\ry-vue.sql"
if not defined DB_SQL_FILE if exist "%ROOT_DIR%\backup\2026-03-26\database\ry-vue-full-20260326.sql" set "DB_SQL_FILE=%ROOT_DIR%\backup\2026-03-26\database\ry-vue-full-20260326.sql"
if not defined DB_SQL_FILE if exist "%ROOT_DIR%\backup\2026-03-24\database\ry-vue-full-20260324.sql" set "DB_SQL_FILE=%ROOT_DIR%\backup\2026-03-24\database\ry-vue-full-20260324.sql"

if exist "%SCRIPT_DIR%env.local.cmd" call "%SCRIPT_DIR%env.local.cmd"

call :ResolveGit
call :ResolveJava
call :ResolveMaven
call :ResolveNode
call :ResolveMysql
call :ResolveRedis

set "MYSQL_AUTH_ARGS=-u%DB_USER%"
if defined DB_PASS set "MYSQL_AUTH_ARGS=-u%DB_USER% -p%DB_PASS%"

goto :eof

:ResolveGit
set "GIT_CMD="
for /f "delims=" %%I in ('where git 2^>nul') do if not defined GIT_CMD set "GIT_CMD=%%I"
exit /b 0

:ResolveJava
set "JAVA_CMD="
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\java.exe" set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
if not defined JAVA_CMD for /f "delims=" %%I in ('where java 2^>nul') do if not defined JAVA_CMD set "JAVA_CMD=%%I"
exit /b 0

:ResolveMaven
set "MVN_CMD="
if defined MAVEN_HOME if exist "%MAVEN_HOME%\bin\mvn.cmd" set "MVN_CMD=%MAVEN_HOME%\bin\mvn.cmd"
if not defined MVN_CMD for /f "delims=" %%I in ('where mvn.cmd 2^>nul') do if not defined MVN_CMD set "MVN_CMD=%%I"
exit /b 0

:ResolveNode
set "NODE_CMD="
if defined NODE_HOME if exist "%NODE_HOME%\node.exe" set "NODE_CMD=%NODE_HOME%\node.exe"
if not defined NODE_CMD if defined NVM_SYMLINK if exist "%NVM_SYMLINK%\node.exe" set "NODE_CMD=%NVM_SYMLINK%\node.exe"
if not defined NODE_CMD for /f "delims=" %%I in ('where node 2^>nul') do if not defined NODE_CMD set "NODE_CMD=%%I"

set "NPM_CMD="
if defined NODE_HOME if exist "%NODE_HOME%\npm.cmd" set "NPM_CMD=%NODE_HOME%\npm.cmd"
if not defined NPM_CMD if defined NVM_SYMLINK if exist "%NVM_SYMLINK%\npm.cmd" set "NPM_CMD=%NVM_SYMLINK%\npm.cmd"
if not defined NPM_CMD for /f "delims=" %%I in ('where npm.cmd 2^>nul') do if not defined NPM_CMD set "NPM_CMD=%%I"
exit /b 0

:ResolveMysql
set "MYSQL_EXE="
if defined MYSQL_HOME if exist "%MYSQL_HOME%\bin\mysql.exe" set "MYSQL_EXE=%MYSQL_HOME%\bin\mysql.exe"
if not defined MYSQL_EXE for /f "delims=" %%I in ('where mysql 2^>nul') do if not defined MYSQL_EXE set "MYSQL_EXE=%%I"
exit /b 0

:ResolveRedis
set "REDIS_SERVER_EXE="
if defined REDIS_HOME if exist "%REDIS_HOME%\redis-server.exe" set "REDIS_SERVER_EXE=%REDIS_HOME%\redis-server.exe"
if not defined REDIS_SERVER_EXE if defined REDIS_HOME if exist "%REDIS_HOME%\bin\redis-server.exe" set "REDIS_SERVER_EXE=%REDIS_HOME%\bin\redis-server.exe"
if not defined REDIS_SERVER_EXE for /f "delims=" %%I in ('where redis-server 2^>nul') do if not defined REDIS_SERVER_EXE set "REDIS_SERVER_EXE=%%I"

set "REDIS_CLI_EXE="
if defined REDIS_HOME if exist "%REDIS_HOME%\redis-cli.exe" set "REDIS_CLI_EXE=%REDIS_HOME%\redis-cli.exe"
if not defined REDIS_CLI_EXE if defined REDIS_HOME if exist "%REDIS_HOME%\bin\redis-cli.exe" set "REDIS_CLI_EXE=%REDIS_HOME%\bin\redis-cli.exe"
if not defined REDIS_CLI_EXE if defined REDIS_SERVER_EXE for %%I in ("%REDIS_SERVER_EXE%") do if exist "%%~dpIredis-cli.exe" set "REDIS_CLI_EXE=%%~dpIredis-cli.exe"

set "REDIS_CONF="
if defined REDIS_HOME if exist "%REDIS_HOME%\redis.conf" set "REDIS_CONF=%REDIS_HOME%\redis.conf"
if not defined REDIS_CONF if defined REDIS_HOME if exist "%REDIS_HOME%\redis.windows.conf" set "REDIS_CONF=%REDIS_HOME%\redis.windows.conf"
if not defined REDIS_CONF if defined REDIS_HOME if exist "%REDIS_HOME%\bin\redis.conf" set "REDIS_CONF=%REDIS_HOME%\bin\redis.conf"
if not defined REDIS_CONF if defined REDIS_SERVER_EXE for %%I in ("%REDIS_SERVER_EXE%") do if exist "%%~dpIredis.conf" set "REDIS_CONF=%%~dpIredis.conf"
exit /b 0
