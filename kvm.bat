title 正在进行wim映像部署......
REM Ensure vmcompute.exe is running
wsl.exe -e true
REM Listen for and Intercept utility vm creation
start Windbgx.exe -pn vmcompute.exe -c "bp vmcompute!Marshal::JsonParser::JsonParser;g;.scriptrun %CD%\script.js;.scriptrun %CD%\script.js;.scriptrun %CD%\script.js;.detach;qq"
REM Ensure WSL Utility VM is not running (hopefully windb starts up fast enough...)
net stop LxssManager
net start LxssManager
echo "Press Enter if the debugger is running"
pause
REM Start WSL