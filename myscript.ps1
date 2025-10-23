$utf8 = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding = $utf8
if ($PSVersionTable.PSEdition -ne 'Core') { chcp 65001 > $null }

$asciiHeader = @"
███████╗██████╗  █████╗ ██████╗ ██╗  ██╗██╗     ███████╗
██╔════╝██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██║     ██╔════╝
███████╗██████╔╝███████║██████╔╝█████╔╝ ██║     █████╗  
╚════██║██╔═══╝ ██╔══██║██╔══██╗██╔═██╗ ██║     ██╔══╝  
███████║██║     ██║  ██║██║  ██║██║  ██╗███████╗███████╗
╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
"@
Write-Host $asciiHeader -ForegroundColor Cyan

PAUSE