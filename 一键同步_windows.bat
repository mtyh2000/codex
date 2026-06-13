@echo off
setlocal
chcp 65001 >nul

cd /d "%~dp0"

echo ======================================
echo 智慧农业项目一键同步
echo 当前目录: %cd%
echo ======================================
echo.

git rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 (
  echo 这里不是 Git 仓库，无法同步。
  echo.
  pause
  exit /b 1
)

for /f "delims=" %%i in ('git rev-parse --abbrev-ref HEAD') do set "branch=%%i"

if "%branch%"=="HEAD" (
  echo 当前不在正常分支上，无法自动同步。
  echo.
  pause
  exit /b 1
)

echo 当前分支: %branch%
echo.

git status --porcelain > "%temp%\zhihui_sync_status.txt"
for %%A in ("%temp%\zhihui_sync_status.txt") do set size=%%~zA

if not "%size%"=="0" (
  echo 检测到本机有改动。
  echo 请输入这次同步备注，不想细写就直接回车使用默认说明。
  set /p commit_message=提交说明:

  if "%commit_message%"=="" set "commit_message=双机同步更新"

  echo.
  echo 正在保存本机改动...
  git add -A
  if errorlevel 1 (
    echo 暂存改动失败。
    echo.
    pause
    exit /b 1
  )

  git commit -m "%commit_message%"
  if errorlevel 1 (
    echo 提交改动失败，请检查后再试。
    echo.
    pause
    exit /b 1
  )
) else (
  echo 本机没有未保存的改动。
)

del "%temp%\zhihui_sync_status.txt" >nul 2>nul

echo.
echo 正在拉取远端最新内容...
git pull --rebase origin %branch%
if errorlevel 1 (
  echo.
  echo 拉取时出现冲突或异常。
  echo 请先不要继续点另一台电脑，回来找我处理就行。
  echo.
  pause
  exit /b 1
)

echo.
echo 正在推送到 GitHub...
git push origin %branch%
if errorlevel 1 (
  echo.
  echo 推送失败，请检查网络或权限后再试。
  echo.
  pause
  exit /b 1
)

echo.
echo 同步完成。另一台电脑开始工作前，也点一次它自己的同步脚本即可。
echo.
pause
