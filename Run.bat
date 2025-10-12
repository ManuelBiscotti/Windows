@echo off
:: Batch file to run Win11Debloat.ps1 as admin with multiple parameters
powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0Win11Debloat.ps1\" -DisableUpdates -RemoveEdge -CTTWinUtil -OptimizeRegistry -DisableServices -DisableSecurity -StartAllBack' -Verb RunAs"
pause

pause


REM irm "https://github.com/ManueITest/Windows/raw/refs/heads/main/Win11Debloat.ps1" -OutFile "$env:TEMP\Win11Debloat.ps1"
REM & "$env:TEMP\Win11Debloat.ps1" -RestorePoint -PowerSettings -ActivateWindows -PauseUpdates -DisableUpdates -Runtimes -Winget -CTTWinUtil -Win11Debloat -Debloat -DisableTelemetry -OptimizeNetwork -OptimizeRegistry -DisableServices -DisableSecurity -StartAllBack -Cleanup
REM .\Win11Debloat.ps1 -DisableSecurity
