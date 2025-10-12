@echo off

echo.
echo Reverting autotuning to default...
netsh interface tcp set global autotuninglevel=normal

echo.
echo Reverting disabledynamictick to default...
bcdedit /deletevalue disabledynamictick

echo.
echo Reverting useplatformtick to default...
bcdedit /deletevalue useplatformtick

echo.
echo Reverting tscsyncpolicy to default...
bcdedit /deletevalue tscsyncpolicy

echo.
echo All settings have been reverted to default.
pause
