@echo off
:: Change to match the setting name (e.g., Sleep, Indexing, etc.)
set "settingName=VbsState"
:: Change to 0 (Disabled) or 1 (Enabled/Minimal) etc
set "stateValue=0"
set "scriptPath=%~f0"

set "___args="%~f0" %*"
fltmc > nul 2>&1 || (
    echo Administrator privileges are required.
    powershell -c "Start-Process -Verb RunAs -FilePath 'cmd' -ArgumentList """/c $env:___args"""" 2> nul || (
        echo You must run this script as admin.
        if "%*"=="" pause
        exit /b 1
    )
    exit /b
)

:: Update Registry (State and Path)
reg add "HKLM\SOFTWARE\AtlasOS\Services\%settingName%" /v state /t REG_DWORD /d %stateValue% /f > nul
reg add "HKLM\SOFTWARE\AtlasOS\Services\%settingName%" /v path /t REG_SZ /d "%scriptPath%" /f > nul

:: End of state and path update

reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /t REG_DWORD /v Enabled /d "1" /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /t REG_DWORD /v EnableVirtualizationBasedSecurity /d "1" /f > nul

echo Changes applied successfully.
echo Press any key to exit...
pause > nul
exit /b