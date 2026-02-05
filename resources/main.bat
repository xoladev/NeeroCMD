::NeeroCMD | Main Script

@echo off

if "%~1"=="" exit
title Loading...

set xName=NeeroCMD
set xDeveloper=External
set xCMDPrefix="%xName%> "
set xCurrentCommand=
set xCommandsFolder="%CD%\commands\"
set xChecker=1
set xNotCommandFoundText=is not an internal or external command, executable program or batch file.
set xDataTransferPath=%CD%\temp\NeeroCMD_DbgTransfer.tmp
set xHelper = %CD%\helper.exe
set xMsgPath="msg.vbs"
set xSettingsPath="..\settings.json"
set xMsgIconError=16
set xMsgIconQuestion=32
set xMsgIconWarn=48
set xMsgIconInfo=64

if not exist %xSettingsPath% (
    echo [%xName%] [%date% %time%]: 'settings.json' not found! > "%xDataTransferPath%"
    wscript %xMsgPath% %xName% "'settings.json' not found!" %xMsgIconError%
    goto END
)

for /f "delims=" %%T in ('powershell -command ^
    "$content = Get-Content -Raw \"..\settings.json\";" ^
    "$cleaned = $content -replace '\s*//.*', '';" ^
    "$cleaned | ConvertFrom-Json | Select-Object -ExpandProperty Theme"') do (
    set "xCurrentTheme=%%T"
)

if "%xCurrentTheme%"=="Black" (
    color 0f
) else if "%xCurrentTheme%"=="White" (
    color f0
) else (
    color 0f
    echo [%xName%] [%date% %time%]: Unknown theme, using default: Black > "%xDataTransferPath%"
    wscript %xMsgPath% %xName% "Unknown theme, using default: Black" %xMsgIconWarn%
)

cls
echo [%xName%] [%date% %time%]: Launching main module, Theme: %xCurrentTheme% > "%xDataTransferPath%"
call neerocmd.bat
:END
exit