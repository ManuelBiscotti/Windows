if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent(
    )).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
$Host.PrivateData.ProgressBackgroundColor = "Black"
$Host.PrivateData.ProgressForegroundColor = "White"

$MultilineComment = @"
Windows Registry Editor Version 5.00

; Remove Share context menu
; Created by: Shawn Brink
; Created on: October 6, 2021
; Updated on: May 3, 2024
; Tutorial: https://www.elevenforum.com/t/add-or-remove-share-context-menu-in-windows-11.1690/

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"="Share"

; Created by: Shawn Brink
; Created on: May 31, 2022
; Tutorial: https://www.elevenforum.com/t/add-or-remove-add-to-favorites-context-menu-in-windows-11.6795/


[-HKEY_CLASSES_ROOT\*\shell\pintohomefile]

; created by Walter Glenn
; for How-To Geek
; article: https://www.howtogeek.com/225844/how-to-make-windows-photo-viewer-your-default-image-viewer-on-windows-10/

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll]

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell]

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open]
"MuiVerb"="@photoviewer.dll,-3043"

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,
00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,
6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,
00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,
25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,
00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,
6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,
00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,
5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,
00,31,00,00,00

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\open\DropTarget]
"Clsid"="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print]

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,
00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,
6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,
00,50,00,72,00,6f,00,67,00,72,00,61,00,6d,00,46,00,69,00,6c,00,65,00,73,00,
25,00,5c,00,57,00,69,00,6e,00,64,00,6f,00,77,00,73,00,20,00,50,00,68,00,6f,
00,74,00,6f,00,20,00,56,00,69,00,65,00,77,00,65,00,72,00,5c,00,50,00,68,00,
6f,00,74,00,6f,00,56,00,69,00,65,00,77,00,65,00,72,00,2e,00,64,00,6c,00,6c,
00,22,00,2c,00,20,00,49,00,6d,00,61,00,67,00,65,00,56,00,69,00,65,00,77,00,
5f,00,46,00,75,00,6c,00,6c,00,73,00,63,00,72,00,65,00,65,00,6e,00,20,00,25,
00,31,00,00,00

[HKEY_CLASSES_ROOT\Applications\photoviewer.dll\shell\print\DropTarget]
"Clsid"="{60fd46de-f830-4894-a628-6fa81bc0190d}"

; Associate image file extensions with Photo Viewer
[HKEY_CURRENT_USER\Software\Classes\.jpg]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.jpeg]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.png]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.bmp]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.gif]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.tif]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.tiff]
@="PhotoViewer.FileAssoc.Tiff"
[HKEY_CURRENT_USER\Software\Classes\.ico]
@="PhotoViewer.FileAssoc.Tiff"



; MulesGaming
; Brave debullshitinator
; Removes unnecessary bloat from Brave Browser
[HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave]
"BraveRewardsDisabled"=dword:00000001
"BraveWalletDisabled"=dword:00000001
"BraveVPNDisabled"=dword:00000001
"BraveAIChatEnabled"=dword:00000000
"NewTabPageLocation"="https://search.brave.com"
"PasswordManagerEnabled"=dword:00000000
"TorDisabled"=dword:00000001
"DnsOverHttpsMode"="automatic"




; Made by Quaked
; TikTok: _Quaked_
; Discord: https://discord.gg/B8EmFVkdFU
; Code Snippet Credit: ChrisTitusTech, Privacy Is Freedom, Prolix, Amitxv, Majorgeeks, PRDGY Ace, Mathako.
; Code Inspiration: Khorvie, Calypto.
; Helper: Mathako.

; (Quaked) Auto Setting Windows Processes Priority
; Set CPU Priority for Key System Processes
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ApplicationFrameHost.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dllhost.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\fontdrvhost.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\services.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smss.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\StartMenu.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wininit.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\winlogon.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WmiPrvSE.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001

; -- Set I/O Priority for Key System Processes
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions]
"IoPriority"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions]
"IoPriority"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions]
"IoPriority"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions]
"IoPriority"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions]
"IoPriority"=dword:00000000

; Set Page Priority for Key System Process
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions]
"PagePriority"=dword:00000001

; Set Minimum Stack Commit for svchost.exe
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe]
"MinimumStackCommitInBytes"=dword:00008000

; Gaming Task Prioritization
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"Priority"=dword:00000006
"Scheduling Category"="High"

; Critical UI process - High I/O priority ensures smooth visuals
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions]
; "IoPriority"=dword:00000003


; Disabling Intel Gpu Bloat
; Disable driver-level post-processing (safe FPS boost)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
"Disable_OverlayDSQualityEnhancement"=dword:00000001

; Optimize DisplayPort signaling (reduces flicker/artifacts)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
"DisablePFonDP"=dword:00000001
"NoFastLinkTrainingForeDP"=dword:00000000

; Ensure DVI timing accuracy (prevents display blanking)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
"EnableCompensationForDVI"=dword:00000001

; Optimize Intel GPU memory allocation (Intel iGPU only)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
"IncreaseFixedSegment"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Intel\GMM]
"DedicatedSegmentSize"=dword:00000200

; Disable Adaptive VSync (set to 0)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
"AdaptiveVsyncEnable"=dword:00000000

; Optional: Only include if you know your driver uses these policy versions
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
; "ACPowerPolicyVersion"=dword:000041f2
; "DCPowerPolicyVersion"=dword:00004002


; Disable Away Mode
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"AwayModeEnabled"=dword:00000000


; Set CSRSS Priority to High Priority
; CpuPriorityClass: 3 = High, 4 = Realtime (better latency but can cause audio glitches)
; IoPriority: 3 = High

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003
"IoPriority"=dword:00000003


; GPU Tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\GraphicsDrivers]
"TdrLevel"=dword:00000000
"TdrDelay"=dword:00000000
"TdrDdiDelay"=dword:00000000
"TdrDebugMode"=dword:00000000
"TdrLimitTime"=dword:00000000
"TdrLimitCount"=dword:00000000
"DisableBadDriverCheckForHwProtection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"GPU Priority"=dword:00000008




; FOX OS


; Autoplay Tweaks
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\CameraAlternate\ShowPicturesOnArrival]
@="MSTakeNoAction"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\StorageOnArrival]
@="MSTakeNoAction"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\CameraAlternate\ShowPicturesOnArrival]
@="MSTakeNoAction"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\StorageOnArrival]
@="MSTakeNoAction"


; Disabling Remote Terminal Services Logons to the Server
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
"WinStationsDisabled"="1"


; Disabling Null Session (restrictanonymous)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"disabledomaincreds"=dword:00000001
"restrictanonymous"=dword:00000001


; Disabling Component Based Servicing Logs and DCOM
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing]
"EnableLog"=dword:00000000
"EnableDpxLog"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Component Based Servicing]
"EnableLog"=dword:00000000
"EnableDpxLog"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole]
"EnableDCOM"="N"

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Ole]
"EnableDCOM"="N"


; Disabling DMA Remapping
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy]
"value"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\pci\Parameters]
"DmaRemappingCompatible"=dword:00000000
"DmaRemappingOnHiberPath"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\storahci\Parameters]
"DmaRemappingCompatible"=dword:00000000
"DmaRemappingOnHiberPath"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\stornvme\Parameters]
"DmaRemappingCompatible"=dword:00000000
"DmaRemappingOnHiberPath"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\USBXHCI\Parameters]
"DmaRemappingCompatibleSelfhost"=dword:00000000
"DmaRemappingCompatible"=dword:00000000


; Delete Obsolete Autoruns Entries
[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Font Drivers]
"Adobe Type Manager"=-

[-HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Terminal Server\Wds\rdpwd]
"StartupPrograms"=-


; Driver Tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Beep]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\GpuEnergyDrv]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\npsvctrig]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\wanarp]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Wanarpv6]
"Start"=dword:00000004


; Disabling LogPages
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Windows\Win32knsWPP\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows\Win32knsWPP\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\USBHUB3\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\USBHUB3\Parameters\Wdf]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters]
"LogPages"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouhid\Parameters]
"LogPages"=dword:00000000


; Windows Hardening
; Disabling RPC usage from a remote asset interacting with scheduled tasks
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule]
"DisableRpcOverTcp"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"RestrictAnonymousSAM"=dword:00000001

; Disabling RPC usage from a remote asset interacting with services
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control]
"DisableRemoteScmEndpoints"=dword:00000001

; Prevent sharing of local drives via Remote Desktop Session Hosts
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services]
"fDisableCdm"=dword:00000001

; Disable solicited remote assistance
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services]
"fAllowToGetHelp"=dword:00000000

; Disable Terminal server
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server]
"TSEnabled"=dword:00000000


; Edge Telemetry
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]
[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker]
[-HKEY_LOCAL_MACHINE\System\ControlSet001\Services\edgeupdate]
[-HKEY_LOCAL_MACHINE\System\ControlSet001\Services\edgeupdatem]
[-HKEY_LOCAL_MACHINE\System\ControlSet001\Services\MicrosoftEdgeElevationService]

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Edge]
"DiagnosticData"=dword:00000000
"TrackingPrevention"=dword:00000003
"AddressBarMicrosoftSearchInBingProviderEnabled"=dword:00000000
"PersonalizationReportingEnabled"=dword:00000000
"PromotionalTabsEnabled"=dword:00000000
"SpotlightExperiencesAndRecommendationsEnabled"=dword:00000000
"WebWidgetAllowed"=dword:00000000
"HubsSidebarEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MicrosoftEdge\Main]
"AllowPrelaunch"=dword:00000000
"DoNotTrack"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MicrosoftEdge\BooksLibrary]
"EnableExtendedBooksTelemetry"=dword:00000000

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Edge]
"MetricsReportingEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000
"SpotlightExperiencesAndRecommendationsEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\BooksLibrary]
"EnableExtendedBooksTelemetry"=dword:00000000


; Disable Telemetry WINEVT
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Steps-Recorder]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Inventory]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Compatibility-Troubleshooter]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Kernel-EventTracing/Admin]
"Enabled"=dword:00000000


; Disable Get Even More Out of Windows
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager]
"EnthusiastMode"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People]
"PeopleBand"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Ndu]
"Start"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters]
"IRPStackSize"=dword:0000001e

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds]
"ShellFeedsTaskbarViewMode"=dword:00000002


; Disable Scheduled Diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics]
"EnabledExecution"=dword:00000000


; Process Explorer Settings
[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer]
"ShowDllView"=dword:00000000
"HandleSortColumn"=dword:00000000
"HandleSortDirection"=dword:00000001
"DllSortColumn"=dword:00000000
"DllSortDirection"=dword:00000001
"ProcessSortColumn"=dword:ffffffff
"ProcessSortDirection"=dword:00000001
"HighlightServices"=dword:00000001
"HighlightOwnProcesses"=dword:00000001
"HighlightRelocatedDlls"=dword:00000000
"HighlightJobs"=dword:00000000
"HighlightNewProc"=dword:00000001
"HighlightDelProc"=dword:00000001
"HighlightImmersive"=dword:00000001
"HighlightProtected"=dword:00000000
"HighlightPacked"=dword:00000001
"HighlightNetProcess"=dword:00000000
"HighlightSuspend"=dword:00000001
"HighlightDuration"=dword:000003e8
"ShowCpuFractions"=dword:00000001
"FindWindowplacement"=hex(3):2C,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,96,00,00,00,96,00,00,00,00,00,00,00,\
00,00,00,00
"ShowAllUsers"=dword:00000001
"ShowProcessTree"=dword:00000001
"SymbolWarningShown"=dword:00000000
"HideWhenMinimized"=dword:00000000
"AlwaysOntop"=dword:00000000
"OneInstance"=dword:00000000
"NumColumnSets"=dword:00000000
"Windowplacement"=hex(3):2C,00,00,00,02,00,00,00,03,00,00,00,00,00,00,00,00,\
00,00,00,FF,FF,FF,FF,FF,FF,FF,FF,37,02,00,00,8C,01,00,00,57,05,00,00,E4,03,\
00,00
"RefreshRate"=dword:000003e8
"PrcessColumnCount"=dword:0000000d
"DllColumnCount"=dword:00000004
"HandleColumnCount"=dword:00000002
"DefaultProcPropPage"=dword:00000000
"DefaultSysInfoPage"=dword:00000000
"DefaultDllPropPage"=dword:00000000
"ProcessImageColumnWidth"=dword:000000c8
"SymbolPath"=""
"ColorPacked"=dword:00ff0080
"ColorImmersive"=dword:00eaea00
"ColorOwn"=dword:00ffd0d0
"ColorServices"=dword:00d0d0ff
"ColorRelocatedDlls"=dword:00a0ffff
"ColorGraphBk"=dword:00f0f0f0
"ColorJobs"=dword:00006cd0
"ColorDelProc"=dword:004646ff
"ColorNewProc"=dword:0046ff46
"ColorNet"=dword:00a0ffff
"ColorProtected"=dword:008000ff
"ShowHeatmaps"=dword:00000001
"ColorSuspend"=dword:00808080
"StatusBarColumns"=dword:00002015
"ShowAllCpus"=dword:00000000
"ShowAllGpus"=dword:00000000
"Opacity"=dword:00000064
"GpuNodeUsageMask"=dword:00000001
"GpuNodeUsageMask1"=dword:00000000
"VerifySignatures"=dword:00000000
"VirusTotalCheck"=dword:00000000
"VirusTotalSubmitUnknown"=dword:00000000
"ToolbarBands"=hex(3):06,01,00,00,00,00,00,00,00,00,00,00,4B,00,00,00,01,00,\
00,00,00,00,00,00,4B,00,00,00,02,00,00,00,00,00,00,00,4B,00,00,00,03,00,00,\
00,00,00,00,00,4B,00,00,00,04,00,00,00,00,00,00,00,4B,00,00,00,05,00,00,00,\
00,00,00,00,4B,00,00,00,06,00,00,00,00,00,00,00,4B,00,00,00,07,00,00,00,00,\
00,00,00,00,00,00,00,08,00,00,00,00,00,00,00
"UseGoogle"=dword:00000000
"ShowNewProcesses"=dword:00000000
"TrayCPUHistory"=dword:00000000
"ShowIoTray"=dword:00000000
"ShowNetTray"=dword:00000000
"ShowDiskTray"=dword:00000000
"ShowPhysTray"=dword:00000000
"ShowCommitTray"=dword:00000000
"ShowGpuTray"=dword:00000000
"FormatIoBytes"=dword:00000001
"StackWindowPlacement"=hex(3):00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00
"ETWstandardUserWarning"=dword:00000000
"ShowUnnamedHandles"=dword:00000000
"SavedDivider"=hex(3):00,00,00,00,00,00,E0,3F
"UnicodeFont"=hex(3):08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,90,01,\
00,00,00,00,00,00,00,00,00,00,4D,00,53,00,20,00,53,00,68,00,65,00,6C,00,6C,\
00,20,00,44,00,6C,00,67,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
"Divider"=hex(3):00,00,00,00,00,00,F0,3F
"DllPropWindowplacement"=hex(3):2C,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,28,00,00,00,28,00,00,00,00,00,00,\
00,00,00,00,00
"PropWindowplacement"=hex(3):2C,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,28,00,00,00,28,00,00,00,00,00,00,00,\
00,00,00,00
"DbgHelpPath"="C:\\Windows\\SYSTEM32\\dbghelp.dll"
"SysinfoWindowplacement"=hex(3):2C,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,28,00,00,00,28,00,00,00,00,00,00,\
00,00,00,00,00
"ConfirmKill"=dword:00000001
"ShowLowerpane"=dword:00000000

[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer\DllColumnMap]
"3"=dword:00000457
"2"=dword:00000409
"0"=dword:0000001a
"1"=dword:0000002a

[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer\DllColumns]
"2"=dword:0000008c
"0"=dword:0000006e
"1"=dword:000000b4
"3"=dword:0000012c

[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer\HandleColumnMap]
"1"=dword:00000016
"0"=dword:00000015

[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer\HandleColumns]
"0"=dword:00000064
"1"=dword:000001c2

[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer\ProcessColumnMap]
"10"=dword:0000049b
"8"=dword:00000005
"12"=dword:00000409
"13"=dword:00000672
"7"=dword:00000004
"5"=dword:00000427
"11"=dword:00000026
"9"=dword:0000053c
"0"=dword:00000003
"1"=dword:0000041f
"2"=dword:00000672
"6"=dword:00000429
"3"=dword:000004b0
"4"=dword:00000424

[HKEY_CURRENT_USER\Software\Sysinternals\Process Explorer\ProcessColumns]
"9"=dword:0000002a
"10"=dword:00000035
"11"=dword:00000096
"12"=dword:0000008c
"8"=dword:0000002b
"7"=dword:00000028
"5"=dword:00000050
"4"=dword:00000050
"3"=dword:00000056
"2"=dword:00000022
"1"=dword:00000028
"6"=dword:00000022
"0"=dword:000000c8




; Created by: Shawn Brink
; Created on: September 28th 2015
; Updated on: August 28th 2019
; Tutorial: https://www.tenforums.com/tutorials/24412-add-remove-default-new-context-menu-items-windows-10-a.html


; ; Text Document
; [-HKEY_CLASSES_ROOT\.txt\ShellNew]
; [HKEY_CLASSES_ROOT\.txt\ShellNew]
; "ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
;   6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
;   00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\
;   2d,00,34,00,37,00,30,00,00,00
; "NullFile"=""

; [-HKEY_CLASSES_ROOT\.txt]

; [HKEY_CLASSES_ROOT\.txt]
; @="txtfile"
; "Content Type"="text/plain"
; "PerceivedType"="text"

; [HKEY_CLASSES_ROOT\.txt\PersistentHandler]
; @="{5e941d80-bf96-11cd-b579-08002b30bfeb}"

; [HKEY_CLASSES_ROOT\.txt\ShellNew]
; "ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
;   6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
;   00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\
;   2d,00,34,00,37,00,30,00,00,00
; "NullFile"=""

; [-HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]

; [HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]
; "PerceivedType"="document"

; [-HKEY_CLASSES_ROOT\txtfile]

; [HKEY_CLASSES_ROOT\txtfile]
; @="Text Document"
; "EditFlags"=dword:00210000
; "FriendlyTypeName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,\
;   00,6f,00,6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,\
;   32,00,5c,00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,\
;   00,2c,00,2d,00,34,00,36,00,39,00,00,00

; [HKEY_CLASSES_ROOT\txtfile\DefaultIcon]
; @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
;   00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,69,00,6d,00,\
;   61,00,67,00,65,00,72,00,65,00,73,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,31,\
;   00,30,00,32,00,00,00

; [HKEY_CLASSES_ROOT\txtfile\shell\open\command]
; @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
;   00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,4e,00,4f,00,\
;   54,00,45,00,50,00,41,00,44,00,2e,00,45,00,58,00,45,00,20,00,25,00,31,00,00,\
;   00

; [HKEY_CLASSES_ROOT\txtfile\shell\print\command]
; @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
;   00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,4e,00,4f,00,\
;   54,00,45,00,50,00,41,00,44,00,2e,00,45,00,58,00,45,00,20,00,2f,00,70,00,20,\
;   00,25,00,31,00,00,00

; [HKEY_CLASSES_ROOT\txtfile\shell\printto\command]
; @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
;   00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,6e,00,6f,00,\
;   74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,20,00,2f,00,70,00,74,\
;   00,20,00,22,00,25,00,31,00,22,00,20,00,22,00,25,00,32,00,22,00,20,00,22,00,\
;   25,00,33,00,22,00,20,00,22,00,25,00,34,00,22,00,00,00

; [-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt]

; [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithList]

; [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithProgids]
; "txtfile"=hex(0):

; [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\UserChoice]
; "Hash"="hyXk/CpboWw="
; "ProgId"="txtfile"

; [-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt]

; [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt\UserChoice]
; "Hash"="FvJcqeZpmOE="
; "ProgId"="txtfile"




; Khorvie Tech

; timeout
[HKEY_CURRENT_USER\Control Panel\Desktop]
"AutoEndTasks"="1"
"HungAppTimeout"="1000"
"WaitToKillAppTimeout"="1000"
"LowLevelHooksTimeout"="1000"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control]
"WaitToKillServiceTimeout"="1000"


; tcpip tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"TcpTimedWaitDelay"=dword:0000001e
"Tcp1323Opts"=dword:00000000
"TcpMaxConnectRetransmissions"=dword:00000001
"DelayedAckFrequency"=dword:00000001
"DelayedAckTicks"=dword:00000001
"MultihopSets"=dword:0000000f

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters]
"IRPStackSize"=dword:00000032
"SizReqBuf"=dword:00004410

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\QoS]
"Do not use NLA"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"NegativeCacheTime"=dword:00000000
"NegativeSOACacheTime"=dword:00000000
"NetFailureCacheTime"=dword:00000000
"EnableAutoDoh"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"NonBlockingSendSpecialBuffering"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters]
"TCPNoDelay"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
"NetworkThrottlingIndex"=dword:ffffffff

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched]
"NonBestEffortLimit"=dword:00000000


; DWM Schedule MASTER VALUES
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM\Schedule]
"WindowedGsyncGeforceFlag"=dword:00000000
"FrameRateMin"=dword:ffffffff
"IgnoreDisplayChangeDuration"=dword:00000000
"LingerInterval"=dword:00000000
"LicenseInterval"=dword:00000000
"RestrictedNvcplUIMode"=dword:00000000
"DisableSpecificPopups"=dword:00000001
"DisableExpirationPopups"=dword:00000001
"EnableForceIgpuDgpuFromUI"=dword:00000001
"HideXGpuTrayIcon"=dword:00000001
"ShowTrayIcon"=dword:00000000
"HideBalloonNotification"=dword:00000001
"PerformanceState"=dword:00000000
"Gc6State"=dword:00000000
"FrameDisplayBaseNegOffsetNS"=dword:ffe17b80
"FrameDisplayResDivValue"=dword:00000001
"IgnoreNodeLocked"=dword:00000001
"IgnoreSP"=dword:00000001
"DontAskAgain"=dword:00000001


; Kernel New Kizzimo
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"KiClockTimerPerCpu"=dword:00000001
"KiClockTimerHighLatency"=dword:00000000
"KiClockTimerAlwaysOnPresent"=dword:00000001
"ClockTimerPerCpu"=dword:00000001
"ClockTimerHighLatency"=dword:00000000
"ClockTimerAlwaysOnPresent"=dword:00000001


; smooth scrolling
[HKEY_CURRENT_USER\Control Panel\Desktop]
"SmoothScroll"=dword:00000000

; fast user switching
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"HideFastUserSwitching"=dword:00000001

; dont tolerate high dpcisr
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"ExitLatency"=dword:00000001
"ExitLatencyCheckEnabled"=dword:00000001
"Latency"=dword:00000001
"LatencyToleranceDefault"=dword:00000001
"LatencyToleranceFSVP"=dword:00000001
"LatencyTolerancePerfOverride"=dword:00000001
"LatencyToleranceScreenOffIR"=dword:00000001
"LatencyToleranceVSyncEnabled"=dword:00000001
"RtlCapabilityCheckLatency"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power]
"DefaultD3TransitionLatencyActivelyUsed"=dword:00000001
"DefaultD3TransitionLatencyIdleLongTime"=dword:00000001
"DefaultD3TransitionLatencyIdleMonitorOff"=dword:00000001
"DefaultD3TransitionLatencyIdleNoContext"=dword:00000001
"DefaultD3TransitionLatencyIdleShortTime"=dword:00000001
"DefaultD3TransitionLatencyIdleVeryLongTime"=dword:00000001
"DefaultLatencyToleranceIdle0"=dword:00000001
"DefaultLatencyToleranceIdle0MonitorOff"=dword:00000001
"DefaultLatencyToleranceIdle1"=dword:00000001
"DefaultLatencyToleranceIdle1MonitorOff"=dword:00000001
"DefaultLatencyToleranceMemory"=dword:00000001
"DefaultLatencyToleranceNoContext"=dword:00000001
"DefaultLatencyToleranceNoContextMonitorOff"=dword:00000001
"DefaultLatencyToleranceOther"=dword:00000001
"DefaultLatencyToleranceTimerPeriod"=dword:00000001
"DefaultMemoryRefreshLatencyToleranceActivelyUsed"=dword:00000001
"DefaultMemoryRefreshLatencyToleranceMonitorOff"=dword:00000001
"DefaultMemoryRefreshLatencyToleranceNoContext"=dword:00000001
"Latency"=dword:00000001
"MaxIAverageGraphicsLatencyInOneBucket"=dword:00000001
"MiracastPerfTrackGraphicsLatency"=dword:00000001
"MonitorLatencyTolerance"=dword:00000001
"MonitorRefreshLatencyTolerance"=dword:00000001
"TransitionLatency"=dword:00000001


; power related
; CPU
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
"ValueMax"=dword:00000000
"ValueMin"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EnergyEstimationEnabled"=dword:00000000
"EnergySaverPolicy"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"CsEnabled"=dword:00000000

[HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100]
"Attributes"=dword:00000002
"Affinity"=dword:00000000
"Background Only"="False"
"Clock Rate"=dword:00010000
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="High"
"SFIO Priority"="High"
"BackgroundPriority"=dword:00000000
"Latency Sensitive"="True"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"CoalescingTimerInterval"=dword:00000000

; Display
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\ModernSleep]
"AdaptiveRefreshRate"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"VideoIdleTimeout"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"PowerSavingModeEnabled"=dword:00000000
"PanelSelfRefresh"=dword:00000000
"ForceOffScreenTimeout"=dword:00000000

; GPU
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler]
"EnableFrameBufferCompression"=dword:00000000
"EnableGpuBoost"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv]
"Start"=dword:00000004

; Network
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001]
"PnPCapabilities"=dword:00000024

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002]
"PnPCapabilities"=dword:00000024

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"DisablePowerManagement"=dword:00000001

; System
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EnergySaverStatus"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"DynamicThrottlePolicy"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling]
"PowerThrottlingOff"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"HibernateEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EcoMode"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel]
"GlobalTimerResolutionRequests"=dword:00000001

; USB Regs
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USB\Parameters]
"DisableSelectiveSuspend"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HidUsb\Parameters]
"SelectiveSuspendEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters]
"EnhancedPowerManagementEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters]
"DisableLegacyUSBSupport"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbaudio\Parameters]
"PowerSettings"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HidUsb\Parameters]
"DeviceIdleEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters]
"SelectiveSuspendEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HidUsb\Parameters]
"DisableWakeFromSuspend"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USB\Parameters]
"ForceHCResetOnResume"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USB]
"DisableSelectiveSuspend"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters]
"DisableSelectiveSuspend"=dword:00000001


; Network
; afd tweaks
; ignoreOrderlynPushBit
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"IgnoreOrderlyRelease"=dword:00000001
"IgnorePushBitOnReceives"=dword:00000001

; Fast Send Copy
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"FastSendDatagramThreshold"=dword:00000400
"FastCopyReceiveThreshold"=dword:00000400

; DynamicSendBufferDisable
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DynamicSendBufferDisable"=dword:00000001

; DoNotHoldNICBuffers
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DoNotHoldNICBuffers"=dword:00000001

; DisableDirectAcceptEx
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DisableDirectAcceptEx"=dword:00000001

; DisableChainedReceive
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DisableChainedReceive"=dword:00000001

; DisableAddressSharing
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DisableAddressSharing"=dword:00000001

; DefaultSendReceive
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DefaultReceiveWindow"=dword:00100000
"DefaultSendWindow"=dword:00100000

; DefaultSendReceive2
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"DefaultReceiveWindow"=dword:00040000
"DefaultSendWindow"=dword:00040000

; BufferAlignment
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
"BufferAlignment"=dword:00000001


; pwrSaving
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002]
"EnableDynamicPowerGating"=dword:00000000
"EnableSavePowerNow"=dword:00000000
"NicAutoPowerSaver"=dword:00000000


[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"Latency Sensitive"="True"

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\NDIS\Parameters]
"EnableNicAutoPowerSaverInSleepStudy"=dword:00000000


;Security
; disable allow pc to be discoverable
[HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Network]
"NewNetworkWindowOff"=dword:00000001

; disableRDP
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server]
"fDenyTSConnections"=dword:00000001

; protocol methods
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0]
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0]
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0]
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1]
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server]
"DisabledByDefault"=dword:00000001
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]
"DisabledByDefault"=dword:00000000
"Enabled"=dword:00000001
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server]
"DisabledByDefault"=dword:00000000
"Enabled"=dword:00000001

; RestrictNTLM
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"LmCompatibilityLevel"=dword:00000005

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0]
"RestrictSendingNTLMTraffic"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters]
"EnableLMHash"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient]
"DisableMultihomeDNSRegistration"=dword:00000001
"DisableParallelNameResolution"=dword:00000001
"DisableSmartNameResolution"=dword:00000001
"EnableMulticast"=dword:00000000

; security
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"DisableParallelAandAAAA"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters]
"SMB1"=dword:00000000

[HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NetBT\Parameters\Interfaces]
"NetBIOSOptions"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters]
"EnableLMHOSTS"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"EnableICMPRedirect"=dword:00000000


; Regtweaks
; svcsplit
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control]
"SvcHostSplitThresholdInKB"=dword:2000000

; serialize timer
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"SerializeTimerExpiration"=dword:00000001

; mouclass
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters]
"MouseDataQueueSize"=dword:0000001e

; kbdclass
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters]
"KeyboardDataQueueSize"=dword:0000001e

; HoverTime
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseHoverTime"="10"

; edge preload
[HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader]
"AllowTabPreloading"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader]
"AllowTabPreloading"=dword:00000000

; disableStartupDelay
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize]
"StartupDelayInMSec"=dword:00000000

; disableAutoRun
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoDriveTypeAutoRun"=dword:000000FF

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoDriveTypeAutoRun"=dword:000000FF

; group policy tweaks
; winSearch
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCloudSearch"=dword:00000000
"AllowSearchToUseLocation"=dword:00000000
"ConnectedSearchUseWeb"=dword:00000000
"DisableWebSearch"=dword:00000001
"EnableDynamicContentInWSB"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion]
"DisableContentFileUpdates"=dword:00000001

; WcmSvc
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\Local]
"WCMPresent"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy]
"fDisablePowerManagement"=dword:00000001

; telephony telemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Telephony]
"KmddspDebugLevel"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\FeatureFlags]
"BlockUxDisabled"=dword:00000000
"TelemetryCallsEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\SQM]
"DisableCustomerImprovementProgram"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client]
"CEIP"=dword:00000002

; speechmodel
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Speech]
"AllowSpeechModelUpdate"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SpeechGestures]
"RDCPolicyCollectionLevel"=dword:00000000

; privacy
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000000

; passreveal
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI]
"DisablePasswordReveal"=dword:00000001

; p2p
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Peernet]
"Disabled"=dword:00000000

; ntusb
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client]
"fEnableUsbBlockDeviceBySetupClass"
"fEnableUsbNoAckIsochWriteToDevice"
"fEnableUsbSelectDeviceByInterface"

; newsinterests
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft]
"AllowNewsAndInterests"=dword:00000000

; ms edge
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]
"StartupBoostEnabled"=dword:00000000
"AutofillAddressEnabled"=dword:00000000
"AutofillCreditCardEnabled"=dword:00000000
"HubsSidebarEnabled"=dword:00000000
"LocalProvidersEnabled"=dword:00000000
"PaymentMethodQueryEnabled"=dword:00000000
"SearchSuggestEnabled"=dword:00000000

; locationAndSensor
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
; "DisableLocationScripting"=dword:00000001
; "DisableWindowsLocationProvider"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\System]
; "AllowExperimentation"=dword:00000000
; "AllowLocation"=dword:00000000

; inputpersonalization
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization]
"AllowInputPersonalization"=dword:00000000
"RestrictImplicitInkCollection"=dword:00000001
"RestrictImplicitTextCollection"=dword:00000001

[HKEY_CURRENT_USER\Software\Policies\Microsoft\InputPersonalization]
"AllowInputPersonalization"=dword:00000000
"RestrictImplicitInkCollection"=dword:00000001
"RestrictImplicitTextCollection"=dword:00000001

; handwriteDataShare
; HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC
; "PreventHandwritingDataSharing"=dword:00000000

; gamedvr
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR]
"AllowGameDVR"="0"

; explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoLowDiskSpaceChecks"=dword:00000001
"NoResolveSearch"=dword:00000001
"NoResolveTrack"=dword:00000001
"TurnOffSPIAnimations"=dword:00000001

; errorreport
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001
"DontSendAdditionalData"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

; diagprovider
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy]
"DisableQueryRemoteServer"=dword:00000000

; datacollection
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"AllowDeviceNameInTelemetry"=dword:00000000
"AllowTelemetry"=dword:00000000
"DisableOneSettingsDownloads"=dword:00000001
"DoNotShowFeedbackNotifications"=dword:00000001
"LimitDiagnosticLogCollection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection]
"AllowTelemetry"=dword:00000000
"MaxTelemetryAllowed"=dword:00000001

; CloudContent
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsConsumerFeatures"=dword:00000001

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent]
"ConfigureWindowsSpotlight"=dword:00000002
"DisableWindowsSpotlightFeatures"=dword:00000001
"DisableWindowsSpotlightOnActionCenter"=dword:00000001
"DisableWindowsSpotlightOnSettings"=dword:00000001
"DisableWindowsSpotlightWindowsWelcomeExperience"=dword:00000001
"IncludeEnterpriseSpotlight"=dword:00000000

[HKEY_CURRENT_USER\Policies\Microsoft\Windows\CloudContent]
"DisableTailoredExperiencesWithDiagnosticData"=dword:00000001

; appCompat
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=dword:00000000
"DisableInventory"=dword:00000001
"DisableUAR"=dword:00000001

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\AppCompat]
"DisablePCA"=dword:00000001

; data sharing
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowSharedUserAppData]
"value"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup\SendTelemetryData]
@="0"

; other background
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
"BackgroundAppGlobalToggle"=dword:00000000

; OneDriveSync
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\OneSyncSvc]
"Start"=dword:00000004




; Project ATOM

; Disable UAC

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableLUA"=dword:00000000
"ConsentPromptBehaviorAdmin"=dword:00000000
"ConsentPromptBehaviorUser"=dword:00000000
"FilterAdministratorToken"=dword:00000001
"LocalAccountTokenFilterPolicy"=dword:00000001
"ConsentPromptBehaviorUser"=dword:00000003
"EnableUIADesktopToggle"=dword:00000000
"ValidateAdminCodeSignatures"=dword:00000000
"EnableInstallerDetection"=dword:00000000
"EnableSecureUIAPaths"=dword:00000000
"DelayedDesktopSwitchTimemout"=dword:00000000
"PromptOnSecureDesktop"=dword:00000000
"LocalAccountTokenFilterPolicy"=dword:00000001

; Fix mouse cursor dissapeiring

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableCursorSuppression"=dword:00000000

; GPU Tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"RmGpsPsEnablePerCpuCoreDpc"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power]
"RmGpsPsEnablePerCpuCoreDpc"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm]
"RmGpsPsEnablePerCpuCoreDpc"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI]
"RmGpsPsEnablePerCpuCoreDpc"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak]
"RmGpsPsEnablePerCpuCoreDpc"=dword:00000001

; Fix Monitor Latency
[HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl]
"MonitorLatencyTolerance"=dword:00000000

[HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl]
"MonitorRefreshLatencyTolerance"=dword:00000000

; Hide duplicate removable drives from navigation pane of file Explorer
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}]

; PortThreadPriority
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print]
"PortThreadPriority"=dword:00000001

; SvCPriority
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions]
"CpuPriorityClass"=dword:00000001
"IoPriority"=dword:00000000

; Delete Task Scheduler Brave
[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Logon\{781AE031-F26B-47E5-9257-00B9378E2439}]

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{5B7D273A-5382-4BC9-9F25-49D34A368FAA}]

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{5B7D273A-5382-4BC9-9F25-49D34A368FAA}]

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{781AE031-F26B-47E5-9257-00B9378E2439}]

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\BraveSoftwareUpdateTaskMachineCore]

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\BraveSoftwareUpdateTaskMachineUA]

; Chrome Tweaks
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome]
"DeviceMetricsReportingEnabled"=dword:00000000
"MetricsReportingEnabled"=dword:00000000
"ChromeCleanupReportingEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000
"WebRtcEventLogCollectionAllowed"=dword:00000000
"NetworkPredictionOptions"=dword:00000002 ; Disable DNS prefetching
"ChromeCleanupEnabled"=dword:00000000
; ""=dword:00000000
; ""=dword:00000000

; Disable Firefox Telemetry
[HKEY_LOCAL_MACHINE\Software\Policies\Mozilla\Firefox]
"DisableTelemetry"=dword:00000001
"DisableDefaultBrowserAgent"=dword:00000001




; CTT

; ESSENTIAL TWEAKS

; Disable Consumer Features
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableConsumerFeatures"=dword:00000001
"DisableWindowsConsumerFeatures"=dword:00000000
"DisableConsumerAccountStateContent"=dword:00000001

; Disable Activity History
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000000
"PublishUserActivities"=dword:00000000
"UploadUserActivities"=dword:00000000

; Disable GameDVR
[HKEY_CURRENT_USER\System\GameConfigStore]
"GameDVR_Enabled"=dword:00000000

; Disable Hibernation
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"HibernateEnabled"=dword:00000000
"HibernateEnabledDefault"=dword:00000000

; Disable Homegroup
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001
"DisableWindowsConsumerFeatures"=dword:00000001

; Disable Location Tracking
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
; "DisableLocation"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location]
; "Value"="Deny"

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}]
; "SensorPermissionState"=dword:00000000

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration]
; "Status"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\Maps]
"AutoUpdateEnabled"=dword:00000000

; Disable Storage Sense
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\StorageSense]
"AllowStorageSenseGlobal"=dword:00000000

; Disable Wifi-Sense
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

; Enable End Task in Taskbar right-click menu
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings]
"TaskbarEndTask"=dword:00000001

; Disable Recall
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI]
"DisableAIDataAnalysis"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsAI]
"DisableAIDataAnalysis"=dword:00000001
"AllowRecallEnablement"=dword:00000000

; Debloat Edge
[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge]
"CreateDesktopShortcutDefault"=dword:00000000
"EdgeEnhanceImagesEnabled"=dword:00000000
"PersonalizationReportingEnabled"=dword:00000000
"ShowRecommendationsEnabled"=dword:00000000
"HideFirstRunExperience"=dword:00000001
"UserFeedbackAllowed"=dword:00000000
"ConfigureDoNotTrack"=dword:00000001
"AlternateErrorPagesEnabled"=dword:00000000
"EdgeCollectionsEnabled"=dword:00000000
"EdgeFollowEnabled"=dword:00000000
"EdgeShoppingAssistantEnabled"=dword:00000000
"MicrosoftEdgeInsiderPromotionEnabled"=dword:00000000
"ShowMicrosoftRewards"=dword:00000000
"WebWidgetAllowed"=dword:00000000
"DiagnosticData"=dword:00000000
"EdgeAssetDeliveryServiceEnabled"=dword:00000000
"CryptoWalletEnabled"=dword:00000000
"WalletDonationEnabled"=dword:00000000


; ADVANCED TWEAKS

; Disable IPv6
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters]
"DisabledComponents"=dword:ffffffff

; Prefer IPv4 over IPv6
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

; Disable Teredo
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters]
"DisabledComponents"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"EnablePMTUDiscovery"=dword:00000001
"EnablePMTUBHDetect"=dword:00000000
"Tcp1323Opts"=dword:00000001
"DefaultTTL"=dword:00000040

; Disable Background Apps
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications]
"GlobalUserDisabled"=dword:00000001

; Disable Fullscreen Optimizations (FSO) & Configure Fullscreen Exclusive (FSE)
[HKEY_CURRENT_USER\System\GameConfigStore]
"GameDVR_DSEBehavior"=dword:00000002
"GameDVR_DXGIHonorFSEWindowsCompatible"=dword:00000001
"GameDVR_EFSEFeatureFlags"=dword:00000000
"GameDVR_FSEBehavior"=dword:00000002
"GameDVR_FSEBehaviorMode"=dword:00000002
"GameDVR_HonorUserFSEBehaviorMode"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
"__COMPAT_LAYER"="~ DISABLEDXMAXIMIZEDWINDOWEDMODE"

; Disable Microsoft Copilot
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

; Disable Notification Tray/Calendar

; Set Classic Right-Click Menu
[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; Remove Home and Gallery from explorer
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"HubMode"=dword:00000001

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_36354489\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}]

[HKEY_CURRENT_USER\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}]
"System.IsPinnedToNameSpaceTree"=dword:00000000


; CUSTOMIZE PREFERENCES

; Dark Theme for Windows
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

; Set selection rectangle colors to black
; [HKEY_CURRENT_USER\Control Panel\Colors]
; "Hilight"="0 0 0"
; "HotTrackingColor"="0 0 0"


; Bing Search in Start Menu 
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=dword:00000001

; Enable NumLock on Startup
[HKEY_USERS\.DEFAULT\Control Panel\Keyboard]
"InitialKeyboardIndicators"=dword:80000002


; Disable Verbose Messages During Logon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"VerboseStatus"=dword:00000000

; Disable Recommendations in Start Menu
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"HideRecommendedSection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Start]
"HideRecommendedSection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Education]
"IsEducationEnvironment"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_Layout"=dword:00000001

; Disable Snap Window 
; Disable Snap Assist Flyout
; Disable Snap Assist Suggestion
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SnapAssist"=dword:00000000
"DITest"=dword:00000000
"EnableSnapBar"=dword:00000000
"EnableTaskGroups"=dword:00000000
"EnableSnapAssistFlyout"=dword:00000000
"SnapFill"=dword:00000000
"JointResize"=dword:00000000

; Disable Mouse Acceleration
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

; Disable Sticky Keys
[HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]
"Flags"="506"

; Show Hidden Files
; Show File Extensions
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"HideFileExt"=dword:00000000
"Hidden"=dword:00000001

; Disable Search Button in Taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
"SearchboxTaskbarMode"=dword:00000000

; Disable Center Taskbar Items
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarAl"=dword:00000000

; Disable Widgets Button in Taskbar
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests]
"value"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh]
"AllowNewsAndInterests"=dword:00000000




; AUTHOR
; Memory
; https://github.com/memstechtips
; https://memstechtips.com
; https://youtube.com/@memstechtips

; --Application and Feature Restrictions--

; Prevents Dev Home Installation
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate]

; Prevents New Outlook for Windows Installation
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate]

; Prevents Chat Auto Installation
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications]
"ConfigureChatAutoInstall"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Chat]
"ChatIcon"=dword:00000003

; Disables OneDrive Automatic Backups of Important Folders (Documents, Pictures etc.)
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\OneDrive]
"KFMBlockOptIn"=dword:00000001

; Disable Tablet Mode
; Always go to desktop mode on sign-in
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell]
"TabletMode"=dword:00000000
"SignInMode"=dword:00000001

; Disables the "Push To Install" feature in Windows
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall]
"DisablePushToInstall"=dword:00000001

; --Windows Update Settings--

; Disable Automatic Updates (Only Check for Updates Manually)
; Notify Before Downloading and Installing Updates
; Enable Notifications for Security Updates Only (Do Not Auto-Download)
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
"NoAutoUpdate"=dword:00000001
"AUOptions"=dword:00000002
"AutoInstallMinorUpdates"=dword:00000000

; Prevent Automatic Upgrade from Windows 10 22H2 to Windows 11 (Manual Upgrade Still Allowed)
; Delay Feature and Quality updates for 1 year from install.
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"TargetReleaseVersion"=dword:00000001
"TargetReleaseVersionInfo"="22H2"
"ProductVersion"="Windows 10"
"DeferFeatureUpdates"=dword:00000001
"DeferFeatureUpdatesPeriodInDays"=dword:0000016d
"DeferQualityUpdates"=dword:00000001
"DeferQualityUpdatesPeriodInDays"=dword:00000007

; Disables allowing downloads from other PCs (Delivery Optimization)
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization]
"DODownloadMode"=dword:00000000

; --Application and Feature Restrictions--

; Disable Windows Copilot system-wide
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

; Prevents Dev Home Installation
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate]

; Prevents New Outlook for Windows Installation
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate]

; Prevents Chat Auto Installation and Removes Chat Icon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications]
"ConfigureChatAutoInstall"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Chat]
"ChatIcon"=dword:00000003

; Disables Bitlocker Auto Encryption on Windows 11 24H2 and Onwards
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BitLocker]
"PreventDeviceEncryption"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices]
"TCGSecurityActivationDisabled"=dword:00000001

; Blocks the "Allow my organization to manage my device" and "No, sign in to this app only" pop-up message
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin]
"BlockAADWorkplaceJoin"=dword:00000001

; --Start Menu Customization--
; Removes All Pinned Apps from the Start Menu to Clean it Up
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Start]
"ConfigureStartPins"="{ \"pinnedList\": [] }"
"ConfigureStartPins_ProviderSet"=dword:00000001
"ConfigureStartPins_WinningProvider"="B5292708-1619-419B-9923-E5D9F3925E71"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start]
"ConfigureStartPins"="{ \"pinnedList\": [] }"
"ConfigureStartPins_LastWrite"=dword:00000001

; --Privacy and Security Settings--
; Disables the Advertising ID for All Users
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000001




; MajorGeeks.Com

; Add or Remove 'Open in Windows Terminal' in Windows 11
; https://www.majorgeeks.com/content/page/open_in_windows_terminal.html

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=""

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=""

;Show Copy as Path always in the right-click menu, without pressing SHIFT
;Ramesh Srinivasan, Winhelponline.com

; [HKEY_CLASSES_ROOT\Allfilesystemobjects\shell\windows.copyaspath]
; @="Copy &as path"
; "Icon"="imageres.dll,-5302"
; "InvokeCommandOnSelection"=dword:00000001
; "VerbHandler"="{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}"
; "VerbName"="copyaspath"

; How to Turn Core Isolation Memory Integrity On or Off in Windows 10
; https://www.majorgeeks.com/content/page/how_to_turn_core_isolation_memory_integrity_on_or_off_in_windows_10.html

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity]
"Enabled"=dword:00000000

; How to Enable or Disable Win32 Long Paths in Windows 10
; https://www.majorgeeks.com/content/page/enable_disable_win32_long_paths.html

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001

; https://www.majorgeeks.com/content/page/how_to_add_or_remove_maximum_processor_frequency.html

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100]
"Attributes"=dword:00000002

; How to Enable or Disable File History in Windows 10
; Tutorial: https://www.majorgeeks.com/content/page/enable_disable_file_history.html

; How to Add Boot to UEFI Firmware Settings Desktop Context Menu
; https://www.majorgeeks.com/content/page/boot_to_uefi_firmware_settings.html

; [HKEY_CLASSES_ROOT\DesktopBackground\Shell\Firmware]
; "Icon"="bootux.dll,-1016"
; "MUIVerb"="BIOS Settings"
; "Position"="Middle"

; [HKEY_CLASSES_ROOT\DesktopBackground\Shell\Firmware\command]
; @="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/s,/c,shutdown /r /fw' -Verb runAs\""




; Atlas

; Remove Security Tray from Startup
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
"SecurityHealth"=-

; Disable Drivers from Windows Update
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
"SearchOrderConfig"=dword:00000000
"DontSearchWindowsUpdate"=dword:00000001

; Disable in Content Delivery Manager
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"ContentDeliveryAllowed"=dword:00000000
"FeatureManagementEnabled"=dword:00000000
"SubscribedContentEnabled"=dword:00000000
"SubscribedContent-338387Enabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000

; Spotlight info on the desktop
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]
"{2cc5ca98-6485-489a-920e-b3e88a6ccce3}"=dword:00000001

; Visual Effects

[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"UserPreferencesMask"=hex:90,12,03,80,10,00,00,00
"DragFullWindows"="1"

[HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
"MinAnimate"="0"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ListviewAlphaSelect"=dword:00000001
"IconsOnly"=dword:00000000
"TaskbarAnimations"=dword:00000000
"ListviewShadow"=dword:00000001

; set appearance options to custom
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects]
"VisualFXSetting"=dword:00000003

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
"EnableAeroPeek"=dword:00000000
"AlwaysHibernateThumbnails"=dword:00000000




; Winaero Tweaker

; Disable Automatic Folder Type Discovery
[-HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags]

[HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell]
"FolderType"="NotSpecified"


; Disable Blur on Sign-in Screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableAcrylicBackgroundOnLogon"=dword:00000001


; Change CHKDSK Timeout to 5 Seconds
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager]
"AutoChkTimeout"=dword:00000005


; Disable Blur on Sign-In Screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableAcrylicBackground"=dword:00000001


; Add Run with priority context menu
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority]
"MUIVerb"="Run with priority"
"SubCommands"=""
; "Icon"="shell32.dll,-25" 

; Low
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\01Low]
@="Low"

[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\01Low\command]
@="cmd.exe /c start \"\" /Low \"%1\""

; Below normal
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\03BelowNormal]
@="Below normal"

[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\03BelowNormal\command]
@="cmd.exe /c start \"\" /BelowNormal \"%1\""


; Normal
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\04Normal]
@="Normal"

[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\04Normal\command]
@="cmd.exe /c start \"\" /Normal \"%1\""


; Above Normal
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\05AboveNormal]
@="Above normal"

[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\05AboveNormal\command]
@="cmd.exe /c start \"\" /AboveNormal \"%1\""


; High
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\06High]
@="High"

[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\06High\command]
@="cmd.exe /c start \"\" /High \"%1\""

; Realtime
[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\07Realtime]
@="Realtime"

[HKEY_CLASSES_ROOT\exefile\Shell\RunWithPriority\Shell\07Realtime\command]
@="cmd.exe /c start \"\" /Realtime \"%1\""

; Add Take Ownership context menu
[HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
@="Take Ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""
"IsolatedCommand"= "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""


[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership]
@="Take Ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" /r /d y && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause' -Verb runAs\""
"IsolatedCommand"="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" /r /d y && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause' -Verb runAs\""

; Disable Action Center
; Created by: Shawn Brink
; http://www.tenforums.com
; Tutorial: http://www.tenforums.com/tutorials/6004-action-center-enable-disable-windows-10-a.html

; [HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]
; "DisableNotificationCenter"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
; "DisableNotificationCenter"=dword:00000001

; Disable Live Tiles
[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
"NoTileApplicationNotification"=dword:00000001

; Remove Quick Access
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"HubMode"=dword:00000001

; Show Drive Letters Before Labels
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"ShowDriveLettersFirst"=dword:00000004

; Set Do this for all current items checked by default
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoPlay]
"SetCheckForAll"=dword:00000001
"DefaultSetCheck"=dword:00000001

; Disable Jump Lists
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_TrackDocs"=dword:00000000
"Start_ShowRecentDocs"=dword:00000000

; Disable Thumbnail Cache
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"DisableThumbnailCache"=dword:00000001

[HKEY_CURRENT_USER\Control Panel\Desktop]
"AutoEndTasks"="1"

; Disable Look for an app in the Microsoft Store
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"NoUseStoreOpenWith"=dword:00000001

; Wallpaper Quallity
[HKEY_CURRENT_USER\Control Panel\Desktop]
"JPEGImportQuality"=dword:00000063

; Enable Network Drives access through UAC
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableLinkedConnections"=dword:00000001
"LocalAccountTokenFilterPolicy"=dword:00000001
"EnableVirtualization"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"DisableLoopbackCheck"=dword:00000001

; Disable Download Restrictions in File Explorer

; Disable SmartScreen for File Explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000

; Disable Mark-of-the-Web (MOTW) for downloaded files
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AttachmentManager]
"ScanWithAntiVirus"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations]
"LowRiskFileTypes"=".exe;.msi;.bat;.cmd;.ps1;.js;.vbs"

; Disable Protected View for Office files (optional)
[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000001

; Disable shortcut text
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates]
"ShortcutNameTemplate"="\"%s.lnk\""

; Disable Automatic Maintenance
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]
"MaintenanceDisabled"=dword:00000001




; Created by imribiy
; https://github.com/imribiy
; https://discord.gg/XTYEjZNPgX

; Disable Cortana
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Search]
"AllowCortana"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Experience]
"AllowCortana"=dword:00000000

; Disable cortana in search
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortana"=dword:00000000
"CortanaConsent"=dword:00000000

; Disable Cortana on Lock Screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortanaAboveLock"=dword:00000000

; turn-off-application-telemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=dword:00000000

; Disable Online Tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\EdgeUI]
"DisableHelpSticker"=dword:00000001

; Disable Help Tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EdgeUI]
"DisableHelpSticker"=dword:00000001

; Don't Show Windows Tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001

; Disable Mitigations
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsMitigation]
"UserPreference"=dword:00000002

; In-kernel Mitigations
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"MitigationAuditOptions"=hex:00,00,00,00,00,00,20,22,00,00,00,00,00,00,00,20,00,00,00,00,00,00,00,00
"MitigationOptions"=hex:00,22,22,20,22,20,22,22,20,00,00,00,00,20,00,20,00,00,00,00,00,00,00,00
"KernelSEHOPEnabled"=dword:00000000

; Services Mitigations
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig]
"EnableSvchostMitigationPolicy"=hex(b):00,00,00,00,00,00,00,00

; Disable FTH 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\FTH]
"Enabled"=dword:00000000

; This reg file automatically applies Media Player setup phase as you would like to complete, no document history, no data sharing. Can be implemented to the ISOs.

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Health]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Skins]
"LastViewModeVTen"=dword:00000002
"SkinX"=dword:00000000
"SkinY"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Skins\res://wmploc/RT_TEXT/player.wsz]
"Prefs"="currentMetadataIconV11;0;FirstRun;0;ap;False;max;False"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Tasks]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Tasks\NowPlaying]
"InitFlags"=dword:00000001
"ShowHorizontalSeparator"=dword:00000001
"ShowVerticalSeparator"=dword:00000001
"PlaylistWidth"=dword:000000ba
"PlaylistHeight"=dword:00000064
"SettingsWidth"=dword:00000064
"SettingsHeight"=dword:00000087
"MetadataWidth"=dword:000000ba
"MetadataHeight"=dword:000000a0
"CaptionsHeight"=dword:00000064

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences]
"AutoMetadataCurrent503ServerErrorCount"=dword:00000000
"AutoMetadataCurrentOtherServerErrorCount"=dword:00000000
"AutoMetadataCurrentNetworkErrorCount"=dword:00000000
"AutoMetadataLastResetTime"=dword:293e214e
"SyncPlaylistsAdded"=dword:00000001
"MLSChangeIndexMusic"=dword:00000000
"MLSChangeIndexVideo"=dword:00000000
"MLSChangeIndexPhoto"=dword:00000000
"MLSChangeIndexList"=dword:00000000
"MLSChangeIndexOther"=dword:00000000
"LibraryHasBeenRun"=dword:00000000
"FirstRun"=dword:00000000
"NextLaunchIndex"=dword:00000002
"XV11"="256"
"YV11"="144"
"WidthV11"="2048"
"HeightV11"="1152"
"Maximized"="0"
"Volume"=dword:00000032
"ModeShuffle"=dword:00000000
"DisableMRUMusic"=dword:00000001
"Mute"=dword:00000000
"Balance"=dword:00000000
"CurrentEffectType"="Bars"
"CurrentEffectPreset"=dword:00000003
"VideoZoom"=dword:00000064
"AutoMetadataCurrent500ServerErrorCount"=dword:00000000
"StretchToFit"=dword:00000001
"ShowEffects"=dword:00000001
"ShowFullScreenPlaylist"=dword:00000000
"NowPlayingQuickHide"=dword:00000000
"ShowTitles"=dword:00000001
"ShowCaptions"=dword:00000000
"NowPlayingPlaylist"=dword:00000001
"NowPlayingMetadata"=dword:00000001
"NowPlayingSettings"=dword:00000000
"CurrentDisplayView"="VideoView"
"CurrentSettingsView"="EQView"
"CurrentMetadataView"="MediaInfoView"
"CurrentDisplayPreset"=dword:00000000
"CurrentSettingsPreset"=dword:00000000
"CurrentMetadataPreset"=dword:00000000
"UserDisplayView"="VizView"
"UserWMPDisplayView"="VizView"
"UserWMPSettingsView"="EQView"
"UserWMPMetadataView"="MediaInfoView"
"UserDisplayPreset"=dword:00000000
"UserWMPDisplayPreset"=dword:00000000
"UserWMPSettingsPreset"=dword:00000000
"UserWMPMetadataPreset"=dword:00000000
"UserWMPShowSettings"=dword:00000000
"UserWMPShowMetadata"=dword:00000000
"ShowAlbumArt"=dword:00000000
"AutoMetadataCurrentDownloadCount"=dword:00000000
"MediaLibraryCreateNewDatabase"=dword:00000000
"TranscodedFilesCacheDefaultSizeSet"=dword:00000001
"TranscodedFilesCacheSize"=dword:00002a5e
"LastScreensaverTimeout"=dword:00003a98
"LastScreensaverState"=dword:00000005
"LastScreensaverSetThreadExecutionState"=dword:80000003
"AppColorLimited"=dword:00000000
"SQMLaunchIndex"=dword:00000001
"LaunchIndex"=dword:00000001
"DisableMRUVideo"=dword:00000001
"DisableMRUPlaylists"=dword:00000001
"ShrinkToFit"=dword:00000000
"DisableMRUPictures"=dword:00000001
"UsageTracking"=dword:00000000
"SilentAcquisition"=dword:00000000
"SendUserGUID"=hex(3):00
"MetadataRetrieval"=dword:00000000
"AcceptedPrivacyStatement"=dword:00000001
"ModeLoop"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\EqualizerSettings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\HME]
"LocalLibraryID"="{95ADD7BE-43A3-4FD9-A4C8-453B88711A10}"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\ProxySettings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\ProxySettings\HTTP]
"ProxyName"=""
"ProxyPort"=dword:00000050
"ProxyExclude"=""
"ProxyBypass"=dword:00000000
"ProxyStyle"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\ProxySettings\RTSP]
"ProxyStyle"=dword:00000000
"ProxyName"=""
"ProxyPort"=dword:0000022a
"ProxyBypass"=dword:00000000
"ProxyExclude"=""

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\VideoSettings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{1F32514F-1561-4922-A604-8A1F478B5A42}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{52903d79-f993-4de6-8317-20c9c176d823}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{5DF031B7-6A37-42D9-8802-E27F4F224332}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{5F4BB5C9-4652-489B-8601-EEC0C3C32E2E}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{7F2B1D6B-1357-402C-A1C8-67E59583B41D}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{93075F62-16B3-43EC-A53B-FFAD0E01D5E7}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{9695AEF9-9D03-4671-8F2F-FF49D1BB01C4}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{976ABECA-93F7-4d81-9187-2A6137829675}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{99DB05E3-F81E-4C8A-A252-F396306AB6FE}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{9F9562EB-15B6-46C6-A7CB-0A66FC65130E}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{9FA014E3-076F-4865-A73C-117131B8E292}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{C1B5977D-9801-4D80-8592-143A044568AF}]
"AttemptedAutoRun"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{D5E49195-ED19-40fb-9EE0-E6625A808B77}]
"AttemptedAutoRun"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{E641D09E-E500-4c09-8260-F1CD7B902E9C}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{F24A1BC2-2331-4B91-8A13-5A549DA56E9D}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{FD981763-B6BB-4d51-9143-6D372A0ED56F}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media\WMSDK]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media\WMSDK\General]
"UniqueID"="{326EA348-9669-4511-8B5D-82373066F6FB}"
"VolumeSerialNumber"=dword:5acb5c10
"ComputerName"="XOS"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media\WMSDK\Namespace]
"DTDFile"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNS.DTD"
"LocalDelta"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNSD.XML"
"RemoteDelta"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNSR.XML"
"LocalBase"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNS.XML"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\JumplistData]
"Microsoft.Windows.MediaPlayer32"=hex(b):E8,DF,57,F3,0D,E9,D7,01

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/vnd.ms-wpl]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/vnd.ms-wpl\UserChoice]
"Progid"="WMP11.AssocMIME.WPL"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-mplayer2]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-mplayer2\UserChoice]
"Progid"="WMP11.AssocMIME.ASF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmd]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmd\UserChoice]
"Progid"="WMP11.AssocMIME.WMD"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmz]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmz\UserChoice]
"Progid"="WMP11.AssocMIME.WMZ"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp2]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp2\UserChoice]
"Progid"="WMP11.AssocMIME.3G2"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp\UserChoice]
"Progid"="WMP11.AssocMIME.3GP"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/aiff]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/aiff\UserChoice]
"Progid"="WMP11.AssocMIME.AIFF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/basic]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/basic\UserChoice]
"Progid"="WMP11.AssocMIME.AU"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mid]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mid\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/midi]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/midi\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp3]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp3\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp4]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp4\UserChoice]
"Progid"="WMP11.AssocMIME.M4A"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpegurl]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpegurl\UserChoice]
"Progid"="WMP11.AssocMIME.M3U"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/vnd.dlna.adts]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/vnd.dlna.adts\UserChoice]
"Progid"="WMP11.AssocMIME.ADTS"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/wav]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/wav\UserChoice]
"Progid"="WMP11.AssocMIME.WAV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-aiff]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-aiff\UserChoice]
"Progid"="WMP11.AssocMIME.AIFF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-flac]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-flac\UserChoice]
"Progid"="WMP11.AssocMIME.FLAC"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-matroska]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-matroska\UserChoice]
"Progid"="WMP11.AssocMIME.MKA"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mid]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mid\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-midi]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-midi\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mp3]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mp3\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpegurl]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpegurl\UserChoice]
"Progid"="WMP11.AssocMIME.M3U"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wax]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wax\UserChoice]
"Progid"="WMP11.AssocMIME.WAX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wma]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wma\UserChoice]
"Progid"="WMP11.AssocMIME.WMA"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-wav]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-wav\UserChoice]
"Progid"="WMP11.AssocMIME.WAV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\midi/mid]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\midi/mid\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp2]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp2\UserChoice]
"Progid"="WMP11.AssocMIME.3G2"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp\UserChoice]
"Progid"="WMP11.AssocMIME.3GP"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/avi]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/avi\UserChoice]
"Progid"="WMP11.AssocMIME.AVI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mp4]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mp4\UserChoice]
"Progid"="WMP11.AssocMIME.MP4"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpg\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/msvideo]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/msvideo\UserChoice]
"Progid"="WMP11.AssocMIME.AVI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/quicktime]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/quicktime\UserChoice]
"Progid"="WMP11.AssocMIME.MOV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/vnd.dlna.mpeg-tts]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/vnd.dlna.mpeg-tts\UserChoice]
"Progid"="WMP11.AssocMIME.TTS"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska-3d]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska-3d\UserChoice]
"Progid"="WMP11.AssocMIME.MK3D"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska\UserChoice]
"Progid"="WMP11.AssocMIME.MKV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg2a]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg2a\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf-plugin]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf-plugin\UserChoice]
"Progid"="WMP11.AssocMIME.ASX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf\UserChoice]
"Progid"="WMP11.AssocMIME.ASX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wm]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wm\UserChoice]
"Progid"="WMP11.AssocMIME.ASF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmv]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmv\UserChoice]
"Progid"="WMP11.AssocMIME.WMV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmx]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmx\UserChoice]
"Progid"="WMP11.AssocMIME.ASX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wvx]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wvx\UserChoice]
"Progid"="WMP11.AssocMIME.WVX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-msvideo]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-msvideo\UserChoice]
"Progid"="WMP11.AssocMIME.AVI"

; This reg file implements all the changes can be done on Steam by regedit to achieve better gaming performance. By imribiy#0001

[HKEY_CURRENT_USER\SOFTWARE\Valve\Steam]
"SmoothScrollWebViews"=dword:00000000
"DWriteEnable"=dword:00000000
"StartupMode"=dword:00000000
"H264HWAccel"=dword:00000000
"DPIScaling"=dword:00000000
"GPUAccelWebViews"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
"Steam"=-


; CONTROL PANEL

; turn off automatic learning
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\InputPersonalization]
"RestrictImplicitTextCollection"=dword:00000001
"RestrictImplicitInkCollection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InputPersonalization]
"RestrictImplicitTextCollection"=dword:00000001
"RestrictImplicitInkCollection"=dword:00000001


; NETWORK

; disable peer caching
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS]
"EnablePeercaching"=dword:00000000

; turn off branchcache
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\Service]
"Enable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PeerDist\Service]
"Enable"=dword:00000000

; disable font providers
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableFontProviders"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"EnableFontProviders"=dword:00000000

; Disbale hotspot authentication
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HotspotAuthentication]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\HotspotAuthentication]
"Enabled"=dword:00000000

; turn off lltdio driver
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\LLTD]
"EnableLLTDIO"=dword:00000000
"AllowLLTDIOOnDomain"=dword:00000000
"AllowLLTDIOOnPublicNet"=dword:00000000
"ProhibitLLTDIOOnPrivateNet"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD]
"EnableLLTDIO"=dword:00000000
"AllowLLTDIOOnDomain"=dword:00000000
"AllowLLTDIOOnPublicNet"=dword:00000000
"ProhibitLLTDIOOnPrivateNet"=dword:00000000

; turn off responder driver
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD]
"EnableRspndr"=dword:00000000
"AllowRspndrOnDomain"=dword:00000000
"AllowRspndrOnPublicNet"=dword:00000000
"ProhibitRspndrOnPrivateNet"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\LLTD]
"EnableRspndr"=dword:00000000
"AllowRspndrOnDomain"=dword:00000000
"AllowRspndrOnPublicNet"=dword:00000000
"ProhibitRspndrOnPrivateNet"=dword:00000000

; disable offline files feature
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetCache]
"Enabled"=dword:00000000


; SERVER

; disallow runonce backups
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Backup\Server]
"NoRunNowBackup"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Backup\Server]
"NoRunNowBackup"=dword:00000001


; START MENU AND TASKBAR

; dont keep history of recently opened documents
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoRecentDocsHistory"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoRecentDocsHistory"=dword:00000001

; turn off notifications network usage
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
"NoCloudApplicationNotification"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
"NoCloudApplicationNotification"=dword:00000001


; SYSTEM

; disable ceip
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\CEIP]
"CEIPEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\AppV\CEIP]
"CEIPEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows]
"CEIPEnable"=dword:00000000

; disable appv client
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\Client]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\AppV\Client]
"Enabled"=dword:00000000

; disable dynamic virtualization
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\AppV\Client\Virtualization]
"EnableDynamicVirtualization"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\Client\Virtualization]
"EnableDynamicVirtualization"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\Virtualization]
"EnableDynamicVirtualization"=dword:00000000

; turn off virtualization based security
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

; disable device health attestation monitoring and reporting
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\DeviceHealthAttestationService]
"EnableDeviceHealthAttestationService"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\DeviceHealthAttestationService]
"EnableDeviceHealthAttestationService"=dword:00000000

; disallow-remote-access-to-the-plug-and-play-interface
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"AllowRemoteRPC"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"AllowRemoteRPC"=dword:00000000

; dont send a windows error report when a generic driver is installed on a device
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendGenericDriverNotFoundToWER"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendGenericDriverNotFoundToWER"=dword:00000001

; prevent creation of a system restore point during device activity that would normally prompt creation of a restore point
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSystemRestore"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSystemRestore"=dword:00000001

; prevent device metadata retrieval from the internet
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001

; prevent windows from sending an error report when a device driver requests additional software during installation
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendRequestAdditionalSoftwareToWER"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendRequestAdditionalSoftwareToWER"=dword:00000001

; turn off found new hardware balloons during device installation
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000001

; turn off windows update device driver search prompt
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DriverSearching]
"DontPromptForWindowsUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DriverSearching]
"DontPromptForWindowsUpdate"=dword:00000001

; disable-windows-standby-resume-performance-diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{ffc42108-4920-4acf-a4fc-8abdcc68ada4}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{ffc42108-4920-4acf-a4fc-8abdcc68ada4}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

; disable-windows-standby-resume-performance-diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{ffc42108-4920-4acf-a4fc-8abdcc68ada4}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{ffc42108-4920-4acf-a4fc-8abdcc68ada4}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

; disable-windows-shutdown-performance-diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{2698178D-FDAD-40AE-9D3C-1371703ADC5B}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{2698178D-FDAD-40AE-9D3C-1371703ADC5B}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

; disable-windows-memory-leak-diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{eb73b633-3f4e-4ba0-8f60-8f3c6f53168f}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{eb73b633-3f4e-4ba0-8f60-8f3c6f53168f}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=dword:00000001

; disable-windows-boot-performance-diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{67144949-5132-4859-8036-a737b43825d8}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{67144949-5132-4859-8036-a737b43825d8}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{86432a0b-3c7d-4ddf-a89c-172faa90485d}]
"ScenarioExecutionEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{86432a0b-3c7d-4ddf-a89c-172faa90485d}]
"ScenarioExecutionEnabled"=dword:00000000

; disallow-users-to-access-and-run-troubleshooting-wizards
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnostics]
"EnableDiagnostics"=dword:00000000

; disallow-users-to-access-online-troubleshooting-content-on-microsoft-servers-via-wots
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy]
"EnableQueryRemoteServer"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy]
"EnableQueryRemoteServer"=dword:00000000

; disable-system-responsiveness-performance-diagnostics
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{a7a5847a-7511-4e4e-90b1-45ad2a002f51}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{a7a5847a-7511-4e4e-90b1-45ad2a002f51}]
"ScenarioExecutionEnabled"=dword:00000000
"EnabledScenarioExecutionLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{186f47ef-626c-4670-800a-4a30756babad}]
"ScenarioExecutionEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{186f47ef-626c-4670-800a-4a30756babad}]
"ScenarioExecutionEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WDI\{ecfb03d1-58ee-4cc7-a1b5-9bc6febcb915}]
"ScenarioExecutionEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{ecfb03d1-58ee-4cc7-a1b5-9bc6febcb915}]
"ScenarioExecutionEnabled"=dword:00000000

; turn-off-the-advertising-id
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000001

; disallow-upload-of-user-activities
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"UploadUserActivities"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"UploadUserActivities"=dword:00000000

; disallow-publishing-of-user-activities
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"PublishUserActivities"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"PublishUserActivities"=dword:00000000

; disallow-clipboard-synchronization-across-devices
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000000

; disallow-clipboard-history
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000000

; disable-activity-feed
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000000

; disallow-blocking-apps-at-shutdown
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowBlockingAppsAtShutdown"=dword:00000000

; turn-off-session-logging
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services]
"LoggingEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows NT\Terminal Services]
"LoggingEnabled"=dword:00000000

; block-enumeration-policy-for-external-devices-incompatible-with-kernel-dma-protection
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Kernel DMA Protection]
"DeviceEnumerationPolicy"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection]
"DeviceEnumerationPolicy"=dword:00000000

; dont-display-getting-started-welcome-screen-at-logon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoWelcomeScreen"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoWelcomeScreen"=dword:00000001

; turn-off-app-notifications-on-the-lock-screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableLockScreenAppNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"DisableLockScreenAppNotifications"=dword:00000001

; disable-delegated-msa-logons
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters]
"DelegatedMSAEnabled"=dword:00000000

; turn-off-ceip
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\SQMClient\Windows]
"CEIPEnable"=dword:00000000

; turn-off-handwriting-personalization-data-sharing
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC]
"PreventHandwritingDataSharing"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\TabletPC]
"PreventHandwritingDataSharing"=dword:00000001

; turn-off-handwriting-recognition-error-reporting
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\HandwritingErrorReports]
"PreventHandwritingErrorReports"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports]
"PreventHandwritingErrorReports"=dword:00000001

; turn-off-windows-error-reporting
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

; turn-off-windows-messenger-ceip
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Messenger\Client]
"CEIP"=dword:00000002


; WINDOWS COMPONENTS

; turn-off-api-sampling
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableAPISamping"=dword:00000001

; turn-off-application-footprint
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableApplicationFootprint"=dword:00000001

; turn-off-compatibility-scan-for-backed-up-apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableWin32AppBackup"=dword:00000001

; turn-off-install-tracing
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableInstallTracing"=dword:00000001

; turn-off-application-compatibility-engine
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AppCompat]
"DisableEngine"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableEngine"=dword:00000001

; turn-off-application-telemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AppCompat]
"AITEnable"=dword:00000000

; turn-off-inventory-collector
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AppCompat]
"DisableInventory"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableInventory"=dword:00000001

; turn-off-program-compatibility-assistant
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisablePCA"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AppCompat]
"DisablePCA"=dword:00000001

; turn-off-steps-recorder
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\AppCompat]
"DisableUAR"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"DisableUAR"=dword:00000001

; turn-off-switchback-compatibility-engine
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]
"SbEnable"=dword:00000000

; turn-off-autoplay
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoDriveTypeAutoRun"=dword:000000ff

; disallow-the-use-of-biometrics
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Biometrics]
"Enabled"=dword:00000000

; disable-organizational-messages
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent]
"EnableOrganizationalMessages"=dword:00000000

; disable-third-party-suggestions
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent]
"DisableThirdPartySuggestions"=dword:00000001

; dont-show-windows-tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001

; turn-off-cloud-optimized-content
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableCloudOptimizedContent"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CloudContent]
"DisableCloudOptimizedContent"=dword:00000001

; turn-off-microsoft-consumer-experiences
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsConsumerFeatures"=dword:00000001

; disable-diagnostic-data-viewer
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"DisableDiagnosticDataViewer"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"DisableDiagnosticDataViewer"=dword:00000001

; disable-onesettings-downloads
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"DisableOneSettingsDownloads"=dword:00000001

; disallow-device-name-to-be-sent-in-windows-diagnostic-data
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"AllowDeviceNameInTelemetry"=dword:00000000

; disallow-diagnostic-data
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000

; dont-send-edge-data
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection]
"MicrosoftEdgeDataOptIn"=dword:00000000

; limit-diagnostic-log-collection
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"LimitDiagnosticLogCollection"=dword:00000001

; limit-dump-collection
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection]
"LimitDumpCollection"=dword:00000001

; turn-off-desktop-gadgets
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar]
"TurnOffSidebar"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar]
"TurnOffSidebar"=dword:00000001

; dont-allow-window-animations
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM]
"DisallowAnimations"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DWM]
"DisallowAnimations"=dword:00000001

; dont-allow-flip3d-invocation
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DWM]
"DisallowFlip3d"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DWM]
"DisallowFlip3d"=dword:00000001

; disable-windows-defender-smartscreen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"ShellSmartScreenLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

; turn-off-file-history
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\FileHistory]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\FileHistory]
"Disabled"=dword:00000001

; turn-off-find-my-device
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FindMyDevice]
"AllowFindMyDevice"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\FindMyDevice]
"AllowFindMyDevice"=dword:00000000

; turn-off-automatic-download-and-update-of-map-data
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps]
"AutoDownloadAndUpdateMapData"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Maps]
"AutoDownloadAndUpdateMapData"=dword:00000000

; disallow-message-service-cloud-sync
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Messaging]
"AllowMessageSync"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Messaging]
"AllowMessageSync"=dword:00000000

; dont-use-uev
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\UEV\Agent\Configuration]
"SyncEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\UEV\Agent\Configuration]
"SyncEnabled"=dword:00000000

; disable-uev
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\UEV\Agent]
"Enabled"=dword:00000000
"RegisterInboxTemplates"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\UEV\Agent]
"Enabled"=dword:00000000
"RegisterInboxTemplates"=-

; disable remote desktop sharing
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Conferencing]
"NoRDS"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing]
"NoRDS"=dword:00000001

; turn off active help
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0]
"NoActiveHelp"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Assistance\Client\1.0]
"NoActiveHelp"=dword:00000001

; turn off presentation settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\PresentationSettings]
"NoPresentationSettings"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\PresentationSettings]
"NoPresentationSettings"=dword:00000001


; turn-off-smart-card-plug-n-play-service
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScPnP]
"EnableScPnP"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\ScPnP]
"EnableScPnP"=dword:00000000

; disallow-automatic-update-of-speech-data
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Speech]
"AllowSpeechModelUpdate"=dword:00000000

; turn-off-the-offer-to-update-to-the-latest-version-of-windows
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\WindowsStore]
"DisableOSUpgrade"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore]
"DisableOSUpgrade"=dword:00000001

; dont-sync
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync]
"DisableSettingSync"=dword:00000002
"DisableSettingSyncUserOverride"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\SettingSync]
"DisableSettingSync"=dword:00000002
"DisableSettingSyncUserOverride"=dword:00000000

; disable-text-prediction
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\TabletTip\1.7]
"DisablePrediction"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\TabletTip\1.7]
"DisablePrediction"=dword:00000001

; disable-improve-inking-and-typing-recognition
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput]
"AllowLinguisticDataCollection"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\TextInput]
"AllowLinguisticDataCollection"=dword:00000000

; disallow-corporate-redirection-of-ceip
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\SQMClient]
"CorporateSQMURL"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient]
"CorporateSQMURL"=-

; disable-windows-defender-smartscreen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

; disable-edge-windows-defender-smartscreen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter]
"EnabledV9"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\MicrosoftEdge\PhishingFilter]
"EnabledV9"=dword:00000000

; disallow-windows-ink-workspace
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\WindowsInkWorkspace]
"AllowWindowsInkWorkspace"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace]
"AllowWindowsInkWorkspace"=-

; prevent-windows-media-drm-internet-access
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM]
"DisableOnline"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\WMDRM]
"DisableOnline"=dword:00000001

; prevent-media-sharing
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\WindowsMediaPlayer]
"PreventLibrarySharing"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer]
"PreventLibrarySharing"=dword:00000001





; ko-fi.com/windowsxlite

; Windows 10 & 11
; Disable Error Reporting
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

; Disable Windows Ink Workspace
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace]
"AllowWindowsInkWorkspace"=dword:00000000

; System Responsiveness alternative values are (default) "00000014" "00000001" or "0000000a"
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
"NetworkThrottlingIndex"=dword:ffffffff
"SystemResponsiveness"=dword:00000000

; Scheduling Category
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks]

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


; === Win32PrioritySeparation Settings for Music Production ===
; 	0x2A (42 decimal) Custom; ultra-responsive, aggressive boost to frontmost app
; 	0x1A (26 decimal) Custom; long slices, but boosted active apps
; 0x00000018 (24 decimal) → "Background Services" preset from Control Panel
;                        → Safest and broadly recommended for DAWs and audio drivers (ASIO, WASAPI)
; 0x00000028 (40 decimal) → Advanced tuning for ultra-low latency setups
;                        → Uses short, fixed processor quanta with no foreground boost
;                        → May provide smoother performance in some real-time audio environments
; 0x00000002 balance between foreground and background responsiveness

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
; "Win32PrioritySeparation"=dword:00000018
; To test advanced tuning, replace the above with:
; "Win32PrioritySeparation"=dword:00000028

; Default for Programs; snappy UI, responsive foreground apps
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
"ConvertibleSlateMode"=dword:00000000
"Win32PrioritySeparation"=dword:00000026


; Enable Virtual Memory 
; To enable largesystemcache set "LargeSystemCache"=dword:00000001
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000001
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
"BootId"=dword:0000001e
"BaseTime"=dword:2c9b398f
"EnableSuperfetch"=dword:00000000
"SfTracingState"=dword:00000001


; Windows 11 Only
; Disable Suggested Actions
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard]
"Disabled"=dword:00000001

; Disable Compact Mode (File Explorer)
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"UseCompactMode"=dword:00000000




; FR33THY + ME


; DEBLOAT ONEDRIVE

; Hide Onedrive Folder
[-HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

[-HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

; Disable OneDrive from running at startup
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]
"OneDrive"=-

; Prevent OneDrive from starting automatically with Windows
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive]
"DisableFileSync"=dword:00000001


; DISABLE NON ESSENTIAL SERVICES

; Disable Telemetry & Data Collection
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\dmwappushservice]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service]
"Start"=dword:00000004

; Disable Windows Features (Safe for Desktops)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WSearch] ; Windows Search (Indexing)
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler] ; Print Spooler (Printing)
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain] ; SysMain (SuperFetch/Prefetch)
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\edgeupdate] ; Microsoft Edge Update
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\edgeupdatem]
"Start"=dword:00000004

; Disable Geolocation & Tracking
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MapsBroker]
"Start"=dword:00000004

; Disable Bluetooth (Skip if you use Bluetooth)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthServ]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTAGService]
"Start"=dword:00000004

; Disable Legacy Networking
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lmhosts] ; NetBIOS over TCP/IP
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry] ; Remote Registry
"Start"=dword:00000004

; Disable Xbox/Game Services
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblAuthManager]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblGameSave]
"Start"=dword:00000004

; Disable Unused System Services
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertPropSvc] ; Certificate Propagation
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wisvc] ; Windows Insider Program
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WalletService] ; Microsoft Wallet
"Start"=dword:00000004


; DISABLE TELEMETRY

; Hide Lock screen
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData]
; "AllowLockScreen"=dword:00000000

; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization]
; "NoLockScreen"=dword:00000001

; Let Apps use Advertising ID for Relevant Ads in Windows 10
[hkey_users\default\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
"Enabled"=dword:00000000

; Online Speech Recognition
[hkey_users\default\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy]
"HasAccepted"=dword:00000000

; Improve Inking & Typing Recognition
[hkey_users\default\Software\Microsoft\Input\TIPC]
"Enabled"=dword:00000000
 
[hkey_users\default\Software\Microsoft\InputPersonalization\TrainedDataStore]
"HarvestContacts"=dword:00000000

[hkey_users\default\Software\Microsoft\Personalization\Settings]
"AcceptedPrivacyPolicy"=dword:00000000

; Disable Let Windows improve Start and search results by tracking app launches
[hkey_users\default\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_TrackProgs"=dword:00000000

; Disable Activity History
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"PublishUserActivities"=dword:00000000

; Set Feedback Frequency to Never
[hkey_users\default\SOFTWARE\Microsoft\Siuf\Rules]
"NumberOfSIUFInPeriod"=dword:00000000
"PeriodInNanoSeconds"=-

; DisableSpyNetTelemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet]
; "DisableBlockAtFirstSeen"=dword:00000001
"LocalSettingOverrideSpynetReporting"=dword:00000000
"SpynetReporting"=dword:00000000
"SubmitSamplesConsent"=dword:00000002

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Microsoft Antimalware\SpyNet]
"SpyNetReporting"=dword:00000000
"LocalSettingOverrideSpyNetReporting"=dword:00000000

; Disable Office Telemetry
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Common\ClientTelemetry]
"DisableTelemetry"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry]
"DisableTelemetry"=dword:00000001

; Disable fun facts, tips and more from Windows and Cortana on your lock screen
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"SubscribedContent-338387Enabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000


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
; open file explorer to this pc
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"LaunchTo"=dword:00000001

; hide frequent folders in quick access
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowFrequent"=dword:00000000

; disable show files from office.com
"ShowCloudFilesInQuickAccess"=dword:00000000

; disable search history
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDeviceSearchHistoryEnabled"=dword:00000000

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
; disable lock
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]
"ShowLockOption"=dword:00000000

; disable sleep
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

; disable device installation settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001




; NETWORK AND INTERNET
; disable allow other network users to control or disable the shared internet connection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Network\SharedAccessConnection]
"EnableControl"=dword:00000000




; SYSTEM AND SECURITY

; disable remote assistance
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance]
"fAllowToGetHelp"=dword:00000000




; TROUBLESHOOTING
; disable automatic maintenance
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]
"MaintenanceDisabled"=dword:00000001




; --IMMERSIVE CONTROL PANEL--




; WINDOWS UPDATE
; disable delivery optimization
[HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings]
"DownloadMode"=dword:00000000




; PRIVACY
; disable show me notification in the settings app
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications]
"EnableAccountNotifications"=dword:00000000

; disable allow location override
; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\UserLocationOverridePrivacySetting]
; "Value"=dword:00000000

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




; PERSONALIZATION
; solid color personalize your background
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Wallpaper"=""

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000001

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

; remove copilot from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowCopilotButton"=dword:00000000

; remove meet now
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=dword:00000001

; remove news and interests
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds]
"EnableFeeds"=dword:00000000

; show all taskbar icons
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

; turn on hardware accelerated gpu scheduling (hags)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"HwSchMode"=dword:00000002

; disable variable refresh rate & enable optimizations for windowed games
[HKEY_CURRENT_USER\Software\Microsoft\DirectX\UserGpuPreferences]
"DirectXUserGlobalSettings"="SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;"

; disable notifications
; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications]
; "ToastEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"SubscribedContent-338389Enabled"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement]
"ScoobeSystemSettingEnabled"=dword:00000000

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

; alt tab open windows only
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"MultiTaskingAltTabFilter"=dword:00000003

; disable share across devices
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP]
"RomeSdkChannelUserAuthzPolicy"=dword:00000000
"CdpSessionUserAuthzPolicy"=dword:00000000




; --OTHER--




; STORE
; disable update apps automatically
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore]
"AutoDownload"=dword:00000002




; EDGE
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]
"HardwareAccelerationModeEnabled"=dword:00000000
"BackgroundModeEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\edgeupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\edgeupdatem]
"Start"=dword:00000004




; CHROME
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome]
"StartupBoostEnabled"=dword:00000000
"HardwareAccelerationModeEnabled"=dword:00000000
"BackgroundModeEnabled"=dword:00000000
"HighEfficiencyModeEnabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdatem]
"Start"=dword:00000004




; NVIDIA
; disable nvidia tray icon
[HKEY_CURRENT_USER\Software\NVIDIA Corporation\NvTray]
"StartOnLogin"=dword:00000000




; --CAN'T DO NATIVELY--




; UWP APPS
; disable background apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy]
"LetAppsRunInBackground"=dword:00000002

; disable windows input experience preload
[HKEY_CURRENT_USER\Software\Microsoft\input]
"IsInputAppPreloadEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Dsh]
"IsPrelaunchEnabled"=dword:00000000




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
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling]
"PowerThrottlingOff"=dword:00000001

; disable fast boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"HiberbootEnabled"=dword:00000000




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




; Disable Game Bar

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR]
"AppCaptureEnabled"=dword:00000000

; Disable Game Bar tips
; Disable 'Open Xbox Game Bar using this button on a controller'

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar]
"GamePanelStartupTipIndex"=dword:00000003
"ShowStartupPanel"=dword:00000000
"UseNexusForGameBarEnabled"=dword:00000000

; Disable Game Bar Presence Writer

[HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter]
"ActivationType"=dword:00000000

; Disable Windows Game Recording and Broadcasting
; It automatically disables Game Bar

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR]
"AllowGameDVR"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR]
"value"=dword:00000000


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

; disable game mode
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar]
"AllowAutoGameMode"=dword:00000000
"AutoGameModeEnabled"=dword:00000000

; OTHER
; remove 3d objects
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

; hide home settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"SettingsPageVisibility"="hide:home"

; disable menu show delay
[HKEY_CURRENT_USER\Control Panel\Desktop]
"MenuShowDelay"="0"

; disable driver searching & updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
"SearchOrderConfig"=dword:00000000
"DontSearchWindowsUpdate"=dword:00000001


; DISABLE WINDOWS SECURITY SETTINGS

; cloud delivered protection
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
"SpyNetReporting"=dword:00000000

; automatic sample submission
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
"SubmitSamplesConsent"=dword:00000000

; firewall notifications
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

; smart app control
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender]
"VerifiedAndReputableTrustModeEnabled"=dword:00000000
"SmartLockerMode"=dword:00000000
"PUAProtection"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\AppID\Configuration\SMARTLOCKER]
"START_PENDING"=dword:00000000
"ENABLED"=hex(b):00,00,00,00,00,00,00,00

[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\CI\Policy]
"VerifiedAndReputablePolicyState"=dword:00000000

; check apps and files
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"SmartScreenEnabled"="Off"

; smartscreen for microsoft edge
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenEnabled]
@=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenPuaEnabled]
@=dword:00000000

; phishing protection
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components]
"CaptureThreatWindow"=dword:00000000
"NotifyMalicious"=dword:00000000
"NotifyPasswordReuse"=dword:00000000
"NotifyUnsafeApp"=dword:00000000
"ServiceEnabled"=dword:00000000

; potentially unwanted app blocking
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender]
"PUAProtection"=dword:00000000

; smartscreen for microsoft store apps
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost]
"EnableWebContentEvaluation"=dword:00000000

; exploit protection, leaving control flow guard cfg on for vanguard anticheat
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\kernel]
"MitigationOptions"=hex:22,22,22,00,00,01,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00

; core isolation 
; memory integrity 
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; kernel-mode hardware-enforced stack protection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; microsoft vulnerable driver blocklist
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\CI\Config]
"VulnerableDriverBlocklistEnable"=dword:00000000




; arkham

; DirectX Tweaks
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX]
"D3D12_ENABLE_UNSAFE_COMMAND_BUFFER_REUSE"=dword:00000001
"D3D12_ENABLE_RUNTIME_DRIVER_OPTIMIZATIONS"=dword:00000001
"D3D12_RESOURCE_ALIGNMENT"=dword:00000001
"D3D11_MULTITHREADED"=dword:00000001
"D3D12_MULTITHREADED"=dword:00000001
"D3D11_DEFERRED_CONTEXTS"=dword:00000001
"D3D12_DEFERRED_CONTEXTS"=dword:00000001
"D3D11_ALLOW_TILING"=dword:00000001
"D3D11_ENABLE_DYNAMIC_CODEGEN"=dword:00000001
"D3D12_ALLOW_TILING"=dword:00000001
"D3D12_CPU_PAGE_TABLE_ENABLED"=dword:00000001
"D3D12_HEAP_SERIALIZATION_ENABLED"=dword:00000001
"D3D12_MAP_HEAP_ALLOCATIONS"=dword:00000001
"D3D12_RESIDENCY_MANAGEMENT_ENABLED"=dword:00000001


; General DirectX Tweaks (DXGKrnl)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DXGKrnl]
"CreateGdiPrimaryOnSlaveGPU"=dword:00000001
"DriverSupportsCddDwmInterop"=dword:00000001
"DxgkCddSyncDxAccess"=dword:00000001
"DxgkCddSyncGPUAccess"=dword:00000001
"DxgkCddWaitForVerticalBlankEvent"=dword:00000001
"DxgkCreateSwapChain"=dword:00000001
"DxgkFreeGpuVirtualAddress"=dword:00000001
"DxgkOpenSwapChain"=dword:00000001
"DxgkShareSwapChainObject"=dword:00000001
"DxgkWaitForVerticalBlankEvent"=dword:00000001
"DxgkWaitForVerticalBlankEvent2"=dword:00000001
"SwapChainBackBuffer"=dword:00000001
"TdrResetFromTimeoutAsync"=dword:00000001


; NVMe Tweaks (stornvme)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\stornvme\Parameters]
"QueueDepth"=dword:00000040
"NvmeMaxReadSplit"=dword:00000004
"NvmeMaxWriteSplit"=dword:00000004
"ForceFlush"=dword:00000001
"ImmediateData"=dword:00000001
"MaxSegmentsPerCommand"=dword:00000100
"MaxOutstandingCmds"=dword:00000100
"ForceEagerWrites"=dword:00000001
"MaxQueuedCommands"=dword:00000100
"MaxOutstandingIORequests"=dword:00000100
"NumberOfRequests"=dword:000005dc
"IoSubmissionQueueCount"=dword:00000003
"IoQueueDepth"=dword:00000040
"HostMemoryBufferBytes"=dword:000005dc
"ArbitrationBurst"=dword:00000100


; NVMe Tweaks (StorNVMe\Parameters\Device)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorNVMe\Parameters\Device]
"QueueDepth"=dword:00000040
"NvmeMaxReadSplit"=dword:00000004
"NvmeMaxWriteSplit"=dword:00000004
"ForceFlush"=dword:00000001
"ImmediateData"=dword:00000001
"MaxSegmentsPerCommand"=dword:00000100
"MaxOutstandingCmds"=dword:00000100
"ForceEagerWrites"=dword:00000001
"MaxQueuedCommands"=dword:00000100
"MaxOutstandingIORequests"=dword:00000100
"NumberOfRequests"=dword:000005dc
"IoSubmissionQueueCount"=dword:00000003
"IoQueueDepth"=dword:00000040
"HostMemoryBufferBytes"=dword:000005dc
"ArbitrationBurst"=dword:00000100


; DPC Kernel Tweaks
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"DpcWatchdogProfileOffset"=dword:00000000
"DpcTimeout"=dword:00000000
"IdealDpcRate"=dword:00000001
"MaximumDpcQueueDepth"=dword:00000001
"MinimumDpcRate"=dword:00000001
"DpcWatchdogPeriod"=dword:00000000
"MaxDynamicTickDuration"=dword:0000000a
"MaximumSharedReadyQueueSize"=dword:00000080
"BufferSize"=dword:00000020
"IoQueueWorkItem"=dword:00000020
"IoQueueWorkItemToNode"=dword:00000020
"IoQueueWorkItemEx"=dword:00000020
"IoQueueThreadIrp"=dword:00000020
"ExTryQueueWorkItem"=dword:00000020
"ExQueueWorkItem"=dword:00000020
"IoEnqueueIrp"=dword:00000020
"XMMIZeroingEnable"=dword:00000000
"UseNormalStack"=dword:00000001
"UseNewEaBuffering"=dword:00000001
"StackSubSystemStackSize"=dword:00010000


; Distribute Timers
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
; "DistributeTimers"=dword:00000001

; Disable NTFS tunnelling
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
; "MaximumTunnelEntries"=dword:00000000

; Max Pending Interrupts
;Founder by kizzimo

; CPU Performance Tuning
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
"CPU_MAX_PENDING_INTERRUPTS"="0"  ; Minimizes the number of interrupts waiting, reducing latency.
"CPU_MAX_PENDING_IO"="0"           ; Keeps I/O processing instant, minimizing wait times.
"CPU_IDLE_POLICY"="0"              ; Prevents CPU from idling to maintain maximum performance.
"CPU_BOOST_POLICY"="2"             ; Always allows the CPU to boost for better performance.
"CPU_MAX_FREQUENCY"="100"          ; Allows the CPU to reach maximum frequency.
"CPU_INTERRUPT_BALANCE_POLICY"="1" ; Ensures interrupts are balanced across all CPU cores.
"MKL_DEBUG_CPU_TYPE"="10"

; I/O Performance Tuning
"IO_COMPLETION_POLICY"="0"         ; Immediate completion of I/O requests to minimize latency.
"IO_REQUEST_LIMIT"="1024"          ; Increases the number of simultaneous I/O requests.
"DISK_MAX_PENDING_IO"="0"          ; No pending I/O for disk operations, reducing read/write latency.
"IO_PRIORITY"="0"                  ; Maximize I/O priority for all operations to minimize bottlenecks.
"DISK_MAX_PENDING_INTERRUPTS"="0"
"IO_MAX_PENDING_INTERRUPTS"="0"

; Power Management and Performance
"POWER_THROTTLE_POLICY"="0"        ; Disables power throttling, ensuring high performance at all times.
"POWER_IDLE_TIMEOUT"="0"           ; Disables idle timeout to maintain continuous high performance.
"CPU_POWER_POLICY"="1"             ; Enforces high-performance power policy, disabling all power-saving features.
"DISABLE_DYNAMIC_TICK"="yes"

; Memory and Latency Tuning
"MEMORY_MAX_ALLOCATION"="0"     ; Increase memory allocation to allow more data in memory for faster access.
"MEMORY_LATENCY_POLICY"="0"        ; Minimizes memory latency, optimizing for faster memory access.
"MEMORY_PREFETCH_POLICY"="2"       ; Enables memory prefetch to speed up data access in memory.
"MEMORY_MAX_PENDING_INTERRUPTS"="0"
"DWM_MAX_PENDING_INTERRUPTS"="0"
"DWM_COMPOSITOR_MAX_PENDING_INTERRUPTS"="0"

; Network and Connectivity Tuning
"NETWORK_BUFFER_SIZE"="512"       ; Increases network buffer size for faster throughput.
"NETWORK_INTERRUPT_COALESCING"="0" ; Disables interrupt coalescing for lower network latency.
"NETWORK_MAX_PENDING_INTERRUPTS"="0"

; Miscellaneous Performance Tuning
"TIMER_RESOLUTION"="0"             ; Sets the smallest possible timer resolution for the highest responsiveness.
"THREAD_SCHEDULER_POLICY"="0"      ; Prioritizes immediate thread scheduling to reduce latency.
"GPU_MAX_PENDING_INTERRUPTS"="0"   ; Minimizes GPU interrupts for faster rendering.

; Network Adapter Performance Tuning
"NETWORK_ADAPTER_PENDING_INTERRUPTS"="0"        ; Ensures no pending interrupts for network devices.
"NETWORK_ADAPTER_MAX_PENDING_IO"="0"            ; Ensures instant I/O processing for network operations.
"NETWORK_ADAPTER_INTERRUPT_MODERATION"="0"      ; Disables interrupt moderation for lower network latency.
"NETWORK_ADAPTER_MAX_PENDING_INTERRUPTS"="0"

; Storage Device (HDD/SSD) Performance Tuning
"STORAGE_DEVICE_PENDING_INTERRUPTS"="0"         ; Ensures no pending interrupts for storage devices.
"STORAGE_DEVICE_MAX_PENDING_IO"="0"             ; Ensures storage I/O operations are processed immediately.
"STORAGE_DEVICE_COMPLETION_POLICY"="0"          ; Forces immediate completion of storage I/O tasks.
"STORAGE_MAX_PENDING_INTERRUPTS"="0"
"STORAGE_DEVICE_MAX_PENDING_INTERRUPTS"="0" 

; USB Device Performance Tuning
"USB_DEVICE_PENDING_INTERRUPTS"="0"             ; No pending interrupts for USB devices.
"USB_DEVICE_MAX_PENDING_IO"="0"                 ; Processes USB I/O instantly, reducing latency.
"USB_MAX_PENDING_INTERRUPTS"="0"
"USB_DEVICE_MAX_PENDING_INTERRUPTS"="0" 

; PCIe Device Performance Tuning
"PCIE_DEVICE_PENDING_INTERRUPTS"="0"            ; No pending interrupts for PCIe devices.
"PCIE_DEVICE_MAX_PENDING_IO"="0"                ; Ensures PCIe I/O operations are processed immediately.
"PCIE_MAX_PENDING_INTERRUPTS"="0"
"PCIE_DEVICE_MAX_PENDING_INTERRUPTS"="0"

; GPU Performance Tuning
"GPU_PENDING_INTERRUPTS"="0"                    ; Reduces GPU interrupt queue to zero for immediate processing.
"GPU_MAX_PENDING_COMPUTE"="0"                   ; Ensures compute operations are processed without delay.
"GPU_MAX_PENDING_RENDER"="0"                    ; Forces immediate rendering tasks processing.

; Audio Device Performance Tuning
"AUDIO_DEVICE_PENDING_INTERRUPTS"="0"           ; Ensures no pending interrupts for sound cards.
"AUDIO_DEVICE_BUFFER_SIZE"="512"                ; Keeps audio buffer size low to reduce latency in sound processing.
"AUDIO_MAX_PENDING_INTERRUPTS"="0"
"AUDIO_DEVICE_MAX_PENDING_INTERRUPTS"="0" 

; General Device Tuning
"DEVICE_PENDING_INTERRUPTS"="0"                 ; Generic setting to ensure no pending interrupts for all devices.
"DEVICE_MAX_PENDING_IO"="0"                     ; Ensures immediate I/O operations across all devices.
"DEVICE_COMPLETION_POLICY"="0"                  ; Forces devices to complete tasks instantly.
"DEVICE_MAX_PENDING_INTERRUPTS"="0"

; Disable Event Processor
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EventProcessorEnabled"=dword:00000000

; Disable InterruptSteering
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"InterruptSteeringDisabled"=dword:00000001

; MMCSS ENABLE
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MMCSS]
"Start"=dword:00000002

; DWMFlipPresent
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM]
"FrameLatency"=dword:00000002

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM]
"ForceDirectDrawSync"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM]
"MaxQueuedPresentBuffers"=dword:00000001

; SplitLargeCaches
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"SplitLargeCaches"=dword:00000001

; Apply Thread DPC
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
"ThreadDpcEnable"=dword:00000000
"@
Set-Content -Path "$env:TEMP\Registry Optimize.reg" -Value $MultilineComment -Force
# edit reg file
$path = "$env:TEMP\Registry Optimize.reg"
(Get-Content $path) -replace "\?","$" | Out-File $path
# disable optimize drives
schtasks /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
# import reg file
Regedit.exe /S "$env:TEMP\Registry Optimize.reg"
Clear-Host
exit
