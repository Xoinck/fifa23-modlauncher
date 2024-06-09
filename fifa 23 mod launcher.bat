@echo off
cls

REM Set the console to a specific width and height (e.g., 80 characters wide)
mode con: cols=38 lines=20

REM Check if running as administrator
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
:menu
cls

REM Define console width
set /a cols=80

REM Centered text menu
call :printCentered      "======================================"
call :printCentered      "          PVPXD FIFA Launcher      "
call :printCentered      "======================================"
echo.
call :printCentered "1. Launch EA App"
call :printCentered "2. Launch FIFA Mod Manager"
call :printCentered "3. Launch FIFA Live Editor"
call :printCentered "4. Launch FIFA CT"
call :printCentered "5. Launch EA, Mods and Live Editor"
call :printCentered "Q. Quit"
echo.

REM Use choice command to get user input with empty prompt
choice /c 12345q /n /m ""

REM Check user choice
if errorlevel 6 goto quit
if errorlevel 5 goto launchAllOptions
if errorlevel 4 goto launchCheatEngine
if errorlevel 3 goto launchLauncher
if errorlevel 2 goto launchFIFA
if errorlevel 1 goto launchEA

goto menu

:launchEA
cls
call :printCentered "Launching EA app..."

REM Path to the EA app executable
set EAAppPath="C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EADesktop.exe"

REM Check if the EA app executable exists
if exist %EAAppPath% (
    start "" %EAAppPath%
    call :printCentered "EA app launched successfully."
) else (
    call :printCentered "EA app executable not found at %EAAppPath%."
)

goto menu

:launchFIFA
cls
call :printCentered "Searching for FIFA Mod Manager..."

REM Search for FIFA Mod Manager executable in C: drive
dir /b /s "C:\FIFA Mod Manager.exe" > "%temp%\fifa_mod_manager_path.txt"
set /p FIFAAppPath=<"%temp%\fifa_mod_manager_path.txt"

if not "%FIFAAppPath%"=="" (
    start "" "%FIFAAppPath%"
    call :printCentered "FIFA Mod Manager launched successfully."
) else (
    call :printCentered "FIFA Mod Manager not found on the system."
)

REM Clean up temporary file
del "%temp%\fifa_mod_manager_path.txt" > nul 2>&1

goto menu

:launchLauncher
cls
call :printCentered "Searching for Launcher..."

REM Search for Launcher executable in C: drive
dir /b /s "C:\Launcher.exe" > "%temp%\launcher_path.txt"
set /p LauncherAppPath=<"%temp%\launcher_path.txt"

if not "%LauncherAppPath%"=="" (
    start "" "%LauncherAppPath%"
    call :printCentered "Launcher launched successfully."
) else (
    call :printCentered "Launcher not found on the system."
)

REM Clean up temporary file
del "%temp%\launcher_path.txt" > nul 2>&1

goto menu

:launchCheatEngine
cls
call :printCentered "Searching for Cheat Engine Tables..."

REM Search for Cheat Engine tables in C: drive
for /r "C:\" %%i in (*fifa*.cetrainer) do (
    call :printCentered "Launching Cheat Engine table..."
    start "" "%%i"
    call :printCentered "Cheat Engine table launched successfully."
    goto launchSuccess
)

call :printCentered "No Cheat Engine tables with 'fifa' in the name found."
goto menu

:launchAllOptions
call :printCentered "Launching all options..."

REM Launching EA App
start "" "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EADesktop.exe"

REM Launching FIFA Mod Manager
dir /b /s "C:\FIFA Mod Manager.exe" > "%temp%\fifa_mod_manager_path.txt"
set /p FIFAAppPath=<"%temp%\fifa_mod_manager_path.txt"

if not "%FIFAAppPath%"=="" (
    start "" "%FIFAAppPath%"
    call :printCentered "FIFA Mod Manager launched successfully."
) else (
    call :printCentered "FIFA Mod Manager not found on the system."
)

REM Clean up temporary file
del "%temp%\fifa_mod_manager_path.txt" > nul 2>&1

REM Launching Launcher
dir /b /s "C:\Launcher.exe" > "%temp%\launcher_path.txt"
set /p LauncherAppPath=<"%temp%\launcher_path.txt"

if not "%LauncherAppPath%"=="" (
    start "" "%LauncherAppPath%"
    call :printCentered "Launcher launched successfully."
) else (
    call :printCentered "Launcher not found on the system."
)

REM Clean up temporary file
del "%temp%\launcher_path.txt" > nul 2>&1
)

goto menu

:quit
cls
call :printCentered "Exiting EA App Launcher."
timeout /t 2 > nul
exit

REM Function to print centered text
:printCentered
setlocal enabledelayedexpansion
set "text=%~1"

REM Calculate the length of the text
call :strlen text textLength

REM Calculate the padding for centered text
set /a padLength = (cols - textLength) / 2

REM Generate padding spaces
set "spaces="
for /L %%i in (1,1,%padLength%) do set "spaces=!spaces! "

REM Print the padded, centered text
echo !spaces!!text!
endlocal
goto :eof

REM Function to get the length of a string (batch workaround)
:strlen
setlocal enabledelayedexpansion
set "str=%~1"
set "len=0"
for /L %%A in (0,1,79) do (
    if "!str:~%%A,1!" neq "" (
        set /a len+=1
    ) else (
        goto done
    )
)
:done
endlocal & set "%~2=%len%"
goto :eof
