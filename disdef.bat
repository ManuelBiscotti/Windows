@Echo Off & Set "_F0=%~f0" & Title

PowerShell.exe -NoProfile -Command "Set-Content -LiteralPath $Env:Temp\_.ps1 -Value ([RegEx]::Matches([System.IO.File]::ReadAllText($Env:_F0), '(?smi)^(Pause|Exit)(.*)$').Groups[2].Value) -Encoding Unicode -Force"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%Temp%\_.ps1"
exit

function Del-PS1 {Remove-Item -LiteralPath $Env:Temp\_.ps1 -Force}

if ((Get-Item -LiteralPath 'Registry::HKU\S-1-5-19' -ErrorAction SilentlyContinue)) {Del-PS1} Else {
    try {Start-Process -FilePath PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$Env:Temp\_.ps1`"" -Verb RunAs} Catch {Del-PS1}
    exit
}

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

function Get-FileFromWeb {
    param (
        [Parameter(Mandatory)][string]$URL,
        [Parameter(Mandatory)][string]$File
    )
    
    try {
        $request = [System.Net.HttpWebRequest]::Create($URL)
        $response = $request.GetResponse()
        
        if ($response.StatusCode -eq 401 -or $response.StatusCode -eq 403 -or $response.StatusCode -eq 404) {
            throw "Remote file either doesn't exist, is unauthorized, or is forbidden for '$URL'."
        }
        
        # Handle relative paths
        if ($File -match '^\.\\') {
            $File = Join-Path (Get-Location -PSProvider 'FileSystem') ($File -Split '^\.')[1]
        }
        if ($File -and !(Split-Path $File)) {
            $File = Join-Path (Get-Location -PSProvider 'FileSystem') $File
        }
        
        # Create directory if it doesn't exist
        if ($File) {
            $fileDirectory = [System.IO.Path]::GetDirectoryName($File)
            if (!(Test-Path($fileDirectory))) {
                [System.IO.Directory]::CreateDirectory($fileDirectory) | Out-Null
            }
        }
        
        # Get file size for progress calculation
        $totalBytes = $response.ContentLength
        $progressId = Get-Random
        
        Write-Host "`n🚀 Downloading: $([System.IO.Path]::GetFileName($File))" -ForegroundColor Cyan
        Write-Host "📦 Size: $([math]::Round($totalBytes/1MB, 2)) MB" -ForegroundColor Yellow
        Write-Host "🎯 Target: $File" -ForegroundColor Gray
        
        # Custom progress bar display
        function Show-ProgressBar {
            param($Percent, $DownloadedMB, $TotalMB)
            
            $bars = 20
            $filled = [math]::Round($Percent / 100 * $bars)
            $empty = $bars - $filled
            
            $bar = "[" + ("█" * $filled) + ("░" * $empty) + "]"
            $percentage = $Percent.ToString("0.0").PadLeft(5)
            
            Write-Host "`r$bar ${percentage}% ($DownloadedMB/$TotalMB MB)" -NoNewline -ForegroundColor Green
        }
        
        # Download with progress tracking
        [byte[]]$buffer = New-Object byte[] 1048576
        $reader = $response.GetResponseStream()
        $writer = New-Object System.IO.FileStream $File, 'Create'
        
        $totalBytesRead = 0
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        
        do {
            $count = $reader.Read($buffer, 0, $buffer.Length)
            $writer.Write($buffer, 0, $count)
            
            $totalBytesRead += $count
            
            if ($totalBytes -gt 0) {
                $percentComplete = [math]::Round(($totalBytesRead / $totalBytes) * 100, 1)
                $downloadedMB = [math]::Round($totalBytesRead / 1MB, 2)
                $totalMB = [math]::Round($totalBytes / 1MB, 2)
                
                Show-ProgressBar -Percent $percentComplete -DownloadedMB $downloadedMB -TotalMB $totalMB
            }
        } while ($count -gt 0)
        
        $stopwatch.Stop()
        $downloadSpeed = [math]::Round(($totalBytesRead / 1MB) / $stopwatch.Elapsed.TotalSeconds, 2)
        
        # Final completion message
        Write-Host "`n✅ Download completed!" -ForegroundColor Green
        Write-Host "⏱️  Time: $($stopwatch.Elapsed.ToString('mm\:ss'))" -ForegroundColor Gray
        Write-Host "📊 Speed: $downloadSpeed MB/s" -ForegroundColor Gray
        Write-Host "📍 Saved to: $File" -ForegroundColor Gray
    }
    finally {
        if ($reader) { $reader.Close() }
        if ($writer) { $writer.Close() }
        if ($response) { $response.Close() }
    }
}


    clear-host
    # Remove-Item "$env:TEMP\*","$env:SystemRoot\Temp\*" -Recurse -Force
    $w = $Host.UI.RawUI.WindowSize.Width
    $c = { param($t) (' ' * [Math]::Max(0,[Math]::Floor(($w-$t.Length)/2))) + $t }

    1..3 | % { '' }
    @(
        "██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗",
        "██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝",
        "██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗",
        "██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║",
        "╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║",
        " ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝"
    ) | % { Write-Host (& $c $_) }

    1..3 | % { '' }
    Write-Host (& $c " Not your avarage Windows optimizer... ") -ForegroundColor DarkGray
    Write-Host (& $c " Install Programs, Tweaks, Fixes, and Updates ") -ForegroundColor DarkGray
    Write-Host (& $c " ") -ForegroundColor DarkGray
    1..3 | % { '' }


Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk" -Force -ErrorAction SilentlyContinue

pause
Write-Host "[ 🚀 ] Downlaoding..."
Get-FileFromWeb -URL "https://github.com/memstechtips/Winhance/releases/latest/download/Winhance.Installer.exe" -File "$env:TEMP\Winhance.Installer.exe"; Start-Process "$env:TEMP\Winhance.Installer.exe"

PAUSE