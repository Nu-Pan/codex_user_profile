---
name: codex-self-improvement-workflow
description: Use when Codex self-improvement work needs to decompose a reusable workflow into a profile, a bundle skill, and component skills. Use for `developer_instructions` design, workflow routing, and reusable skill structure. Do not use for config placement alone, skill wording simplification alone, or for final reporting alone.
---

# Codex Self Improvement Workflow

## Use when

- ユーザーが示した再利用可能な workflow を profile と skill 群へ分解したいとき
- `developer_instructions` に何を残し、bundle/component skills と `references/` に何を逃がすかを決めたいとき
- must-read、推奨フェーズ順、skill 間の責務分離を設計したいとき

## Purpose

- この skill は reusable workflow を `profile`、`束ね skill`、`役割別 skill` に分解するための詳細手順と判断基準を定義する。
- workflow 全体の導線は bundle skill `codex-self-improvement` を正本とする。

## Inputs

- workflow の目的、制約、期待する成果物
- 既存 profile、`developer_instructions`、関連 skill の現状
- 必要なら `AGENTS.md` と `config.toml` の既存導線

## Outputs

- profile / bundle skill / component skills の構成案
- `developer_instructions` の最小契約
- reference の置き場所、must-read、validation 観点

## Quick start

- bundle skill `codex-self-improvement` を確認する。
- まず [`references/workflow-to-profile-skill.md`](references/workflow-to-profile-skill.md) で分解方針を確認し、`developer_instructions` の文面が絡む場合は [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md) も読む。
- skill の責務分離は固まっていて文面だけを整えたい task は `codex-self-improvement-skill-writing` へ渡す。

## Reference map

- [`references/workflow-to-profile-skill.md`](references/workflow-to-profile-skill.md)
  - 典型 workflow を新規 profile、bundle skill、component skills に分解するときの判断基準、最小テンプレ、文書配置を確認するときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - `developer_instructions` に何を書くか、bundle skill を入口にして component skills をどう逃がすかを決めるときに読む。
