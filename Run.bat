@echo off
:: Batch file to run Win11Debloat.ps1 as admin with multiple parameters
powershell -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0nuovo2.ps1\" -full' -Verb RunAs"

pause