@echo off
setlocal
chcp 65001 >nul
set "ps1=%~dp0myscript.ps1"
powershell -NoProfile -ExecutionPolicy Bypass ^
  -Command "[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; [Console]::InputEncoding=[System.Text.Encoding]::UTF8; & '%ps1%'"
pause
