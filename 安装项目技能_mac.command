#!/bin/bash

set -u

PROJECT_DIR="/Users/mac/Documents/智慧农业"
SKILL_NAME="julong-project-copilot"
SOURCE_DIR="$PROJECT_DIR/skills/$SKILL_NAME"
TARGET_ROOT="$HOME/.codex/skills"
TARGET_DIR="$TARGET_ROOT/$SKILL_NAME"

echo "======================================"
echo "安装/更新 聚龙项目 Skill"
echo "项目目录: $PROJECT_DIR"
echo "技能来源: $SOURCE_DIR"
echo "安装位置: $TARGET_DIR"
echo "======================================"
echo

if [ ! -d "$SOURCE_DIR" ]; then
  echo "没有找到项目 Skill 目录，无法安装。"
  echo
  read -r -p "按回车键退出..."
  exit 1
fi

mkdir -p "$TARGET_ROOT"
mkdir -p "$TARGET_DIR"

if command -v rsync >/dev/null 2>&1; then
  if ! rsync -a --delete "$SOURCE_DIR/" "$TARGET_DIR/"; then
    echo
    echo "Skill 安装失败，请检查文件权限后再试。"
    echo
    read -r -p "按回车键退出..."
    exit 1
  fi
else
  rm -rf "$TARGET_DIR"
  mkdir -p "$TARGET_DIR"
  if ! cp -R "$SOURCE_DIR/"* "$TARGET_DIR/"; then
    echo
    echo "Skill 安装失败，请检查文件权限后再试。"
    echo
    read -r -p "按回车键退出..."
    exit 1
  fi
fi

echo
echo "Skill 已安装/更新完成。"
echo "如果 Codex 已经开着，建议关闭后重新打开一次。"
echo
read -r -p "按回车键退出..."
