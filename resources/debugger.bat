@echo off
setlocal EnableExtensions
title Debugger

set "PIPE_FILE=%~dp0temp\NeeroCMD_DbgTransfer.tmp"

if not exist "%~dp0temp\" mkdir "%~dp0temp\" 2>nul
if exist "%PIPE_FILE%" del /f /q "%PIPE_FILE%" >nul 2>&1

powershell -NoProfile -Command ^
  "Write-Host 'Open NeeroCMD.lnk to start the shell.' -ForegroundColor Blue; " ^
  "Write-Host 'Debugger started. Waiting for log data...' -ForegroundColor Green"

:loop
if exist "%PIPE_FILE%" (
    type "%PIPE_FILE%"
    del /f /q "%PIPE_FILE%" >nul 2>&1
)
timeout /t 1 /nobreak >nul
goto loop
