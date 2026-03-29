---
name: codex-self-improvement-workflow
description: Legacy compatibility entrypoint for the old workflow component-skill name. Use when older prompts or docs mention this name. Use for handing off to root skill `codex-self-improvement` and child role `si_design`. Do not use as the canonical source for new self-improvement work.
---

# Codex Self Improvement Workflow

## Use when

- 既存の prompt や文書がこの旧 skill 名を参照しているとき
- reusable workflow の再分解が必要で、canonical な担当 role を知りたいとき

## Purpose

- この legacy skill は旧 component-skill 名から root skill `codex-self-improvement` と child role `si_design` へ handoff する compatibility entrypoint である。
- canonical な workflow decomposition は関連 reference を正本とし、この skill 自体は新規 workflow の正本にはしない。

## Inputs

- workflow の目的、制約、期待する成果物
- 既存 profile、`developer_instructions`、関連 skill の現状
- 必要なら `AGENTS.md` と `config.toml` の既存導線

## Outputs

- `si_design` が返す architecture decision の期待 shape
- root skill と関連 reference への handoff 導線

## Quick start

- 軽量 self-improvement session を使う場合は `codex_meta` profile で root skill 側から開始する。
- まず root skill [`codex-self-improvement`](../codex-self-improvement/SKILL.md) を確認する。
- 次に [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md) を読み、canonical role が `si_design` であることを確認する。
- workflow decomposition rule 自体は [`references/workflow-to-profile-role.md`](references/workflow-to-profile-role.md) を読む。
- `developer_instructions` の責務分離が絡む場合は [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md) も読む。

## Reference map

- [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md)
  - `si_design` の入力と期待出力を確認するときに読む。
- [`references/workflow-to-profile-role.md`](references/workflow-to-profile-role.md)
  - 典型 workflow を新規 profile、root skill、child agent roles、role config、references に分解するときの判断基準、最小テンプレ、文書配置を確認するときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - `developer_instructions` に何を書くか、root skill を入口にして child agent roles をどう逃がすかを決めるときに読む。
