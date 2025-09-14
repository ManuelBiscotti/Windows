if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent(
    )).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

[CmdletBinding(SupportsShouldProcess=$true)]
param (
    [switch]$UninstallOneDrive,
    [switch]$RemoveEdge,
    [switch]$RunWPD
)

function Uninstall-OneDrive {
    & { iex (irm 'https://asheroto.com/uninstallonedrive') } *> $null
}

function Remove-Edge {
    & { iex "&{$(irm 'https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1')} -UninstallEdge -RemoveEdgeData -NonInteractive -Wait" } *> $null
}

function Run-WPD {
    $zip = Join-Path $env:TEMP 'latest.zip'
    iwr 'https://wpd.app/get/latest.zip' -OutFile $zip
    Expand-Archive $zip -DestinationPath $env:TEMP -Force
    Start-Process (Join-Path $env:TEMP 'WPD.exe') -ArgumentList '-wfpOnly','-wfp on','-recommended','-close' -Wait
}

if (-not ($UninstallOneDrive -or $RemoveEdge -or $RunWPD)) {
    Write-Output 'No switches selected. Exiting.'
    return
}

if ($UninstallOneDrive) {
    if ($PSCmdlet.ShouldProcess('OneDrive','Uninstall OneDrive')) {
        Uninstall-OneDrive
    }
}

if ($RemoveEdge) {
    if ($PSCmdlet.ShouldProcess('Edge','Remove Edge')) {
        Remove-Edge
    }
}

if ($RunWPD) {
    if ($PSCmdlet.ShouldProcess('WPD','Run Windows Privacy Dashboard')) {
        Run-WPD
    }
}

Write-Output 'Completed.'
