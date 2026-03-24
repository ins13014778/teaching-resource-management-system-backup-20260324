@echo off
setlocal

echo.
echo [INFO] Closing common Teaching Resource Management System processes...

for %%P in (java.exe javaw.exe node.exe redis-server.exe) do (
  taskkill /f /im %%P >nul 2>nul
)

echo [SUCCESS] Stop command executed for common processes.
echo [INFO] If any extra cmd windows remain, close them manually.
echo.
exit /b 0
