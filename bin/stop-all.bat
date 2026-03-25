@echo off
setlocal

call "%~dp0env.cmd"

echo.
echo [INFO] Closing Teaching Resource Management System related processes...

powershell -NoProfile -Command ^
  "$root = [regex]::Escape('%ROOT_DIR%');" ^
  "$redisPath = if('%REDIS_SERVER_EXE%'){ [regex]::Escape('%REDIS_SERVER_EXE%') } else { '' };" ^
  "$targets = @(80,8080,6379);" ^
  "$listeners = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Where-Object { $targets -contains $_.LocalPort } | Sort-Object -Property OwningProcess -Unique;" ^
  "if(-not $listeners){ Write-Host '[INFO] No matching listening process found.'; exit 0 }" ^
  "foreach($listener in $listeners){" ^
  "  $proc = Get-CimInstance Win32_Process -Filter ('ProcessId=' + $listener.OwningProcess) -ErrorAction SilentlyContinue;" ^
  "  if(-not $proc){ continue }" ^
  "  $cmd = [string]$proc.CommandLine;" ^
  "  $name = [string]$proc.Name;" ^
  "  $port = [int]$listener.LocalPort;" ^
  "  $shouldStop = $false;" ^
  "  if($port -eq 8080 -and $cmd -match 'ruoyi-admin\.jar'){ $shouldStop = $true }" ^
  "  elseif($port -eq 80 -and ($cmd -match $root -or $cmd -match 'vue-cli-service' -or $cmd -match 'npm(.cmd)? run dev')){ $shouldStop = $true }" ^
  "  elseif($port -eq 6379 -and ($name -ieq 'redis-server.exe' -or ($redisPath -and $cmd -match $redisPath))){ $shouldStop = $true }" ^
  "  if($shouldStop){ Stop-Process -Id $listener.OwningProcess -Force -ErrorAction SilentlyContinue; Write-Host ('[SUCCESS] Stopped PID ' + $listener.OwningProcess + ' on port ' + $port) }" ^
  "  else { Write-Host ('[SKIP] PID ' + $listener.OwningProcess + ' on port ' + $port + ' is not recognized as the current project process.') }" ^
  "}"

if errorlevel 1 (
  echo [ERROR] Failed to stop one or more processes.
  exit /b 1
)

echo [SUCCESS] Stop command completed.
echo.
exit /b 0
