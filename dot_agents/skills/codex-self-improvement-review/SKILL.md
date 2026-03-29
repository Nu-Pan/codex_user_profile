---
name: codex-self-improvement-review
description: Legacy compatibility entrypoint for the old review component-skill name. Use when older prompts or docs mention this name. Use for handing off to root skill `codex-self-improvement` and child role `si_audit`. Do not use as the canonical source for new self-improvement work.
---

# Codex Self Improvement Review

## Use when

- 既存の prompt や文書がこの旧 skill 名を参照しているとき
- validation、責務分離、最終報告観点の canonical な担当 role を知りたいとき

## Purpose

- この legacy skill は旧 component-skill 名から root skill `codex-self-improvement` と child role `si_audit` へ handoff する compatibility entrypoint である。
- canonical な review / validation rule は関連 reference を正本とし、この skill 自体は新規 workflow の正本にはしない。

## Inputs

- 変更前の計画または変更後の差分
- 影響を受ける `AGENTS.md`、`config.toml`、skill / reference の現状
- 必要なら validation 実行結果

## Outputs

- `si_audit` が返す findings、validation、残余リスクの期待 shape
- root skill と関連 reference への handoff 導線

## Quick start

- 軽量 self-improvement session を使う場合は `codex_meta` profile で root skill 側から開始する。
- まず root skill [`codex-self-improvement`](../codex-self-improvement/SKILL.md) を確認する。
- 次に [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md) を読み、canonical role が `si_audit` であることを確認する。
- review rule 自体は [`references/workflow-checklist.md`](references/workflow-checklist.md) を読む。

## Reference map

- [`../codex-self-improvement/references/role-contracts.md`](../codex-self-improvement/references/role-contracts.md)
  - `si_audit` の入力と期待出力を確認するときに読む。
- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前の確認、自己レビュー、validation、最終報告、reference への一般化判断を確認するときに読む。
