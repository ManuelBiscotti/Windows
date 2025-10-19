@Echo Off & Set "_F0=%~f0" & Title

PowerShell.exe -NoProfile -Command "Set-Content -LiteralPath $Env:Temp\_.ps1 -Value ([RegEx]::Matches([System.IO.File]::ReadAllText($Env:_F0), '(?smi)^(Pause|Exit)(.*)$').Groups[2].Value) -Encoding Unicode -Force"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%Temp%\_.ps1"
exit

function Del-PS1 {Remove-Item -LiteralPath $Env:Temp\_.ps1 -Force}

if ((Get-Item -LiteralPath 'Registry::HKU\S-1-5-19' -ErrorAction SilentlyContinue)) {Del-PS1} Else {
    try {Start-Process -FilePath PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$Env:Temp\_.ps1`"" -Verb RunAs} Catch {Del-PS1}
    exit
}

    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    function Get-FileFromWeb {
    param ([Parameter(Mandatory)][string]$URL, [Parameter(Mandatory)][string]$File)
    function Show-Progress {
    param ([Parameter(Mandatory)][Single]$TotalValue, [Parameter(Mandatory)][Single]$CurrentValue, [Parameter(Mandatory)][string]$ProgressText, [Parameter()][int]$BarSize = 10, [Parameter()][switch]$Complete)
    $percent = $CurrentValue / $TotalValue
    $percentComplete = $percent * 100
    if ($psISE) { Write-Progress "$ProgressText" -id 0 -percentComplete $percentComplete }
    else { Write-Host -NoNewLine "`r$ProgressText $(''.PadRight($BarSize * $percent, [char]9608).PadRight($BarSize, [char]9617)) $($percentComplete.ToString('##0.00').PadLeft(6)) % " }
    }
    try {
    $request = [System.Net.HttpWebRequest]::Create($URL)
    $response = $request.GetResponse()
    if ($response.StatusCode -eq 401 -or $response.StatusCode -eq 403 -or $response.StatusCode -eq 404) { throw "Remote file either doesn't exist, is unauthorized, or is forbidden for '$URL'." }
    if ($File -match '^\.\\') { $File = Join-Path (Get-Location -PSProvider 'FileSystem') ($File -Split '^\.')[1] }
    if ($File -and !(Split-Path $File)) { $File = Join-Path (Get-Location -PSProvider 'FileSystem') $File }
    if ($File) { $fileDirectory = $([System.IO.Path]::GetDirectoryName($File)); if (!(Test-Path($fileDirectory))) { [System.IO.Directory]::CreateDirectory($fileDirectory) | Out-Null } }
    [long]$fullSize = $response.ContentLength
    [byte[]]$buffer = new-object byte[] 1048576
    [long]$total = [long]$count = 0
    $reader = $response.GetResponseStream()
    $writer = new-object System.IO.FileStream $File, 'Create'
    do {
    $count = $reader.Read($buffer, 0, $buffer.Length)
    $writer.Write($buffer, 0, $count)
    $total += $count
    if ($fullSize -gt 0) { Show-Progress -TotalValue $fullSize -CurrentValue $total -ProgressText " $($File.Name)" }
    } while ($count -gt 0)
    }
    finally {
    $reader.Close()
    $writer.Close()
    }
    }

    function RunAsTI($cmd, $arg) {
    $id = 'RunAsTI'; $key = "Registry::HKU\$(((whoami /user)-split' ')[-1])\Volatile Environment"; $code = @'
    $I=[int32]; $M=$I.module.gettype("System.Runtime.Interop`Services.Mar`shal"); $P=$I.module.gettype("System.Int`Ptr"); $S=[string]
    $D=@(); $T=@(); $DM=[AppDomain]::CurrentDomain."DefineDynami`cAssembly"(1,1)."DefineDynami`cModule"(1); $Z=[uintptr]::size
    0..5|% {$D += $DM."Defin`eType"("AveYo_$_",1179913,[ValueType])}; $D += [uintptr]; 4..6|% {$D += $D[$_]."MakeByR`efType"()}
    $F='kernel','advapi','advapi', ($S,$S,$I,$I,$I,$I,$I,$S,$D[7],$D[8]), ([uintptr],$S,$I,$I,$D[9]),([uintptr],$S,$I,$I,[byte[]],$I)
    0..2|% {$9=$D[0]."DefinePInvok`eMethod"(('CreateProcess','RegOpenKeyEx','RegSetValueEx')[$_],$F[$_]+'32',8214,1,$S,$F[$_+3],1,4)}
    $DF=($P,$I,$P),($I,$I,$I,$I,$P,$D[1]),($I,$S,$S,$S,$I,$I,$I,$I,$I,$I,$I,$I,[int16],[int16],$P,$P,$P,$P),($D[3],$P),($P,$P,$I,$I)
    1..5|% {$k=$_; $n=1; $DF[$_-1]|% {$9=$D[$k]."Defin`eField"('f' + $n++, $_, 6)}}; 0..5|% {$T += $D[$_]."Creat`eType"()}
    0..5|% {nv "A$_" ([Activator]::CreateInstance($T[$_])) -fo}; function F ($1,$2) {$T[0]."G`etMethod"($1).invoke(0,$2)}
    $TI=(whoami /groups)-like'*1-16-16384*'; $As=0; if(!$cmd) {$cmd='control';$arg='admintools'}; if ($cmd-eq'This PC'){$cmd='file:'}
    if (!$TI) {'TrustedInstaller','lsass','winlogon'|% {if (!$As) {$9=sc.exe start $_; $As=@(get-process -name $_ -ea 0|% {$_})[0]}}
    function M ($1,$2,$3) {$M."G`etMethod"($1,[type[]]$2).invoke(0,$3)}; $H=@(); $Z,(4*$Z+16)|% {$H += M "AllocHG`lobal" $I $_}
    M "WriteInt`Ptr" ($P,$P) ($H[0],$As.Handle); $A1.f1=131072; $A1.f2=$Z; $A1.f3=$H[0]; $A2.f1=1; $A2.f2=1; $A2.f3=1; $A2.f4=1
    $A2.f6=$A1; $A3.f1=10*$Z+32; $A4.f1=$A3; $A4.f2=$H[1]; M "StructureTo`Ptr" ($D[2],$P,[boolean]) (($A2 -as $D[2]),$A4.f2,$false)
    $Run=@($null, "powershell -win 1 -nop -c iex `$env:R; # $id", 0, 0, 0, 0x0E080600, 0, $null, ($A4 -as $T[4]), ($A5 -as $T[5]))
    F 'CreateProcess' $Run; return}; $env:R=''; rp $key $id -force; $priv=[diagnostics.process]."GetM`ember"('SetPrivilege',42)[0]
    'SeSecurityPrivilege','SeTakeOwnershipPrivilege','SeBackupPrivilege','SeRestorePrivilege' |% {$priv.Invoke($null, @("$_",2))}
    $HKU=[uintptr][uint32]2147483651; $NT='S-1-5-18'; $reg=($HKU,$NT,8,2,($HKU -as $D[9])); F 'RegOpenKeyEx' $reg; $LNK=$reg[4]
    function L ($1,$2,$3) {sp 'HKLM:\Software\Classes\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}' 'RunAs' $3 -force -ea 0
    $b=[Text.Encoding]::Unicode.GetBytes("\Registry\User\$1"); F 'RegSetValueEx' @($2,'SymbolicLinkValue',0,6,[byte[]]$b,$b.Length)}
    function Q {[int](gwmi win32_process -filter 'name="explorer.exe"'|?{$_.getownersid().sid-eq$NT}|select -last 1).ProcessId}
    $11bug=($((gwmi Win32_OperatingSystem).BuildNumber)-eq'22000')-AND(($cmd-eq'file:')-OR(test-path -lit $cmd -PathType Container))
    if ($11bug) {'System.Windows.Forms','Microsoft.VisualBasic' |% {[Reflection.Assembly]::LoadWithPartialName("'$_")}}
    if ($11bug) {$path='^(l)'+$($cmd -replace '([\+\^\%\~\(\)\[\]])','{$1}')+'{ENTER}'; $cmd='control.exe'; $arg='admintools'}
    L ($key-split'\\')[1] $LNK ''; $R=[diagnostics.process]::start($cmd,$arg); if ($R) {$R.PriorityClass='High'; $R.WaitForExit()}
    if ($11bug) {$w=0; do {if($w-gt40){break}; sleep -mi 250;$w++} until (Q); [Microsoft.VisualBasic.Interaction]::AppActivate($(Q))}
    if ($11bug) {[Windows.Forms.SendKeys]::SendWait($path)}; do {sleep 7} while(Q); L '.Default' $LNK 'Interactive User'
'@; $V = ''; 'cmd', 'arg', 'id', 'key' | ForEach-Object { $V += "`n`$$_='$($(Get-Variable $_ -val)-replace"'","''")';" }; Set-ItemProperty $key $id $($V, $code) -type 7 -force -ea 0
    Start-Process powershell -args "-win 1 -nop -c `n$V `$env:R=(gi `$key -ea 0).getvalue(`$id)-join''; iex `$env:R" -verb runas -Wait
    }

	# Reinstall OneDrive
	Get-FileFromWeb -URL "https://go.microsoft.com/fwlink/?linkid=2324845" -File "$env:TEMP\OneDriveSetup.exe"
	Start-Process -Wait -FilePath "$env:TEMP\OneDriveSetup.exe" -ArgumentList "/silent", "/allusers"
	
	# Reset OneDrive Settings
	$batchCode = @'
@echo off
:: https://privacy.sexy — v0.13.8 — Sun, 19 Oct 2025 08:43:23 GMT
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


:: Restore previous environment settings
endlocal
'@

	$batPath = "$env:TEMP\FixOneDrive.bat"
	Set-Content -Path $batPath -Value $batchCode -Encoding ASCII
	Start-Process -FilePath $batPath -Wait -NoNewWindow *> $null							
pause