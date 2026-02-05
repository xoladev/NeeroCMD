::NeeroCMD | Host Script
@echo off

if not defined xChecker exit /b 1

title %xName%
call %xCommandsFolder%cls.bat
call %xCommandsFolder%ncmd.bat

:CMDPass
set /p xCurrentCommand=%xCMDPrefix%
if "%xCurrentCommand%"=="" goto CMDEnd
if exist "%xCommandsFolder%%xCurrentCommand%.bat" (
    goto CMDOpen
) else (
    goto CMDNotFound
)

:CMDNotFound
echo [%xName%] [%date% %time%]: Not valid command: %xCurrentCommand% > "%xDataTransferPath%"
echo "%xCurrentCommand%" %xNotCommandFoundText%
echo.
goto CMDEnd

:CMDOpen
echo [%xName%] [%date% %time%]: Runned command: %xCurrentCommand% > "%xDataTransferPath%"
call "%xCommandsFolder%%xCurrentCommand%.bat"
goto CMDEnd

:CMDEnd
set xCurrentCommand=
goto CMDPass