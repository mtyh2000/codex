#!/bin/bash

set -u

PROJECT_DIR="/Users/mac/Documents/智慧农业"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -d "$PROJECT_DIR/.git" ]; then
  WORK_DIR="$PROJECT_DIR"
else
  WORK_DIR="$SCRIPT_DIR"
fi

cd "$WORK_DIR" || exit 1

echo "======================================"
echo "智慧农业项目一键同步"
echo "启动位置: $SCRIPT_DIR"
echo "项目目录: $WORK_DIR"
echo "======================================"
echo

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "这里不是 Git 仓库，无法同步。"
  echo
  read -r -p "按回车键退出..."
  exit 1
fi

branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$branch" = "HEAD" ]; then
  echo "当前不在正常分支上，无法自动同步。"
  echo
  read -r -p "按回车键退出..."
  exit 1
fi

echo "当前分支: $branch"
echo

if [ -n "$(git status --porcelain)" ]; then
  echo "检测到本机有改动。"
  echo "请输入这次同步备注，不想细写就直接回车使用默认说明。"
  read -r -p "提交说明: " commit_message

  if [ -z "$commit_message" ]; then
    commit_message="双机同步更新 $(date '+%Y-%m-%d %H:%M')"
  fi

  echo
  echo "正在保存本机改动..."
  if ! git add -A; then
    echo "暂存改动失败。"
    read -r -p "按回车键退出..."
    exit 1
  fi

  if ! git commit -m "$commit_message"; then
    echo "提交改动失败，请检查后再试。"
    read -r -p "按回车键退出..."
    exit 1
  fi
else
  echo "本机没有未保存的改动。"
fi

echo
echo "正在拉取远端最新内容..."
if ! git pull --rebase origin "$branch"; then
  echo
  echo "拉取时出现冲突或异常。"
  echo "请先不要继续点另一台电脑，回来找我处理就行。"
  read -r -p "按回车键退出..."
  exit 1
fi

echo
echo "正在推送到 GitHub..."
if ! git push origin "$branch"; then
  echo
  echo "推送失败，请检查网络或权限后再试。"
  read -r -p "按回车键退出..."
  exit 1
fi

echo
echo "同步完成。另一台电脑开始工作前，也点一次它自己的同步脚本即可。"
echo
read -r -p "按回车键退出..."
