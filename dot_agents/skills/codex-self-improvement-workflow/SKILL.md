---
name: codex-self-improvement-workflow
description: Use when Codex self-improvement work needs to decompose a reusable workflow into a profile, a bundle skill, component skills, references, and durable settings. Use for `developer_instructions` design and workflow routing. Do not use for placement decisions alone, simple wording cleanup, or final reporting alone.
---

# Codex Self Improvement Workflow

## Use when

- ユーザーが示した再利用可能な workflow を `profile`、`bundle skill`、`component skill` へ分解したいとき
- `developer_instructions` に何を残し、`bundle skill`、`component skills`、`references/` に何を逃がすかを決めたいとき
- must-read、推奨フェーズ順、skill 間の責務分離を設計したいとき

## Purpose

- この skill は reusable workflow を `profile`、`bundle skill`、`component skill`、`reference`、durable 設定に分解する判断基準を定義する。
- workflow 全体の導線は bundle skill `codex-self-improvement` を正本とする。

## Inputs

- workflow の目的、制約、期待する成果物
- 既存 profile、`developer_instructions`、関連 skill の現状
- 必要なら `AGENTS.md` と `config.toml` の既存導線

## Outputs

- `developer_instructions` に残す session 契約の最小集合
- bundle skill / component skill / `references/` / durable 設定への切り分け
- must-read、推奨フェーズ順、validation 観点

## Quick start

- bundle skill `codex-self-improvement` と変更対象を確認する。
- file placement が曖昧なら、先に `codex-self-improvement-placement` を使う。
- まず [`references/workflow-to-profile-skill.md`](references/workflow-to-profile-skill.md) で workflow を session 契約、bundle skill、component skill、reference、durable 設定へ切り分ける。
- `developer_instructions` の文面が絡む場合は [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md) も読む。
- skill の責務分離は固まっていて文面だけを整えたい task は `codex-self-improvement-skill-writing` へ渡す。

## Reference map

- [`references/workflow-to-profile-skill.md`](references/workflow-to-profile-skill.md)
  - 典型 workflow を新規 profile、bundle skill、component skills に分解するときの判断基準、最小テンプレ、文書配置を確認するときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - `developer_instructions` に何を書くか、bundle skill を入口にして component skills をどう逃がすかを決めるときに読む。
