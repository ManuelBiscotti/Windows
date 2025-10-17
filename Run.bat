@Echo Off & Set "_F0=%~f0" & Title

PowerShell.exe -NoProfile -Command "Set-Content -LiteralPath $Env:Temp\_.ps1 -Value ([RegEx]::Matches([System.IO.File]::ReadAllText($Env:_F0), '(?smi)^(Pause|Exit)(.*)$').Groups[2].Value) -Encoding Unicode -Force"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%Temp%\_.ps1"
exit

function Del-PS1 {Remove-Item -LiteralPath $Env:Temp\_.ps1 -Force}

if ((Get-Item -LiteralPath 'Registry::HKU\S-1-5-19' -ErrorAction SilentlyContinue)) {Del-PS1} Else {
    try {Start-Process -FilePath PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$Env:Temp\_.ps1`"" -Verb RunAs} Catch {Del-PS1}
    exit
}

:: Batch file to run Win11Debloat.ps1 as admin with multiple parameters

irm "https://github.com/ManueITest/Windows/raw/refs/heads/main/nuovo2.ps1" -OutFile "$env:TEMP\nuovo2.ps1"
& "$env:TEMP\nuovo2.ps1" -Full
# -RestorePoint -PowerSettings -ActivateWindows -PauseUpdates -DisableUpdates -Runtimes -Winget -CTTWinUtil -Win11Debloat -Debloat -DisableTelemetry -OptimizeNetwork -OptimizeRegistry -DisableServices -DisableSecurity -StartAllBack -Cleanup
REM .\Win11Debloat.ps1 -DisableSecurity
