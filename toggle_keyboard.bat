@echo off
:: Check current state of the i8042prt service
for /f "tokens=3" %%a in ('sc qc i8042prt ^| findstr /i "START_TYPE"') do set current=%%a

cls
echo ================================
echo Toggle Built-in Keyboard (i8042prt)
echo ================================
if "%current%"=="2" (
    echo Current Status: ENABLED (start= AUTO)
) else if "%current%"=="4" (
    echo Current Status: DISABLED (start= DISABLED)
) else (
    echo Current Status: UNKNOWN
)
echo ================================
echo 1. Disable built-in keyboard
echo 2. Enable built-in keyboard
echo 3. Exit
echo.

set /p choice="Select an option (1-3): "

if "%choice%"=="1" goto DISABLE
if "%choice%"=="2" goto ENABLE
if "%choice%"=="3" exit
goto MENU

:DISABLE
sc config i8042prt start= disabled
echo Built-in keyboard disabled.
pause
goto MENU

:ENABLE
sc config i8042prt start= auto
echo Built-in keyboard enabled.
pause
goto MENU

:MENU
cls
goto MENU
