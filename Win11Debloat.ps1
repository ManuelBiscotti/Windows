#Requires -RunAsAdministrator

[CmdletBinding()]
param (
    [switch]$ActivateWindows,
    [switch]$PauseUpdates,
    [switch]$Runtimes,
    [switch]$CPlusPlus,
    [switch]$DirectX,
    [switch]$NET35,
    [switch]$Choco,
    [switch]$Winget,
    [switch]$CTTWinUtil,
    [switch]$Win11Debloat,
    [switch]$RemoveBloatware,
    [switch]$UninstallOneDrive,
    [switch]$RemoveEdge,
    [switch]$RemoveWindowsAI,
    [switch]$RemoveApps,
    [switch]$InstallStore,	
    [switch]$PrivacyTweaks,
    [switch]$WPD,
    [switch]$ShutUp10,
    [switch]$PrivacyIsSexy,
    [switch]$DisableSecurity,
    [switch]$DisbaleDefender,
    [switch]$DisableMitigations
)

function Activate-Windows {
	Write-Output "Activating Windows..."
	iex "& {$((irm https://get.activated.win))} /HWID"
}

function Pause-Updates {
	# Fix Windows Update
 	Write-Output "Fixing Windows Update..."
	$bat = "$env:TEMP\Fix Updates.bat"
 	iwr "https://raw.githubusercontent.com/ShadowWhisperer/Fix-WinUpdates/refs/heads/main/Fix%20Updates.bat" -OutFile $bat
	Start-Process cmd.exe -ArgumentList "/c echo.|`"$bat`"" -WindowStyle Normal -Wait
 	shutdown /a
	
 	# Extend updates delay to beyond 35 days
 	Write-Output "Disabling automatic updates..."
	Write-Output "Extending updates delay to beyond 35 days..."
 	iwr "https://github.com/Aetherinox/pause-windows-updates/raw/refs/heads/main/windows-updates-pause.reg" -OutFile "$env:TEMP\windows-updates-pause.reg"
	reg.exe import "$env:TEMP\windows-updates-pause.reg" *> $null
	
 	# Pause updates until 7/11/3000
	Write-Output "Pausing updates until 3000..."
 	$pe="3000-07-11T12:00:00Z"
	$ps=(Get-Date).ToString("yyyy-MM-ddT00:00:00Z")
 	$uk=@("PauseUpdatesExpiryTime",$pe),("PauseUpdatesStartTime",$ps),("PauseFeatureUpdatesStartTime",$ps),("PauseFeatureUpdatesEndTime",$pe),("PauseQualityUpdatesStartTime",$ps),("PauseQualityUpdatesEndTime",$pe)
	$p="HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
 	if(!(Test-Path $p)){New-Item $p -Force};$uk|%{Set-ItemProperty -Path $p -Name $_[0] -Value $_[1] -Type String}
	
 	# Disable driver offering through Windows Update 
	Write-Output "Disabling driver offering through Windows Update..."
 	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
	
 	# Disable Windows Update automatic restart
	Write-Output "Disabling Windows Update automatic restart..."
 	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
	
 	# Feature updates delayed by 2 years
 	# Security updates installled after 4 days
	Write-Output "Delaying Feature updates delayed by 2 years..."
	Write-Output "Delaying Security updates installled after 4 days..."
 	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings")) {New-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Force | Out-Null}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "BranchReadinessLevel" -Type DWord -Value 20
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "DeferFeatureUpdatesPeriodInDays" -Type DWord -Value 365
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "DeferQualityUpdatesPeriodInDays" -Type DWord -Value 4
}

function Install-CPlusPlus { 
	# Download and install Microsoft Visual C++ Redistributable Runtimes
 	Write-Output "Installing Visual C++ Redistributable All in One..."
	Get-FileFromWeb -URL "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE" -File "$env:TEMP\vcredist2005_x86.exe"			
	Get-FileFromWeb -URL "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE" -File "$env:TEMP\vcredist2005_x64.exe"	    	
	Get-FileFromWeb -URL "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -File "$env:TEMP\vcredist2008_x86.exe"	    	
	Get-FileFromWeb -URL "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe" -File "$env:TEMP\vcredist2008_x64.exe"	    	
	Get-FileFromWeb -URL "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe" -File "$env:TEMP\vcredist2010_x86.exe" 	    	
	Get-FileFromWeb -URL "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe" -File "$env:TEMP\vcredist2010_x64.exe"	    	
	Get-FileFromWeb -URL "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe" -File "$env:TEMP\vcredist2012_x86.exe"	    	
	Get-FileFromWeb -URL "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe" -File "$env:TEMP\vcredist2012_x64.exe"	    	
	Get-FileFromWeb -URL "https://aka.ms/highdpimfc2013x86enu" -File "$env:TEMP\vcredist2013_x86.exe"	    	
	Get-FileFromWeb -URL "https://aka.ms/highdpimfc2013x64enu" -File "$env:TEMP\vcredist2013_x64.exe"	    	
	Get-FileFromWeb -URL "https://aka.ms/vs/17/release/vc_redist.x86.exe" -File "$env:TEMP\vcredist2015_2017_2019_2022_x86.exe"	    	
	Get-FileFromWeb -URL "https://aka.ms/vs/17/release/vc_redist.x64.exe" -File "$env:TEMP\vcredist2015_2017_2019_2022_x64.exe"
	Start-Process -wait "$env:TEMP\vcredist2005_x86.exe" -ArgumentList "/q"	    	
	Start-Process -wait "$env:TEMP\vcredist2005_x64.exe" -ArgumentList "/q"	    	
	Start-Process -wait "$env:TEMP\vcredist2008_x86.exe" -ArgumentList "/qb"	    	
	Start-Process -wait "$env:TEMP\vcredist2008_x64.exe" -ArgumentList "/qb"	    	
	Start-Process -wait "$env:TEMP\vcredist2010_x86.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2010_x64.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2012_x86.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2012_x64.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2013_x86.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2013_x64.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2015_2017_2019_2022_x86.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2015_2017_2019_2022_x64.exe" -ArgumentList "/passive /norestart" 
}

function Install-DirectX { 
	# DirectX Runtime
 	Write-Output "Installing DirectX..."
	Remove-Item "$env:TEMP\DirectX","$env:SystemRoot\Temp\DirectX" -Recurse -Force
	Get-FileFromWeb -URL "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -File "$env:TEMP\DirectX.exe"
	Start-Process "$env:TEMP\DirectX.exe" -ArgumentList "/Q /T:`"$env:TEMP\DirectX`"" -Wait
	Start-Process "$env:TEMP\DirectX\DXSETUP.exe" -ArgumentList "/silent" -Wait		
}

function Install-NET35 {   
	# .NET Freamework 3.5 (includes .NET 2.0 and 3.0)
 	Write-Output "Installing .NET Freamework 3.5..."
	Get-FileFromWeb -URL "https://github.com/abbodi1406/dotNetFx35W10/releases/download/v0.20.01/dotNetFx35_WX_9_x86_x64.zip" -File "$env:TEMP\dotNetFx35_WX_9_x86_x64.zip"
	Expand-Archive "$env:TEMP\dotNetFx35_WX_9_x86_x64.zip" $env:TEMP -Force
	Start-Process "$env:TEMP\dotNetFx35_WX_9_x86_x64.exe" -ArgumentList "/ai /S /NORESTART" -Wait -NoNewWindow
}

function Install-Choco {
	# Allow script execution in current session
	Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
	
	# Ensure TLS 1.2 for secure downloads
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	
	# Check if Chocolatey is installed
	if (Get-Command choco -ErrorAction SilentlyContinue) {
	    # Upgrade Chocolatey if present
	    choco upgrade chocolatey -y --ignore-checksums
	}
	else {
	    # Remove old Chocolatey remnants if any
	    Remove-Item "C:\ProgramData\Chocolatey*" -Recurse -Force -ErrorAction SilentlyContinue
	    Remove-Item "C:\ProgramData\ChocolateyHttpCache" -Recurse -Force -ErrorAction SilentlyContinue
	
	    Start-Sleep -Seconds 3
	
	    # Install Chocolatey
	    Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	
	    # Wait until Chocolatey becomes available or timeout
	    $i = 0
	    while (-not (Get-Command choco -ErrorAction SilentlyContinue) -and $i -lt 20) {
	        Start-Sleep -Seconds 3
	        $i++
	    }
	}
}

function Repair-Winget {
	Install-Choco
 
	# Check if Winget is installed
	if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
	    # Upgrade Winget if present
	    choco upgrade winget -y --ignore-checksums
	}
	elseif (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
	    # Detect Windows build version
	    $build = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild
	
	    if ($build -le 19045) {
	        # For Windows 10
	        Start-Process -Wait powershell -ArgumentList '-NoProfile', '-Command', 'Invoke-RestMethod https://asheroto.com/winget | Invoke-Expression'
	    }
	    elseif ($build -ge 22000) {
	        # For Windows 11
	        choco install winget -y --force --ignore-checksums
	    }
	}
	else {
	    Write-Output "Unexpected condition: Unable to determine Winget state."
	}
}

function CTT-WinUtilAutomation {
<#
	Optional:
	// Run Disk Cleanup
	"WPFTweaksDiskCleanup"
	// Disable hibernation
	"WPFTweaksHiber"
	// Disable Full Screen optimization
	"WPFTweaksDisableFSO"
#>
$json = @'
{
    "WPFTweaks":  [
                      "WPFTweaksRestorePoint",
                      "WPFTweaksTeredo",
                      "WPFTweaksWifi",
                      "WPFTweaksRazerBlock",
                      "WPFTweaksRightClickMenu",
                      "WPFTweaksDebloatAdobe",
                      "WPFTweaksDisableWpbtExecution",
                      "WPFTweaksDisableLMS1",
                      "WPFTweaksStorage",
                      "WPFTweaksDeBloat",
                      "WPFTweaksRemoveHome",
                      "WPFTweaksIPv46",
                      "WPFTweaksConsumerFeatures",
                      "WPFTweaksDVR",
                      "WPFTweaksRemoveGallery",
                      "WPFTweaksTele",
                      "WPFTweaksDisplay",
                      "WPFTweaksAH",
                      "WPFTweaksEndTaskOnTaskbar",
                      "WPFTweaksBlockAdobeNet",
                      "WPFTweaksEdgeDebloat",
                      "WPFTweaksRemoveCopilot",
                      "WPFTweaksLoc",
                      "WPFTweaksRemoveOnedrive",
                      "WPFTweaksHome",
                      "WPFTweaksDisableExplorerAutoDiscovery",
                      "WPFTweaksBraveDebloat",
                      "WPFTweaksDisableNotifications",
                      "WPFTweaksPowershell7Tele",
                      "WPFTweaksDeleteTempFiles",
                      "WPFTweaksUTC",
                      "WPFTweaksRecallOff",
                      "WPFTweaksDisableBGapps",
                      "WPFTweaksPowershell7",
                      "WPFTweaksServices"				  				
                   ]
}
'@

	$config = "$env:TEMP\tweaks.json"
	$script = "$env:TEMP\winutil.ps1"
	
	Set-Content -Path $config -Value $json -Encoding ASCII
	iwr "https://github.com/ChrisTitusTech/winutil/releases/latest/download/winutil.ps1" -OutFile $script
	
	# Use Start-Process with redirected output
	$outFile = "$env:TEMP\winutil_log.txt"
	$psi = New-Object System.Diagnostics.ProcessStartInfo
	$psi.FileName = "powershell.exe"
	$psi.Arguments = "-NoProfile -Sta -ExecutionPolicy Bypass -File `"$script`" -Config `"$config`" -Run"
	$psi.RedirectStandardOutput = $true
	$psi.RedirectStandardError  = $true
	$psi.UseShellExecute = $false
	$psi.CreateNoWindow = $true
	
	$p = New-Object System.Diagnostics.Process
	$p.StartInfo = $psi
	$p.Start() | Out-Null
	
	$reader = $p.StandardOutput
	while (-not $p.HasExited) {
	    $line = $reader.ReadLine()
	    if ($line -ne $null) {
	        Write-Host $line
	        if ($line -match "Tweaks are Finished") {
	            Write-Host ">>> Marker found! Closing process..."
	            $p.Kill()
	            break
	        }
	    } else {
	        Start-Sleep -Milliseconds 200
	    }
	}
}

function Run-Win11Debloat {
	& ([scriptblock]::Create((irm "https://debloat.raphi.re/"))) `
	    -Silent `
	    -RemoveApps `
	    -RemoveHPApps `
	    -RemoveCommApps `
	    -RemoveW11Outlook `
	    -RemoveDevApps `
	    -RemoveGamingApps `
	    -ForceRemoveEdge `
	    -DisableDVR `
	    -DisableStartRecommended `
	    -DisableStartPhoneLink `
	    -DisableTelemetry `
	    -DisableSuggestions `
	    -DisableEdgeAds `
	    -DisableDesktopSpotlight `
	    -DisableLockscreenTips `
	    -DisableSettings365Ads `
	    -DisableSettingsHome `
	    -DisableBing `
	    -DisableCopilot `
	    -DisableRecall `
	    -DisableEdgeAI `
	    -DisablePaintAI `
	    -DisableNotepadAI `
	    -RevertContextMenu `
	    -DisableMouseAcceleration `
	    -DisableStickyKeys `
	    -DisableFastStartup `
	    -DisableModernStandbyNetworking `
	    -ShowHiddenFolders `
	    -ShowKnownFileExt `
	    -HideDupliDrive `
	    -EnableDarkMode `
	    -DisableTransparency `
	    -DisableAnimations `
	    -TaskbarAlignLeft `
	    -HideSearchTb `
	    -HideTaskview `
	    -HideChat `
	    -DisableWidgets `
	    -EnableEndTask `
	    -HideHome `
	    -HideGallery `
	    -ExplorerToThisPC `
	    -HideOnedrive `
	    -Hide3dObjects `
	    -HideIncludeInLibrary `
	    -HideGiveAccessTo `
	    -HideShare
}

# UNINSTALL MICROSOFT ONEDRIVE FUNCTION
function Uninstall-OneDrive {
    Write-Output "Uninstalling OneDrive..."
    irm asheroto.com/uninstallonedrive | iex *> $null
}

# REMOVE MICROSOFT EDGE FUNCTION
function Remove-Edge {
    Write-Output "Removing Edge..."
    iex "&{$(irm https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1)} -UninstallEdge -RemoveEdgeData -NonInteractive -Wait"
}

# REMOVE WINDOWS AI FEATURES FUNCTION
function Remove-WindowsAI {
    Write-Output "Removing Windows AI..."
# Create a response file with multiple "N" answers
$responses = ("N" * 20) -join "`r`n"
Set-Content -Path "$env:TEMP\responses.txt" -Value $responses

# Download the original script and remove ReadKey() calls
$scriptContent = (Invoke-WebRequest "https://raw.githubusercontent.com/zoicware/RemoveWindowsAI/main/RemoveWindowsAi.ps1" -UseBasicParsing).Content
$scriptContent = $scriptContent -replace '(?m)^.*ReadKey\(\).*$\n?', ''
Set-Content -Path "$env:TEMP\RemoveWindowsAI.ps1" -Value $scriptContent -Force

# Execute the script with redirected input in a new window
$process = Start-Process powershell.exe -ArgumentList @(
    '-NoProfile',
    '-ExecutionPolicy',
    'Bypass',
    '-File',
    "$env:TEMP\RemoveWindowsAI.ps1",
    '-NonInteractive',
    '-AllOptions'
) -RedirectStandardInput "$env:TEMP\responses.txt" -WorkingDirectory $env:TEMP -PassThru -Wait
}




<#
KEPT.
	NVIDIA, CBS, Winget, Snipping Tool
	Notepad(system), VBSCRIPT, Microsoft Paint, Windows Media Player Legacy (App)
	Media Features
#>
function Remove-Apps {
    # Remove Universal Windows Platform Apps
    Write-Output "Removing Apps..."
    Get-AppXPackage -AllUsers | Where-Object { $_.Name -notlike '*NVIDIA*' -and $_.Name -notlike '*CBS*' -and $_.Name -notlike '*DesktopAppInstaller*'} | Remove-AppxPackage
	
 	# Uninstall Remote Desktop Connection
 	Write-Output "Uninstalling Remote Desktop Connection..."
	
  
  	# Activate Windows Photo Viewer
	Write-Host "Activating Windows Photo Viewer..."
	'tif','tiff','bmp','dib','gif','jfif','jpe','jpeg','jpg','jxr','png','ico'|%{
 		reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".${_}" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >$null 2>&1
 		reg add "HKCU\SOFTWARE\Classes\.${_}" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >$null 2>&1
  	}
   
    # Remove Windows Capabilities
    Write-Output "Removing Optional features..."
    "App.StepsRecorder~~~~0.0.1.0",
	"App.Support.QuickAssist~~~~0.0.1.0",
	"Browser.InternetExplorer~~~~0.0.11.0",
	"DirectX.Configuration.Database~~~~0.0.1.0",
	"Hello.Face.18967~~~~0.0.1.0",
	"Hello.Face.20134~~~~0.0.1.0",
	"MathRecognizer~~~~0.0.1.0",
	"Microsoft.Wallpapers.Extended~~~~0.0.1.0",
	"Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0",
	"OneCoreUAP.OneSync~~~~0.0.1.0",
	"OpenSSH.Client~~~~0.0.1.0",
	"Print.Fax.Scan~~~~0.0.1.0",
	"Print.Management.Console~~~~0.0.1.0",
	"Windows.Kernel.LA57~~~~0.0.1.0",
	"Microsoft.Windows.WordPad~~~~0.0.1.0",
	"WMIC~~~~0.0.1.0" | % { Remove-WindowsCapability -Online -Name $_ | Out-Null }
 
	# Remove "Character Map" capability app
 	Write-Output "Removing Character Map..."
    function Set-ForceOwnership($p){
		cmd /c "takeown /f `"$p`" /a /r /d y >nul 2>&1"
		cmd /c "icacls `"$p`" /grant Administrators:F Everyone:F /t /c /q >nul 2>&1"
		$a=Get-Acl $p;if($a){$a.SetOwner([System.Security.Principal.NTAccount]"Administrators")
 			Set-Acl $p $a
		}
  	}
  	function Remove-Aggressive($p){
   		if(Test-Path $p){
	 		Set-ForceOwnership $p
  			Remove-Item $p -Force -Recurse
 			cmd /c "attrib -r -s -h `"$p`" /s /d >nul 2>&1 & del /f /s /q `"$p`" & rd /s /q `"$p`" >nul 2>&1"
		}
  	}
	$p = @(
	    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories",
	    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows Accessories", 
	    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows Tools",
	    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs",
	    "$env:AppData\Microsoft\Windows\Start Menu\Programs",
	    "$env:UserProfile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs",
	    "$env:AllUsersProfile\Microsoft\Windows\Start Menu\Programs",
	    "$env:CommonProgramFiles\Microsoft Shared\Windows\Start Menu\Programs"
	)	
	$n = @(
	    "Character Map.lnk",
	    "Character Map", 
	    "charmap.lnk",
	    "charmap"
	)
	$p | ForEach-Object { 
	    $d = $_
	    $n | ForEach-Object {
	        Get-ChildItem -Path $d -Recurse -Filter "*$_*" | ForEach-Object {
	            Remove-Aggressive $_.FullName
	        }
	    }
	} > $null 2>&1

	# Delete Internet Explorer shortcuts
	@(
    "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk",
    "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Internet Explorer.lnk",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Internet Explorer.lnk"
	) | ForEach-Object {
        if (Test-Path $_) {
            Remove-Item $_ -Force
        }
    }
	
    # Disable Windows Features
	'WCF-Services45',
	'WCF-TCP-PortSharing45',
	'Printing-PrintToPDFServices-Features',
	'Printing-XPSServices-Features',
	'Printing-Foundation-Features',
	'Printing-Foundation-InternetPrinting-Client',
	'MSRDC-Infrastructure',
	'SMB1Protocol',
	'SMB1Protocol-Client',
	'SMB1Protocol-Deprecation',
	'SmbDirect',
	'Windows-Identity-Foundation',
	'MicrosoftWindowsPowerShellV2Root',
	'MicrosoftWindowsPowerShellV2',
	'WorkFolders-Client',
	'Microsoft-Hyper-V-All',
	'Recall' | ForEach-Object { 
    	Dism /Online /NoRestart /Disable-Feature /FeatureName:$_ | Out-Null 
	} 

 	# Windows Stuff
  	# Ensure policy key exists and disable Bing search suggestions in the Start menu search box
	New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force | Out-Null; Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord | Out-Null 
	# Disable OneDrive, Edge, Brave and Google tasks
	Get-ScheduledTask | Where-Object { $_.TaskName -like "*OneDrive*" -or $_.TaskName -like "*Edge*" -or $_.TaskName -like "*Brave*" -or $_.TaskName -like "*Google*" } | ForEach-Object { Disable-ScheduledTask -TaskName $_.TaskName | Out-Null }
	# Kill Microsoft Text Input Application
	cmd /c "taskkill /F /IM TextInputHost.exe >nul 2>&1"; $d=Get-ChildItem "$env:SystemRoot\SystemApps" -Dir -Filter "MicrosoftWindows.Client.CBS_*"|Select-Object -First 1 -ExpandProperty FullName
	if($d){$x=Join-Path $d "TextInputHost.exe"
		if(Test-Path $x){cmd /c "takeown /f `"$x`" >nul 2>&1 & icacls `"$x`" /grant *S-1-3-4:F >nul 2>&1 & move /y `"$x`" `"$env:SystemRoot\TextInputHost.exe.bak`" >nul 2>&1"}
	}		
	# Create System Properties Start menu shortcut
	$t="$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\System Properties.lnk"
	$s=(New-Object -ComObject WScript.Shell).CreateShortcut($t)
	$s.TargetPath="$env:SystemRoot\System32\SystemPropertiesAdvanced.exe"
	$s.IconLocation="$env:SystemRoot\System32\SystemPropertiesAdvanced.exe"
	$s.Save()

 	# Windows 10 Stuff
 	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -le 19045) {
		# uninstall Microsoft Update Health Tools W10
		cmd /c "MsiExec.exe /X{1FC1A6C2-576E-489A-9B4A-92D21F542136} /qn >nul 2>&1"	
		# Disable AppX Deployment Service
		Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\AppXSvc" -Name "Start" -Value 4 -Type DWord | Out-Null
		# Disable TextInput Management Service	
		Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\TextInputManagementService" -Name "Start" -Value 4 -Type DWord | Out-Null
		# Show Copy as Path always in right-click menu          
		$regPath = "Registry::HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\windows.copyaspath"
		New-Item -Path $regPath -Force | Out-Null; Set-ItemProperty -Path $regPath -Name "(default)" -Value "Copy &as path" | Out-Null
		Set-ItemProperty -Path $regPath -Name "InvokeCommandOnSelection" -Value 1 -Type DWord | Out-Null
		Set-ItemProperty -Path $regPath -Name "VerbHandler" -Value "{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}" | Out-Null
		Set-ItemProperty -Path $regPath -Name "VerbName" -Value "copyaspath" | Out-Null   	
		# Disable News and interests
		New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -Force | Out-Null
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -Name 'EnableFeeds' -Value 0 -Type DWord | Out-Null	
 		# clean microsoft update health tools w10
		cmd /c "reg delete `"HKLM\SYSTEM\ControlSet001\Services\uhssvc`" /f >nul 2>&1"
		Unregister-ScheduledTask -TaskName PLUGScheduler -Confirm:$false
		# uninstall update for windows 10 for x64-based systems
		cmd /c "MsiExec.exe /X{B9A7A138-BFD5-4C73-A269-F78CCA28150E} /qn >nul 2>&1"
		cmd /c "MsiExec.exe /X{85C69797-7336-4E83-8D97-32A7C8465A3B} /qn >nul 2>&1"
		# clean adobe type manager w10
		cmd /c "reg delete `"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Drivers`" /f >nul 2>&1"
		# Remove "Meet Now" icon from taskbar
		New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
		Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 | Out-Null
		# CLEAN START MENU W10
		Remove-Item -Recurse -Force "$env:SystemDrive\Windows\StartMenuLayout.xml"
		$MultilineComment = @'
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
	<LayoutOptions StartTileGroupCellWidth="6" />
	<DefaultLayoutOverride>
		<StartLayoutCollection>
			<defaultlayout:StartLayout GroupCellWidth="6" />
		</StartLayoutCollection>
	</DefaultLayoutOverride>
</LayoutModificationTemplate>
'@
		Set-Content -Path "C:\Windows\StartMenuLayout.xml" -Value $MultilineComment -Force -Encoding ASCII
		$layoutFile="C:\Windows\StartMenuLayout.xml"
		$regAliases = @("HKLM", "HKCU")
		foreach ($regAlias in $regAliases){
		$basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
		$keyPath = $basePath + "\Explorer"
		IF(!(Test-Path -Path $keyPath)) { New-Item -Path $basePath -Name "Explorer" }	
		Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
		Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
		}	
		Stop-Process -Force -Name explorer
		Timeout /T 5 | Out-Null
		foreach ($regAlias in $regAliases){
		$basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
		$keyPath = $basePath + "\Explorer"
		Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
		}
		Stop-Process -Name explorer -Force
  	}

 	# Windows 11 Stuff
  	elseif ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
   		# Uninstall Microsoft Update Health Tools W11
		cmd /c "MsiExec.exe /X{C6FD611E-7EFE-488C-A0E0-974C09EF6473} /qn >nul 2>&1"
   		# Hide the recommended section in the start menu. This will also change the start menu layout to More pins
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Force | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "HideRecommendedSection" -Value 1 -Type DWord | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecommendedSection" -Value 1 -Type DWord | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Force | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Name "IsEducationEnvironment" -Value 1 -Type DWord | Out-Null
		# Remove all pinned apps from start https://github.com/Raphire/Win11Debloat/tree/refs/heads/master/Assets/Start
		Get-Process StartMenuExperienceHost | Stop-Process -Force | Out-Null; Start-Sleep -Milliseconds 200
		$dst="$env:LOCALAPPDATA\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin"
  		if (!(Test-Path (Split-Path $dst))){New-Item -Path (Split-Path $dst) -ItemType Directory -Force}
  		iwr 'https://github.com/Raphire/Win11Debloat/raw/refs/heads/master/Assets/Start/start2.bin' -OutFile $dst -UseBasicParsing
		# Restore New Text Document context menu item
		iwr "https://github.com/vishnusai-karumuri/Registry-Fixes/raw/refs/heads/master/Restore_New_Text_Document_context_menu_item.reg" -OutFile "$env:TEMP\Restore_New_Text_Document_context_menu_item.reg"
  		Start-Process regedit.exe -ArgumentList "/s `"$env:TEMP\Restore_New_Text_Document_context_menu_item.reg`"" -Wait
	 	# Rename Windows Media Player Legacy Start menu shortcut if it exists
		Rename-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows Media Player Legacy.lnk" -NewName "Windows Media Player.lnk" -Force
		# Install legacy Snipping Tool and Paint apps	
		# Ensure target directory exists
		New-Item -Path "C:\Program Files\Windows NT\Accessories" -ItemType Directory -Force | Out-Null
		# Snipping Tool (Windows 10 Version 1803)
		iwr "https://github.com/ManueITest/Windows/raw/main/SnippingTool.zip" -OutFile "$env:TEMP\SnippingTool.zip"
		Expand-Archive -Path "$env:TEMP\SnippingTool.zip" -DestinationPath "C:\Program Files\Windows NT\Accessories" -Force	
		# classic Paint (mspaint) app taken from Windows 10 Build 14393
		iwr "https://github.com/ManueITest/Windows/raw/main/Classic%20Paint.zip" -OutFile "$env:TEMP\ClassicPaint.zip"
		Expand-Archive -Path "$env:TEMP\ClassicPaint.zip" -DestinationPath "C:\Program Files\Windows NT\Accessories" -Force		
		# Ensure Accessories folder exists
		New-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories" -ItemType Directory -Force | Out-Null	
		# Create Snipping Tool Start menu shortcut
		$shell = New-Object -ComObject WScript.Shell
		$shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk")
		$shortcut.TargetPath = "C:\Program Files\Windows NT\Accessories\SnippingTool.exe"
		$shortcut.Save()	
		# Create Paint Start menu shortcut  
		$shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Paint.lnk")
		$shortcut.TargetPath = "C:\Program Files\Windows NT\Accessories\mspaint1.exe"
		$shortcut.Save()	
		# Create Notepad Start menu shortcut
		$shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Notepad.lnk")
		$shortcut.TargetPath = "$env:SystemRoot\System32\notepad.exe"
		$shortcut.Save()	
 	}
}else{   
}

function Install-Store {
 	Write-Output "Installing Microsoft Store..."
  	# Install Microsoft Store
	Get-AppXPackage -AllUsers *Microsoft.WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}       
	Get-AppXPackage -AllUsers *Microsoft.Microsoft.StorePurchaseApp* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}
}

function Run-WPD {
	# Run WPD automation
    Write-Output "Windows Privacy Dashboard Tweaks..."
    iwr "https://wpd.app/get/latest.zip" -OutFile "$env:TEMP\latest.zip"
    Expand-Archive "$env:TEMP\latest.zip" -DestinationPath "$env:TEMP" -Force
    Start-Process "$env:TEMP\WPD.exe" -ArgumentList "-wfpOnly","-wfp on","-recommended","-close" -Wait
}

# ShutUp10 Function
function Run-ShutUp10 {
    Write-Output "ShutUp10 Tweaks..."
    $configCode = @'
############################################################################
# This file was created with O&O ShutUp10++ V1.9.1444
# and can be imported onto another computer. 
#
# Download the application at https://www.oo-software.com/shutup10
# You can then import the file from within the program. 
#
# Alternatively you can import it automatically over a command line.
# Simply use the following parameter: 
# OOSU10.exe <path to file>
# 
# Selecting the Option /quiet ends the app right after the import and the
# user does not get any feedback about the import.
#
# We are always happy to answer any questions you may have!
# © 2015-2025 O&O Software GmbH, Berlin. All rights reserved.
# https://www.oo-software.com/
############################################################################

P001	+	# Disable sharing of handwriting data (Category: Privacy)
P002	+	# Disable sharing of handwriting error reports (Category: Privacy)
P003	+	# Disable Inventory Collector (Category: Privacy)
P004	+	# Disable camera in logon screen (Category: Privacy)
P005	+	# Disable and reset Advertising ID and info for the machine (Category: Privacy)
P006	+	# Disable and reset Advertising ID and info (Category: Privacy)
P008	+	# Disable transmission of typing information (Category: Privacy)
P026	+	# Disable advertisements via Bluetooth (Category: Privacy)
P027	+	# Disable the Windows Customer Experience Improvement Program (Category: Privacy)
P028	+	# Disable backup of text messages into the cloud (Category: Privacy)
P064	+	# Disable suggestions in the timeline (Category: Privacy)
P065	+	# Disable suggestions in Start (Category: Privacy)
P066	+	# Disable tips, tricks, and suggestions when using Windows (Category: Privacy)
P067	+	# Disable showing suggested content in the Settings app (Category: Privacy)
P070	+	# Disable the possibility of suggesting to finish the setup of the device (Category: Privacy)
P069	+	# Disable Windows Error Reporting (Category: Privacy)
P009	+	# Disable biometrical features (Category: Privacy)
P010	-	# Disable app notifications (Category: Privacy)
P015	+	# Disable access to local language for browsers (Category: Privacy)
P068	+	# Disable text suggestions when typing on the software keyboard (Category: Privacy)
P016	+	# Disable sending URLs from apps to Windows Store (Category: Privacy)
A001	+	# Disable recordings of user activity (Category: Activity History and Clipboard)
A002	+	# Disable storing users' activity history (Category: Activity History and Clipboard)
A003	+	# Disable the submission of user activities to Microsoft (Category: Activity History and Clipboard)
A004	+	# Disable storage of clipboard history for whole machine (Category: Activity History and Clipboard)
A006	+	# Disable storage of clipboard history (Category: Activity History and Clipboard)
A005	+	# Disable the transfer of the clipboard to other devices via the cloud (Category: Activity History and Clipboard)
P007	+	# Disable app access to user account information (Category: App Privacy)
P036	+	# Disable app access to user account information (Category: App Privacy)
P025	+	# Disable Windows tracking of app starts (Category: App Privacy)
P033	+	# Disable app access to diagnostics information (Category: App Privacy)
P023	+	# Disable app access to diagnostics information (Category: App Privacy)
P056	+	# Disable app access to device location (Category: App Privacy)
P057	+	# Disable app access to device location (Category: App Privacy)
P012	-	# Disable app access to camera (Category: App Privacy)
P034	-	# Disable app access to camera (Category: App Privacy)
P013	-	# Disable app access to microphone (Category: App Privacy)
P035	-	# Disable app access to microphone (Category: App Privacy)
P062	+	# Disable app access to use voice activation (Category: App Privacy)
P063	+	# Disable app access to use voice activation when device is locked (Category: App Privacy)
P081	+	# Disable the standard app for the headset button (Category: App Privacy)
P047	-	# Disable app access to notifications (Category: App Privacy)
P019	-	# Disable app access to notifications (Category: App Privacy)
P048	+	# Disable app access to motion (Category: App Privacy)
P049	+	# Disable app access to movements (Category: App Privacy)
P020	+	# Disable app access to contacts (Category: App Privacy)
P037	+	# Disable app access to contacts (Category: App Privacy)
P011	+	# Disable app access to calendar (Category: App Privacy)
P038	+	# Disable app access to calendar (Category: App Privacy)
P050	+	# Disable app access to phone calls (Category: App Privacy)
P051	+	# Disable app access to phone calls (Category: App Privacy)
P018	+	# Disable app access to call history (Category: App Privacy)
P039	+	# Disable app access to call history (Category: App Privacy)
P021	+	# Disable app access to email (Category: App Privacy)
P040	+	# Disable app access to email (Category: App Privacy)
P022	+	# Disable app access to tasks (Category: App Privacy)
P041	+	# Disable app access to tasks (Category: App Privacy)
P014	+	# Disable app access to messages (Category: App Privacy)
P042	+	# Disable app access to messages (Category: App Privacy)
P052	+	# Disable app access to radios (Category: App Privacy)
P053	+	# Disable app access to radios (Category: App Privacy)
P054	+	# Disable app access to unpaired devices (Category: App Privacy)
P055	+	# Disable app access to unpaired devices (Category: App Privacy)
P029	+	# Disable app access to documents (Category: App Privacy)
P043	+	# Disable app access to documents (Category: App Privacy)
P030	+	# Disable app access to images (Category: App Privacy)
P044	+	# Disable app access to images (Category: App Privacy)
P031	+	# Disable app access to videos (Category: App Privacy)
P045	+	# Disable app access to videos (Category: App Privacy)
P032	+	# Disable app access to the file system (Category: App Privacy)
P046	+	# Disable app access to the file system (Category: App Privacy)
P058	+	# Disable app access to wireless equipment (Category: App Privacy)
P059	+	# Disable app access to wireless technology (Category: App Privacy)
P060	+	# Disable app access to eye tracking (Category: App Privacy)
P061	+	# Disable app access to eye tracking (Category: App Privacy)
P071	+	# Disable the ability for apps to take screenshots (Category: App Privacy)
P072	+	# Disable the ability for apps to take screenshots (Category: App Privacy)
P073	+	# Disable the ability for desktop apps to take screenshots (Category: App Privacy)
P074	+	# Disable the ability for apps to take screenshots without borders (Category: App Privacy)
P075	+	# Disable the ability for apps to take screenshots without borders (Category: App Privacy)
P076	+	# Disable the ability for desktop apps to take screenshots without margins (Category: App Privacy)
P077	+	# Disable app access to music libraries (Category: App Privacy)
P078	+	# Disable app access to music libraries (Category: App Privacy)
P079	+	# Disable app access to downloads folder (Category: App Privacy)
P080	+	# Disable app access to downloads folder (Category: App Privacy)
P024	-	# Prohibit apps from running in the background (Category: App Privacy)
S001	+	# Disable password reveal button (Category: Security)
S002	+	# Disable user steps recorder (Category: Security)
S003	+	# Disable telemetry (Category: Security)
S008	+	# Disable Internet access of Windows Media Digital Rights Management (DRM) (Category: Security)
E101	+	# Disable tracking in the web (Category: Microsoft Edge (new version based on Chromium))
E201	+	# Disable tracking in the web (Category: Microsoft Edge (new version based on Chromium))
E115	+	# Disable check for saved payment methods by sites (Category: Microsoft Edge (new version based on Chromium))
E215	+	# Disable check for saved payment methods by sites (Category: Microsoft Edge (new version based on Chromium))
E118	+	# Disable personalizing advertising, search, news and other services (Category: Microsoft Edge (new version based on Chromium))
E218	+	# Disable personalizing advertising, search, news and other services (Category: Microsoft Edge (new version based on Chromium))
E107	+	# Disable automatic completion of web addresses in address bar (Category: Microsoft Edge (new version based on Chromium))
E207	+	# Disable automatic completion of web addresses in address bar (Category: Microsoft Edge (new version based on Chromium))
E111	+	# Disable user feedback in toolbar (Category: Microsoft Edge (new version based on Chromium))
E211	+	# Disable user feedback in toolbar (Category: Microsoft Edge (new version based on Chromium))
E112	+	# Disable storing and autocompleting of credit card data on websites (Category: Microsoft Edge (new version based on Chromium))
E212	+	# Disable storing and autocompleting of credit card data on websites (Category: Microsoft Edge (new version based on Chromium))
E109	+	# Disable form suggestions (Category: Microsoft Edge (new version based on Chromium))
E209	+	# Disable form suggestions (Category: Microsoft Edge (new version based on Chromium))
E121	+	# Disable suggestions from local providers (Category: Microsoft Edge (new version based on Chromium))
E221	+	# Disable suggestions from local providers (Category: Microsoft Edge (new version based on Chromium))
E103	+	# Disable search and website suggestions (Category: Microsoft Edge (new version based on Chromium))
E203	+	# Disable search and website suggestions (Category: Microsoft Edge (new version based on Chromium))
E123	+	# Disable shopping assistant in Microsoft Edge (Category: Microsoft Edge (new version based on Chromium))
E223	+	# Disable shopping assistant in Microsoft Edge (Category: Microsoft Edge (new version based on Chromium))
E124	+	# Disable Edge bar (Category: Microsoft Edge (new version based on Chromium))
E224	+	# Disable Edge bar (Category: Microsoft Edge (new version based on Chromium))
E128	+	# Disable Sidebar in Microsoft Edge (Category: Microsoft Edge (new version based on Chromium))
E228	+	# Disable Sidebar in Microsoft Edge (Category: Microsoft Edge (new version based on Chromium))
E129	+	# Disable the Microsoft Account Sign-In Button (Category: Microsoft Edge (new version based on Chromium))
E229	+	# Disable the Microsoft Account Sign-In Button (Category: Microsoft Edge (new version based on Chromium))
E130	+	# Disable Enhanced Spell Checking (Category: Microsoft Edge (new version based on Chromium))
E230	+	# Disable Enhanced Spell Checking (Category: Microsoft Edge (new version based on Chromium))
E119	+	# Disable use of web service to resolve navigation errors (Category: Microsoft Edge (new version based on Chromium))
E219	+	# Disable use of web service to resolve navigation errors (Category: Microsoft Edge (new version based on Chromium))
E120	+	# Disable suggestion of similar sites when website cannot be found (Category: Microsoft Edge (new version based on Chromium))
E220	+	# Disable suggestion of similar sites when website cannot be found (Category: Microsoft Edge (new version based on Chromium))
E122	+	# Disable preload of pages for faster browsing and searching (Category: Microsoft Edge (new version based on Chromium))
E222	+	# Disable preload of pages for faster browsing and searching (Category: Microsoft Edge (new version based on Chromium))
E125	+	# Disable saving passwords for websites (Category: Microsoft Edge (new version based on Chromium))
E225	+	# Disable saving passwords for websites (Category: Microsoft Edge (new version based on Chromium))
E126	+	# Disable site safety services for more information about a visited website (Category: Microsoft Edge (new version based on Chromium))
E226	+	# Disable site safety services for more information about a visited website (Category: Microsoft Edge (new version based on Chromium))
E131	+	# Disable automatic redirection from Internet Explorer to Microsoft Edge (Category: Microsoft Edge (new version based on Chromium))
E106	+	# Disable SmartScreen Filter (Category: Microsoft Edge (new version based on Chromium))
E206	+	# Disable SmartScreen Filter (Category: Microsoft Edge (new version based on Chromium))
E127	+	# Disable typosquatting checker for site addresses (Category: Microsoft Edge (new version based on Chromium))
E227	+	# Disable typosquatting checker for site addresses (Category: Microsoft Edge (new version based on Chromium))
E001	+	# Disable tracking in the web (Category: Microsoft Edge (legacy version))
E002	+	# Disable page prediction (Category: Microsoft Edge (legacy version))
E003	+	# Disable search and website suggestions (Category: Microsoft Edge (legacy version))
E008	+	# Disable Cortana in Microsoft Edge (Category: Microsoft Edge (legacy version))
E007	+	# Disable automatic completion of web addresses in address bar (Category: Microsoft Edge (legacy version))
E010	+	# Disable showing search history (Category: Microsoft Edge (legacy version))
E011	+	# Disable user feedback in toolbar (Category: Microsoft Edge (legacy version))
E012	+	# Disable storing and autocompleting of credit card data on websites (Category: Microsoft Edge (legacy version))
E009	+	# Disable form suggestions (Category: Microsoft Edge (legacy version))
E004	+	# Disable sites saving protected media licenses on my device (Category: Microsoft Edge (legacy version))
E005	+	# Do not optimize web search results on the task bar for screen reader (Category: Microsoft Edge (legacy version))
E013	+	# Disable Microsoft Edge launch in the background (Category: Microsoft Edge (legacy version))
E014	+	# Disable loading the start and new tab pages in the background (Category: Microsoft Edge (legacy version))
E006	+	# Disable SmartScreen Filter (Category: Microsoft Edge (legacy version))
Y001	+	# Disable synchronization of all settings (Category: Synchronization of Windows Settings)
Y002	+	# Disable synchronization of design settings (Category: Synchronization of Windows Settings)
Y003	+	# Disable synchronization of browser settings (Category: Synchronization of Windows Settings)
Y004	+	# Disable synchronization of credentials (passwords) (Category: Synchronization of Windows Settings)
Y005	+	# Disable synchronization of language settings (Category: Synchronization of Windows Settings)
Y006	+	# Disable synchronization of accessibility settings (Category: Synchronization of Windows Settings)
Y007	+	# Disable synchronization of advanced Windows settings (Category: Synchronization of Windows Settings)
C012	+	# Disable and reset Cortana (Category: Cortana (Personal Assistant))
C002	+	# Disable Input Personalization (Category: Cortana (Personal Assistant))
C013	+	# Disable online speech recognition (Category: Cortana (Personal Assistant))
C007	+	# Cortana and search are disallowed to use location (Category: Cortana (Personal Assistant))
C008	+	# Disable web search from Windows Desktop Search (Category: Cortana (Personal Assistant))
C009	+	# Disable display web results in Search (Category: Cortana (Personal Assistant))
C010	+	# Disable download and updates of speech recognition and speech synthesis models (Category: Cortana (Personal Assistant))
C011	+	# Disable cloud search (Category: Cortana (Personal Assistant))
C014	+	# Disable Cortana above lock screen (Category: Cortana (Personal Assistant))
C015	+	# Disable the search highlights in the taskbar (Category: Cortana (Personal Assistant))
C101	+	# Disable the Windows Copilot (Category: Windows AI)
C201	+	# Disable the Windows Copilot (Category: Windows AI)
C204	+	# Disable the provision of recall functionality to all users (Category: Windows AI)
C205	+	# Disable the Image Creator in Microsoft Paint (Category: Windows AI)
C102	+	# Disable the Copilot button from the taskbar (Category: Windows AI)
C103	+	# Disable Windows Copilot+ Recall (Category: Windows AI)
C203	+	# Disable Windows Copilot+ Recall (Category: Windows AI)
C206	+	# Disable Cocreator in Microsoft Paint (Category: Windows AI)
C207	+	# Disable AI-powered image fill in Microsoft Paint (Category: Windows AI)
L001	+	# Disable functionality to locate the system (Category: Location Services)
L003	+	# Disable scripting functionality to locate the system (Category: Location Services)
L004	-	# Disable sensors for locating the system and its orientation (Category: Location Services)
L005	+	# Disable Windows Geolocation Service (Category: Location Services)
U001	+	# Disable application telemetry (Category: User Behavior)
U004	+	# Disable diagnostic data from customizing user experiences for whole machine (Category: User Behavior)
U005	+	# Disable the use of diagnostic data for a tailor-made user experience (Category: User Behavior)
U006	+	# Disable diagnostic log collection (Category: User Behavior)
U007	+	# Disable downloading of OneSettings configuration settings (Category: User Behavior)
W001	+	# Disable Windows Update via peer-to-peer (Category: Windows Update)
W011	+	# Disable updates to the speech recognition and speech synthesis modules. (Category: Windows Update)
W004	+	# Activate deferring of upgrades (Category: Windows Update)
W005	+	# Disable automatic downloading manufacturers' apps and icons for devices (Category: Windows Update)
W010	+	# Disable automatic driver updates through Windows Update (Category: Windows Update)
W009	+	# Disable automatic app updates through Windows Update (Category: Windows Update)
P017	+	# Disable Windows dynamic configuration and update rollouts (Category: Windows Update)
W006	+	# Disable automatic Windows Updates (Category: Windows Update)
W008	+	# Disable Windows Updates for other products (e.g. Microsoft Office) (Category: Windows Update)
M006	+	# Disable occassionally showing app suggestions in Start menu (Category: Windows Explorer)
M011	+	# Do not show recently opened items in Jump Lists on "Start" or the taskbar (Category: Windows Explorer)
M010	+	# Disable ads in Windows Explorer/OneDrive (Category: Windows Explorer)
O003	+	# Disable OneDrive access to network before login (Category: Windows Explorer)
O001	+	# Disable Microsoft OneDrive (Category: Windows Explorer)
S012	+	# Disable Microsoft SpyNet membership (Category: Microsoft Defender and Microsoft SpyNet)
S013	+	# Disable submitting data samples to Microsoft (Category: Microsoft Defender and Microsoft SpyNet)
S014	+	# Disable reporting of malware infection information (Category: Microsoft Defender and Microsoft SpyNet)
K001	+	# Disable Windows Spotlight (Category: Lock Screen)
K002	+	# Disable fun facts, tips, tricks, and more on your lock screen (Category: Lock Screen)
K005	+	# Disable notifications on lock screen (Category: Lock Screen)
D001	+	# Disable access to mobile devices (Category: Mobile Devices)
D002	+	# Disable Phone Link app (Category: Mobile Devices)
D003	+	# Disable showing suggestions for using mobile devices with Windows (Category: Mobile Devices)
D104	+	# Disable connecting the PC to mobile devices (Category: Mobile Devices)
M025	+	# Disable search with AI in search box (Category: Search)
M003	+	# Disable extension of Windows search with Bing (Category: Search)
M015	+	# Disable People icon in the taskbar (Category: Taskbar)
M016	+	# Disable search box in task bar (Category: Taskbar)
M017	+	# Disable "Meet now" in the task bar (Category: Taskbar)
M018	+	# Disable "Meet now" in the task bar (Category: Taskbar)
M019	+	# Disable news and interests in the task bar (Category: Taskbar)
M021	+	# Disable widgets in Windows Explorer (Category: Taskbar)
M022	+	# Disable feedback reminders (Category: Miscellaneous)
M001	+	# Disable feedback reminders (Category: Miscellaneous)
M004	+	# Disable automatic installation of recommended Windows Store Apps (Category: Miscellaneous)
M005	+	# Disable tips, tricks, and suggestions while using Windows (Category: Miscellaneous)
M024	+	# Disable Windows Media Player Diagnostics (Category: Miscellaneous)
M026	+	# Disable remote assistance connections to this computer (Category: Miscellaneous)
M027	+	# Disable remote connections to this computer (Category: Miscellaneous)
M028	+	# Disable the desktop icon for information on "Windows Spotlight" (Category: Miscellaneous)
M012	+	# Disable Key Management Service Online Activation (Category: Miscellaneous)
M013	+	# Disable automatic download and update of map data (Category: Miscellaneous)
M014	+	# Disable unsolicited network traffic on the offline maps settings page (Category: Miscellaneous)
N001	+	# Disable Network Connectivity Status Indicator (Category: Miscellaneous)
'@
    Set-Content -Path "$env:TEMP\ooshutup10.cfg" -Value $configCode -Force
    iwr "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -OutFile "$env:TEMP\OOSU10.exe"
    Start-Process -FilePath "$env:TEMP\OOSU10.exe" -ArgumentList "$env:TEMP\ooshutup10.cfg","/quiet" -WorkingDirectory $env:TEMP -Verb RunAs -Wait
}

function Run-PrivacySexy {

}

function Disable-Defender {
    Write-Output "Disabling Defender..."
	# Create batch file
	$batchCode = @'
@echo off

:: Disable UAC
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f > nul 2>&1

:: Disable Firewall
netsh advfirewall set allprofiles state off > nul 2>&1

:: Disable security notifications
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f > nul 2>&1

:: Disable virtualization-based security
bcdedit /set hypervisorlaunchtype off > nul 2>&1
bcdedit /set vsmlaunchtype off > nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f > nul 2>&1

:: Disable SecurityHealthService
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v Start /t REG_DWORD /d 4 /f > nul 2>&1

:: Remove SecurityHealth tray icon
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f > nul 2>&1

:: Download and run DefenderSwitcher
powershell -NoProfile -Command "try { Invoke-WebRequest 'https://github.com/instead1337/Defender-Switcher/releases/latest/download/DefenderSwitcher.ps1' -OutFile '%TEMP%\DefenderSwitcher.ps1' -UseBasicParsing } catch { }"
powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\DefenderSwitcher.ps1" -disable_av
'@

	# Save batch file
	Set-Content -Path "$env:TEMP\DisableDefender.bat" -Value $batchCode -Encoding ASCII

	# Execute with RunAsTI
	RunAsTI -TargetPath "$env:TEMP\DisableDefender.bat" -Wait
}

function Disable-Mitigations {
	    Write-Output "Disabling Mitigations..."
	$batchCode = @'
@echo off
setlocal EnableDelayedExpansion

:: Disable Spectre and Meltdown
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f > nul 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f > nul

:: Disable Structured Exception Handling Overwrite Protection (SEHOP)
:: Exists in ntoskrnl strings, keep for now
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f > nul

:: Disable Control Flow Guard (CFG)
:: Find correct mitigation values for different Windows versions
:: Initialize bit mask in registry by disabling a random mitigation
PowerShell -NoP -C "Set-ProcessMitigation -System -Disable CFG"

:: Get current bit mask
for /f "tokens=3 skip=2" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions"') do (
    set "mitigation_mask=%%a"
)

:: Set all bits to 2 (Disable all process mitigations)
for /l %%a in (0,1,9) do (
    set "mitigation_mask=!mitigation_mask:%%a=2!"
)
:: Fix Valorant with mitigations disabled - enable CFG
set "enableCFGApps=valorant valorant-win64-shipping vgtray vgc"
PowerShell -NoP -C "foreach ($a in $($env:enableCFGApps -split ' ')) {Set-ProcessMitigation -Name $a`.exe -Enable CFG}" > nul 

:: Apply mask to kernel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul

:: Disable file system mitigations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f > nul
'@

	$batPath = "$env:TEMP\DisableAllMitigations.bat"
	Set-Content -Path $batPath -Value $batchCode -Encoding ASCII
	cmd.exe /c "`"$batPath`""
}




function Registry-Tweaks {
	$MultilineComment = @'
Windows Registry Editor Version 5.00

; --SERVICES--


[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AarSvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AJRouter]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ALG]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AppIDSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Appinfo]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AppMgmt]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AppReadiness]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AppVClient]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AppXSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AssignedAccessManagerSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AudioEndpointBuilder]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Audiosrv]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\autotimesvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\AxInstSV]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BcastDVRUserService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BDESVC]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BFE]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BITS]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BluetoothUserService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Browser]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BrokerInfrastructure]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BTAGService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\BthAvctpSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bthserv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\camsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CaptureService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\cbdhsvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CDPSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CDPUserSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CertPropSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ClipSVC]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CloudBackupRestoreSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\cloudidsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\COMSysApp]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ConsentUxUserSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CredentialEnrollmentManagerUserSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CryptSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\CscService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DcomLaunch]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dcsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\defragsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DeviceAssociationBrokerSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DeviceAssociationService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DeviceInstall]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DevicePickerUserSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DevicesFlowUserSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DevQueryBroker]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Dhcp]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\diagnosticshub.standardcollector.service]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\diagsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DiagTrack]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DialogBlockingService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DispBrokerDesktopSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DisplayEnhancementService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DmEnrollmentSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dmwappushservice]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Dnscache]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DoSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\dot3svc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DPS]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DsmSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DsSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\DusmSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EapHost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\edgeupdatem]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\edgeupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EFS]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\embeddedmode]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EntAppSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EventLog]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EventSystem]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Fax]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\fdPHost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\FDResPub]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\fhsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\FontCache]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\FontCache3.0.0.0]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\FrameServerMonitor]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\FrameServer]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\GameInputSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\gpsvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\GraphicsPerfSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\hidserv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\HvHost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\icssvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\IKEEXT]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\InstallService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\InventorySvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\iphlpsvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\IpxlatCfgSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\KeyIso]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\KtmRm]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\LanmanServer]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\LanmanWorkstation]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\lfsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\LicenseManager]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\lltdsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\lmhosts]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\logi_lamparray_service]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\LSM]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\LxpSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MapsBroker]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\McpManagementService]
"Start"=dword:00000003

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MDCoreSvc]
; "Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MessagingService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MicrosoftEdgeElevationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MixedRealityOpenXRSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\mpssvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MSDTC]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MSiSCSI]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\msiserver]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\MsKeyboardFilter]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NaturalAuthentication]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NcaSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NcbService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NcdAutoSetup]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Netlogon]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Netman]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\netprofm]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NetSetupSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NetTcpPortSharing]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NgcCtnrSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NgcSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NlaSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NPSMSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\nsi]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\OneSyncSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\p2pimsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\p2psvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\P9RdrService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PcaSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PeerDistSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PenService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\perceptionsimulation]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PerfHost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PhoneSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PimIndexMaintenanceSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\pla]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PlugPlay]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PNRPAutoReg]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PNRPsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PolicyAgent]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Power]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PrintNotify]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PrintWorkflowUserSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ProfSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\PushToInstall]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\QWAVE]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RasAuto]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RasMan]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RemoteAccess]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RemoteRegistry]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RetailDemo]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RmSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RpcEptMapper]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RpcLocator]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RpcSs]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SamSs]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SCardSvr]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ScDeviceEnum]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Schedule]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SCPolicySvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SDRSVC]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\seclogon]
"Start"=dword:00000003

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService]
; "Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SEMgrSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SensorDataService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SensorService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SensrSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SENS]
"Start"=dword:00000002

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense]
; "Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SessionEnv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SgrmBroker]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedRealitySvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ShellHWDetection]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\shpamsvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\smphost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SmsRouter]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SNMPTrap]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\spectrum]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Spooler]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\sppsvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SSDPSRV]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\ssh-agent]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SstpSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\StateRepository]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\stisvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\StiSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\StorSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\svsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\swprv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SysMain]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SystemEventsBroker]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TabletInputService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TapiSrv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TermService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TextInputManagementService]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Themes]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TieringEngineService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TimeBrokerSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TokenBroker]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TrkWks]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TroubleshootingSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TrustedInstaller]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\tzautoupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UdkUserSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UevAgentService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\uhssvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UmRdpService]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UnistoreSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\upnphost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UserDataSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UserManager]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\UsoSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\VacSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\VaultSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vds]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmicguestinterface]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmicheartbeat]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmickvpexchange]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmicrdv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmicshutdown]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmictimesync]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmicvmsession]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vmicvss]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\VSS]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\W32Time]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WaaSMedicSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WalletService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WarpJITSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wbengine]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WbioSrvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Wcmsvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wcncsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WdiServiceHost]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WdiSystemHost]
"Start"=dword:00000003

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc]
; "Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WebClient]
"Start"=dword:00000003

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\webthreatdefsvc]
; "Start"=dword:00000003

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\webthreatdefusersvc]
; "Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Wecsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WEPHOSTSVC]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wercplsupport]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WerSvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WFDSConMgrSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WiaRpc]
"Start"=dword:00000003

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend]
; "Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WinHttpAutoProxySvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Winmgmt]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WinRM]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wisvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WlanSvc]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wlidsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wlpasvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WManSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wmiApSrv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WMPNetworkSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\workfolderssvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WpcMonSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WPDBusEnum]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WpnService]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WpnUserService]
"Start"=dword:00000002

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc]
; "Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WSearch]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wuauserv]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WwanSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XblAuthManager]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XblGameSave]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XboxGipSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XboxNetApiSvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BraveElevationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\brave]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\bravem]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\jhi_service]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WMIRegistrationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Intel(R) Platform License Manager Service]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ipfsvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\igccservice]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cplspcon]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LMS]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\IntelAudioService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Intel(R) Capability Licensing Service TCP IP Interface]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cphs]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DSAService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DSAUpdateService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\igfxCUIService2.0.0.0]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RstMwService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Intel(R) SUR QC SAM]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SystemUsageReportSvc_QUEENCREEK]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAfsService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SynTPEnhService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NahimicService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RtkAudioUniversalService]
"Start"=dword:00000004




; --LEGACY CONTROL PANEL--




; EASE OF ACCESS
; disable narrator
[HKEY_CURRENT_USER\Software\Microsoft\Narrator\NoRoam]
"DuckAudio"=dword:00000000
"WinEnterLaunchEnabled"=dword:00000000
"ScriptingEnabled"=dword:00000000
"OnlineServicesEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Narrator]
"NarratorCursorHighlight"=dword:00000000
"CoupleNarratorCursorKeyboard"=dword:00000000

; disable ease of access settings 
[HKEY_CURRENT_USER\Software\Microsoft\Ease of Access]
"selfvoice"=dword:00000000
"selfscan"=dword:00000000

[HKEY_CURRENT_USER\Control Panel\Accessibility]
"Sound on Activation"=dword:00000000
"Warning Sounds"=dword:00000000

[HKEY_CURRENT_USER\Control Panel\Accessibility\HighContrast]
"Flags"="4194"

[HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response]
"Flags"="2"
"AutoRepeatRate"="0"
"AutoRepeatDelay"="0"

[HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys]
"Flags"="130"
"MaximumSpeed"="39"
"TimeToMaximumSpeed"="3000"

[HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]
"Flags"="2"

[HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]
"Flags"="34"

[HKEY_CURRENT_USER\Control Panel\Accessibility\SoundSentry]
"Flags"="0"
"FSTextEffect"="0"
"TextEffect"="0"
"WindowsEffect"="0"

[HKEY_CURRENT_USER\Control Panel\Accessibility\SlateLaunch]
"ATapp"=""
"LaunchAT"=dword:00000000




; CLOCK AND REGION
; disable notify me when the clock changes
[HKEY_CURRENT_USER\Control Panel\TimeDate]
"DstNotification"=dword:00000000




; APPEARANCE AND PERSONALIZATION
; disable spotlight
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableCloudOptimizedContent"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsSpotlightFeatures"=dword:00000001
"DisableWindowsSpotlightWindowsWelcomeExperience"=dword:00000001
"DisableWindowsSpotlightOnActionCenter"=dword:00000001
"DisableWindowsSpotlightOnSettings"=dword:00000001
"DisableThirdPartySuggestions"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]
"{2cc5ca98-6485-489a-920e-b3e88a6ccce3}"=dword:00000001

; open file explorer to this pc
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"LaunchTo"=dword:00000001

; hide frequent folders in quick access
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowFrequent"=dword:00000000

; show file name extensions
; show hidden files
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"HideFileExt"=dword:00000000
"Hidden"=dword:00000001

; disable search history
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDeviceSearchHistoryEnabled"=dword:00000000

; disable show files from office.com
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowCloudFilesInQuickAccess"=dword:00000000

; disable display file size information in folder tips
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"FolderContentsInfoTip"=dword:00000000

; enable display full path in the title bar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState]
"FullPath"=dword:00000001

; disable show pop-up description for folder and desktop items
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowInfoTip"=dword:00000000

; disable show preview handlers in preview pane
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowPreviewHandlers"=dword:00000000

; disable show status bar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowStatusBar"=dword:00000000

; disable show sync provider notifications
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowSyncProviderNotifications"=dword:00000000

; disable use sharing wizard
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SharingWizardOn"=dword:00000000

; disable show network
[HKEY_CURRENT_USER\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}]
"System.IsPinnedToNameSpaceTree"=dword:00000000




; HARDWARE AND SOUND
; disable lock [ optional ]
; [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]
; "ShowLockOption"=dword:00000000

; disable sleep [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]
; "ShowSleepOption"=dword:00000000

; sound communications do nothing
[HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio]
"UserDuckingPreference"=dword:00000003

; disable startup sound
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation]
"DisableStartupSound"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\EditionOverrides]
"UserSetting_DisableStartupSound"=dword:00000001

; sound scheme none
[HKEY_CURRENT_USER\AppEvents\Schemes]
@=".None"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceFail\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\FaxBeep\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MailBeep\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MessageNudge\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.IM\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Mail\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Proximity\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Reminder\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.SMS\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\ProximityConnection\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOnSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubSleepSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\MisrecoSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\PanelSound\.current]
@=""

; disable autoplay
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers]
"DisableAutoplay"=dword:00000001

; disable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; mouse pointers scheme none
[HKEY_CURRENT_USER\Control Panel\Cursors]
"AppStarting"=hex(2):00,00
"Arrow"=hex(2):00,00
"ContactVisualization"=dword:00000000
"Crosshair"=hex(2):00,00
"GestureVisualization"=dword:00000000
"Hand"=hex(2):00,00
"Help"=hex(2):00,00
"IBeam"=hex(2):00,00
"No"=hex(2):00,00
"NWPen"=hex(2):00,00
"Scheme Source"=dword:00000000
"SizeAll"=hex(2):00,00
"SizeNESW"=hex(2):00,00
"SizeNS"=hex(2):00,00
"SizeNWSE"=hex(2):00,00
"SizeWE"=hex(2):00,00
"UpArrow"=hex(2):00,00
"Wait"=hex(2):00,00
@=""

; disable device installation settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001




; NETWORK AND INTERNET
; disable allow other network users to control or disable the shared internet connection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Network\SharedAccessConnection]
"EnableControl"=dword:00000000




; SYSTEM AND SECURITY
; prefer IPv4 over IPv6
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters]
"DisabledComponents"=dword:00000020

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"EnablePMTUDiscovery"=dword:00000001
"EnablePMTUBHDetect"=dword:00000000
"Tcp1323Opts"=dword:00000001
"SackOpts"=dword:00000001
"DefaultTTL"=dword:00000040
"GlobalMaxTcpWindowSize"=dword:00007fff

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"MaxCacheEntryTtlLimit"=dword:0000fa00
"MaxNegativeCacheTtl"=dword:00000000

; set appearance options to custom
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects]
"VisualFXSetting"=dword:3

; Visual Effects
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"UserPreferencesMask"=hex:90,12,03,80,10,00,00,00
"DragFullWindows"="1"

; animate windows when minimizing and maximizing
[HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
"MinAnimate"="0"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ListviewAlphaSelect"=dword:00000001
"IconsOnly"=dword:00000000
"TaskbarAnimations"=dword:00000000 ; animations in the taskbar
"ListviewShadow"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
"EnableAeroPeek"=dword:00000000
"AlwaysHibernateThumbnails"=dword:00000000

; adjust for best performance of programs
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
"ConvertibleSlateMode"=dword:00000000
"Win32PrioritySeparation"=dword:00000026

; disable remote assistance
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance]
"fAllowToGetHelp"=dword:00000000

; system responsiveness 100%
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
"NetworkThrottlingIndex"=dword:ffffffff
"SystemResponsiveness"=dword:00000000

; cpu priority for gaming
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000005
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing]
"Affinity"=dword:00000000
"Background Only"="True"
"BackgroundPriority"=dword:00000008
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000008
"Scheduling Category"="High"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000004
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"Affinity"=dword:00000000
"Background Only"="False"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="High"
"SFIO Priority"="High"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback]
"Affinity"=dword:00000000
"Background Only"="False"
"BackgroundPriority"=dword:00000004
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000003
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio]
"Affinity"=dword:00000000
"Background Only"="False"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000001
"Scheduling Category"="High"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000005
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

; enable virtual memory
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000001
"HotPatchTableSize"=dword:00001000
"LargeSystemCache"=dword:00000000
"NonPagedPoolQuota"=dword:00000000
"NonPagedPoolSize"=dword:00000000
"PagedPoolQuota"=dword:00000000
"PagedPoolSize"=dword:00000000
"PagingFiles"=hex(7):63,00,3a,00,5c,00,70,00,61,00,67,00,65,00,66,00,69,00,6c,\
  00,65,00,2e,00,73,00,79,00,73,00,20,00,31,00,36,00,20,00,38,00,31,00,39,00,\
  32,00,00,00,00,00
"SecondLevelDataCache"=dword:00000000
"SessionPoolSize"=dword:00000004
"SessionViewSize"=dword:00000030
"SystemPages"=dword:00000000
"SwapfileControl"=dword:00000000
"AutoReboot"=dword:00000000
"CrashDumpEnabled"=dword:00000000
"Overwrite"=dword:00000000
"LogEvent"=dword:00000000
"MinidumpsCount"=dword:00000020
"FeatureSettings"=dword:00000000
"FeatureSettingsOverrideMask"=dword:00000003
"FeatureSettingsOverride"=dword:00000003
"PhysicalAddressExtension"=dword:00000001
"ExistingPageFiles"=hex(7):5c,00,3f,00,3f,00,5c,00,43,00,3a,00,5c,00,70,00,61,\
  00,67,00,65,00,66,00,69,00,6c,00,65,00,2e,00,73,00,79,00,73,00,00,00,00,00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnablePrefetcher"=dword:00000000
"EnableBootTrace"=dword:00000000
"EnableSuperfetch"=dword:00000000
; "SfTracingState"=dword:00000001




; DISABLE WINDOWS SECURITY SETTINGS
; cloud delivered protection
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
"SpyNetReporting"=dword:00000000

; automatic sample submission
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
"SubmitSamplesConsent"=dword:00000000

; disable firewall notifications
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications]
"DisableEnhancedNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Virus and threat protection]
"NoActionNotificationDisabled"=dword:00000001
"SummaryNotificationDisabled"=dword:00000001
"FilesBlockedNotificationDisabled"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Defender Security Center\Account protection]
"DisableNotifications"=dword:00000001
"DisableDynamiclockNotifications"=dword:00000001
"DisableWindowsHelloNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Epoch]
"Epoch"=dword:000004cf

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile]
"DisableNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile]
"DisableNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile]
"DisableNotifications"=dword:00000001

; exploit protection, leaving control flow guard cfg on for vanguard anticheat
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\kernel]
"MitigationOptions"=hex:22,22,22,00,00,01,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00

; disable core isolation 
; memory integrity 
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; disable device guard
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceGuard]
"EnableVirtualizationBasedSecurity"=dword:00000000
"RequirePlatformSecurityFeatures"=-
"HypervisorEnforcedCodeIntegrity"=-
"HVCIMATRequired"=dword:00000000
"LsaCfgFlags"=-
"ConfigureSystemGuardLaunch"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard]
"EnableVirtualizationBasedSecurity"=dword:00000000
"RequirePlatformSecurityFeatures"=-
"HypervisorEnforcedCodeIntegrity"=-
"HVCIMATRequired"=dword:00000000
"LsaCfgFlags"=-
"ConfigureSystemGuardLaunch"=-

; disable local security authority protection
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"RunAsPPL"=dword:00000000
"RunAsPPLBoot"=dword:00000000

; disable microsoft vulnerable driver blocklist
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\CI\Config]
"VulnerableDriverBlocklistEnable"=dword:00000000

; disable Bitlocker
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BitLocker]
"PreventDeviceEncryption"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE]
"DisableExternalDMAUnderLock"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices]
"TCGSecurityActivationDisabled"=dword:00000001

; kernel-mode hardware-enforced stack protection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; spectre and meltdown
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management]
"FeatureSettingsOverrideMask"=dword:00000003
"FeatureSettingsOverride"=dword:00000003

; other mitigations
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsMitigation]
"UserPreference"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig]
"EnableSvchostMitigationPolicy"=hex(b):00,00,00,00,00,00,00,00

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
; "MitigationAuditOptions"=hex:00,00,00,00,00,00,20,22,00,00,00,00,00,00,00,20,00,00,00,00,00,00,00,00
; "MitigationOptions"=hex:00,22,22,20,22,20,22,22,20,00,00,00,00,20,00,20,00,00,00,00,00,00,00,00
; "KernelSEHOPEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; disable uac
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableLUA"=dword:00000000

; disable smartscreen
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"SmartScreenEnabled"="Off"

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

; disable smartscreen in edge
[HKEY_CURRENT_USER\Software\Microsoft\Edge\SmartScreenEnabled]
"(Default)"="0"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenEnabled]
@=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenPuaEnabled]
@=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter]
"EnabledV9"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\MicrosoftEdge\PhishingFilter]
"EnabledV9"=dword:00000000

; disable smartscreen for store apps
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost]
"EnableWebContentEvaluation"=dword:00000000
"PreventOverride"=dword:00000000

; disable fth
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\FTH]
"Enabled"=dword:00000000

; hide family options settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options]
"UILockdown"=dword:00000001

; hide account protection settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection]
"UILockdown"=dword:00000001

; hide device security settings (optional)
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security]
; "UILockdown"=dword:00000001




; TROUBLESHOOTING
; disable automatic maintenance
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]
"MaintenanceDisabled"=dword:00000001




; SECURITY AND MAINTENANCE
; disable report problems
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001
"DontSendAdditionalData"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\HandwritingErrorReports]
"PreventHandwritingErrorReports"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports]
"PreventHandwritingErrorReports"=dword:00000001

; dont send a windows error report when a generic driver is installed on a device
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendGenericDriverNotFoundToWER"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendGenericDriverNotFoundToWER"=dword:00000001

; prevent windows from sending an error report when a device driver requests additional software during installation
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendRequestAdditionalSoftwareToWER"=dword:00000001

; Increase System Restore Point Creation Frequency
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore]
"SystemRestorePointCreationFrequency"=dword:00000000




; --IMMERSIVE CONTROL PANEL--




; WINDOWS UPDATE
; disable automatic updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
"AUOptions"=dword:00000002
; Breaks 'Receive updates for other Microsoft products'
; "NoAutoUpdate"=dword:00000001
; enable notifications for security updates only (do not auto-download)
; "AutoInstallMinorUpdates"=dword:00000000

; prevent automatic upgrade to windows 11 and defer quality updates for 1 year
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"TargetReleaseVersion"=dword:00000001
"TargetReleaseVersionInfo"="22H2"
"ProductVersion"="Windows 10"
"DeferFeatureUpdates"=dword:00000001
"DeferFeatureUpdatesPeriodInDays"=dword:0000016d
"DeferQualityUpdates"=dword:00000001
"DeferQualityUpdatesPeriodInDays"=dword:00000007

; block workplace join prompt
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin]
"BlockAADWorkplaceJoin"=dword:00000001

; turn off driver updates via win update
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate]
"value"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
"DontSearchWindowsUpdate"=dword:00000001

; disable delivery optimization
; gray out settings [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization]
; "DODownloadMode"=dword:00000000

[HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings]
"DownloadMode"=dword:00000000




; PRIVACY
; disable password reveal button
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI]
"DisablePasswordReveal"=dword:00000001

; disable show me notification in the settings app
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications]
"EnableAccountNotifications"=dword:00000000

; disable location
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location]
"Value"="Deny"

; disable allow location override
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\UserLocationOverridePrivacySetting]
"Value"=dword:00000000

; enable camera
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam]
"Value"="Allow"

; enable microphone 
[Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone]
"Value"="Allow"

; disable voice activation
[HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps]
"AgentActivationEnabled"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps]
"AgentActivationLastUsed"=dword:00000000

; disable notifications
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener]
"Value"="Deny"

; disable action center [ optional ]
; [HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]
; "DisableNotificationCenter"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
; "DisableNotificationCenter"=dword:00000001

; disable account info
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation]
"Value"="Deny"

; disable contacts
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts]
"Value"="Deny"

; disable calendar
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments]
"Value"="Deny"

; disable phone calls
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall]
"Value"="Deny"

; disable call history
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory]
"Value"="Deny"

; disable email
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email]
"Value"="Deny"

; disable tasks
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks]
"Value"="Deny"

; disable messaging
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat]
"Value"="Deny"

; disable radios
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios]
"Value"="Deny"

; disable other devices 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync]
"Value"="Deny"

; app diagnostics 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics]
"Value"="Deny"

; disable documents
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary]
"Value"="Deny"

; disable downloads folder 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder]
"Value"="Deny"

; disable music library
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary]
"Value"="Deny"

; disable pictures
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary]
"Value"="Deny"

; disable videos
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary]
"Value"="Deny"

; disable file system
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess]
"Value"="Deny"

; disable let websites show me locally relevant content by accessing my language list 
[HKEY_CURRENT_USER\Control Panel\International\User Profile]
"HttpAcceptLanguageOptOut"=dword:00000001

; disable let windows improve start and search results by tracking app launches  
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\EdgeUI]
"DisableMFUTracking"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EdgeUI]
"DisableMFUTracking"=dword:00000001

; disable personal inking and typing dictionary
[HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization]
"RestrictImplicitInkCollection"=dword:00000001
"RestrictImplicitTextCollection"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization\TrainedDataStore]
"HarvestContacts"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings]
"AcceptedPrivacyPolicy"=dword:00000000

; disable sending required data
[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000

; feedback frequency never
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules]
"NumberOfSIUFInPeriod"=dword:00000000
"PeriodInNanoSeconds"=-

; disable store my activity history on this device 
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"PublishUserActivities"=dword:00000000




; SEARCH
; disable search highlights
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDynamicSearchBoxEnabled"=dword:00000000

; disable safe search
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"SafeSearchMode"=dword:00000000

; disable cloud content search for work or school account
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsAADCloudSearchEnabled"=dword:00000000

; disable cloud content search for microsoft account
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsMSACloudSearchEnabled"=dword:00000000




; EASE OF ACCESS
; disable magnifier settings 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\ScreenMagnifier]
"FollowCaret"=dword:00000000
"FollowNarrator"=dword:00000000
"FollowMouse"=dword:00000000
"FollowFocus"=dword:00000000

; disable narrator settings
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator]
"IntonationPause"=dword:00000000
"ReadHints"=dword:00000000
"ErrorNotificationType"=dword:00000000
"EchoChars"=dword:00000000
"EchoWords"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome]
"MinimizeType"=dword:00000000
"AutoStart"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam]
"EchoToggleKeys"=dword:00000000

; disable use the print screen key to open screeen capture
[HKEY_CURRENT_USER\Control Panel\Keyboard]
"PrintScreenKeyForSnippingEnabled"=dword:00000000




; GAMING
; disable game bar
[HKEY_CURRENT_USER\System\GameConfigStore]
"GameDVR_Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]
"AppCaptureEnabled"=dword:00000000

; disable enable open xbox game bar using game controller
[HKEY_CURRENT_USER\Software\Microsoft\GameBar]
"UseNexusForGameBarEnabled"=dword:00000000

; disable game mode
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar]
"AllowAutoGameMode"=dword:00000000
"AutoGameModeEnabled"=dword:00000000

; other settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]
"AudioEncodingBitrate"=dword:0001f400
"AudioCaptureEnabled"=dword:00000000
"CustomVideoEncodingBitrate"=dword:003d0900
"CustomVideoEncodingHeight"=dword:000002d0
"CustomVideoEncodingWidth"=dword:00000500
"HistoricalBufferLength"=dword:0000001e
"HistoricalBufferLengthUnit"=dword:00000001
"HistoricalCaptureEnabled"=dword:00000000
"HistoricalCaptureOnBatteryAllowed"=dword:00000001
"HistoricalCaptureOnWirelessDisplayAllowed"=dword:00000001
"MaximumRecordLength"=hex(b):00,D0,88,C3,10,00,00,00
"VideoEncodingBitrateMode"=dword:00000002
"VideoEncodingResolutionMode"=dword:00000002
"VideoEncodingFrameRateMode"=dword:00000000
"EchoCancellationEnabled"=dword:00000001
"CursorCaptureEnabled"=dword:00000000
"VKToggleGameBar"=dword:00000000
"VKMToggleGameBar"=dword:00000000
"VKSaveHistoricalVideo"=dword:00000000
"VKMSaveHistoricalVideo"=dword:00000000
"VKToggleRecording"=dword:00000000
"VKMToggleRecording"=dword:00000000
"VKTakeScreenshot"=dword:00000000
"VKMTakeScreenshot"=dword:00000000
"VKToggleRecordingIndicator"=dword:00000000
"VKMToggleRecordingIndicator"=dword:00000000
"VKToggleMicrophoneCapture"=dword:00000000
"VKMToggleMicrophoneCapture"=dword:00000000
"VKToggleCameraCapture"=dword:00000000
"VKMToggleCameraCapture"=dword:00000000
"VKToggleBroadcast"=dword:00000000
"VKMToggleBroadcast"=dword:00000000
"MicrophoneCaptureEnabled"=dword:00000000
"SystemAudioGain"=hex(b):10,27,00,00,00,00,00,00
"MicrophoneGain"=hex(b):10,27,00,00,00,00,00,00




; TIME & LANGUAGE 
; disable show the voice typing mic button
[HKEY_CURRENT_USER\Software\Microsoft\input\Settings]
"IsVoiceTypingKeyEnabled"=dword:00000000

; disable capitalize the first letter of each sentence
; disable play key sounds as i type
; disable add a period after i double-tap the spacebar
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\1.7]
"EnableAutoShiftEngage"=dword:00000000
"EnableKeyAudioFeedback"=dword:00000000
"EnableDoubleTapSpace"=dword:00000000

; disable typing insights
[HKEY_CURRENT_USER\Software\Microsoft\input\Settings]
"InsightsEnabled"=dword:00000000




; ACCOUNTS
; disable use my sign in info after restart
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"DisableAutomaticRestartSignOn"=dword:00000001




; APPS
; disable automatically update maps
[HKEY_LOCAL_MACHINE\SYSTEM\Maps]
"AutoUpdateEnabled"=dword:00000000

; disable archive apps 
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx]
"AllowAutomaticAppArchiving"=dword:00000000

; turn off resume
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration]
"IsResumeAllowed"=dword:00000000

; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume]  
; "DisableCrossDeviceResume"=dword:00000001  

; disable sync apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowSyncMySettings]
"value"=dword:00000000




; PERSONALIZATION
; solid color personalize your background
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Wallpaper"=""

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000001

; dark theme 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000000
"SystemUsesLightTheme"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000000

; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent]
; "StartColorMenu"=dword:ff3d3f41
; "AccentColorMenu"=dword:ff484a4c
; "AccentPalette"=hex(3):DF,DE,DC,00,A6,A5,A1,00,68,65,62,00,4C,4A,48,00,41,\
; 3F,3D,00,27,25,24,00,10,0D,0D,00,10,7C,10,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"EnableWindowColorization"=dword:00000001
"AccentColor"=dword:ff484a4c
"ColorizationColor"=dword:c44c4a48
"ColorizationAfterglow"=dword:c44c4a48

; disable transparency
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000000

; always hide most used list in start menu
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"ShowOrHideMostUsedApps"=dword:00000002

[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"ShowOrHideMostUsedApps"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoStartMenuMFUprogramsList"=-
"NoInstrumentation"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoStartMenuMFUprogramsList"=-
"NoInstrumentation"=-

; start menu hide recommended w11
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Start]
"HideRecommendedSection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Education]
"IsEducationEnvironment"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"HideRecommendedSection"=dword:00000001

; more pins personalization start
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_Layout"=dword:00000001

; disable show recently added apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"HideRecentlyAddedApps"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideRecentlyAddedApps"=dword:00000001

; disable show account-related notifications
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_AccountNotifications"=dword:00000000

; disable show recently opened items in start, jump lists and file explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_TrackDocs"=dword:00000000 
"Start_ShowRecentDocs"=dword:00000000

; left taskbar alignment
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarAl"=dword:00000000

; remove chat from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarMn"=dword:00000000

; remove task view from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowTaskViewButton"=dword:00000000

; remove search from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
"SearchboxTaskbarMode"=dword:00000000

; remove windows widgets from taskbar
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh] 
"AllowNewsAndInterests"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds]
"ShellFeedsTaskbarOpenOnHover"=dword:00000000

; remove copilot from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowCopilotButton"=dword:00000000

; remove meet now
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=dword:00000001

; remove news and interests
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds]
"EnableFeeds"=dword:00000000

; show all taskbar icons [ optional ]
; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
; "EnableAutoTray"=dword:00000000

; remove security taskbar icon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run]
"SecurityHealth"=hex(3):07,00,00,00,05,DB,8A,69,8A,49,D9,01

; disable use dynamic lighting on my devices
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"AmbientLightingEnabled"=dword:00000000

; disable compatible apps in the forground always control lighting 
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"ControlledByForegroundApp"=dword:00000000

; disable match my windows accent color 
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"UseSystemAccentColor"=dword:00000000

; disable show key background
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\1.7]
"IsKeyBackgroundEnabled"=dword:00000000

; disable show recommendations for tips shortcuts new apps and more
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_IrisRecommendations"=dword:00000000

; disable share any window from my taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarSn"=dword:00000000

; disable online tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\EdgeUI]
"DisableHelpSticker"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001




; DEVICES
; disable usb issues notify
[HKEY_CURRENT_USER\Software\Microsoft\Shell\USB]
"NotifyOnUsbErrors"=dword:00000000

; disable let windows manage my default printer
[HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows]
"LegacyDefaultPrinterMode"=dword:00000001

; disable write with your fingertip
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\EmbeddedInkControl]
"EnableInkingWithTouch"=dword:00000000




; SYSTEM
; 100% dpi scaling
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000060
"Win8DpiScaling"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
"UseDpiScaling"=dword:00000000

; disable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000000

; turn on hardware accelerated gpu scheduling
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"HwSchMode"=dword:00000002

; disable variable refresh rate & enable optimizations for windowed games
[HKEY_CURRENT_USER\Software\Microsoft\DirectX\UserGpuPreferences]
"DirectXUserGlobalSettings"="SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;"

; disable notifications
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications]
"ToastEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"RotatingLockScreenEnabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement]
"ScoobeSystemSettingEnabled"=dword:00000000

; disable suggested actions
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard]
"Disabled"=dword:00000001

; disable focus assist
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\??windows.data.notifications.quiethourssettings\Current]
"Data"=hex(3):02,00,00,00,B4,67,2B,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,14,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,55,00,6E,00,72,00,65,00,73,00,74,00,72,\
00,69,00,63,00,74,00,65,00,64,00,CA,28,D0,14,02,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentfullscreen?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,97,1D,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,26,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,41,00,6C,00,61,00,72,00,6D,00,73,00,4F,\
00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentgame?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,6C,39,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,50,00,72,00,69,00,6F,00,72,00,69,00,74,\
00,79,00,4F,00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentpostoobe?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,06,54,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,50,00,72,00,69,00,6F,00,72,00,69,00,74,\
00,79,00,4F,00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentpresentation?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,83,6E,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,26,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,41,00,6C,00,61,00,72,00,6D,00,73,00,4F,\
00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentscheduled?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,2E,8A,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,50,00,72,00,69,00,6F,00,72,00,69,00,74,\
00,79,00,4F,00,6E,00,6C,00,79,00,C2,28,01,D1,32,80,E0,AA,8A,99,30,D1,3C,80,\
E0,F6,C5,D5,0E,CA,50,00,00

; battery options optimize for video quality
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\VideoSettings]
"VideoQualityOnBattery"=dword:00000001

; disable storage sense
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\StorageSense]
"AllowStorageSenseGlobal"=dword:00000000

; disable snap window settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SnapAssist"=dword:00000000
"DITest"=dword:00000000
"EnableSnapBar"=dword:00000000
"EnableTaskGroups"=dword:00000000
"EnableSnapAssistFlyout"=dword:00000000
"SnapFill"=dword:00000000
"JointResize"=dword:00000000

; alt tab open windows only
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"MultiTaskingAltTabFilter"=dword:00000003

; disable share across devices
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP]
"RomeSdkChannelUserAuthzPolicy"=dword:00000000
"CdpSessionUserAuthzPolicy"=dword:00000000

; disable Clipboard
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000000

; disable Clipboard history
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000000




; --OTHER--




; STORE
; disable update apps automatically
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore]
"AutoDownload"=dword:00000002




; EDGE
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]
"Edge3PSerpTelemetryEnabled"=dword:00000000
"EdgeAssetDeliveryServiceEnabled"=dword:00000000
"EdgeDiscoverEnabled"=dword:00000000
"EdgeEDropEnabled"=dword:00000000
"EdgeEnhanceImagesEnabled"=dword:00000000
"EdgeWalletCheckoutEnabled"=dword:00000000
"EdgeWalletEtreeEnabled"=dword:00000000
"ExperimentationAndConfigurationServiceControl"=dword:00000000
"ForceSync"=dword:00000000
"ImageEditorServiceEnabled"=dword:00000000
"InAppSupportEnabled"=dword:00000000
"InternetExplorerIntegrationLevel"=dword:00000000
"LiveCaptionsAllowed"=dword:00000000
"LiveTranslationAllowed"=dword:00000000
"MathSolverEnabled"=dword:00000000
"MicrosoftEdgeInsiderPromotionEnabled"=dword:00000000
"MicrosoftEditorSynonymsEnabled"=dword:00000000
"MicrosoftOfficeMenuEnabled"=dword:00000000
"OutlookHubMenuEnabled"=dword:00000000
"PersonalizeTopSitesInCustomizeSidebarEnabled"=dword:00000000
"PictureInPictureOverlayEnabled"=dword:00000000
"PromptForDownloadLocation"=dword:00000000
"SpeechRecognitionEnabled"=dword:00000000
"TextPredictionEnabled"=dword:00000000
"TranslateEnabled"=dword:00000001
"TravelAssistanceEnabled"=dword:00000000
"UploadFromPhoneEnabled"=dword:00000000
"UrlDiagnosticDataEnabled"=dword:00000000
"VisualSearchEnabled"=dword:00000000
"WalletDonationEnabled"=dword:00000000
"DefaultGeolocationSetting"=dword:00000002
"DefaultNotificationsSetting"=dword:00000002
"DefaultLocalFontsSetting"=dword:00000002
"DefaultSensorsSetting"=dword:00000002
"DefaultSerialGuardSetting"=dword:00000002
"CloudReportingEnabled"=dword:00000000
"DriveDisabled"=dword:00000001
"PasswordSharingEnabled"=dword:00000000
"PasswordLeakDetectionEnabled"=dword:00000000
"QuickAnswersEnabled"=dword:00000000
"SafeBrowsingExtendedReportingEnabled"=dword:00000000
"SafeBrowsingSurveysEnabled"=dword:00000000
"SafeBrowsingDeepScanningEnabled"=dword:00000000
"DeviceActivityHeartbeatEnabled"=dword:00000000
"DeviceMetricsReportingEnabled"=dword:00000000
"HeartbeatEnabled"=dword:00000000
"LogUploadEnabled"=dword:00000000
"ReportAppInventory"="00000000"
"ReportDeviceActivityTimes"=dword:00000000
"ReportDeviceAppInfo"=dword:00000000
"ReportDeviceSystemInfo"=dword:00000000
"ReportDeviceUsers"=dword:00000000
"ReportWebsiteTelemetry"=""
"BrowserGuestModeEnabled"=dword:0000000
"BuiltInDnsClientEnabled"=dword:00000000
"ParcelTrackingEnabled"=dword:00000000
"ShoppingListEnabled"=dword:00000000
"ControlDefaultStateOfAllowExtensionFromOtherStoresSettingEnabled"=dword:00000001
"BlockExternalExtensions"=dword:00000000
"GenAILocalFoundationalModelSettings"=dword:00000001
"LinkedAccountEnabled"=dword:00000000
"ProactiveAuthWorkflowEnabled"=dword:00000000
"WebToBrowserSignInEnabled"=dword:00000000
"EdgeManagementEnabled"=dword:00000000
"EdgeManagementExtensionsFeedbackEnabled"=dword:00000000
"MAMEnabled"=dword:00000000
"PasswordGeneratorEnabled"=dword:00000000
"PasswordRevealEnabled"=dword:00000000
"PasswordMonitorAllowed"=dword:00000000
"RelatedWebsiteSetsEnabled"=dword:00000000
"ScarewareBlockerProtectionEnabled"=dword:00000000
"SmartScreenEnabled"=dword:00000000
"SmartScreenPuaEnabled"=dword:00000000
"SmartScreenForTrustedDownloadsEnabled"=dword:00000000
"SmartScreenDnsRequestsEnabled"=dword:00000000
"NewTabPageAppLauncherEnabled"=dword:00000000
"NewTabPageBingChatEnabled"=dword:00000000
"NewTabPagePrerenderEnabled"=dword:00000000
"AADWebSiteSSOUsingThisProfileEnabled"=dword:00000000
"AccessibilityImageLabelsEnabled"=dword:00000000
"AIGenThemesEnabled"=dword:00000000
"AllowGamesMenu"=dword:00000000
"AmbientAuthenticationInPrivateModesEnabled"=dword:00000000
"AutomaticHttpsDefault"=dword:00000001
"BingAdsSuppression"=dword:00000001
"ComposeInlineEnabled"=dword:00000000
"CryptoWalletEnabled"=dword:00000000
"ExtensionManifestV2Availability"=dword:00000002
"ApplicationGuardTrafficIdentificationEnabled"=dword:00000000
"PasswordExportEnabled"=dword:00000000
"ExtensionsPerformanceDetectorEnabled"=dword:00000000
"PerformanceDetectorEnabled"=dword:00000000
"GamerModeEnabled"=dword:00000000
"SeamlessWebToBrowserSignInEnabled"=dword:00000000
"ImmersiveReaderGrammarToolsEnabled"=dword:00000000
"ImmersiveReaderPictureDictionaryEnabled"=dword:00000000
"ShoppingAssistantEnabled"=dword:00000000
"PriceComparisonEnabled"=dword:00000000
"SidebarEnabled"=dword:00000000
"PinnedToTaskbar"=dword:00000000
"CreateDesktopShortcutDefault"=dword:00000000
"RunAllTime"=dword:00000000
"MetricsReportingEnabled"=dword:00000000
"TrackingPrevention"=dword:00000003
"PromotionalTabsEnabled"=dword:00000000
"SpotlightExperiencesAndRecommendationsEnabled"=dword:00000000
"HardwareAccelerationModeEnabled"=dword:00000000
"NewTabPageLocation"="about:blank"
"EdgeHistoryAISearchEnabled"=dword:00000000
"BackgroundModeEnabled"=dword:00000000
"DiagnosticData"=dword:00000000
"ConfigureDoNotTrack"=dword:00000001
"ConfigureOnStartup"=dword:00000000
"PaymentMethodQueryEnabled"=dword:00000000
"PersonalizationReportingEnabled"=dword:00000000
"AddressBarMicrosoftSearchInBingProviderEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000
"AutofillCreditCardEnabled"=dword:00000000
"AutofillAddressEnabled"=dword:00000000
"LocalProvidersEnabled"=dword:00000000
"SearchSuggestEnabled"=dword:00000000
"EdgeShoppingAssistantEnabled"=dword:00000000
"WebWidgetAllowed"=dword:00000000
"HubsSidebarEnabled"=dword:00000000
"BrowserSignin"=dword:00000000
"MicrosoftEditorProofingEnabled"=dword:00000000
"ResolveNavigationErrorsUseWebService"=dword:00000000
"AlternateErrorPagesEnabled"=dword:00000000
"NetworkPredictionOptions"=dword:00000002
"PasswordManagerEnabled"=dword:00000000
"SiteSafetyServicesEnabled"=dword:00000000
"TyposquattingCheckerEnabled"=dword:00000000
"AutoImportAtFirstRun"=dword:00000004
"ShowRecommendationsEnabled"=dword:00000000
"HideFirstRunExperience"=dword:00000001
"FirstRunExperience"=dword:00000000
"PinBrowserEssentialsToolbarButton"=dword:00000000
"DefaultBrowserSettingEnabled"=dword:00000000
"EdgeFollowEnabled"=dword:00000000
"StandaloneHubsSidebarEnabled"=dword:00000000
"SyncDisabled"=dword:00000001
"HideRestoreDialogEnabled"=dword:00000001
"ShowMicrosoftRewards"=dword:00000000
"QuickSearchShowMiniMenu"=dword:00000000
"ImplicitSignInEnabled"=dword:00000000
"EdgeCollectionsEnabled"=dword:00000000
"SplitScreenEnabled"=dword:00000000
"SearchbarAllowed"=dword:00000000
"StartupBoostEnabled"=dword:00000000
"NewTabPageHideDefaultTopSites"=dword:00000001
"NewTabPageQuickLinksEnabled"=dword:00000000
"NewTabPageAllowedBackgroundTypes"=dword:00000003
"NewTabPageContentEnabled"=dword:00000000
"UpdateNotificationsAllowed"=dword:00000000
"ApplicationGuardFavoritesSyncEnabled"=dword:00000000
"ApplicationGuardPassiveModeEnabled"=dword:00000000
"ApplicationGuardUploadBlockingEnabled"=dword:00000000
"EdgeWorkspacesEnabled"=dword:00000000
"ReadAloudEnabled"=dword:00000000
"ShowAcrobatSubscriptionButton"=dword:00000000
"ShowOfficeShortcutInFavoritesBar"=dword:00000000
"SpellcheckEnabled"=dword:00000000
"TabServiceEnabled"=dword:00000000
"HttpsUpgradesEnabled"=dword:00000001
"NonRemovableProfileEnabled"=dword:00000000
"ProactiveAuthEnabled"=dword:00000000




; block desktop shortcut for all edge channels
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"CreateDesktopShortcutDefault"=dword:00000000

; disable edge updates
[HKEY_CURRENT_USER\Software\Policies\Microsoft\EdgeUpdate]
"UpdateDefault"=dword:00000000

; disable auto-updates for all users
; prevent edge from staying up-to-date automatically
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"UpdateDefault"=dword:00000000
"AutoUpdateCheckPeriodMinutes"=dword:00000000

; block all update channels
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"=dword:00000000
"Update{2CD8A007-E189-4D47-B5A4-DD5A7A6D2766}"=dword:00000000
"Update{65C35B14-6C1D-4122-AC46-7148CC9D6497}"=dword:00000000

; disable Edge as default PDF viewer
[HKEY_CLASSES_ROOT\.pdf]
@="AcroExch.Document.DC"

[HKEY_CLASSES_ROOT\.pdf\OpenWithProgids]
"AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723"=-

; Disable Edge update notifications
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"UpdateDefault"=dword:00000000
"AutoUpdateCheckPeriodMinutes"=dword:00000000

; edge telemetry
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]
[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker]

[HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\BooksLibrary]
"EnableExtendedBooksTelemetry"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MicrosoftEdge\BooksLibrary]
"EnableExtendedBooksTelemetry"=dword:00000000

; dont send edge data
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection]
"MicrosoftEdgeDataOptIn"=dword:00000000

; edge preload
[HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader]
"AllowTabPreloading"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader]
"AllowTabPreloading"=dword:00000000

; force install uBlock origin and webrtc control extensions in edge
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist]
"1"="odfafepnkmbhccpbejgmiehpchacaeak;https://edge.microsoft.com/extensionwebstorebase/v1/crx"
"2"="eepeadgljpkkjpbfecfkijnnliikglpl;https://edge.microsoft.com/extensionwebstorebase/v1/crx"




; CHROME
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome]
"StartupBoostEnabled"=dword:00000000
"HardwareAccelerationModeEnabled"=dword:00000000
"BackgroundModeEnabled"=dword:00000000
"HighEfficiencyModeEnabled"=dword:00000001
"DeviceMetricsReportingEnabled"=dword:00000000
"MetricsReportingEnabled"=dword:00000000
"ChromeCleanupReportingEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000
"WebRtcEventLogCollectionAllowed"=dword:00000000
"NetworkPredictionOptions"=dword:00000002 ; Disable DNS prefetching
"ChromeCleanupEnabled"=dword:00000000
"DefaultGeolocationSetting"=dword:00000002
"DefaultNotificationsSetting"=dword:00000002
"DefaultLocalFontsSetting"=dword:00000002
"DefaultSensorsSetting"=dword:00000002
"DefaultSerialGuardSetting"=dword:00000002
"CloudReportingEnabled"=dword:00000000
"DriveDisabled"=dword:00000001
"PasswordManagerEnabled"=dword:00000000
"PasswordSharingEnabled"=dword:00000000
"PasswordLeakDetectionEnabled"=dword:00000000
"QuickAnswersEnabled"=dword:00000000
"SafeBrowsingExtendedReportingEnabled"=dword:00000000
"SafeBrowsingSurveysEnabled"=dword:00000000
"SafeBrowsingDeepScanningEnabled"=dword:00000000
"DeviceActivityHeartbeatEnabled"=dword:00000000
"HeartbeatEnabled"=dword:00000000
"LogUploadEnabled"=dword:00000000
"ReportAppInventory"=""
"ReportDeviceActivityTimes"=dword:00000000
"ReportDeviceAppInfo"=dword:00000000
"ReportDeviceSystemInfo"=dword:00000000
"ReportDeviceUsers"=dword:00000000
"ReportWebsiteTelemetry"=""
"AlternateErrorPagesEnabled"=dword:00000000
"AutofillCreditCardEnabled"=dword:00000000
"BrowserGuestModeEnabled"=dword:00000000
"BrowserSignin"=dword:00000000
"BuiltInDnsClientEnabled"=dword:00000000
"DefaultBrowserSettingEnabled"=dword:00000000
"ParcelTrackingEnabled"=dword:00000000
"RelatedWebsiteSetsEnabled"=dword:00000000
"ShoppingListEnabled"=dword:00000000
"SyncDisabled"=dword:00000001
"ExtensionManifestV2Availability"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdatem]
"Start"=dword:00000004




;FIREFOX
; Disable Firefox Telemetry
[HKEY_LOCAL_MACHINE\Software\Policies\Mozilla\Firefox]
"DisableTelemetry"=dword:00000001
"DisableDefaultBrowserAgent"=dword:00000001




; NVIDIA
; disable nvidia tray icon
[HKEY_CURRENT_USER\Software\NVIDIA Corporation\NvTray]
"StartOnLogin"=dword:00000000




; --CAN'T DO NATIVELY--




; UWP APPS
; disable background apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy]
"LetAppsRunInBackground"=dword:00000002

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications]
"GlobalUserDisabled"=dword:00000001

; disable windows input experience preload
[HKEY_CURRENT_USER\Software\Microsoft\input]
"IsInputAppPreloadEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Dsh]
"IsPrelaunchEnabled"=dword:00000000

; disable web search in start menu 
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=dword:00000001

; disable copilot
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

; disable Cortana
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Search]
"AllowCortana"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Experience]
"AllowCortana"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortanaAboveLock"=dword:00000000

; disable widgets
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests]
"value"=dword:00000000

; disable ink workspace
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace]
"AllowWindowsInkWorkspace"=dword:00000000

; disable telemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics]
"EnabledExecution"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"LimitDiagnosticLogCollection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000000

; disable activity history
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000000
"UploadUserActivities"=dword:00000000

; disbale Location [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
; "DisableLocation"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
; "DisableLocationScripting"=dword:00000001
; "DisableWindowsLocationProvider"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\System]
; "AllowExperimentation"=dword:00000000

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}]
; "SensorPermissionState"=dword:00000000

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration]
; "Status"=dword:00000000




; NVIDIA
; enable old nvidia legacy sharpening
; old location
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS]
"EnableGR535"=dword:00000000

; new location
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\nvlddmkm\Parameters\FTS]
"EnableGR535"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS]
"EnableGR535"=dword:00000000




; POWER
; add maximum processor frequency
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100]
"Attributes"=dword:00000002

; disable fast boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"HiberbootEnabled"=dword:00000000

; disable energy estimation & power saving
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EnergyEstimationEnabled"=dword:00000000
"EnergySaverPolicy"=dword:00000001

; disable connected standby
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
; "CsEnabled"=dword:00000000

; disable away mode
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"AwayModeEnabled"=dword:00000000




; DISABLE ADVERTISING & PROMOTIONAL
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"ContentDeliveryAllowed"=dword:00000000
"FeatureManagementEnabled"=dword:00000000
"OemPreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEverEnabled"=dword:00000000
"RotatingLockScreenEnabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000
"SilentInstalledAppsEnabled"=dword:00000000
"SlideshowEnabled"=dword:00000000
"SoftLandingEnabled"=dword:00000000
"SubscribedContent-310093Enabled"=dword:00000000
"SubscribedContent-314563Enabled"=dword:00000000
"SubscribedContent-338388Enabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000
"SubscribedContent-338393Enabled"=dword:00000000
"SubscribedContent-338393Enabled"=dword:00000000
"SubscribedContent-353694Enabled"=dword:00000000
"SubscribedContent-353694Enabled"=dword:00000000
"SubscribedContent-353696Enabled"=dword:00000000
"SubscribedContent-353696Enabled"=dword:00000000
"SubscribedContent-353698Enabled"=dword:00000000
"SubscribedContentEnabled"=dword:00000000
"SystemPaneSuggestionsEnabled"=dword:00000000




; OTHER
; remove 3d objects
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

; remove quick access
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"HubMode"=dword:00000001

; remove home
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}]

; remove gallery
[HKEY_CURRENT_USER\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}]
"System.IsPinnedToNameSpaceTree"=dword:00000000

; restore the classic context menu
[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; add "Take ownership" context menu to files and folders
[HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
@="Take ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""
"IsolatedCommand"= "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""


[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership]
@="Take ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" /r /d y && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause' -Verb runAs\""
"IsolatedCommand"="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" /r /d y && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause' -Verb runAs\""

; disable menu show delay
[HKEY_CURRENT_USER\Control Panel\Desktop]
"MenuShowDelay"="0"

; disable driver searching & updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
"SearchOrderConfig"=dword:00000000

; mouse fix (no accel with epp on)
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	C0,CC,0C,00,00,00,00,00,\
	80,99,19,00,00,00,00,00,\
	40,66,26,00,00,00,00,00,\
	00,33,33,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; enable endtask menu taskbar w11
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings]
"TaskbarEndTask"=dword:00000001

; enable win32 long paths
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001

; remove 'Open in Windows Terminal' in win 11
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=""

; remove share context menu
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"="Share"

; remove add to favourites context menu
[-HKEY_CLASSES_ROOT\*\shell\pintohomefile]

; hide insider program page
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility]
"HideInsiderPage"=dword:00000001

; remove shortcut arrow overlay icon 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons]
"29"="C:\\Windows\\blanc.ico"

; Clear icon cache
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_ShowRecentDocs"=dword:00000001
"Start_TrackDocs"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"Shell Icons"=-

; disable the " - shortcut" text for shortcuts
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates]
"ShortcutNameTemplate"="\"%s.lnk\""

; set "Do this for all current items" checked by default
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager]
"ConfirmationCheckBoxDoForAll"=dword:00000001

; disable automatic folder type discovery
[-HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags]

[HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell]
"FolderType"="NotSpecified"

; Show Drive letters before labels
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"ShowDriveLettersFirst"=dword:00000004

; enable network drives over uac [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
; "EnableLinkedConnections"=dword:00000001
; "LocalAccountTokenFilterPolicy"=dword:00000001
; "EnableVirtualization"=dword:00000000

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
; "DisableLoopbackCheck"=dword:00000001

; onedrive
; disable onedrive user folder backup [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\OneDrive]
; "KFMBlockOptIn"=dword:00000001

; hide onedrive folder
[-HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

[-HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

; hide lock screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData]
"AllowLockScreen"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization]
"NoLockScreen"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortanaAboveLock"=dword:00000000

; disable automatic registry backup
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager]
"EnablePeriodicBackup"=dword:00000000

; disable "Look for an app in the Store" notification
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"NoUseStoreOpenWith"=dword:00000001

; disable downloaded files from being blocked in file explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=dword:00000001

; disable mark-of-the-web (MOTW) for downloaded files
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AttachmentManager]
"ScanWithAntiVirus"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations]
"LowRiskFileTypes"=".exe;.msi;.bat;.cmd;.ps1;.js;.vbs"

; disable protected view for office files
[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000001

; disable malicious software removal tool from installing
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT]
"DontOfferThroughWUAU"=dword:00000001

; disable live tiles
[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
"NoTileApplicationNotification"=dword:00000001

; increase wallpaper quallity
[HKEY_CURRENT_USER\Control Panel\Desktop]
"JPEGImportQuality"=dword:00000063

; enable windows installer in safe Mode
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer]
@="Service"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer]
@="Service"

; change the timeout for disk auto check to 5 seconds
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager]
"AutoChkTimeout"=dword:00000005

; disable blur on sign-in screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableAcrylicBackgroundOnLogon"=dword:00000001

; disable settings home
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"SettingsPageVisibility"="hide:home"

; disable consumer features
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001
"DisableConsumerFeatures"=dword:00000001
"DisableWindowsConsumerFeatures"=dword:00000001
"DisableConsumerAccountStateContent"=dword:00000001

; disable homegroup
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupListener]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupProvider ]
"Start"=dword:00000004

; disable wifi-sense
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"AllowWiFiHotSpotReporting"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting]
"Value"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots]
"Value"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config]
"AutoConnectAllowedOEM"=dword:00000000

; disable ai features
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI]
"DisableAIDataAnalysis"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsAI]
"DisableAIDataAnalysis"=dword:00000001
"AllowRecallEnablement"=dword:00000000

; disable NumLock on startup
[HKEY_USERS\.DEFAULT\Control Panel\Keyboard]
"InitialKeyboardIndicators"=dword:"0"

; enable verbose messages during logon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"VerboseStatus"=dword:00000001

; disable thumbnail cache
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"DisableThumbnailCache"=dword:00000001

; close apps automatically on shutdown
[HKEY_CURRENT_USER\Control Panel\Desktop]
"AutoEndTasks"="1"
"HungAppTimeout"="1000"
"WaitToKillAppTimeout"="1000"
"LowLevelHooksTimeout"="1000"

; set audiodg priority to high
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003
"IoPriority"=dword:00000003

; fix mouse cursor dissapeiring
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableCursorSuppression"=dword:00000000

; disable tablet mode
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell]
"TabletMode"=dword:00000000
"SignInMode"=dword:00000001

; disables push to install feature
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall]
"DisablePushToInstall"=dword:00000001




; Created by: Shawn Brink
; Created on: September 28th 2015
; Updated on: August 28th 2019
; Tutorial: https://www.tenforums.com/tutorials/24412-add-remove-default-new-context-menu-items-windows-10-a.html


; Text Document
[-HKEY_CLASSES_ROOT\.txt\ShellNew]
[HKEY_CLASSES_ROOT\.txt\ShellNew]
"ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
  6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
  00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\
  2d,00,34,00,37,00,30,00,00,00
"NullFile"=""


[-HKEY_CLASSES_ROOT\.txt]

[HKEY_CLASSES_ROOT\.txt]
@="txtfile"
"Content Type"="text/plain"
"PerceivedType"="text"

[HKEY_CLASSES_ROOT\.txt\PersistentHandler]
@="{5e941d80-bf96-11cd-b579-08002b30bfeb}"

[HKEY_CLASSES_ROOT\.txt\ShellNew]
"ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
  6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
  00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\
  2d,00,34,00,37,00,30,00,00,00
"NullFile"=""

[-HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]

[HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]
"PerceivedType"="document"

[-HKEY_CLASSES_ROOT\txtfile]

[HKEY_CLASSES_ROOT\txtfile]
@="Text Document"
"EditFlags"=dword:00210000
"FriendlyTypeName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,\
  00,6f,00,6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,\
  32,00,5c,00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,\
  00,2c,00,2d,00,34,00,36,00,39,00,00,00

[HKEY_CLASSES_ROOT\txtfile\DefaultIcon]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,69,00,6d,00,\
  61,00,67,00,65,00,72,00,65,00,73,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,31,\
  00,30,00,32,00,00,00

[HKEY_CLASSES_ROOT\txtfile\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,4e,00,4f,00,\
  54,00,45,00,50,00,41,00,44,00,2e,00,45,00,58,00,45,00,20,00,25,00,31,00,00,\
  00

[HKEY_CLASSES_ROOT\txtfile\shell\print\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,4e,00,4f,00,\
  54,00,45,00,50,00,41,00,44,00,2e,00,45,00,58,00,45,00,20,00,2f,00,70,00,20,\
  00,25,00,31,00,00,00

[HKEY_CLASSES_ROOT\txtfile\shell\printto\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,6e,00,6f,00,\
  74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,20,00,2f,00,70,00,74,\
  00,20,00,22,00,25,00,31,00,22,00,20,00,22,00,25,00,32,00,22,00,20,00,22,00,\
  25,00,33,00,22,00,20,00,22,00,25,00,34,00,22,00,00,00

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithList]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithProgids]
"txtfile"=hex(0):

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\UserChoice]
"Hash"="hyXk/CpboWw="
"ProgId"="txtfile"

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt\UserChoice]
"Hash"="FvJcqeZpmOE="
"ProgId"="txtfile"
'@
	# Disable Startup apps
	$startupApps = Get-WmiObject -Class Win32_StartupCommand | Select-Object -ExpandProperty Caption
	foreach ($app in $startupApps) {
	    if ([string]::IsNullOrWhiteSpace($app)) { continue }
	    $appTrimmed = $app.TrimEnd()
	    $regPaths = @(
	        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
	        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
	    )
	    foreach ($regPath in $regPaths) {
	        if (Get-ItemProperty -Path $regPath -Name $appTrimmed) {
	            $binaryValue = [byte[]](0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00)
	            Set-ItemProperty -Path $regPath -Name $appTrimmed -Value $binaryValue -Type Binary -Force
	        }
	    }
	} 	
	# Grouping svchost.exe processes
	$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force
	# Download blanc.ico into C:\Windows
	Get-FileFromWeb -URL "https://github.com/benzaria/remove_shortcut_arrow/raw/refs/heads/main/blanc.ico" -File "C:\\Windows\\blanc.ico"
	Set-Content -Path "$env:TEMP\RegistryOptimize.reg" -Value $MultilineComment -Force
	# Fix VMware Tools if present
	if (Test-Path "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe") { Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "VMware User Process" -Value '"C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" -n vmusr' | Out-Null }	
 	
  	# edit reg file
	$path = "$env:TEMP\RegistryOptimize.reg"
	(Get-Content $path) -replace "\?","$" | Out-File $path
	# import reg file
	Regedit.exe /S "$env:TEMP\RegistryOptimize.reg"
}



<#
.SYNOPSIS
Runs a file or command as the TrustedInstaller account using RunAsTI.exe.

.DESCRIPTION
The RunAsTI function downloads and configures the required Visual C++ Runtime
and RunAsTI.exe tool (if missing) into the TEMP directory. It then executes the
specified target (batch files, executables, scripts, or registry imports) with
TrustedInstaller privileges. The function also supports waiting for the target
process to finish.

.PARAMETER TargetPath
The file or command host to execute. This can be an executable, script, or
command host (such as cmd.exe or powershell.exe).

.PARAMETER TargetArgs
Optional arguments to pass to the target process. Accepts an array of strings
which are safely quoted if they contain spaces.

.PARAMETER Wait
If specified, the function will block until the target process finishes. By
default, the function starts the process and returns immediately.

.PARAMETER TimeoutSeconds
Maximum time (in seconds) to wait when -Wait is used. Default is 600 seconds.

.EXAMPLE
# Run a batch file with TrustedInstaller privileges and wait for it
RunAsTI -TargetPath "$env:TEMP\DisableDefender.bat" -Wait

.EXAMPLE
# Run a PowerShell script as TrustedInstaller
RunAsTI -TargetPath "powershell.exe" -TargetArgs "-ExecutionPolicy Bypass -File `"$env:TEMP\script.ps1`"" -Wait

.EXAMPLE
# Import a .reg file silently as TrustedInstaller
RunAsTI -TargetPath "regedit.exe" -TargetArgs "/s `"$env:TEMP\settings.reg`"" -Wait

.EXAMPLE
# Execute a direct command by wrapping it with cmd.exe
RunAsTI -TargetPath "cmd.exe" -TargetArgs "/c reg add HKLM\SOFTWARE\Test /v Flag /t REG_DWORD /d 1 /f" -Wait

# Execute a direct command by wrapping it with powershell.exe
RunAsTI -TargetPath "powershell.exe" -TargetArgs "-Command reg add HKLM\...\..." -Wait

.NOTES
- Requires internet access on first run to download vc_redist and RunAsTI.exe.
- RunAsTI.exe is sourced from: https://github.com/mbcdev/RunAsTrustedInstaller
- To run raw one-liner commands, wrap them with cmd.exe or powershell.exe.
- Tested on Windows 10 and Windows 11.
#>

function RunAsTI {
    param(
        [Parameter(Mandatory=$true,Position=0)][string]$TargetPath,
        [string[]]$TargetArgs = @(),
        [switch]$Wait,
        [int]$TimeoutSeconds = 600
    )

    # ensure VC++ runtime
    $vcUrl  = 'https://aka.ms/vs/17/release/vc_redist.x64.exe'
    $vcFile = Join-Path $env:TEMP 'vcredist_x64.exe'
    if (-not (Test-Path $vcFile)) {
        Invoke-WebRequest -Uri $vcUrl -OutFile $vcFile
        Start-Process -FilePath $vcFile -ArgumentList '/passive','/norestart' -Wait
    }

    # ensure RunAsTI
    $runAsUrl = 'https://github.com/mbcdev/RunAsTrustedInstaller/releases/latest/download/RunAsTI.exe'
    $runAsExe = Join-Path $env:TEMP 'RunAsTI.exe'
    if (-not (Test-Path $runAsExe)) {
        Invoke-WebRequest -Uri $runAsUrl -OutFile $runAsExe
    }

    # build quoted target + args
    $quotedTarget = '"{0}"' -f $TargetPath
    if ($TargetArgs.Count -gt 0) {
        $quotedTarget += ' ' + ($TargetArgs | ForEach-Object { if ($_ -match '\s') { '"{0}"' -f $_ } else { $_ } } -join ' ')
    }

    # if batch, run via cmd.exe /c
    if ($TargetPath -match '\.bat$|\.cmd$') {
        $cmdLine = "cmd.exe /c $quotedTarget"
    } else {
        $cmdLine = $quotedTarget
    }

    # start RunAsTI (it will launch the target as TrustedInstaller)
    $p = Start-Process -FilePath $runAsExe -ArgumentList $cmdLine -PassThru *> $null

    if ($Wait) {
        $deadline  = (Get-Date).AddSeconds($TimeoutSeconds)
        $targetBase = [System.IO.Path]::GetFileName($TargetPath)

        # wait until a process referencing the target appears (short timeout)
        while ((Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
               Where-Object { $_.CommandLine -and $_.CommandLine -like "*$targetBase*" }) -eq $null) {
            if (Get-Date -gt $deadline) { break }
            Start-Sleep -Milliseconds 200
        }

        # then wait until it disappears
        while ((Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
               Where-Object { $_.CommandLine -and $_.CommandLine -like "*$targetBase*" }) -ne $null) {
            if (Get-Date -gt $deadline) { break }
            Start-Sleep -Seconds 1
        }
    }

    return $p
}

function Get-FileFromWeb {
    param($URL, $File)
    $resp = [System.Net.HttpWebRequest]::Create($URL).GetResponse()
    if ($resp.StatusCode -in 401, 403, 404) { return }
    if (!(Split-Path $File)) { $File = Join-Path (Get-Location) $File }
    $dir = [System.IO.Path]::GetDirectoryName($File)
    if (!(Test-Path $dir)) { [void][System.IO.Directory]::CreateDirectory($dir) }
    $buf = [byte[]]::new(1MB)
    $r = $resp.GetResponseStream()
    $w = [System.IO.File]::Open($File, 'Create')
    while (($cnt = $r.Read($buf, 0, $buf.Length)) -gt 0) { $w.Write($buf, 0, $cnt) }
    $r.Close(); $w.Close(); $resp.Close()
}

$Host.UI.RawUI.WindowTitle = ''
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'Blue'
$Host.PrivateData.ProgressBackgroundColor = 'Black'
$Host.PrivateData.ProgressForegroundColor = 'Blue'
Clear-Host

$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'SilentlyContinue'

#
if ($ActivateWindows) {
	Activate-Windows
}

#
if ($PauseUpdates) {
	Pause-Updates
}

# INSTALL RUNTIMES
if ($Runtimes) {
	Write-Output "Installing Runtimes..." -ForegroundColor Green
	Install-CPlusPlus
 	Install-DirectX
  	Install-NET35
}

# REPAIR WINGET
if ($Winget) {
    Repair-Winget
}

# INSTALL CHOCOLATEY
if ($Choco) {
    Install-Choco
}

# RUN WIN11DEBLOAT AUTOMATION
if ($Win11Debloat) {
    Run-Win11Debloat
}

# RUN WINUTIL AUTOMATION
if ($CTTWinUtil) {
	CTT-WinUtilAutomation
}

# REMOVE BLOATWARE
if ($RemoveBloatware) {
    Write-Output "Removing Bloatware..." -ForegroundColor Green
    Uninstall-OneDrive
    Remove-Edge
    Remove-WindowsAI
    Remove-Apps
}

if ($InstallStore) {
	Install-Store
}

# Uninstall OneDrive
if ($UninstallOneDrive) {
    Uninstall-OneDrive   
}

# Remove Edge
if ($RemoveEdge) {
    Remove-Edge
}

# Privacy Tweaks
if ($PrivacyTweaks) {
    Write-Output "Applying Privacy Tweaks..."
    Run-WPD
    Run-ShutUp10
    Run-PrivacySexy
}

# Run Windows Privacy Dashboard Automation
if ($WPD) {
	Run-WPD
}

# Run O&O ShutUp10++ Automation
if ($ShutUp10) {
	Run-ShutUp10
}

# DISABLE SECURITY
if ($DisableSecurity) {
	Disable-Defender
 	Disable-Mitigations
}

Write-Output ""
Write-Output ""
Write-Output ""

Write-Output "Script execution completed."
pause



















