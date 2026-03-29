---
name: codex-self-improvement-review
description: Use when Codex self-improvement work needs checklist-driven review before or after edits. Use for validation planning, self-review, reference generalization, and final reporting. Do not use for placement decisions or workflow decomposition by itself.
---

# Codex Self Improvement Review

## Use when

- 編集前に確認項目を揃えたいとき
- 編集後に validation、責務分離、一般化判断を点検したいとき
- 最終報告に何を書くべきかを整理したいとき

## Purpose

- この skill は Codex 自己改善タスクの checklist-driven review、validation、reference への一般化、final reporting の判断基準を定義する。
- workflow 全体の導線は bundle skill `codex-self-improvement` を正本とする。

## Inputs

- 変更前の計画または変更後の差分
- 影響を受ける `AGENTS.md`、`config.toml`、skill / reference の現状
- 必要なら validation 実行結果

## Outputs

- 編集前に確認すべき checklist と editable scope
- 編集後に実行すべき validation、self-review、reference への一般化判断
- 最終報告へ載せる変更内容、成立根拠、制約、未解決事項

## Quick start

- bundle skill `codex-self-improvement` を確認する。
- 編集前なら [`references/workflow-checklist.md`](references/workflow-checklist.md) の `Before editing` と `Preferred editable scope` を確認する。
- 編集後なら同じ文書の `Validation`、`Self review`、`Final reporting` を確認する。

## Reference map

- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前の確認、自己レビュー、validation、最終報告、reference への一般化判断を確認するときに読む。
