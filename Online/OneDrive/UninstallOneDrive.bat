@echo off
:: https://privacy.sexy — v0.13.8 — Sun, 19 Oct 2025 10:12:09 GMT
:: Ensure PowerShell is available
where PowerShell >nul 2>&1 || (
    echo PowerShell is not available. Please install or enable PowerShell.
    pause & exit 1
)
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion


:: ----------------------------------------------------------
:: ------------------Kill OneDrive process-------------------
:: ----------------------------------------------------------
echo --- Kill OneDrive process
:: Check and terminate the running process "OneDrive.exe"
tasklist /fi "ImageName eq OneDrive.exe" /fo csv 2>NUL | find /i "OneDrive.exe">NUL && (
    echo OneDrive.exe is running and will be killed.
    taskkill /f /im OneDrive.exe
) || (
    echo Skipping, OneDrive.exe is not running.
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Remove OneDrive through official installer--------
:: ----------------------------------------------------------
echo --- Remove OneDrive through official installer
if exist "%SYSTEMROOT%\System32\OneDriveSetup.exe" (
    "%SYSTEMROOT%\System32\OneDriveSetup.exe" /uninstall
) else (
    if exist "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" (
        "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" /uninstall
    ) else (
        echo Failed to uninstall, uninstaller could not be found. 1>&2
    )
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------------Remove OneDrive from startup---------------
:: ----------------------------------------------------------
echo --- Remove OneDrive from startup
:: Delete the registry value "OneDrive" from the key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 
PowerShell -ExecutionPolicy Unrestricted -Command "$keyName = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Run'; $valueName = 'OneDrive'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----------------Remove OneDrive shortcuts-----------------
:: ----------------------------------------------------------
echo --- Remove OneDrive shortcuts
PowerShell -ExecutionPolicy Unrestricted -Command "$shortcuts = @(; @{ Revert = $True;  Path = "^""$env:APPDATA\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:USERPROFILE\Links\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:SYSTEMROOT\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:SYSTEMROOT\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; ); foreach ($shortcut in $shortcuts) { if (-Not (Test-Path $shortcut.Path)) { Write-Host "^""Skipping, shortcut does not exist: `"^""$($shortcut.Path)`"^""."^""; continue; }; try { Remove-Item -Path $shortcut.Path -Force -ErrorAction Stop; Write-Output "^""Successfully removed shortcut: `"^""$($shortcut.Path)`"^""."^""; } catch { Write-Error "^""Encountered an issue while attempting to remove shortcut at: `"^""$($shortcut.Path)`"^""."^""; }; }"
PowerShell -ExecutionPolicy Unrestricted -Command "Set-Location "^""HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace"^""; Get-ChildItem | ForEach-Object {Get-ItemProperty $_.pspath} | ForEach-Object { $leftnavNodeName = $_."^""(default)"^""; if (($leftnavNodeName -eq "^""OneDrive"^"") -Or ($leftnavNodeName -eq "^""OneDrive - Personal"^"")) { if (Test-Path $_.pspath) { Write-Host "^""Deleting $($_.pspath)."^""; Remove-Item $_.pspath; }; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable automatic OneDrive installation----------
:: ----------------------------------------------------------
echo --- Disable automatic OneDrive installation
:: Delete the registry value "OneDriveSetup" from the key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 
:: This operation will not run on Windows versions earlier than Windows10-1909.This operation will not run on Windows versions later than Windows10-1909.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $keyName = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Run'; $valueName = 'OneDriveSetup'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable OneDrive scheduled tasks-------------
:: ----------------------------------------------------------
echo --- Disable OneDrive scheduled tasks
:: Disable scheduled task(s): `\OneDrive Reporting Task-*`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='OneDrive Reporting Task-*'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\OneDrive Standalone Update Task-*`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='OneDrive Standalone Update Task-*'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\OneDrive Per-Machine Standalone Update`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='OneDrive Per-Machine Standalone Update'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----------Clear OneDrive environment variable------------
:: ----------------------------------------------------------
echo --- Clear OneDrive environment variable
:: Delete the registry value "OneDrive" from the key "HKCU\Environment" 
PowerShell -ExecutionPolicy Unrestricted -Command "$keyName = 'HKCU\Environment'; $valueName = 'OneDrive'; $hive = $keyName.Split('\')[0]; $path = "^""$($hive):$($keyName.Substring($hive.Length))"^""; Write-Host "^""Removing the registry value '$valueName' from '$path'."^""; if (-Not (Test-Path -LiteralPath $path)) { Write-Host 'Skipping, no action needed, registry key does not exist.'; Exit 0; }; $existingValueNames = (Get-ItemProperty -LiteralPath $path).PSObject.Properties.Name; if (-Not ($existingValueNames -Contains $valueName)) { Write-Host 'Skipping, no action needed, registry value does not exist.'; Exit 0; }; try { if ($valueName -ieq '(default)') { Write-Host 'Removing the default value.'; $(Get-Item -LiteralPath $path).OpenSubKey('', $true).DeleteValue(''); } else { Remove-ItemProperty -LiteralPath $path -Name $valueName -Force -ErrorAction Stop; }; Write-Host 'Successfully removed the registry value.'; } catch { Write-Error "^""Failed to remove the registry value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0
