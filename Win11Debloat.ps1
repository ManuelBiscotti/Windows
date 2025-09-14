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
}

function Install-Store {
	# Install Microsoft Store
 	Write-Output "Installing Microsoft Store..."
	Get-AppXPackage -AllUsers *Microsoft.WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}       
	Get-AppXPackage -AllUsers *Microsoft.Microsoft.StorePurchaseApp* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}
}

# WPD Function
function Run-WPD {
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
	Write-Output "Installing Runtimes..."
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
    Write-Output "Removing Bloatware..."
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


















