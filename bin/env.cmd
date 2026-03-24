@echo off

set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "ROOT_DIR=%%~fI"

set "JAVA_CMD="
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\java.exe" set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
if not defined JAVA_CMD if exist "C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot\bin\java.exe" set "JAVA_CMD=C:\Program Files\Microsoft\jdk-21.0.9.10-hotspot\bin\java.exe"
if not defined JAVA_CMD if exist "C:\Program Files\Java\jdk-21\bin\java.exe" set "JAVA_CMD=C:\Program Files\Java\jdk-21\bin\java.exe"
if not defined JAVA_CMD for /f "delims=" %%I in ('where java 2^>nul') do if not defined JAVA_CMD set "JAVA_CMD=%%I"

set "MVN_CMD="
if defined MAVEN_HOME if exist "%MAVEN_HOME%\bin\mvn.cmd" set "MVN_CMD=%MAVEN_HOME%\bin\mvn.cmd"
if not defined MVN_CMD if exist "C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd" set "MVN_CMD=C:\Program Files\JetBrains\IntelliJ IDEA 2025.3.1.1\plugins\maven\lib\maven3\bin\mvn.cmd"
if not defined MVN_CMD if exist "C:\Program Files\Apache\maven\bin\mvn.cmd" set "MVN_CMD=C:\Program Files\Apache\maven\bin\mvn.cmd"
if not defined MVN_CMD for /f "delims=" %%I in ('where mvn.cmd 2^>nul') do if not defined MVN_CMD set "MVN_CMD=%%I"

set "NODE_CMD="
if not defined NODE_CMD if exist "C:\nvm4w\nodejs\node.exe" set "NODE_CMD=C:\nvm4w\nodejs\node.exe"
if not defined NODE_CMD for /f "delims=" %%I in ('where node 2^>nul') do if not defined NODE_CMD set "NODE_CMD=%%I"

set "NPM_CMD="
if not defined NPM_CMD if exist "C:\nvm4w\nodejs\npm.cmd" set "NPM_CMD=C:\nvm4w\nodejs\npm.cmd"
if not defined NPM_CMD for /f "delims=" %%I in ('where npm.cmd 2^>nul') do if not defined NPM_CMD set "NPM_CMD=%%I"

set "MYSQL_EXE="
if defined MYSQL_HOME if exist "%MYSQL_HOME%\bin\mysql.exe" set "MYSQL_EXE=%MYSQL_HOME%\bin\mysql.exe"
if not defined MYSQL_EXE if exist "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" set "MYSQL_EXE=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
if not defined MYSQL_EXE for /f "delims=" %%I in ('where mysql 2^>nul') do if not defined MYSQL_EXE set "MYSQL_EXE=%%I"

set "REDIS_SERVER_EXE="
if exist "C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe" set "REDIS_SERVER_EXE=C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-server.exe"
if not defined REDIS_SERVER_EXE if exist "C:\Redis\redis-server.exe" set "REDIS_SERVER_EXE=C:\Redis\redis-server.exe"
if not defined REDIS_SERVER_EXE for /f "delims=" %%I in ('where redis-server 2^>nul') do if not defined REDIS_SERVER_EXE set "REDIS_SERVER_EXE=%%I"

set "REDIS_CLI_EXE="
if exist "C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-cli.exe" set "REDIS_CLI_EXE=C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis-cli.exe"
if not defined REDIS_CLI_EXE if defined REDIS_SERVER_EXE for %%I in ("%REDIS_SERVER_EXE%") do if exist "%%~dpIredis-cli.exe" set "REDIS_CLI_EXE=%%~dpIredis-cli.exe"

set "REDIS_CONF="
if exist "C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis.conf" set "REDIS_CONF=C:\Windows\Redis-8.6.1-Windows-x64-cygwin-with-Service\redis.conf"
if not defined REDIS_CONF if defined REDIS_SERVER_EXE for %%I in ("%REDIS_SERVER_EXE%") do if exist "%%~dpIredis.conf" set "REDIS_CONF=%%~dpIredis.conf"

set "DB_HOST=127.0.0.1"
set "DB_PORT=3306"
set "DB_NAME=ry-vue"
set "DB_USER=root"
set "DB_PASS=czp123.."
set "DB_SQL_FILE=%ROOT_DIR%\backup\2026-03-24\database\ry-vue-full-20260324.sql"

goto :eof
