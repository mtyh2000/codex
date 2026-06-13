@echo off
chcp 65001 >nul
title 智慧农业项目一键同步
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\windows_sync.ps1"
echo.
pause
