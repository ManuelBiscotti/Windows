$ProgressPreference = 'SilentlyContinue'

$windir = [Environment]::GetFolderPath('Windows')
& "$windir\AtlasModules\initPowerShell.ps1"

$packageInstall = "$windir\AtlasModules\Scripts\packageInstall.ps1"
if (!(Test-Path $packageInstall)) {
    Write-Host "Missing package install script, can't continue."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

$package = "*Z-Atlas-NoDefender-Package*"

# Disable Defender
Clear-Host
Write-Host "Disabling Windows Defender... This will take a moment." -ForegroundColor Yellow

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v Start /t REG_DWORD /d 4 /f | Out-Null
bcdedit /set hypervisorlaunchtype off | Out-Null
& $packageInstall -NoInteraction -InstallPackages @($package)

