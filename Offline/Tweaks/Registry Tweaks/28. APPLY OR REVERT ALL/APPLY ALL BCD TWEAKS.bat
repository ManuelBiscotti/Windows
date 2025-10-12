@echo off

echo.
echo Disabling autotuning...
netsh interface tcp set global autotuninglevel=disabled

echo.
echo Disabling Dynamic Tick...
bcdedit /set disabledynamictick Yes

echo.
echo Applying Platform Tick...
bcdedit /set useplatformtick Yes

echo.
echo Setting TSC Sync Policy to Enhanced...
bcdedit /set tscsyncpolicy Enhanced

echo.
echo All tweaks have been applied.
pause
