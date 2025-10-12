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

    Write-Host "1. Registry: Optimize (Recommended)"
    Write-Host "2. Registry: Default"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

		Clear-Host
		Write-Host "Registry: Optimize . . ."
		# create reg file
		$MultilineComment = @'
Windows Registry Editor Version 5.00

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
; disable cloud delivered protection
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
; "SpyNetReporting"=dword:00000000

; disable automatic sample submission
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
; "SubmitSamplesConsent"=dword:00000000

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
; unpark cpu cores 
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
"ValueMax"=dword:00000000

; disable power throttling
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling]
; "PowerThrottlingOff"=dword:00000001

; disable hibernate
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
; "HibernateEnabled"=dword:00000000
; "HibernateEnabledDefault"=dword:00000000

; disable fast boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"HiberbootEnabled"=dword:00000000

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
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons]
; "29"="C:\\Windows\\blanc.ico"

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

; Prevent Print Spooler to start automatically with windows
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Spooler]
"Start"=dword:00000003

; Disable Windows Search Indexing
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WSearch]
"Start"=dword:00000004

; Allow double-click execution of .ps1 files (Windows PowerShell)
[HKEY_CLASSES_ROOT\Applications\powershell.exe\shell\open\command]
@="C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -NoLogo -ExecutionPolicy Unrestricted -File \"%1\""

; Allow double-click execution of .ps1 files (PowerShell 7)
[HKEY_CLASSES_ROOT\Applications\pwsh.exe\shell\open\command]
@="C:\\Program Files\\PowerShell\\7\\pwsh.exe -NoLogo -ExecutionPolicy Unrestricted -File \"%1\""




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




; POWERSHELL
; allow powershell scripts
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell]
"ExecutionPolicy"="Unrestricted"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell]
"ExecutionPolicy"="Unrestricted"
'@

# Signout Lockscreen	
Write-Output "Setting signout Lockscreen black..."	
# create new image	
Add-Type -AssemblyName System.Windows.Forms	
$screenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width	
$screenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height	
Add-Type -AssemblyName System.Drawing	
$file = "C:\Windows\Black.jpg"	
$edit = New-Object System.Drawing.Bitmap $screenWidth, $screenHeight	
$color = [System.Drawing.Brushes]::Black	
$graphics = [System.Drawing.Graphics]::FromImage($edit)	
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)	
$graphics.Dispose()	
$edit.Save($file)	
$edit.Dispose()	
# set image settings	
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v "LockScreenImagePath" /t REG_SZ /d "C:\Windows\Black.jpg" /f | Out-Null	
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v "LockScreenImageStatus" /t REG_DWORD /d "1" /f | Out-Null	

# Unpin all taskbar icons	
# Write-Output "Unpinning all taskbar icons..."	
# cmd /c "reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f >nul 2>&1"	
# Remove-Item -Recurse -Force "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch" -ErrorAction SilentlyContinue | Out-Null	
# New-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null	
# New-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\ImplicitAppShortcuts" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null	

# Disable BitLocker	
Write-Output "Disabling BitLocker..."	
# Disable BitLocker on C:	
Disable-BitLocker -MountPoint "C:" 2>&1 | Out-Null -ErrorAction SilentlyContinue	
# Disable Device Encryption via registry	
New-Item -Path "HKLM:\System\CurrentControlSet\Control" -Name "BitLocker" -Force 2>&1 | Out-Null -ErrorAction SilentlyContinue	
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\BitLocker" -Name "PreventDeviceEncryption" -Type DWord -Value 1	
# Disable EFS (Encrypting File System)	
fsutil behavior set disableencryption 1 | Out-Null	
# Additional BitLocker policy: Disable External DMA Under Lock	
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "FVE" -Force | Out-Null	
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "DisableExternalDMAUnderLock" -Type DWord -Value 1	

# Disable Startup apps	
Write-Output "Disabling Startup apps..." 	
cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\RunNotification`" /f >nul 2>&1" 	
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunNotification" /f | Out-Null	
cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`" /f >nul 2>&1"	
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f | Out-Null	
cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\Run`" /f >nul 2>&1"	
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f | Out-Null	
cmd /c "reg delete `"HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`" /f >nul 2>&1"	
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f | Out-Null	
cmd /c "reg delete `"HKLM\Software\Microsoft\Windows\CurrentVersion\Run`" /f >nul 2>&1"	
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /f | Out-Null	
cmd /c "reg delete `"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce`" /f >nul 2>&1"	
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce" /f | Out-Null	
cmd /c "reg delete `"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run`" /f >nul 2>&1"	
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /f | Out-Null	
cmd /c "reg delete `"HKLM\Software\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}`" /f >nul 2>&1"	
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

# Unlock all power settings options
Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings' -Recurse | ForEach-Object { if (Get-ItemProperty $_.PSPath -Name Attributes -ErrorAction SilentlyContinue) { Set-ItemProperty $_.PSPath -Name Attributes -Value 0 } }
	
# Group svchost.exe processes
Write-Output "Grouping svchost.exe processes..."
$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force
	
# Enable MSI Mode on all supported Drivers	
Write-Output "Enabling MSI Mode on all supported Drivers..."	
$gpuDevices = Get-PnpDevice -Class Display	
foreach ($gpu in $gpuDevices) {	
	$instanceID = $gpu.InstanceId	
	reg add "HKLM\SYSTEM\ControlSet001\Enum\$instanceID\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f | Out-Null	
}	
	
# Fix VMware Tools if present	
if (Test-Path "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe") { 	
	Write-Output "Fixing VMware Tools..." 	
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "VMware User Process" -Value '"C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" -n vmusr' | Out-Null  	
}		
	
# Disables automatic disk defragmentation
Write-Output "Disabling automatic disk defragmentation..."
schtasks /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
 
# Allow double-click of .ps1 files
Write-Output "Allowing double-click execution of .ps1 files ..."
# powershell.exe
if (-not (Test-Path $regPath)) {
	New-Item -Path 'HKCR:\Applications\powershell.exe\shell\open\command' -Force | Out-Null   
}
Set-ItemProperty -Path 'HKCR:\Applications\powershell.exe\shell\open\command' -Name '(default)' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy Unrestricted -File "%1"'	 
# PowerShell 7
$regPathPwsh = 'HKCR:\Applications\pwsh.exe\shell\open\command'
if (-not (Test-Path $regPathPwsh)) { New-Item -Path $regPathPwsh -Force | Out-Null }
Set-ItemProperty -Path $regPathPwsh -Name '(default)' -Value 'C:\Program Files\PowerShell\7\pwsh.exe -NoLogo -ExecutionPolicy Unrestricted -File "%1"'  

# Set account password to never expires
Write-Output "Setting account password to never expires..."
Get-LocalUser | ForEach-Object { Set-LocalUser -Name $_.Name -PasswordNeverExpires $true | Out-Null }
  
Write-Output "Applying miscellaneous Registry tweaks..."
# Download blanc.ico into C:\Windows
# Invoke-WebRequest -Uri "https://github.com/benzaria/remove_shortcut_arrow/raw/refs/heads/main/blanc.ico" -OutFile "C:\\Windows\\blanc.ico"

Set-Content -Path "$env:TEMP\RegistryOptimize.reg" -Value $MultilineComment -Force	
# edit reg file  
$path = "$env:TEMP\RegistryOptimize.reg"
(Get-Content $path) -replace "\?","$" | Out-File $path
# import reg file
Regedit.exe /S "$env:TEMP\RegistryOptimize.reg"

Clear-Host
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
Write-Host "Registry: Default . . ."
# create reg file
$MultilineComment = @'
Windows Registry Editor Version 5.00

; --LEGACY CONTROL PANEL--




; EASE OF ACCESS
; narrator
[HKEY_CURRENT_USER\Software\Microsoft\Narrator\NoRoam]
"DuckAudio"=-
"WinEnterLaunchEnabled"=-
"ScriptingEnabled"=-
"OnlineServicesEnabled"=-

[HKEY_CURRENT_USER\Software\Microsoft\Narrator]
"NarratorCursorHighlight"=-
"CoupleNarratorCursorKeyboard"=-

; ease of access settings
[-HKEY_CURRENT_USER\Software\Microsoft\Ease of Access]

[HKEY_CURRENT_USER\Control Panel\Accessibility]
"Sound on Activation"=-
"Warning Sounds"=-

[HKEY_CURRENT_USER\Control Panel\Accessibility\HighContrast]
"Flags"="126"

[HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response]
"Flags"="126"
"AutoRepeatRate"="500"
"AutoRepeatDelay"="1000"

[HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys]
"Flags"="62"
"MaximumSpeed"="80"
"TimeToMaximumSpeed"="3000"

[HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]
"Flags"="510"

[HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]
"Flags"="62"

[HKEY_CURRENT_USER\Control Panel\Accessibility\SoundSentry]
"Flags"="2"
"FSTextEffect"="0"
"TextEffect"="0"
"WindowsEffect"="1"

[HKEY_CURRENT_USER\Control Panel\Accessibility\SlateLaunch]
"ATapp"="narrator"
"LaunchAT"=dword:00000001




; CLOCK AND REGION
; notify me when the clock changes
[-HKEY_CURRENT_USER\Control Panel\TimeDate]




; APPEARANCE AND PERSONALIZATION
; spotlight
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableCloudOptimizedContent"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsSpotlightFeatures"=dword:00000000
"DisableWindowsSpotlightWindowsWelcomeExperience"=dword:00000000
"DisableWindowsSpotlightOnActionCenter"=dword:00000000
"DisableWindowsSpotlightOnSettings"=dword:00000000
"DisableThirdPartySuggestions"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]
"{2cc5ca98-6485-489a-920e-b3e88a6ccce3}"=dword:00000000

; open file explorer to this quick access
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"LaunchTo"=-

; frequent folders in quick access
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowFrequent"=-

; file name extensions
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"HideFileExt"=dword:00000001

; search history
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDeviceSearchHistoryEnabled"=-

; show files from office.com
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowCloudFilesInQuickAccess"=-

; display file size information in folder tips
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"FolderContentsInfoTip"=-

; display full path in the title bar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState]
"FullPath"=dword:00000000

; show pop-up description for folder and desktop items
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowInfoTip"=dword:00000001

; show preview handlers in preview pane
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowPreviewHandlers"=-

; show status bar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowStatusBar"=dword:00000001

; show sync provider notifications
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowSyncProviderNotifications"=-

; use sharing wizard
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SharingWizardOn"=-

; show network
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}]




; HARDWARE AND SOUND
; lock
[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]

; sleep
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]

; sound communications
[HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio]
"UserDuckingPreference"=-

; startup sound
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation]
"DisableStartupSound"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\EditionOverrides]
"UserSetting_DisableStartupSound"=dword:00000000

; sound scheme
[HKEY_CURRENT_USER\AppEvents\Schemes]
@=".Default"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
@="C:\\Windows\\media\\Windows Background.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.Current]
@="C:\\Windows\\media\\Windows Foreground.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
@="C:\\Windows\\media\\Windows Hardware Insert.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
@="C:\\Windows\\media\\Windows Hardware Remove.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceFail\.Current]
@="C:\\Windows\\media\\Windows Hardware Fail.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\FaxBeep\.Current]
@="C:\\Windows\\media\\Windows Notify Email.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.Current]
@="C:\\Windows\\media\\Windows Background.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MailBeep\.Current]
@="C:\\Windows\\media\\Windows Notify Email.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MessageNudge\.Current]
@="C:\\Windows\\media\\Windows Message Nudge.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
@="C:\\Windows\\media\\Windows Notify System Generic.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.IM\.Current]
@="C:\\Windows\\media\\Windows Notify Messaging.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Mail\.Current]
@="C:\\Windows\\media\\Windows Notify Email.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Proximity\.Current]
@="C:\\Windows\\media\\Windows Proximity Notification.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Reminder\.Current]
@="C:\\Windows\\media\\Windows Notify Calendar.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.SMS\.Current]
@="C:\\Windows\\media\\Windows Notify Messaging.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\ProximityConnection\.Current]
@="C:\\Windows\\media\\Windows Proximity Connection.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
@="C:\\Windows\\media\\Windows Background.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
@="C:\\Windows\\media\\Windows Background.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
@="C:\\Windows\\media\\Windows Foreground.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
@="C:\\Windows\\media\\Windows Background.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
@="C:\\Windows\\media\\Windows User Account Control.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
@="C:\\Windows\\media\\Speech Disambiguation.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
@="C:\\Windows\\media\\Speech Off.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOnSound\.current]
@="C:\\Windows\\media\\Speech On.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubSleepSound\.current]
@="C:\\Windows\\media\\Speech Sleep.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\MisrecoSound\.current]
@="C:\\Windows\\media\\Speech Misrecognition.wav"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\PanelSound\.current]
@="C:\\Windows\\media\\Speech Disambiguation.wav"

; autoplay
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers]
"DisableAutoplay"=dword:00000000

; enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; mouse pointers scheme
[HKEY_CURRENT_USER\Control Panel\Cursors]
"AppStarting"="C:\\Windows\\cursors\\aero_working.ani"
"Arrow"="C:\\Windows\\cursors\\aero_arrow.cur"
"ContactVisualization"=dword:00000001
"Crosshair"=""
"CursorBaseSize"=dword:00000020
"GestureVisualization"=dword:0000001f
"Hand"="C:\\Windows\\cursors\\aero_link.cur"
"Help"="C:\\Windows\\cursors\\aero_helpsel.cur"
"IBeam"=""
"No"="C:\\Windows\\cursors\\aero_unavail.cur"
"NWPen"="C:\\Windows\\cursors\\aero_pen.cur"
"Scheme Source"=dword:00000002
"SizeAll"="C:\\Windows\\cursors\\aero_move.cur"
"SizeNESW"="C:\\Windows\\cursors\\aero_nesw.cur"
"SizeNS"="C:\\Windows\\cursors\\aero_ns.cur"
"SizeNWSE"="C:\\Windows\\cursors\\aero_nwse.cur"
"SizeWE"="C:\\Windows\\cursors\\aero_ew.cur"
"UpArrow"="C:\\Windows\\cursors\\aero_up.cur"
"Wait"="C:\\Windows\\cursors\\aero_busy.ani"
@="Windows Default"

; device installation settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000000




; NETWORK AND INTERNET
; allow other network users to control or disable the shared internet connection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Network\SharedAccessConnection]
"EnableControl"=dword:00000001




; SYSTEM AND SECURITY
; undo prefer IPv4 over IPv6
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters]
"DisabledComponents"=00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"EnablePMTUDiscovery"=-
"EnablePMTUBHDetect"=-
"Tcp1323Opts"=-
"SackOpts"=-
"DefaultTTL"=-
"GlobalMaxTcpWindowSize"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"MaxCacheEntryTtlLimit"=-
"MaxNegativeCacheTtl"=-

; set appearance options
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects]
"VisualFXSetting"=-

; animate controls and elements inside windows
; fade or slide menus into view
; fade or slide tooltips into view
; fade out menu items after clicking
; show shadows under mouse pointer
; show shadows under windows
; slide open combo boxes
; smooth-scroll list boxes
[HKEY_CURRENT_USER\Control Panel\Desktop]
"UserPreferencesMask"=hex(2):9e,1e,07,80,12,00,00,00

; animate windows when minimizing and maximizing
[HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
"MinAnimate"="1"

; animations in the taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarAnimations"=dword:1

; enable peek
[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"EnableAeroPeek"=dword:1

; save taskbar thumbnail previews
[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"AlwaysHibernateThumbnails"=dword:0

; disable show thumbnails instead of icons
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"IconsOnly"=dword:0

; show translucent selection rectangle
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ListviewAlphaSelect"=dword:1

; show window contents while dragging
[HKEY_CURRENT_USER\Control Panel\Desktop]
"DragFullWindows"="1"

; smooth edges of screen fonts
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"

; use drop shadows for icon labels on the desktop
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ListviewShadow"=dword:1

; adjust for best performance of
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
"Win32PrioritySeparation"=dword:00000002

; remote assistance
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance]
"fAllowToGetHelp"=dword:00000001

; system responsiveness
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
"NetworkThrottlingIndex"=dword:0000000a
"SystemResponsiveness"=dword:00000014

; cpu priority
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager]

; virtual memory
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000000
"HotPatchTableSize"=dword:00001000
"LargeSystemCache"=dword:00000000
"NonPagedPoolQuota"=dword:00000000
"NonPagedPoolSize"=dword:00000000
"PagedPoolQuota"=dword:00000000
"PagedPoolSize"=dword:00000000
"SecondLevelDataCache"=dword:00000000
"SessionPoolSize"=dword:00000004
"SessionViewSize"=dword:00000030
"SystemPages"=dword:00000000
"PagingFiles"=hex(7):63,00,3a,00,5c,00,70,00,61,00,67,00,65,00,66,00,69,00,6c,\
  00,65,00,2e,00,73,00,79,00,73,00,20,00,30,00,20,00,30,00,00,00,00,00
"PagefileUsage"=hex:04,00,00,00,4e,a5,02,00,cf,8f,00,00,b3,72,00,00,1b,74,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
"PhysicalAddressExtension"=dword:00000001
"FeatureSettings"=dword:00000000
"FeatureSettingsOverrideMask"=-
"FeatureSettingsOverride"=-
"ExistingPageFiles"=hex(7):5c,00,3f,00,3f,00,5c,00,43,00,3a,00,5c,00,70,00,61,\
  00,67,00,65,00,66,00,69,00,6c,00,65,00,2e,00,73,00,79,00,73,00,00,00,00,00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnablePrefetcher"=dword:00000003
"EnableSuperfetch"=dword:00000003
"EnableBootTrace"=dword:00000001
"BootId"=-
"BaseTime"=-
"SfTracingState"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\StoreParameters]




; ENABLE WINDOWS SECURITY SETTINGS
; cloud delivered protection
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
"SpyNetReporting"=dword:00000002

; automatic sample submission
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
"SubmitSamplesConsent"=dword:00000001

; firewall notifications
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications]
"DisableEnhancedNotifications"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Virus and threat protection]
"NoActionNotificationDisabled"=dword:00000000
"SummaryNotificationDisabled"=dword:00000000
"FilesBlockedNotificationDisabled"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Defender Security Center\Account protection]
"DisableNotifications"=dword:00000000
"DisableDynamiclockNotifications"=dword:00000000
"DisableWindowsHelloNotifications"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Epoch]
"Epoch"=dword:000004cc

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile]
"DisableNotifications"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile]
"DisableNotifications"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile]
"DisableNotifications"=dword:00000000

; exploit protection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\kernel]
"MitigationOptions"=hex(3):11,11,11,00,00,01,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00

; core isolation 
; memory integrity 
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity]
"ChangedInBootCycle"=-
"Enabled"=dword:00000001
"WasEnabledBy"=dword:00000002

; device guard
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard]
"EnableVirtualizationBasedSecurity"=dword:00000001
"RequirePlatformSecurityFeatures"=dword:00000001
"HypervisorEnforcedCodeIntegrity"=dword:00000001
"HVCIMATRequired"=dword:00000001
"LsaCfgFlags"=dword:00000001
"ConfigureSystemGuardLaunch"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceGuard]
"EnableVirtualizationBasedSecurity"=dword:00000001
"RequirePlatformSecurityFeatures"=dword:00000001
"HypervisorEnforcedCodeIntegrity"=dword:00000001
"HVCIMATRequired"=dword:00000001
"LsaCfgFlags"=dword:00000001
"ConfigureSystemGuardLaunch"=dword:00000001

; enable local security authority protection
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"RunAsPPL"=dword:00000001
"RunAsPPLBoot"=dword:00000001

; enable microsoft vulnerable driver blocklist
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\CI\Config]
"VulnerableDriverBlocklistEnable"=dword:00000001

; enable Bitlocker
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BitLocker]
"PreventDeviceEncryption"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE]
"DisableExternalDMAUnderLock"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices]
"TCGSecurityActivationDisabled"=dword:00000000

; kernel-mode hardware-enforced stack protection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=dword:00000001
"WasEnabledBy"=dword:00000002

; spectre and meltdown
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management]
"FeatureSettingsOverrideMask"=-
"FeatureSettingsOverride"=-

; other mitigations
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsMitigation]
"UserPreference"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig]
"EnableSvchostMitigationPolicy"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"MitigationAuditOptions"=-
"MitigationOptions"=-
"KernelSEHOPEnabled"=-

[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=-
"WasEnabledBy"=-

; enable uac
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableLUA"=dword:00000001

; enable smartscreen
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"SmartScreenEnabled"="Warn"

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=-

; turn on smartscreen in edge
[HKEY_CURRENT_USER\Software\Microsoft\Edge\SmartScreenEnabled]
"(Default)"="1"

; enable smartscreen for store apps
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost]
"EnableWebContentEvaluation"=dword:00000001
"PreventOverride"=dword:00000001

; show family options settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options]
"UILockdown"=-

; show account protection settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection]
"UILockdown"=-

; show device security settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security]
"UILockdown"=-

; enable fth
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\FTH]
"Enabled"=dword:00000001




; TROUBLESHOOTING
; automatic maintenance
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]
"MaintenanceDisabled"=-




; SECURITY AND MAINTENANCE
; report problems
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000000

; restore point creation frequency
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore]
"SystemRestorePointCreationFrequency"=-




; --IMMERSIVE CONTROL PANEL--




; WINDOWS UPDATE
; automatic updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
"AUOptions"=-
"NoAutoUpdate"=-
"AutoInstallMinorUpdates"=-

; prevent automatic upgrade to windows 11 and defer updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"targetreleaseversion"=-
"targetreleaseversioninfo"=-
"productversion"=-
"deferfeatureupdates"=-
"deferfeatureupdatesperiodindays"=-
"deferqualityupdates"=-
"deferqualityupdatesperiodindays"=-

; block workplace join prompt
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin]
"blockaadworkplacejoin"=-

; turn on driver updates via win update
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update]
"ExcludeWUDriversInQualityUpdate"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update]
"ExcludeWUDriversInQualityUpdate"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings]
"ExcludeWUDriversInQualityUpdate"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"ExcludeWUDriversInQualityUpdate"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate]
"value"=-

; delivery optimization
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization]
"DODownloadMode"=-

[HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings]
"DownloadMode"=-

;   @script       windows-updates-unpause.reg
;   @author       Aetherinox
;   @url          https://github.com/Aetherinox/pause-windows-updates
;
;   A script to re-activate Windows Updates.

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings]
"PauseFeatureUpdatesStartTime"=-
"PauseFeatureUpdatesEndTime"=-
"PauseQualityUpdatesStartTime"=-
"PauseQualityUpdatesEndTime"=-
"PauseUpdatesStartTime"=-
"PauseUpdatesExpiryTime"=-
"ActiveHoursStart"=dword:0000000d
"ActiveHoursEnd"=dword:00000007
"FlightSettingsMaxPauseDays"=dword:00002727

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc]
"Start"=dword:00000003
"FailureActions"=hex:84,03,00,00,00,00,00,00,00,00,00,00,03,00,00,00,14,00,00,\
  00,01,00,00,00,c0,d4,01,00,01,00,00,00,e0,93,04,00,00,00,00,00,00,00,00,00




; PRIVACY
; password reveal button
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI]
"DisablePasswordReveal"=dword:00000000

; show me notification in the settings app
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications]
"EnableAccountNotifications"=-

; location
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location]
"Value"="Allow"

; allow location override
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\UserLocationOverridePrivacySetting]
"Value"=dword:00000001

; camera
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam]
"Value"="Allow"

; microphone 
[Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone]
"Value"="Allow"

; voice activation
[-HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings]

; notifications
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener]
"Value"="Allow"

; account info
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation]
"Value"="Allow"

; contacts
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts]
"Value"="Allow"

; calendar
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments]
"Value"="Allow"

; phone calls
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall]
"Value"="Allow"

; call history
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory]
"Value"="Allow"

; email
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email]
"Value"="Allow"

; tasks
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks]
"Value"="Allow"

; messaging
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat]
"Value"="Allow"

; radios
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios]
"Value"="Allow"

; other devices 
[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync]

; app diagnostics 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics]
"Value"="Allow"

; documents
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary]
"Value"="Allow"

; downloads folder 
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder]

; music library
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary]
"Value"="Allow"

; pictures
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary]
"Value"="Deny"

; videos
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary]
"Value"="Allow"

; file system
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess]
"Value"="Allow"

; let websites show me locally relevant content by accessing my language list 
[HKEY_CURRENT_USER\Control Panel\International\User Profile]
"HttpAcceptLanguageOptOut"=-

; let windows improve start and search results by tracking app launches  
[-HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\EdgeUI]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EdgeUI]

; personal inking and typing dictionary
[HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization]
"RestrictImplicitInkCollection"=dword:00000000
"RestrictImplicitTextCollection"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization\TrainedDataStore]
"HarvestContacts"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings]
"AcceptedPrivacyPolicy"=dword:00000001

; sending required data
[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=-

; feedback frequency
[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf]

; store my activity history on this device 
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"PublishUserActivities"=-




; SEARCH
; search highlights
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDynamicSearchBoxEnabled"=-

; safe search
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"SafeSearchMode"=-

; cloud content search for work or school account
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsAADCloudSearchEnabled"=-

; cloud content search for microsoft account
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsMSACloudSearchEnabled"=-




; EASE OF ACCESS
; magnifier settings 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\ScreenMagnifier]
"FollowCaret"=-
"FollowNarrator"=-
"FollowMouse"=-
"FollowFocus"=-

; narrator settings
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator]
"IntonationPause"=-
"ReadHints"=-
"ErrorNotificationType"=-
"EchoChars"=-
"EchoWords"=-

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam]
"EchoToggleKeys"=-

; use the print screen key to open screeen capture
[HKEY_CURRENT_USER\Control Panel\Keyboard]
"PrintScreenKeyForSnippingEnabled"=-




; GAMING
; game bar
[HKEY_CURRENT_USER\System\GameConfigStore]
"GameDVR_Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]
"AppCaptureEnabled"=-

; enable open xbox game bar using game controller
[HKEY_CURRENT_USER\Software\Microsoft\GameBar]
"UseNexusForGameBarEnabled"=-

; game mode
[HKEY_CURRENT_USER\Software\Microsoft\GameBar]
"AutoGameModeEnabled"=00000000
"AllowAutoGameMode"=00000000

; other settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]
"AudioEncodingBitrate"=-
"AudioCaptureEnabled"=-
"CustomVideoEncodingBitrate"=-
"CustomVideoEncodingHeight"=-
"CustomVideoEncodingWidth"=-
"HistoricalBufferLength"=-
"HistoricalBufferLengthUnit"=-
"HistoricalCaptureEnabled"=-
"HistoricalCaptureOnBatteryAllowed"=-
"HistoricalCaptureOnWirelessDisplayAllowed"=-
"MaximumRecordLength"=-
"VideoEncodingBitrateMode"=-
"VideoEncodingResolutionMode"=-
"VideoEncodingFrameRateMode"=-
"EchoCancellationEnabled"=-
"CursorCaptureEnabled"=-
"VKToggleGameBar"=-
"VKMToggleGameBar"=-
"VKSaveHistoricalVideo"=-
"VKMSaveHistoricalVideo"=-
"VKToggleRecording"=-
"VKMToggleRecording"=-
"VKTakeScreenshot"=-
"VKMTakeScreenshot"=-
"VKToggleRecordingIndicator"=-
"VKMToggleRecordingIndicator"=-
"VKToggleMicrophoneCapture"=-
"VKMToggleMicrophoneCapture"=-
"VKToggleCameraCapture"=-
"VKMToggleCameraCapture"=-
"VKToggleBroadcast"=-
"VKMToggleBroadcast"=-
"MicrophoneCaptureEnabled"=-
"SystemAudioGain"=-
"MicrophoneGain"=-




; TIME & LANGUAGE 
; show the voice typing mic button
[HKEY_CURRENT_USER\Software\Microsoft\input\Settings]
"IsVoiceTypingKeyEnabled"=-

; capitalize the first letter of each sentence
; play key sounds as i type
; add a period after i double-tap the spacebar
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\1.7]
"EnableAutoShiftEngage"=-
"EnableKeyAudioFeedback"=-
"EnableDoubleTapSpace"=-

; typing insights 
[HKEY_CURRENT_USER\Software\Microsoft\input\Settings]
"InsightsEnabled"=-




; ACCOUNTS
; use my sign in info after restart
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"DisableAutomaticRestartSignOn"=-




; APPS
; automatically update maps
[HKEY_LOCAL_MACHINE\SYSTEM\Maps]
"AutoUpdateEnabled"=-

; archive apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx]
"AllowAutomaticAppArchiving"=-

; turn on resume
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration]
"IsResumeAllowed"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume]  
"DisableCrossDeviceResume"=dword:00000000

; sync apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowSyncMySettings]
"value"=dword:00000001




; PERSONALIZATION
; picture personalize your background
[HKEY_CURRENT_USER\Control Panel\Desktop]
"WallPaper"="C:\\Windows\\web\\wallpaper\\Windows\\img0.jpg"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundHistoryPath0"="C:\\Windows\\web\\wallpaper\\Windows\\img0.jpg"
"CurrentWallpaperPath"="C:\\Windows\\web\\wallpaper\\Windows\\img0.jpg"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000000

; light theme 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000001
"SystemUsesLightTheme"=dword:00000001

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent]
"AccentPalette"=hex:99,eb,ff,00,4c,c2,ff,00,00,91,f8,00,00,78,d4,00,00,67,c0,\
  00,00,3e,92,00,00,1a,68,00,f7,63,0c,00
"StartColorMenu"=dword:ffc06700
"AccentColorMenu"=dword:ffd47800

[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"EnableWindowColorization"=dword:00000000
"AccentColor"=dword:ffd47800
"ColorizationColor"=dword:c40078d4
"ColorizationAfterglow"=dword:c40078d4

; transparency
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000001

; don't hide most used list in start menu
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]

[-HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]

; revert start menu hide recommended w11
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Start]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Education]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"HideRecommendedSection"=-

; default pins personalization start
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_Layout"=-

; show recently added apps
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]

; show account-related notifications
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_AccountNotifications"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideRecentlyAddedApps"=-

; show recently opened items in start, jump lists and file explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_TrackDocs"=-

; normal taskbar alignment
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarAl"=-

; chat from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarMn"=-

; task view from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowTaskViewButton"=-

; search from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
"SearchboxTaskbarMode"=-

; windows widgets from taskbar
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds]
"ShellFeedsTaskbarOpenOnHover"=dword:00000001

; copilot from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowCopilotButton"=-

; meet now
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]

; action center
[-HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]

; news and interests
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds]

; don't show all taskbar icons
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"EnableAutoTray"=-

; security taskbar icon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run]
"SecurityHealth"=hex:04,00,00,00,00,00,00,00,00,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
"SecurityHealth"=hex(2):25,00,77,00,69,00,6e,00,64,00,69,00,72,00,25,00,5c,00,\
  73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,53,00,65,00,63,00,75,\
  00,72,00,69,00,74,00,79,00,48,00,65,00,61,00,6c,00,74,00,68,00,53,00,79,00,\
  73,00,74,00,72,00,61,00,79,00,2e,00,65,00,78,00,65,00,00,00

; use dynamic lighting on my devices
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"AmbientLightingEnabled"=dword:00000001

; compatible apps in the forground always control lighting 
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"ControlledByForegroundApp"=-

; match my windows accent color 
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"UseSystemAccentColor"=dword:00000001

; show key background
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\1.7]
"IsKeyBackgroundEnabled"=-

; show recommendations for tips shortcuts new apps and more
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_IrisRecommendations"=-

; share any window from my taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarSn"=-

; online tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000001

; enable EdgeUI help stickers
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\EdgeUI]
"DisableHelpSticker"=dword:00000000

; device install balloon tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000000




; DEVICES
; usb issues notify
[-HKEY_CURRENT_USER\Software\Microsoft\Shell]

; let windows manage my default printer
[HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows]
"LegacyDefaultPrinterMode"=dword:ffffffff

; write with your fingertip
[-HKEY_CURRENT_USER\Software\Microsoft\TabletTip\EmbeddedInkControl]




; SYSTEM
; dpi scaling
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=-
"Win8DpiScaling"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
"UseDpiScaling"=-

; fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=-

; hardware accelerated gpu scheduling
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"HwSchMode"=-

; variable refresh rate & optimizations for windowed games
[HKEY_CURRENT_USER\Software\Microsoft\DirectX\UserGpuPreferences]
"DirectXUserGlobalSettings"=-

; notifications
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications]
"ToastEnabled"=-

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel]
"Enabled"=-

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
"Enabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"RotatingLockScreenEnabled"=dword:00000001
"RotatingLockScreenOverlayEnabled"=dword:00000001
"SubscribedContent-338389Enabled"=dword:00000001

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement]

; suggested actions
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard]
"Disabled"=-

; focus assist
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\??windows.data.notifications.quiethourssettings\Current]
"Data"=hex:02,00,00,00,74,a9,70,73,03,82,da,01,00,00,00,00,43,42,01,00,c2,0a,\
  01,d2,14,28,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,2e,00,51,\
  00,75,00,69,00,65,00,74,00,48,00,6f,00,75,00,72,00,73,00,50,00,72,00,6f,00,\
  66,00,69,00,6c,00,65,00,2e,00,55,00,6e,00,72,00,65,00,73,00,74,00,72,00,69,\
  00,63,00,74,00,65,00,64,00,ca,28,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentfullscreen?windows.data.notifications.quietmoment\Current]
"Data"=hex:02,00,00,00,82,a3,71,73,03,82,da,01,00,00,00,00,43,42,01,00,c2,0a,\
  01,c2,14,01,d2,1e,26,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,\
  2e,00,51,00,75,00,69,00,65,00,74,00,48,00,6f,00,75,00,72,00,73,00,50,00,72,\
  00,6f,00,66,00,69,00,6c,00,65,00,2e,00,41,00,6c,00,61,00,72,00,6d,00,73,00,\
  4f,00,6e,00,6c,00,79,00,ca,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentgame?windows.data.notifications.quietmoment\Current]
"Data"=hex:02,00,00,00,a5,c1,71,73,03,82,da,01,00,00,00,00,43,42,01,00,c2,0a,\
  01,c2,14,01,d2,1e,28,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,\
  2e,00,51,00,75,00,69,00,65,00,74,00,48,00,6f,00,75,00,72,00,73,00,50,00,72,\
  00,6f,00,66,00,69,00,6c,00,65,00,2e,00,50,00,72,00,69,00,6f,00,72,00,69,00,\
  74,00,79,00,4f,00,6e,00,6c,00,79,00,ca,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentpostoobe?windows.data.notifications.quietmoment\Current]
"Data"=hex:02,00,00,00,85,de,71,73,03,82,da,01,00,00,00,00,43,42,01,00,c2,0a,\
  01,c2,14,01,d2,1e,28,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,\
  2e,00,51,00,75,00,69,00,65,00,74,00,48,00,6f,00,75,00,72,00,73,00,50,00,72,\
  00,6f,00,66,00,69,00,6c,00,65,00,2e,00,50,00,72,00,69,00,6f,00,72,00,69,00,\
  74,00,79,00,4f,00,6e,00,6c,00,79,00,ca,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentpresentation?windows.data.notifications.quietmoment\Current]
"Data"=hex:02,00,00,00,a4,fa,71,73,03,82,da,01,00,00,00,00,43,42,01,00,c2,0a,\
  01,c2,14,01,d2,1e,26,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,\
  2e,00,51,00,75,00,69,00,65,00,74,00,48,00,6f,00,75,00,72,00,73,00,50,00,72,\
  00,6f,00,66,00,69,00,6c,00,65,00,2e,00,41,00,6c,00,61,00,72,00,6d,00,73,00,\
  4f,00,6e,00,6c,00,79,00,ca,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentscheduled?windows.data.notifications.quietmoment\Current]
"Data"=hex:02,00,00,00,fe,17,72,73,03,82,da,01,00,00,00,00,43,42,01,00,c2,0a,\
  01,d2,1e,28,4d,00,69,00,63,00,72,00,6f,00,73,00,6f,00,66,00,74,00,2e,00,51,\
  00,75,00,69,00,65,00,74,00,48,00,6f,00,75,00,72,00,73,00,50,00,72,00,6f,00,\
  66,00,69,00,6c,00,65,00,2e,00,50,00,72,00,69,00,6f,00,72,00,69,00,74,00,79,\
  00,4f,00,6e,00,6c,00,79,00,d1,32,80,e0,aa,8a,99,30,d1,3c,80,e0,f6,c5,d5,0e,\
  ca,50,00,00

; battery options optimize
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\VideoSettings]

; storage sense
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\StorageSense]

; snap window settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SnapAssist"=-
"DITest"=-
"EnableSnapBar"=-
"EnableTaskGroups"=-
"EnableSnapAssistFlyout"=-
"SnapFill"=-
"JointResize"=-

; alt tab open
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"MultiTaskingAltTabFilter"=-

; share across devices
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP]
"RomeSdkChannelUserAuthzPolicy"=dword:00000001
"CdpSessionUserAuthzPolicy"=-

; enable clipboard
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000001

; enable clipboard history
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000001




; --OTHER--




; STORE
; update apps automatically
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore]




; EDGE
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]

[-HKEY_CURRENT_USER\Software\Policies\Microsoft\EdgeUpdate]

; Restore Edge as default PDF viewer - Remove custom association
[-HKEY_CLASSES_ROOT\.pdf]

; Remove the OpenWithProgids removal for Edge PDF handler (restores Edge as an option)
[HKEY_CLASSES_ROOT\.pdf\OpenWithProgids]
"AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723"=dword:00000000




; CHROME
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome]

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdate]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdatem]
"Start"=dword:00000002




; BRAVE
[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\BraveSoftware\Brave]

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\BraveSoftwareUpdateTaskMachineCore]

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\BraveSoftwareUpdateTaskMachineUA]




;FIREFOX
[-HKEY_LOCAL_MACHINE\Software\Policies\Mozilla\Firefox]




; NVIDIA
; nvidia tray icon
[-HKEY_CURRENT_USER\Software\NVIDIA Corporation\NvTray]




; --CAN'T DO NATIVELY--




; UWP APPS
; background apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy]
"LetAppsRunInBackground"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications]
"GlobalUserDisabled"=dword:00000000

; disable windows input experience preload
[HKEY_CURRENT_USER\Software\Microsoft\input]
"IsInputAppPreloadEnabled"=-

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Dsh]

; web search in start menu 
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=-

; copilot
[-HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot]

; cortana
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Search]
"AllowCortana"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Experience]
"AllowCortana"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortanaAboveLock"=dword:00000001

; widgets
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests]
"value"=dword:00000001

; enable ink workspace
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace]
"AllowWindowsInkWorkspace"=dword:00000001

; enable telemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics]
"EnabledExecution"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"LimitDiagnosticLogCollection"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000001

; enable activity history
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000001
"UploadUserActivities"=dword:00000001

; enable location
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
"DisableLocation"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
"DisableLocationScripting"=dword:00000000
"DisableWindowsLocationProvider"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\System]
"AllowExperimentation"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}]
"SensorPermissionState"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration]
"Status"=dword:00000001




; NVIDIA
; disable old nvidia legacy sharpening
; old location
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS]
"EnableGR535"=dword:00000001

; new location
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\nvlddmkm\Parameters\FTS]
"EnableGR535"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS]
"EnableGR535"=dword:00000001




; POWER
; park cpu cores 
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
"ValueMax"=dword:00000064
"ValueMin"=-

; remove maximum processor frequency
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100]
"Attributes"=dword:00000001

; power throttling
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling]

; hibernate
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"HibernateEnabled"=-
"HibernateEnabledDefault"=dword:00000001

; fast boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"HiberbootEnabled"=dword:00000001

; energy estimation & power saving
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EnergyEstimationEnabled"=dword:00000001
"EnergySaverPolicy"=dword:00000000

; connected standby
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"CsEnabled"=dword:00000001

; timer coalescing
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"CoalescingTimerInterval"=dword:00000001

; away mode
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"AwayModeEnabled"=dword:00000001




; ADVERTISING & PROMOTIONAL
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"ContentDeliveryAllowed"=dword:00000001
"FeatureManagementEnabled"=dword:00000001
"OemPreInstalledAppsEnabled"=dword:00000001
"PreInstalledAppsEnabled"=dword:00000001
"PreInstalledAppsEverEnabled"=dword:00000001
"RotatingLockScreenEnabled"=dword:00000001
"RotatingLockScreenOverlayEnabled"=dword:00000001
"SilentInstalledAppsEnabled"=dword:00000001
"SlideshowEnabled"=dword:00000001
"SoftLandingEnabled"=dword:00000001
"SubscribedContent-310093Enabled"=-
"SubscribedContent-314563Enabled"=-
"SubscribedContent-338388Enabled"=-
"SubscribedContent-338389Enabled"=-
"SubscribedContent-338389Enabled"=-
"SubscribedContent-338393Enabled"=-
"SubscribedContent-338393Enabled"=-
"SubscribedContent-353694Enabled"=-
"SubscribedContent-353694Enabled"=-
"SubscribedContent-353696Enabled"=-
"SubscribedContent-353696Enabled"=-
"SubscribedContent-353698Enabled"=-
"SubscribedContentEnabled"=dword:00000001
"SystemPaneSuggestionsEnabled"=dword:00000001




; OTHER
; 3d objects
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

; quick access
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"HubMode"=-

; home
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}]
@="CLSID_MSGraphHomeFolder"

; gallery
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}]

; context menu
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}]

; remove "Kill Not Responding Tasks" to desktop context menu
[-HKEY_CLASSES_ROOT\DesktopBackground\Shell\KillNRTasks]

; remove Run with priority context menu
[-HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority]

; remove Switch Power Plan context menu to desktop
[-HKEY_CLASSES_ROOT\DesktopBackground\Shell\PowerPlan_WAT]

; remove "Take Ownership" context menu to files and folders
[-HKEY_CLASSES_ROOT\*\shell\TakeOwnership]

; remove delete temp files
[-HKEY_CLASSES_ROOT\DesktopBackground\Shell\TempClean]

; menu show delay
[HKEY_CURRENT_USER\Control Panel\Desktop]
"MenuShowDelay"="400"

; driver searching & updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
"SearchOrderConfig"=dword:00000001

; mouse (default accel with epp on)
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"
"SmoothMouseXCurve"=hex:00,00,00,00,00,00,00,00,15,6e,00,00,00,00,00,00,00,40,\
  01,00,00,00,00,00,29,dc,03,00,00,00,00,00,00,00,28,00,00,00,00,00
"SmoothMouseYCurve"=hex:00,00,00,00,00,00,00,00,fd,11,01,00,00,00,00,00,00,24,\
  04,00,00,00,00,00,00,fc,12,00,00,00,00,00,00,c0,bb,01,00,00,00,00

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; disable endtask menu taskbar w11
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings]
"TaskbarEndTask"=dword:00000000

; disable win32 long paths
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001

; add 'Open in Windows Terminal' in win 11
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=-

; share context menu
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"=-

; add to favourites context menu
[-HKEY_CLASSES_ROOT\*\shell\pintohomefile]

[HKEY_CLASSES_ROOT\*\shell\pintohomefile]
"CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
"CommandStateSync"=""
"MUIVerb"="@shell32.dll,-51389"
"NeverDefault"=""
"SkipCloudDownload"=dword:00000000

[HKEY_CLASSES_ROOT\*\shell\pintohomefile\command]
"DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

; show insider program page
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility]
"HideInsiderPage"=-

; shortcut overlay icon 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons]
"29"=-

; enable the " - shortcut" text for shortcuts
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates]
"ShortcutNameTemplate"=-

; undo "Do this for all current items" checked by default
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager]
"ConfirmationCheckBoxDoForAll"=dword:00000000

; Enable automatic folder type discovery
[HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags]

[-HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell]

; Disable Network Drives over UAC
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableLinkedConnections"=dword:00000000
"LocalAccountTokenFilterPolicy"=dword:00000000
"EnableVirtualization"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"DisableLoopbackCheck"=dword:00000000

; onedrive user folder backup
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\OneDrive]
"KFMBlockOptIn"=-

; restore onedrive folder visibility
[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:1

[HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:1

; onedrive startup
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
"OneDrive"="\"C:\\Users\\Admin\\AppData\\Local\\Microsoft\\OneDrive\\OneDrive.exe\" /background"

; lock screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData]
"AllowLockScreen"=-

; enable automatic registry backup
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager]
"EnablePeriodicBackup"=dword:00000001

; enable "Look for an app in the Store" notification
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"NoUseStoreOpenWith"=-

; enable download restrictions in file explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=-

; enable mark-of-the-web (MOTW) for downloaded files
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AttachmentManager]
"ScanWithAntiVirus"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations]
"LowRiskFileTypes"=-

; protected view for office files
[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000000

; undo disable malicious software removal tool from installing
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT]
"DontOfferThroughWUAU"=-

; live tiles
[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
"NoTileApplicationNotification"=dword:00000000

; default wallpaper quallity
[HKEY_CURRENT_USER\Control Panel\Desktop]
"JPEGImportQuality"=dword:00000055

; disable windows installer in safe mode
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer]

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer]

; default timeout for disk auto check
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager]
"AutoChkTimeout"=dword:00000008

; enable blur on sign-in screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableAcrylicBackgroundOnLogon"=dword:00000000

; deactivate photo viewer
[HKEY_CLASSES_ROOT\jpegfile\shell\open\DropTarget]
"Clsid"=-

[HKEY_CLASSES_ROOT\pngfile\shell\open\DropTarget]
"Clsid"=-

[-HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open]

[-HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap]

[-HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF]

[-HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Jpeg]

[-HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Gif]

[-HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Png]

[-HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Wdp]



[HKEY_CURRENT_USER\SOFTWARE\Classes\.bmp]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.ico]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.jfif]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.jpg]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.jpeg]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.gif]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.png]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.tif]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.tiff]
@=-

[HKEY_CURRENT_USER\SOFTWARE\Classes\.wdp]
@=-


[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\OpenWithProgids]
"PhotoViewer.FileAssoc.Tiff"=-

[-HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\Image Preview]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities]
"ApplicationDescription"="@%ProgramFiles%\\Windows Photo Viewer\\photoviewer.dll,-3069"
"ApplicationName"="@%ProgramFiles%\\Windows Photo Viewer\\photoviewer.dll,-3009"

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations]
".tif"="PhotoViewer.FileAssoc.Tiff"
".tiff"="PhotoViewer.FileAssoc.Tiff"

; enable settings home
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"SettingsPageVisibility"=-

; enable consumer features
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000000
"DisableConsumerFeatures"=dword:00000000
"DisableWindowsConsumerFeatures"=dword:00000000
"DisableConsumerAccountStateContent"=dword:00000000

; enable homegroup
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupListener]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupProvider ]
"Start"=dword:00000003

; enable wifi-sense
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"AllowWiFiHotSpotReporting"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting]
"Value"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots]
"Value"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots]
"Enabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config]
"AutoConnectAllowedOEM"=dword:00000001

; enable ai features
[-HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI]

; enable NumLock on startup
[HKEY_USERS\.DEFAULT\Control Panel\Keyboard]
"InitialKeyboardIndicators"=dword:"2"

; Disable Verbose Messages During Logon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"VerboseStatus"=dword:00000000

; enable thumbnail cache
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"DisableThumbnailCache"=dword:00000001

; wait apps to close on shutdown
[HKEY_CURRENT_USER\Control Panel\Desktop]
"autoendtasks"="0"
"hungapptimeout"="5000"
"waittokillapptimeout"="20000"
"lowlevelhookstimeout"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control]
"waittokillservicetimeout"="5000"

; audiodg priority
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions]
"CpuPriorityClass"=-
"IoPriority"=-

; mouse cursor dissapeiring
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableCursorSuppression"=-

; tablet mode
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell]
; "TabletMode"=dword:-
; "SignInMode"=dword:-

; push to install feature
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall]
"DisablePushToInstall"=dword:00000000




; FOX OS
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\CameraAlternate\ShowPicturesOnArrival]
@=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\StorageOnArrival]
@=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\CameraAlternate\ShowPicturesOnArrival]
@=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\StorageOnArrival]
@=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
"winstationsdisabled"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"disabledomaincreds"=-
"restrictanonymous"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing]
"enablelog"=-
"enabledpxlog"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Component Based Servicing]
"enablelog"=-
"enabledpxlog"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole]
"enabledcom"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Ole]
"enabledcom"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy]
"value"=-

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\pci\Parameters]
"dmaremappingcompatible"=-
"dmaremappingonhiberpath"=-

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\storahci\Parameters]
"dmaremappingcompatible"=-
"dmaremappingonhiberpath"=-

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\stornvme\Parameters]
"dmaremappingcompatible"=-
"dmaremappingonhiberpath"=-

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\USBXHCI\Parameters]
"dmaremappingcompatibleselfhost"=-
"dmaremappingcompatible"=-

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Font Drivers]
"adobe type manager"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Terminal Server\Wds\rdpwd]
"startupprograms"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Beep]
"start"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\GpuEnergyDrv]
"start"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\npsvctrig]
"start"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\wanarp]
"start"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Wanarpv6]
"start"=-

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Windows\Win32knsWPP\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows\Win32knsWPP\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\USBHUB3\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\USBHUB3\Parameters\Wdf]
"logpages"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouhid\Parameters]
"logpages"=-

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule]
"disablerpcovertcp"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"restrictanonymoussam"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control]
"disableremotescmendpoints"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services]
"fdisablecdm"=-
"fallowtogethelp"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server]
"tsenabled"=-




; KHORVIE TECH
; tcpip tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"tcptimedwaitdelay"=dword:000000f0
"tcp1323opts"=-
"tcpmaxconnectretransmissions"=dword:00000002
"delayedackfrequency"=-
"delayedackticks"=-
"multihopsets"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters]
"irpstacksize"=-
"sizreqbuf"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\QoS]
"do not use nla"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"negativecachetime"=dword:0000012c
"negativesoacachetime"=-
"netfailurecachetime"=-
"enableautodoh"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"nonblockingsendspecialbuffering"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters]
"tcpnodelay"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched]
"nonbesteffortlimit"=-

; dwm schedule master values
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM\Schedule]
"windowedgsyncgeforceflag"=-
"frameratemin"=-
"ignoredisplaychangeduration"=-
"lingerinterval"=-
"licenseinterval"=-
"restrictednvcpluimode"=-
"disablespecificpopups"=-
"disableexpirationpopups"=-
"enableforceigpudgpufromui"=-
"hidexgputrayicon"=-
"showtrayicon"=-
"hideballoonnotification"=-
"performancestate"=-
"gc6state"=-
"framedisplaybasenegoffsetns"=-
"framedisplayresdivvalue"=-
"ignorenodelocked"=-
"ignoresp"=-
"dontaskagain"=-

; kernel new kizzimo
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"kiclocktimerpercpu"=-
"kiclocktimerhighlatency"=-
"kiclocktimeralwaysonpresent"=-
"clocktimerpercpu"=-
"clocktimerhighlatency"=-
"clocktimeralwaysonpresent"=-

; smooth scrolling
[HKEY_CURRENT_USER\Control Panel\Desktop]
"smoothscroll"=-

; fast user switching
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"hidefastuserswitching"=-

; dont tolerate high dpc/isr
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"exitlatency"=-
"exitlatencycheckenabled"=-
"latency"=-
"latencytolerancedefault"=-
"latencytolerancefsvp"=-
"latencytoleranceperfoverride"=-
"latencytolerancescreenoffir"=-
"latencytolerancevsyncenabled"=-
"rtlcapabilitychecklatency"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power]
*all values removed*

; display
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\ModernSleep]
"adaptiverefreshrate"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"videoidletimeout"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"powersavingmodeenabled"=-
"panelselfrefresh"=-
"forceoffscreentimeout"=-

; gpu
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler]
"enableframebuffercompression"=-
"enablegpuboost"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv]
"start"=-

; network
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001]
"pnpcapabilities"=-




; ARKHAM

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX]
"d3d12_enable_unsafe_command_buffer_reuse"=-
"d3d12_enable_runtime_driver_optimizations"=-
"d3d12_resource_alignment"=-
"d3d11_multithreaded"=-
"d3d12_multithreaded"=-
"d3d11_deferred_contexts"=-
"d3d12_deferred_contexts"=-
"d3d11_allow_tiling"=-
"d3d11_enable_dynamic_codegen"=-
"d3d12_allow_tiling"=-
"d3d12_cpu_page_table_enabled"=-
"d3d12_heap_serialization_enabled"=-
"d3d12_map_heap_allocations"=-
"d3d12_residency_management_enabled"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DXGKrnl]
"creategdiprimaryonslavegpu"=-
"driversupportscdddwminterop"=-
"dxgkcddsyncdxaccess"=-
"dxgkcddsyncgpuaccess"=-
"dxgkcddwaitforverticalblankevent"=-
"dxgkcreateswapchain"=-
"dxgkfreegpuvirtualaddress"=-
"dxgkopenswapchain"=-
"dxgkshareswapchainobject"=-
"dxgkwaitforverticalblankevent"=-
"dxgkwaitforverticalblankevent2"=-
"swapchainbackbuffer"=-
"tdrresetfromtimeoutasync"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\stornvme\Parameters]
"StorNVMeAllowZeroLatency"=-
"queuedepth"=-
"nvmemaxreadsplit"=-
"nvmemaxwritesplit"=-
"forceflush"=-
"immediatedata"=-
"maxsegmentspercommand"=-
"maxoutstandingcmds"=-
"forceeagerwrites"=-
"maxqueuedcommands"=-
"maxoutstandingiorequests"=-
"numberofrequests"=dword:000003e8
"io submissionqueuecount"=-
"ioqueuedepth"=-
"hostmemorybufferbytes"=-
"arbitrationburst"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorNVMe\Parameters\Device]
"StorNVMeAllowZeroLatency"=-
"queuedepth"=-
"nvmemaxreadsplit"=-
"nvmemaxwritesplit"=-
"forceflush"=-
"immediatedata"=-
"maxsegmentspercommand"=-
"maxoutstandingcmds"=-
"forceeagerwrites"=-
"maxqueuedcommands"=-
"maxoutstandingiorequests"=-
"numberofrequests"=dword:000003e8
"io submissionqueuecount"=-
"ioqueuedepth"=-
"hostmemorybufferbytes"=-
"arbitrationburst"=-

; dpc kernel tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"dpcwatchdogprofileoffset"=-
_dpctimeout"=-
"idealdpcrate"=-
"maximumdpcqueuedepth"=-
"minimumdpcrate"=-
"dpcwatchdogperiod"=-
"maxdynamictickduration"=-
"maximumsharedreadyqueuesize"=-
"buffersize"=-
"ioqueueworkitem"=-
"ioqueueworkitemtonode"=-
"ioqueueworkitemex"=-
"ioqueuethreadirp"=-
"extryqueueworkitem"=-
"exqueueworkitem"=-
"ioenqueueirp"=-
"xmmizerroingenable"=-
"usenormalstack"=-
"usenewaabuffering"=-
"stacksubsystemstacksize"=-

; cpu performance tuning
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
"cpu_max_pending_interrupts"=-
"cpu_max_pending_io"=-
"cpu_idle_policy"=-
"cpu_boost_policy"=-
"cpu_max_frequency"=-
"cpu_interrupt_balance_policy"=-
"mkl_debug_cpu_type"=-

"io performance tuning
"io_completion_policy"=-
"io_request_limit"=-
"disk_max_pending_io"=-
"io_priority"=-
"disk_max_pending_interrupts"=-
"io_max_pending_interrupts"=-




; HAKANFLY

; Revert Base and OverTarget Priorities
; Founded and Created by Kizzimo (Revert file created by Alchemy Tweaks)
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0003]

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0002]

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0001]

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0000]


[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{fe8f1572-c67a-48c0-bbac-0b5c6d66cafb}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f8ecafa6-66d1-41a5-899b-66585d7216b7}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f75a86c0-10d8-4c3a-b233-ed60e4cdfaac}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f3586baf-b5aa-49b5-8d6c-0569284c639f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f2e7dd72-6468-4e36-b6f1-6488f42c1b52}]
"BasePriority"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f048e777-b971-404b-bd9c-3802613495c2}]

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f01a9d53-3ff6-48d2-9f97-c8a7004be10c}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{eec5ad98-8080-425f-922a-dabf3de3f69a}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e6f1aa1c-7f3b-4473-b2e8-c97d8ac71d53}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e55fa6f9-128c-4d04-abab-630c74b1453a}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e2f84ce7-8efa-411c-aa69-97454ca4cb57}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e0cbf06c-cd8b-4647-bb8a-263b43f0f974}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d94ee5d8-d189-4994-83d2-f68d7d41b0e6}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d546500a-2aeb-45f6-9482-f4b1799c3177}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d48179be-ec20-11d1-b6b8-00c04fa372a7}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d421b08e-6d16-41ca-9c4d-9147e5ac98e0}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d02bc3da-0c8e-4945-9bd5-f1883c226c8c}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{ce5939ae-ebde-11d0-b181-0000f8753ec4}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{cdcf0939-b75b-4630-bf76-80f7ba655884}]
"BasePriority"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{cc342e67-bd5b-4dd2-bb7b-bf23cf9f2a0e}]


[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{ca3e7ab9-b4c3-4ae6-8251-579ef933890f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{c30ecea0-11ef-4ef9-b02e-6af81e6e65c0}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{c166523c-fe0c-4a94-a586-f1a80cfbbf3e}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{c06ff265-ae09-48f0-812c-16753d7cba83}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{bbbe8734-08fa-4966-b6a6-4e5ad010cdd7}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{b86dff51-a31e-4bac-b3cf-e8cfe75c9fc2}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{b2728d24-ac56-42db-9e02-8edaf5db652f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{b1d1a169-c54f-4379-81db-bee7d88d7454}]
"BasePriority"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a73c93f1-9727-4d1d-ace1-0e333ba4e7db}]


[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a3e32dba-ba89-4f17-8386-2d0127fbd4cc}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a0a701c0-a511-42ff-aa6c-06dc0395576f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a0a588a4-c46f-4b37-b7ea-c82fe89870c6}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{9da2b80f-f89f-4a49-a5c2-511b085b9e8a}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{8ecc055d-047f-11d1-a537-0000f8753ed1}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{89786ff1-9c12-402f-9c9e-17753c7f4375}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{88bae032-5a81-49f0-bc3d-a4ff138216d6}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{88a1c342-4539-11d3-b88d-00c04fad5171}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{87ef9ad1-8f70-49ee-b215-ab1fcadcbe3c}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{8503c911-a6c7-4919-8f79-5028f5866b0c}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{7ebefbc0-3200-11d2-b4c2-00a0c9697d07}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{745a17a0-74d3-11d0-b6fe-00a0c90f57da}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{72631e54-78a4-11d0-bcf7-00aa00b7b32a}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{71aa14f8-6fad-4622-ad77-92bb9d7e6947}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{71a27cdd-812a-11d0-bec7-08002be2092f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6fae73b7-b735-4b50-a0da-0dc2484b1f1a}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6d807884-7d21-11cf-801c-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc5-810f-11d0-bec7-08002be2092f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc1-810f-11d0-bec7-08002be2092f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6a0a8e78-bba6-4fc4-a709-1e33cd09d67e}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{62f9c741-b25a-46ce-b54c-9bccce08b6f2}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5d1b9aaa-01e2-46af-849f-272b3f324c46}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5c4c3332-344d-483c-8739-259e934c9cc8}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5989fce8-9cd0-467d-8a6a-5419e31529d4}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5630831c-06c9-4856-b327-f5d32586e060}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53d29ef7-377c-4d14-864b-eb3a85769359}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53ccb149-e543-4c84-b6e0-bce4f6b7e806}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53b3cf03-8f5a-4788-91b6-d19ed9fcccbf}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53966cb1-4d46-4166-bf23-c522403cd495}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53487c23-680f-4585-acc3-1f10d6777e82}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{533c5b84-ec70-11d2-9505-00c04f79deaf}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5175d334-c371-4806-b3ba-71fd53c9258d}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5099944a-f6b9-4057-a056-8c550228544c}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{50906cb8-ba12-11d1-bf5d-0000f805f530}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{50127dc3-0f36-415e-a6cc-4cb3be910b65}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e97e-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e97d-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e97b-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e978-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e977-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e975-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e974-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e973-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e971-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e970-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96f-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96e-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96d-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96b-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96a-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001]


[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e966-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{49ce6ac8-6f86-11d2-b1e5-0080c72e74a2}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{48d3ebc4-4cf8-48ff-b869-9c68ad42eb9f}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{48721b56-6795-11d2-b1a8-0080c72e74a2}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4658ee7e-f050-11d1-b6bd-00c04fa372a7}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{43675d81-502a-4a82-9f84-b75f418c5dea}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{3e3f0674-c83c-4558-bb26-9820e1eba5c5}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{36fc9e60-c465-11cf-8056-444553540000}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{2db15374-706e-4131-a0c7-d7c78eb0289a}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{268c95a1-edfe-11d3-95c3-0010dc4050a5}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{25dbce51-6c8f-4a72-8a6d-b54c2b4fc835}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{14b62f50-3f15-11dd-ae16-0800200c9a66}]
"BasePriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{1264760f-a5c8-4bfe-b314-d56a7b44a362}]
"BasePriority"=-



[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0003]


[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0002]


[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0001]


[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{33123269-1807-11EF-B26D-806E6F6E6963}\0000]


[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{fe8f1572-c67a-48c0-bbac-0b5c6d66cafb}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f8ecafa6-66d1-41a5-899b-66585d7216b7}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f75a86c0-10d8-4c3a-b233-ed60e4cdfaac}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f3586baf-b5aa-49b5-8d6c-0569284c639f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f2e7dd72-6468-4e36-b6f1-6488f42c1b52}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f048e777-b971-404b-bd9c-3802613495c2}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{f01a9d53-3ff6-48d2-9f97-c8a7004be10c}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{eec5ad98-8080-425f-922a-dabf3de3f69a}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e6f1aa1c-7f3b-4473-b2e8-c97d8ac71d53}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e55fa6f9-128c-4d04-abab-630c74b1453a}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e2f84ce7-8efa-411c-aa69-97454ca4cb57}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{e0cbf06c-cd8b-4647-bb8a-263b43f0f974}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d94ee5d8-d189-4994-83d2-f68d7d41b0e6}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d546500a-2aeb-45f6-9482-f4b1799c3177}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d48179be-ec20-11d1-b6b8-00c04fa372a7}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d421b08e-6d16-41ca-9c4d-9147e5ac98e0}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{d02bc3da-0c8e-4945-9bd5-f1883c226c8c}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{ce5939ae-ebde-11d0-b181-0000f8753ec4}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{cdcf0939-b75b-4630-bf76-80f7ba655884}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{cc342e67-bd5b-4dd2-bb7b-bf23cf9f2a0e}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{ca3e7ab9-b4c3-4ae6-8251-579ef933890f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{c30ecea0-11ef-4ef9-b02e-6af81e6e65c0}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{c166523c-fe0c-4a94-a586-f1a80cfbbf3e}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{c06ff265-ae09-48f0-812c-16753d7cba83}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{bbbe8734-08fa-4966-b6a6-4e5ad010cdd7}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{b86dff51-a31e-4bac-b3cf-e8cfe75c9fc2}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{b2728d24-ac56-42db-9e02-8edaf5db652f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{b1d1a169-c54f-4379-81db-bee7d88d7454}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a73c93f1-9727-4d1d-ace1-0e333ba4e7db}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a3e32dba-ba89-4f17-8386-2d0127fbd4cc}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a0a701c0-a511-42ff-aa6c-06dc0395576f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{a0a588a4-c46f-4b37-b7ea-c82fe89870c6}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{9da2b80f-f89f-4a49-a5c2-511b085b9e8a}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{8ecc055d-047f-11d1-a537-0000f8753ed1}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{89786ff1-9c12-402f-9c9e-17753c7f4375}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{88bae032-5a81-49f0-bc3d-a4ff138216d6}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{88a1c342-4539-11d3-b88d-00c04fad5171}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{87ef9ad1-8f70-49ee-b215-ab1fcadcbe3c}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{8503c911-a6c7-4919-8f79-5028f5866b0c}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{7ebefbc0-3200-11d2-b4c2-00a0c9697d07}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{745a17a0-74d3-11d0-b6fe-00a0c90f57da}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{72631e54-78a4-11d0-bcf7-00aa00b7b32a}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{71aa14f8-6fad-4622-ad77-92bb9d7e6947}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{71a27cdd-812a-11d0-bec7-08002be2092f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6fae73b7-b735-4b50-a0da-0dc2484b1f1a}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6d807884-7d21-11cf-801c-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc5-810f-11d0-bec7-08002be2092f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc1-810f-11d0-bec7-08002be2092f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{6a0a8e78-bba6-4fc4-a709-1e33cd09d67e}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{62f9c741-b25a-46ce-b54c-9bccce08b6f2}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5d1b9aaa-01e2-46af-849f-272b3f324c46}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5c4c3332-344d-483c-8739-259e934c9cc8}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5989fce8-9cd0-467d-8a6a-5419e31529d4}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5630831c-06c9-4856-b327-f5d32586e060}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53d29ef7-377c-4d14-864b-eb3a85769359}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53ccb149-e543-4c84-b6e0-bce4f6b7e806}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53b3cf03-8f5a-4788-91b6-d19ed9fcccbf}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53966cb1-4d46-4166-bf23-c522403cd495}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{53487c23-680f-4585-acc3-1f10d6777e82}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{533c5b84-ec70-11d2-9505-00c04f79deaf}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5175d334-c371-4806-b3ba-71fd53c9258d}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{5099944a-f6b9-4057-a056-8c550228544c}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{50906cb8-ba12-11d1-bf5d-0000f805f530}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{50127dc3-0f36-415e-a6cc-4cb3be910b65}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e97e-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e97d-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e97b-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e978-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e977-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e975-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e974-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e973-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e971-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e970-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96f-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96e-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96d-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96b-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e96a-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001]


[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e966-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{49ce6ac8-6f86-11d2-b1e5-0080c72e74a2}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{48d3ebc4-4cf8-48ff-b869-9c68ad42eb9f}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{48721b56-6795-11d2-b1a8-0080c72e74a2}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4658ee7e-f050-11d1-b6bd-00c04fa372a7}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{43675d81-502a-4a82-9f84-b75f418c5dea}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{3e3f0674-c83c-4558-bb26-9820e1eba5c5}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{36fc9e60-c465-11cf-8056-444553540000}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{2db15374-706e-4131-a0c7-d7c78eb0289a}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{268c95a1-edfe-11d3-95c3-0010dc4050a5}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{25dbce51-6c8f-4a72-8a6d-b54c2b4fc835}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{14b62f50-3f15-11dd-ae16-0800200c9a66}]
"OverTargetPriority"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{1264760f-a5c8-4bfe-b314-d56a7b44a362}]
"OverTargetPriority"=-

; Revert Advanced DWM Tweaks
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe]

; FlipPresent
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM]
"ForceDirectDrawSync"=-
"FrameLatency"=-
"MaxQueuedPresentBuffers"=-

; Adjustablesd - jdallmann
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM]
"DDisplayTestMode"=-
"DebugFailFast"=-
"DisableDeviceBitmaps"=-
"DisableHologramCompositor"=-
"DisableLockingMemory"=-
"DisableProjectedShadowsRendering"=-
"DisableProjectedShadows"=-
"DisallowNonDrawListRendering"=-
"EnableCpuClipping"=-
"EnableRenderPathTestMode"=-
"FlattenVirtualSurfaceEffectInput"=-
"InkGPUAccelOverrideVendorWhitelist"=-
"InteractionOutputPredictionDisabled"=-
"MPCInputRouterWaitForDebugger"=-
"OneCoreNoDWMRawGameController"=-
"ResampleInLinearSpace"=-
"SDRBoostPercentOverride"=-
"SuperWetEnabled"=-

; ImmediateRender - Kizzimo
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM]
"AnimationAttributionEnabled"=-
"AnimationsShiftKey"=-
"DisableAdvancedDirectFlip"=-
"DisableDrawListCaching"=-
"EnableCommonSuperSets"=-
"EnableDesktopOverlays"=-
"EnableEffectCaching"=-
"EnableFrontBufferRenderChecks"=-
"EnableMegaRects"=-
"EnablePrimitiveReordering"=-
"EnableResizeOptimization"=-
"HighColor"=-
"MaxD3DFeatureLevel"=-
"OverlayQualifyCount"=-
"OverlayDisqualifyCount"=-
"ParallelModePolicy"=-
"ResampleModeOverride"=-
"RenderThreadWatchdogTimeoutMilliseconds"=-
"ResizeTimeoutGdi"=-
"ResizeTimeoutModern"=-
"UseHWDrawListEntriesOnWARP"=-

; Revert CSRSS Tweaks
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe]

; Revert D3D11 - D3D12 Tweaks
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX]
"D3D12_ENABLE_UNSAFE_COMMAND_BUFFER_REUSE"=-
"D3D12_ENABLE_RUNTIME_DRIVER_OPTIMIZATIONS"=-
"D3D12_RESOURCE_ALIGNMENT"=-
"D3D11_MULTITHREADED"=-
"D3D12_MULTITHREADED"=-
"D3D11_DEFERRED_CONTEXTS"=-
"D3D12_DEFERRED_CONTEXTS"=-
"D3D11_ALLOW_TILING"=-
"D3D11_ENABLE_DYNAMIC_CODEGEN"=-
"D3D12_ALLOW_TILING"=-
"D3D12_CPU_PAGE_TABLE_ENABLED"=-
"D3D12_HEAP_SERIALIZATION_ENABLED"=-
"D3D12_MAP_HEAP_ALLOCATIONS"=-
"D3D12_RESIDENCY_MANAGEMENT_ENABLED"=-

; Revert DirectX Driver DXGKrnl Advanced Tweaks (2)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DXGKrnl]
"CreateGdiPrimaryOnSlaveGPU"=-
"DriverSupportsCddDwmInterop"=-
"DxgkCddSyncDxAccess"=-
"DxgkCddSyncGPUAccess"=-
"DxgkCddWaitForVerticalBlankEvent"=-
"DxgkCreateSwapChain"=-
"DxgkFreeGpuVirtualAddress"=-
"DxgkOpenSwapChain"=-
"DxgkShareSwapChainObject"=-
"DxgkWaitForVerticalBlankEvent"=-
"DxgkWaitForVerticalBlankEvent2"=-
"SwapChainBackBuffer"=-
"TdrResetFromTimeoutAsync"=-

; Revert NVMe Tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\stornvme\Parameters]
"StorNVMeAllowZeroLatency"=-
"QueueDepth"=-
"NvmeMaxReadSplit"=-
"NvmeMaxWriteSplit"=-
"ForceFlush"=-
"ImmediateData"=-
"MaxSegmentsPerCommand"=-
"MaxOutstandingCmds"=-
"ForceEagerWrites"=-
"MaxQueuedCommands"=-
"MaxOutstandingIORequests"=-
"NumberOfRequests"=-
"IoSubmissionQueueCount"=-
"IoQueueDepth"=-
"HostMemoryBufferBytes"=-
"ArbitrationBurst"=-

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorNVMe\Parameters\Device]
"StorNVMeAllowZeroLatency"=-
"QueueDepth"=d-
"NvmeMaxReadSplit"=-
"NvmeMaxWriteSplit"=-
"ForceFlush"=-
"ImmediateData"=-
"MaxSegmentsPerCommand"=-
"MaxOutstandingCmds"=-
"ForceEagerWrites"=-
"MaxQueuedCommands"=-
"MaxOutstandingIORequests"=-
"NumberOfRequests"=-
"IoSubmissionQueueCount"=-
"IoQueueDepth"=-
"HostMemoryBufferBytes"=-
"ArbitrationBurst"=-

; Revert Priority Control Tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
"AdjustDpcThreshold"=-
"DeepIoCoalescingEnabled"=-
"IdealDpcRate"=-
"ForegroundBoost"=-
"SchedulerAssistThreadFlagOverride"=-
"ThreadBoostType"=-
"ThreadSchedulingModel"=-

; Revert Resource Sets
[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets]

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ApplicationService]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ApplicationServiceElastic]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="ElasticRecipient"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ApplicationServiceHighPriElastic]
"CPU"="SoftCapLow"
"ExternalResources"="BackgroundAudioPlayer"
"Flags"="ElasticRecipient"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ApplicationServiceHighPriority]
"CPU"="SoftCapLow"
"ExternalResources"="BackgroundAudioPlayer"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ApplicationServiceRemote]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\AppToAppTarget]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="None"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\BackgroundAudioPlayer]
"CPU"="SoftCapLow"
"ExternalResources"="BackgroundAudioPlayer"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\BackgroundCachedFileUpdater]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\BackgroundTaskCompletion]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\BackgroundTaskDebug]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\BackgroundTransfer]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\BackgroundTransferNetworkState]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\Balloon]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\CalendarProviderAsChild]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\CallingEvent]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\CallingEventHighPriority]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="VeryHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ChatMessageNotification]
"CPU"="SoftCapFull"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="VeryHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ComponentTarget]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ContinuousBackgroundExecution]
"CPU"="SoftCapLow"
"ExternalResources"="ExtendedExecution"
"Flags"="None"
"Importance"="MediumHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\CortanaSpeechBackground]
"CPU"="SoftCapLow"
"ExternalResources"="Cortana"
"Flags"="BackgroundDefault"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\CreateProcess]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\DefaultModernBackgroundTask]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\DefaultPPLE]
"CPU"="SoftCapFull"
"ExternalResources"="PPLE"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\DefaultPPLE2]
"CPU"="SoftCapFull"
"ExternalResources"="PPLE"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\EmCreateProcess]
"CPU"="SoftCapLowBackgroundBegin"
"ExternalResources"="EmCreateProcess"
"Flags"="EstimateMemoryUsage"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\EmCreateProcessNormalPriority]
"CPU"="SoftCapLow"
"ExternalResources"="EmCreateProcess"
"Flags"="EstimateMemoryUsage"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\EmptyHost]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="VeryLow"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\EmptyHostHighPriority]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\EmptyHostPPLE]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="FrozenPPLE"
"Importance"="EmptyHostPPLE"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\FileProviderTarget]
"CPU"="SoftCapFull"
"ExternalResources"="FileProviderTarget"
"Flags"="Foreground"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ForegroundAgent]
"CPU"="SoftCapLow"
"ExternalResources"="ForegroundAgent"
"Flags"="ShareWithFG"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ForegroundCachedFileUpdater]
"CPU"="SoftCapFull"
"ExternalResources"="ForegroundAgent"
"Flags"="None"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ForegroundTaskCompletion]
"CPU"="SoftCapFull"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\Frozen]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="VeryLow"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\GenericExtendedExecution]
"CPU"="SoftCapLow"
"ExternalResources"="ExtendedExecution"
"Flags"="None"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\GeofenceTask]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\HighPriorityBackgroundAgent]
"CPU"="UnmanagedAboveNormal"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="VeryHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\HighPriorityBackgroundDemoted]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\HighPriorityBackgroundTransfer]
"CPU"="SoftCapFull"
"ExternalResources"="ForegroundAgent"
"Flags"="ShareWithFG"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\IoTStartupTask]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\JumboForegroundAgent]
"CPU"="SoftCapLow"
"ExternalResources"="ForegroundAgent"
"Flags"="ShareWithFG"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaBackgroundTaskCompletion]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaDefaultModernBackgroundTask]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaPrelaunchForeground]
"CPU"="SoftCapFull"
"ExternalResources"="ApplicationService"
"Flags"="PrelaunchForeground"
"Importance"="Lowest"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiDebugModeForeground]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiFrozen]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="VeryLow"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiFrozenDNCS]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="FrozenDNCS"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiFrozenDNK]
"CPU"="SoftCapFull"
"ExternalResources"="None"
"Flags"="FrozenDNK"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiFrozenHighPriority]
"CPU"="SoftCapFull"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="StartHost"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiModernForeground]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiModernForegroundLarge]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiPaused]
"CPU"="HardCap0"
"ExternalResources"="Paused"
"Flags"="Paused"
"Importance"="VeryLow"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiPausedDNK]
"CPU"="SoftCapFull"
"ExternalResources"="Paused"
"Flags"="PausedDNK"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiPausedHighPriority]
"CPU"="SoftCapFull"
"ExternalResources"="Paused"
"Flags"="Paused"
"Importance"="VeryHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LmaUiPausing]
"CPU"="SoftCapFull"
"ExternalResources"="Pausing"
"Flags"="Pausing"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LongRunningBluetooth]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationServiceNetworkSponsor"
"Flags"="BackgroundDefault"
"Importance"="MediumHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LongRunningControlChannel]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\LongRunningSensor]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="MediumHigh"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\MediaProcessing]
"CPU"="SoftCapLow"
"ExternalResources"="ExtendedExecution"
"Flags"="ThrottleGPUInterference"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\OemBackgroundAgent]
"CPU"="SoftCapLow"
"ExternalResources"="EmCreateProcess"
"Flags"="NotKillable"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\OemTask]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\PendingDefaultPPLE]
"CPU"="SoftCapFull"
"ExternalResources"="PPLE"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\PiP]
"CPU"="SoftCapLow"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="CriticalNoUi"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\PreinstallTask]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\PrelaunchForeground]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="PrelaunchForeground"
"Importance"="Lowest"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\PushTriggerTask]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ResourceIntensive]
"CPU"="SoftCapLow"
"ExternalResources"="ResourceIntensive"
"Flags"="BackgroundDefault"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ShareDataPackageHost]
"CPU"="SoftCapFull"
"ExternalResources"="ApplicationService"
"Flags"="None"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\ShortRunningBluetooth]
"CPU"="SoftCapLow"
"ExternalResources"="ApplicationService"
"Flags"="BackgroundDefault"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\TaskCompletionHighPriority]
"CPU"="SoftCapLow"
"ExternalResources"="ExtendedExecution"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiComposer]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiDebugModeForeground]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiForegroundDNK]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiFrozen]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="VeryLow"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiFrozenDNCS]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="FrozenDNCS"
"Importance"="Low"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiFrozenDNK]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="FrozenDNK"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiFrozenHighPriority]
"CPU"="HardCap0"
"ExternalResources"="None"
"Flags"="Frozen"
"Importance"="StartHost"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiLockScreen]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiModernForeground]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiModernForegroundExtended]
"CPU"="SoftCapLow"
"ExternalResources"="UiExtended"
"Flags"="None"
"Importance"="CriticalNoUi"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiModernForegroundLarge]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiOverlay]
"CPU"="SoftCapLow"
"ExternalResources"="UiOverlay"
"Flags"="Foreground"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiPaused]
"CPU"="Paused"
"ExternalResources"="Paused"
"Flags"="Paused"
"Importance"="VeryLow"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiPausedDNK]
"CPU"="Paused"
"ExternalResources"="Paused"
"Flags"="PausedDNK"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiPausedHighPriority]
"CPU"="Paused"
"ExternalResources"="Paused"
"Flags"="Paused"
"Importance"="StartHost"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiPausing]
"CPU"="SoftCapLow"
"ExternalResources"="Pausing"
"Flags"="Pausing"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiPausingLowPriority]
"CPU"="SoftCapLow"
"ExternalResources"="Pausing"
"Flags"="Pausing"
"Importance"="StartHost"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiShellCustom1]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiShellCustom2]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiShellCustom3]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\UiShellCustom4]
"CPU"="SoftCapFull"
"ExternalResources"="StandardExternalResources"
"Flags"="Foreground"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VideoTranscoding]
"CPU"="SoftCapLow"
"ExternalResources"="ExtendedExecution"
"Flags"="ThrottleGPUInterference"
"Importance"="Medium"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VoipActiveCallBackground]
"CPU"="SoftCapFullAboveNormal"
"ExternalResources"="VoipBackground"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VoipActiveCallBackgroundPriority]
"CPU"="SoftCapFullAboveNormal"
"ExternalResources"="VoipCall"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VoipActiveCallForeground]
"CPU"="SoftCapFullAboveNormal"
"ExternalResources"="VoipCall"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VoipForegroundWorker]
"CPU"="SoftCapFull"
"ExternalResources"="VoipLegacy"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VoipSuspendedBackground]
"CPU"="Paused"
"ExternalResources"="None"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\VoipWorker]
"CPU"="SoftCapFull"
"ExternalResources"="ApplicationService"
"Flags"="PPLE"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\Vpn]
"CPU"="SoftCapFull"
"ExternalResources"="ForegroundAgent"
"Flags"="None"
"Importance"="Critical"
"IO"="NoCap"
"Memory"="NoCap"

[HKEY_LOCAL_MACHINE\SYSTEM\ResourcePolicyStore\ResourceSets\PolicySets\WebAuthSignIn]
"CPU"="SoftCapFull"
"ExternalResources"="WebAuthSignIn"
"Flags"="Foreground"
"Importance"="High"
"IO"="NoCap"
"Memory"="NoCap"




; set split treshold for svchost
; Restore Default Behavior
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control]
"SvcHostSplitThresholdInKB"=dword:380000




; POWERSHELL
; disallow powershell scripts
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell]
"ExecutionPolicy"="Restricted"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell]
"ExecutionPolicy"="Restricted"
'@
	
Set-Content -Path "$env:TEMP\RegistryDefaults.reg" -Value $MultilineComment -Force	
# edit reg file	
$path = "$env:TEMP\RegistryDefaults.reg"	
(Get-Content $path) -replace "\?","$" | Out-File $path
	
# Default signout Lockscreen	
# delete image	
Remove-Item -Recurse -Force "C:\Windows\Black.jpg" -ErrorAction SilentlyContinue | Out-Null	
# revert image settings	
cmd /c "reg delete `"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP`" /f >nul 2>&1"
	
# Disable MSI Mode	
# get all gpu driver ids	
$gpuDevices = Get-PnpDevice -Class Display	
foreach ($gpu in $gpuDevices) {	
	$instanceID = $gpu.InstanceId	
	# disable msi mode for all gpus regedit	
	reg add "HKLM\SYSTEM\ControlSet001\Enum\$instanceID\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "0" /f | Out-Null	
}
	
# enable optimize drives	
schtasks /Change /ENABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
	
# set account password to expire    
# Get-LocalUser | ForEach-Object { Set-LocalUser -Name $_.Name -PasswordNeverExpires $false | Out-Null }
	
# import reg file	
Regedit.exe /S "$env:TEMP\Registry Defaults.reg"

Clear-Host
Write-Host "Restart to apply . . ."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }