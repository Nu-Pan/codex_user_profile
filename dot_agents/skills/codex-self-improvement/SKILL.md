---
name: codex-self-improvement
description: Use when improving Codex itself rather than product code, especially when editing `AGENTS.md`, `~/.codex/config.toml`, repo-scoped `.codex/**/*`, or `~/.agents/skills/codex-self-improvement/**/*`. Use for Codex self-improvement tasks that need minimal-harness rules, config responsibility splitting, or Codex/OpenAI docs contract checks. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、または `~/.agents/skills/codex-self-improvement/**/*` を追加・変更するとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善するとき
- `~/.codex/config.toml` と repo-scoped `.codex/config.toml` の責務分離を見直すとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この skill は Codex 自己改善タスクの入口だけを定義する。
- repo-wide の入口は `AGENTS.md`、durable settings は `config.toml`、詳細ルールと手順は `references/` を正本とする。
- 実施前に `AGENTS.md`、`~/.codex/config.toml`、変更対象を確認し、必要な参照文書だけ読む。

## Reference map

- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - ルールの置き場所、`config.toml` / permissions / MCP / `AGENTS.md` の責務分離で迷ったときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - `developer_instructions` を新設・改訂するときに読む。
- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前の確認、自己レビュー、最終報告、OpenAI developer docs MCP を使う条件を確認するときに読む。
