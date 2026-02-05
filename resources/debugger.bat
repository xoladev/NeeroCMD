@echo off
if "%~1"=="" exit
chcp 1251 >nul
title Debugger
set PIPE_FILE=%CD%\temp\NeeroCMD_DbgTransfer.tmp
if exist %PIPE_FILE% (
  del "%PIPE_FILE%" >nul
)
powershell -Command ^
  "Write-Host 'Open: NeeroCMD.lnk to start debugging it!' -f Blue; " ^
  "Write-Host 'Debbuger started. Waiting for any data...' -f Green"

:loop
if exist "%PIPE_FILE%" (
    type %PIPE_FILE%
    del "%PIPE_FILE%" >nul 2>&1
)
goto loop