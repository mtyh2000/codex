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
echo "智慧农业项目收工检查"
echo "项目目录: $WORK_DIR"
echo "======================================"
echo

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "这里不是 Git 仓库，无法继续检查。"
  echo
  read -r -p "按回车键退出..."
  exit 1
fi

status_output="$(git status --porcelain)"

if [ -z "$status_output" ]; then
  echo "当前没有未提交改动。"
  echo "如果只是想同步另一台电脑，可以直接点一键同步脚本。"
  echo
  read -r -p "是否现在打开一键同步？[y/N] " open_sync
  if [[ "$open_sync" =~ ^[Yy]$ ]]; then
    "$WORK_DIR/一键同步_mac.command"
  fi
  exit 0
fi

echo "检测到以下未提交改动："
echo "$status_output"
echo

needs_log="yes"
needs_todo="yes"

while IFS= read -r line; do
  path="${line#?? }"

  if [ "$path" = "00_总控主线/更新日志.md" ]; then
    needs_log="no"
  fi

  if [ "$path" = "00_总控主线/待办清单.md" ]; then
    needs_todo="no"
  fi
done <<< "$status_output"

echo "收工提醒："

if [ "$needs_log" = "yes" ]; then
  echo "- 你这轮有改动，但还没看到 更新日志.md 的同步记录。"
fi

if [ "$needs_todo" = "yes" ]; then
  echo "- 如果下一步动作已经变化，记得看看 待办清单.md 是否需要更新。"
fi

echo "- 如果这轮讨论产出了稳定结论，记得判断是否要回收到主文档。"
echo "- 如果只是中间讨论但值得保留，记得放入 对话归档。"
echo "- 如果另一台电脑也可能改同一文件，先确认是否存在冲突风险。"
echo

read -r -p "是否现在打开一键同步？[y/N] " open_sync
if [[ "$open_sync" =~ ^[Yy]$ ]]; then
  "$WORK_DIR/一键同步_mac.command"
fi

echo
read -r -p "按回车键退出..."
