@echo off
setlocal
set "ps1=%~dp0myscript.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%ps1%" -Name "John" -Age 30
pause
