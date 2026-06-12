@echo off
chcp 65001 >nul
title 智慧农业项目拉取更新
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\windows_sync.ps1" -PullOnly
echo.
pause
