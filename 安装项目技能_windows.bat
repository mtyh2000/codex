@echo off
setlocal
chcp 65001 >nul

set "PROJECT_DIR=%~dp0"
if "%PROJECT_DIR:~-1%"=="\" set "PROJECT_DIR=%PROJECT_DIR:~0,-1%"

set "SKILL_NAME=julong-project-copilot"
set "SOURCE_DIR=%PROJECT_DIR%\skills\%SKILL_NAME%"
set "TARGET_ROOT=%USERPROFILE%\.codex\skills"
set "TARGET_DIR=%TARGET_ROOT%\%SKILL_NAME%"

echo ======================================
echo 安装/更新 聚龙项目 Skill
echo 项目目录: %PROJECT_DIR%
echo 技能来源: %SOURCE_DIR%
echo 安装位置: %TARGET_DIR%
echo ======================================
echo.

if not exist "%SOURCE_DIR%" (
  echo 没有找到项目 Skill 目录，无法安装。
  echo.
  pause
  exit /b 1
)

if not exist "%TARGET_ROOT%" mkdir "%TARGET_ROOT%"
if exist "%TARGET_DIR%" rmdir /s /q "%TARGET_DIR%"

robocopy "%SOURCE_DIR%" "%TARGET_DIR%" /E >nul
if errorlevel 8 (
  echo Skill 安装失败，请检查文件权限后再试。
  echo.
  pause
  exit /b 1
)

echo.
echo Skill 已安装/更新完成。
echo 如果 Codex 已经开着，建议关闭后重新打开一次。
echo.
pause
