---
name: codex-self-improvement-review
description: Use when Codex self-improvement work needs checklist-driven review before or after edits. Use for validation planning, reference generalization, self-review, and final reporting. Do not use for placement decisions or workflow decomposition by itself.
---

# Codex Self Improvement Review

## Use when

- 編集前に確認項目を揃えたいとき
- 編集後に validation、責務分離、一般化判断を点検したいとき
- 最終報告に何を書くべきかを整理したいとき

## Purpose

- この skill は Codex 自己改善タスクの checklist、validation、self review、final reporting の判断基準を定義する。
- workflow 全体の導線は bundle skill `codex-self-improvement` を正本とする。

## Inputs

- 変更前の計画または変更後の差分
- 影響を受ける `AGENTS.md`、`config.toml`、skill / reference の現状
- 必要なら validation 実行結果

## Outputs

- 編集前後に確認すべき checklist
- 実行すべき validation とその観点
- 最終報告へ載せる変更内容、制約、未解決事項

## Quick start

- bundle skill `codex-self-improvement` を確認する。
- まず [`references/workflow-checklist.md`](references/workflow-checklist.md) を読み、今回の task で必要な validation と reporting items を確定する。

## Reference map

- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前の確認、自己レビュー、validation、最終報告、reference への一般化判断を確認するときに読む。
