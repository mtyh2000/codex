@echo off
setlocal enabledelayedexpansion

set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"

echo ======================================
echo 智慧农业项目收工检查
echo 项目目录: %PROJECT_DIR%
echo ======================================
echo.

git rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 (
  echo 这里不是 Git 仓库，无法继续检查。
  echo.
  pause
  exit /b 1
)

set "HAS_CHANGES="
for /f "delims=" %%i in ('git status --porcelain') do (
  set "HAS_CHANGES=1"
)

if not defined HAS_CHANGES (
  echo 当前没有未提交改动。
  echo 如果只是想同步另一台电脑，可以直接点一键同步脚本。
  echo.
  set /p OPEN_SYNC=是否现在打开一键同步？[y/N] 
  if /i "%OPEN_SYNC%"=="y" call "%PROJECT_DIR%一键同步_windows.bat"
  pause
  exit /b 0
)

echo 检测到以下未提交改动：
git status --porcelain
echo.

set "NEEDS_LOG=yes"
set "NEEDS_TODO=yes"

for /f "tokens=1,* delims= " %%a in ('git status --porcelain') do (
  set "PATH_PART=%%b"
  if "!PATH_PART!"=="00_总控主线/更新日志.md" set "NEEDS_LOG=no"
  if "!PATH_PART!"=="00_总控主线/待办清单.md" set "NEEDS_TODO=no"
)

echo 收工提醒：
if "%NEEDS_LOG%"=="yes" echo - 你这轮有改动，但还没看到 更新日志.md 的同步记录。
if "%NEEDS_TODO%"=="yes" echo - 如果下一步动作已经变化，记得看看 待办清单.md 是否需要更新。
echo - 如果这轮讨论产出了稳定结论，记得判断是否要回收到主文档。
echo - 如果只是中间讨论但值得保留，记得放入 对话归档。
echo - 如果另一台电脑也可能改同一文件，先确认是否存在冲突风险。
echo.

set /p OPEN_SYNC=是否现在打开一键同步？[y/N] 
if /i "%OPEN_SYNC%"=="y" call "%PROJECT_DIR%一键同步_windows.bat"

pause
