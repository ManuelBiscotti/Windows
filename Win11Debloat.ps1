#Requires -RunAsAdministrator

[CmdletBinding()]
param (
    [switch]$UninstallOneDrive,
    [switch]$RemoveEdge,
    [switch]$RunWPD
)

# Uninstall OneDrive
if ($UninstallOneDrive) {
    Write-Output "Uninstalling OneDrive..."
    irm asheroto.com/uninstallonedrive | iex *> $null
}

# Remove Edge
if ($RemoveEdge) {
    Write-Output "Removing Microsoft Edge..."
    iex "&{$(irm https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1)} -UninstallEdge -RemoveEdgeData -NonInteractive -Wait"
}

# Run Windows Privacy Dashboard
if ($RunWPD) {
    Write-Output "Running Windows Privacy Dashboard..."
    iwr "https://wpd.app/get/latest.zip" -OutFile "$env:TEMP\latest.zip"
    Expand-Archive "$env:TEMP\latest.zip" -DestinationPath "$env:TEMP" -Force
    Start-Process "$env:TEMP\WPD.exe" -ArgumentList "-wfpOnly","-wfp on","-recommended","-close" -Wait
}

Write-Output "Script execution completed."


