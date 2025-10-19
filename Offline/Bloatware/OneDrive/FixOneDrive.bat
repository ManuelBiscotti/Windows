@echo off
:: https://privacy.sexy — v0.13.8 — Sun, 19 Oct 2025 09:10:05 GMT
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
:: ----------Remove OneDrive from startup (revert)-----------
:: ----------------------------------------------------------
echo --- Remove OneDrive from startup (revert)
:: Restore the registry value "OneDrive" in key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data =  '"^""%LOCALAPPDATA%\Microsoft\OneDrive\OneDrive.exe"^"" /background'; $rawType = 'REG_SZ'; $rawPath = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Run'; $value = 'OneDrive'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---Remove OneDrive through official installer (revert)----
:: ----------------------------------------------------------
echo --- Remove OneDrive through official installer (revert)
if exist "%SYSTEMROOT%\System32\OneDriveSetup.exe" (
    "%SYSTEMROOT%\System32\OneDriveSetup.exe" /silent
) else (
    if exist "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" (
        "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" /silent
    ) else (
        echo Failed to install, installer could not be found. 1>&2
    )
)
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Remove OneDrive shortcuts (revert)------------
:: ----------------------------------------------------------
echo --- Remove OneDrive shortcuts (revert)
PowerShell -ExecutionPolicy Unrestricted -Command "$targetFilePath = "^""%LOCALAPPDATA%\Microsoft\OneDrive\OneDrive.exe"^""; $expandedTargetFilePath = [System.Environment]::ExpandEnvironmentVariables($targetFilePath); $shortcuts = @(; @{ Revert = $True;  Path = "^""$env:APPDATA\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:USERPROFILE\Links\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:SYSTEMROOT\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; @{ Revert = $False; Path = "^""$env:SYSTEMROOT\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"^""; }; ); if (-Not (Test-Path $expandedTargetFilePath)) { Write-Warning "^""Target file `"^""$expandedTargetFilePath`"^"" does not exist."^""; }; $wscriptShell = $null; try { $wscriptShell = New-Object -ComObject WScript.Shell; } catch { throw "^""Failed to create WScript.Shell object: $($_.Exception.Message)"^""; }; foreach ($shortcut in $shortcuts) { if (-Not $shortcut.Revert) { Write-Host "^""Skipping, revert operation is not needed for: `"^""$($shortcut.Path)`"^""."^""; continue; }; if (Test-Path $shortcut.Path) { Write-Host "^""Shortcut already exists, skipping: `"^""$($shortcut.Path)`"^""."^""; continue; }; try { $shellShortcut = $wscriptShell.CreateShortcut($shortcut.Path); $shellShortcut.TargetPath = $expandedTargetFilePath; $shellShortcut.Save(); Write-Output "^""Successfully created shortcut at `"^""$($shortcut.Path)`"^""."^""; } catch { Write-Error "^""An error occurred while creating the shortcut at `"^""$($shortcut.Path)`"^""."^""; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------------Disable OneDrive usage (revert)--------------
:: ----------------------------------------------------------
echo --- Disable OneDrive usage (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive!DisableFileSyncNGSC"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive' /v 'DisableFileSyncNGSC' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive!DisableFileSync"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive' /v 'DisableFileSync' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable automatic OneDrive installation (revert)-----
:: ----------------------------------------------------------
echo --- Disable automatic OneDrive installation (revert)
:: Restore the registry value "OneDriveSetup" in key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" to its original value 
:: This operation will not run on Windows versions earlier than Windows10-1909.This operation will not run on Windows versions later than Windows10-1909.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }$versionName = 'Windows10-1909'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $data = $(if ([Environment]::Is64BitOperatingSystem) { "^""$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe /silent"^""; } else { "^""$env:SYSTEMROOT\System32\OneDriveSetup.exe /silent"^""; }; ) <# 'if ([Environment]::Is64BitOperatingSystem) { #>; "^""$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe /silent"^""; } else { "^""$env:SYSTEMROOT\System32\OneDriveSetup.exe /silent"^""; }; '; $rawType = 'REG_SZ'; $rawPath = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Run'; $value = 'OneDriveSetup'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Remove OneDrive folder from File Explorer (revert)----
:: ----------------------------------------------------------
echo --- Remove OneDrive folder from File Explorer (revert)
:: Set the registry value "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}!System.IsPinnedToNameSpaceTree"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData =  '1'; reg add 'HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' /v 'System.IsPinnedToNameSpaceTree' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Set the registry value "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}!System.IsPinnedToNameSpaceTree"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData =  '1'; reg add 'HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' /v 'System.IsPinnedToNameSpaceTree' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable OneDrive scheduled tasks (revert)---------
:: ----------------------------------------------------------
echo --- Disable OneDrive scheduled tasks (revert)
:: Restore scheduled task(s) to default state: `\OneDrive Reporting Task-*`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='OneDrive Reporting Task-*'; $shouldDisable =  $false; Write-Output "^""Enabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Warning ( "^""Missing task: Cannot enable, no tasks matching pattern `"^""$taskNamePattern`"^"" found."^"" + "^"" This task appears to be not included in this version of Windows."^"" ); exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($shouldDisable) { if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; } else { if (($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) -and ($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Unknown)) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already enabled, no action needed."^""; continue; }; }; try { if ($shouldDisable) { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } else { $task | Enable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully enabled task `"^""$taskName`"^""."^""; }; } catch { Write-Error "^""Failed to restore task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to restore some tasks. Check error messages above.'; exit 1; }"
:: Restore scheduled task(s) to default state: `\OneDrive Standalone Update Task-*`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='OneDrive Standalone Update Task-*'; $shouldDisable =  $false; Write-Output "^""Enabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Warning ( "^""Missing task: Cannot enable, no tasks matching pattern `"^""$taskNamePattern`"^"" found."^"" + "^"" This task appears to be not included in this version of Windows."^"" ); exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($shouldDisable) { if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; } else { if (($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) -and ($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Unknown)) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already enabled, no action needed."^""; continue; }; }; try { if ($shouldDisable) { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } else { $task | Enable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully enabled task `"^""$taskName`"^""."^""; }; } catch { Write-Error "^""Failed to restore task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to restore some tasks. Check error messages above.'; exit 1; }"
:: Restore scheduled task(s) to default state: `\OneDrive Per-Machine Standalone Update`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='OneDrive Per-Machine Standalone Update'; $shouldDisable =  $false; Write-Output "^""Enabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Warning ( "^""Missing task: Cannot enable, no tasks matching pattern `"^""$taskNamePattern`"^"" found."^"" + "^"" This task appears to be not included in this version of Windows."^"" ); exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($shouldDisable) { if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; } else { if (($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) -and ($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Unknown)) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already enabled, no action needed."^""; continue; }; }; try { if ($shouldDisable) { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } else { $task | Enable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully enabled task `"^""$taskName`"^""."^""; }; } catch { Write-Error "^""Failed to restore task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to restore some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -------Clear OneDrive environment variable (revert)-------
:: ----------------------------------------------------------
echo --- Clear OneDrive environment variable (revert)
:: Restore the registry value "OneDrive" in key "HKCU\Environment" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data =  '%USERPROFILE%\OneDrive'; $rawType = 'REG_EXPAND_SZ'; $rawPath = 'HKCU\Environment'; $value = 'OneDrive'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0