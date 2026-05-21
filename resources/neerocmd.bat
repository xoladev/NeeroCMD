::NeeroCMD | Host Script
@echo off

if not defined xChecker exit /b 1

title %xName%
call "%xCommandsFolder%cls.bat"
call "%xCommandsFolder%ncmd.bat"

:CMDPass
set "xCurrentCommand="
set "xCommandArgs="
set "xInputLine="
set /p "xInputLine=%xCMDPrefix%"
if errorlevel 1 goto CMDShutdown
if not defined xInputLine goto CMDEnd

for /f "tokens=1*" %%A in ("%xInputLine%") do (
    set "xCurrentCommand=%%A"
    set "xCommandArgs=%%B"
)

if not defined xCurrentCommand goto CMDEnd

if /i "%xCurrentCommand%"=="exit" goto CMDShutdown
if /i "%xCurrentCommand%"=="quit" goto CMDShutdown

echo %xCurrentCommand%| findstr /r /x "[A-Za-z0-9_][A-Za-z0-9_]*" >nul
if errorlevel 1 goto CMDInvalidName

if not exist "%xCommandsFolder%%xCurrentCommand%.bat" goto CMDNotFound

:CMDOpen
echo [%xName%] [%date% %time%]: Run command: %xCurrentCommand% > "%xDataTransferPath%"
call "%xCommandsFolder%%xCurrentCommand%.bat" %xCommandArgs%
if defined xShouldExit goto CMDShutdown
goto CMDEnd

:CMDInvalidName
echo [%xName%] [%date% %time%]: Invalid command name: %xCurrentCommand% > "%xDataTransferPath%"
echo "%xCurrentCommand%" %xNotCommandFoundText%
echo.
goto CMDEnd

:CMDNotFound
echo [%xName%] [%date% %time%]: Not valid command: %xCurrentCommand% > "%xDataTransferPath%"
echo "%xCurrentCommand%" %xNotCommandFoundText%
echo.
goto CMDEnd

:CMDShutdown
echo [%xName%] [%date% %time%]: Session ended > "%xDataTransferPath%"
exit /b 0

:CMDEnd
set "xCurrentCommand="
set "xCommandArgs="
goto CMDPass
