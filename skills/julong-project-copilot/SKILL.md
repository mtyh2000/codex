---
name: julong-project-copilot
description: Use when working in /Users/mac/Documents/智慧农业 on the 印尼聚龙集团棕榈园智慧农业项目, especially to continue a work session, choose the right branch between 00_总控主线 and 01~05, absorb chat conclusions into durable docs, maintain 更新日志/待办清单/对话归档, and keep outputs aligned with the user's direct Chinese working style and weak-network-first project constraints.
---

# Julong Project Copilot

## When To Use

Use this skill when the user is doing any of the following inside this project:

- 推进一期范围、业务闭环、采样、终端、平台或商务任一板块
- 让你整理新结论到主文档
- 让你把零散讨论沉淀成可同步的项目资料
- 让你判断这次改动是否要更新日志、待办或同步到 GitHub
- 让你按“总控主线 + 5 个板块分支”继续长期协作

Do not use this skill for unrelated通用编程任务。

## Required Reads

Read only the files needed for the current task, in this order:

1. `/Users/mac/Documents/智慧农业/AGENTS.md`
2. `/Users/mac/Documents/智慧农业/README.md`
3. `/Users/mac/Documents/智慧农业/00_总控主线/更新日志.md`
4. `/Users/mac/Documents/智慧农业/00_总控主线/待办清单.md`
5. The active branch document(s) for the current topic
6. If the task comes from scattered discussion, also read:
   - `/Users/mac/Documents/智慧农业/对话归档/README.md`
   - `/Users/mac/Documents/智慧农业/对话归档/99_模板/对话归档模板.md`

## Default Working Style

- Default to Chinese.
- Speak directly and clearly; avoid empty concepts.
- Treat this project as a long-running program, not a one-off document task.
- Prioritize phase-1 closure over long-term smart-agriculture expansion.
- Assume weak connectivity by default; never design critical flows that require full-time online access.
- Distinguish `已确认信息`、`待确认问题`、`建议项/风险点`.
- If numbers such as budget, timeline, accuracy, or hardware specs are not explicitly confirmed, label them as `参考`.
- Any customer-facing content must emphasize business value and闭环能力; any研发-facing content must emphasize字段、流程、接口、算法、设备、运维.

## Branch Map

- `00_总控主线`: 统一口径、阶段判断、结论回收、日志与待办
- `01_业务闭环与一期范围`: 一期边界、角色、闭环流程、做什么/不做什么
- `02_采样与算法验证`: 采样、标注、样本台账、测试口径、准确率验证
- `03_手持终端与现场测试`: 拍照、离线、补传、续航、防护、试用记录
- `04_平台字段与系统对接`: 字段、主数据、图片留存、对账、调度、接口
- `05_商务与实施路径`: 试点、预算、工期、职责边界、风险、汇报口径

If the request spans multiple branches, use `00_总控主线` to decide priority first, then update only the affected branch docs.

## Standard Workflow

### 1. Session Start

- Read the required files.
- Identify the current branch and the exact output target.
- State the working assumption if the input is incomplete.
- Prefer continuing an existing main document over creating a new scattered note.

### 2. Produce Or Update Content

When drafting or revising project docs:

- Keep the result tied to `园区 -> 地块 -> 终端/图片 -> 车辆 -> 工厂 -> 平台`.
- Favor actionable structure over long prose.
- Reuse the project's stable headings when helpful:
  - `已确认信息`
  - `待确认问题`
  - `风险点`
  - `下一步动作`
- Explicitly separate:
  - 一阶段必做
  - 后续扩展
  - 已确认
  - 待确认
  - 参考值

### 3. Decide Where Knowledge Should Land

Use this routing rule:

- If the conclusion changes official project direction, update the relevant main doc directly.
- If the discussion is useful but still intermediate, create or update a file under `对话归档`.
- If the content is one-off or disposable, do not preserve it.

### 4. Archive Scattered Discussion

When a conversation is worth keeping:

- Create one concise Markdown note, not a raw transcript.
- Follow the archive template.
- Include `主题 / 背景 / 关键结论 / 可执行动作 / 是否需要回收进主文档 / 相关文件`.
- If archived, also update `对话归档/对话索引.md`.
- If the archive contains stable conclusions, note which main doc should absorb them next.

### 5. Session Close

Before considering the task complete:

- Check whether `00_总控主线/更新日志.md` needs a new entry.
- Check whether `00_总控主线/待办清单.md` needs a new next action.
- Check whether the change should be synced to GitHub for the other machine.
- Warn about conflict risk if the same high-value file may be edited on both machines.

## Output Rules

- Start from the user's actual question, not from a generic framework.
- Keep recommendations grounded in the confirmed project assumptions from `AGENTS.md`.
- Never promise final commercial commitments unless the user explicitly confirms them.
- When summarizing progress, prefer:
  - what changed
  - what is now clearer
  - what still needs confirmation
  - what should happen next

## Trigger Phrases

This skill should trigger strongly when the user says things like:

- “继续推进这个项目”
- “整理成主文档”
- “回收到总控”
- “更新待办/更新日志”
- “归档这段对话”
- “按我的方式继续做”
- “帮我收敛一期范围/平台字段/采样方案/商务路径”

## Related Reference

For delegated deep-dive review on one branch, read:

- `/Users/mac/Documents/智慧农业/skills/julong-project-copilot/references/topic-review-subagent.md`
