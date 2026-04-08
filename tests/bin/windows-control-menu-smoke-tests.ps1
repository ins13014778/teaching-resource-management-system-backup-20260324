$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

function Assert-True {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Assert-Contains {
    param(
        [string]$Actual,
        [string]$Expected,
        [string]$Message
    )

    if ($Actual -notlike "*$Expected*") {
        throw "$Message`nExpected to find: $Expected`nActual:`n$Actual"
    }
}

function Run-Cmd {
    param(
        [string]$Command
    )

    $tempFile = Join-Path $env:TEMP ("windows-control-menu-test.{0}.cmd" -f [guid]::NewGuid())

    try {
        Set-Content -LiteralPath $tempFile -Value "@echo off`r`n$Command`r`n" -Encoding ASCII
        $output = & cmd.exe /d /c "`"$tempFile`"" 2>&1 | Out-String
        return @{
            Output   = $output
            ExitCode = $LASTEXITCODE
        }
    }
    finally {
        Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue
    }
}

Write-Host '[TEST] env.local override'
$envLocalFile = Join-Path $repoRoot 'bin\env.local.cmd'
$envLocalBackup = $null

if (Test-Path $envLocalFile) {
    $envLocalBackup = Join-Path $env:TEMP ("env.local.backup.{0}.cmd" -f [guid]::NewGuid())
    Copy-Item -LiteralPath $envLocalFile -Destination $envLocalBackup -Force
}

try {
    $envLocalContent = @"
@echo off
set "DB_NAME=smoke-db"
"@
    Set-Content -LiteralPath $envLocalFile -Value $envLocalContent -Encoding ASCII

    $envResult = Run-Cmd "setlocal EnableDelayedExpansion && call `"$repoRoot\bin\env.cmd`" && echo !DB_NAME!"
    Assert-True ($envResult.ExitCode -eq 0) 'env.cmd execution failed'
    Assert-Contains $envResult.Output 'smoke-db' 'env.local override was not loaded'
}
finally {
    Remove-Item -LiteralPath $envLocalFile -Force -ErrorAction SilentlyContinue
    if ($envLocalBackup) {
        Move-Item -LiteralPath $envLocalBackup -Destination $envLocalFile -Force
    }
}

Write-Host '[TEST] clone-project dry-run'
$cloneResult = Run-Cmd "`"$repoRoot\bin\clone-project.bat`" --dry-run `"%TEMP%\trms-clone-target`""
Assert-True ($cloneResult.ExitCode -eq 0) 'clone-project --dry-run failed'
Assert-Contains $cloneResult.Output 'teaching-resource-management-system-backup-20260324.git' 'clone-project did not print repo URL'
Assert-Contains $cloneResult.Output 'git clone' 'clone-project did not print git clone command'

Write-Host '[TEST] install-deps dry-run'
$depsResult = Run-Cmd "`"$repoRoot\bin\install-deps.bat`" --dry-run"
Assert-True ($depsResult.ExitCode -eq 0) 'install-deps --dry-run failed'
Assert-Contains $depsResult.Output 'mvn' 'install-deps did not print Maven command'
Assert-Contains $depsResult.Output 'npm' 'install-deps did not print npm command'

Write-Host '[TEST] menu show and exit'
$menuResult = Run-Cmd "`"$repoRoot\bin\menu.bat`" 12"
Assert-True ($menuResult.ExitCode -eq 0) 'menu.bat did not exit cleanly'
Assert-Contains $menuResult.Output '[12]' 'menu.bat did not print menu options'

Write-Host '[PASS] windows control menu smoke tests passed.'
