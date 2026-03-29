---
name: codex-self-improvement-placement
description: Legacy compatibility entrypoint for the old placement component-skill name. Use when older prompts or docs mention this name. Use for handing off to root skill `codex-self-improvement` and child role `si_scope`. Do not use as the canonical source for new self-improvement work.
---

# Codex Self Improvement Placement

## Use when

- 既存の prompt や文書がこの旧 skill 名を参照しているとき
- placement、canonical path、session 契約の置き場所判断が必要で、canonical な担当 role を知りたいとき

## Purpose

- この legacy skill は旧 component-skill 名から root skill `codex-self-improvement` と child role `si_scope` へ handoff する compatibility entrypoint である。
- canonical な placement rule 自体は関連 reference を正本とし、この skill 自体は新規 workflow の正本にはしない。

## Inputs

- 変更したい rule、設定、または workflow 上の要件
- 現在の `AGENTS.md`、`config.toml`、対象 skill / reference の状態
- 必要なら既存の未コミット差分

## Outputs

- `si_scope` が返す placement decision の期待 shape
- root skill と関連 reference への handoff 導線

## Quick start

- 軽量 self-improvement session を使う場合は `codex_meta` profile で root skill 側から開始する。
- まず root skill [`codex-self-improvement`](../codex-self-improvement/SKILL.md) を確認する。
- 次に [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md) を読み、canonical role が `si_scope` であることを確認する。
- placement rule 自体は [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) を読む。

## Reference map

- [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md)
  - `si_scope` の入力と期待出力を確認するときに読む。
- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - path 表記の canonical rule、`AGENTS.md` / `developer_instructions` / `config.toml` / permissions / MCP の責務分離で迷ったときに読む。
