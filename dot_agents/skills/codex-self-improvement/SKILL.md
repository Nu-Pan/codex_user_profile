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

## Goal

- Codex 自己改善の最小ハーネスだけを定義する。
- repo-wide の入口は `AGENTS.md`、durable settings は `config.toml`、詳細ルールは `references/` に分離する。
- この `SKILL.md` には、着手条件と参照先の案内だけを残す。

## Quick start

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象ファイルを先に確認する。
2. repo-scoped `.codex/config.toml` や `.codex/**/*` がある場合だけ、追加で確認する。
3. 変更対象に既存の未コミット差分がある場合は、編集前に必ず内容を確認する。
4. 次のうち必要な参照文書だけを読む。
5. ユーザーの明示的な許可がない限り、最小スコープの変更にとどめる。
6. repo から確認できない契約や設定キーの意味を確認する必要がある場合だけ OpenAI developer docs MCP を使う。

## Editing scope

- 主な編集対象は `AGENTS.md`、`~/.codex/config.toml`、存在する場合の repo-scoped `.codex/**/*`、`~/.agents/skills/codex-self-improvement/**/*` とその参照文書である。
- プロダクトコード、テスト、依存関係、周辺自動化は、明示依頼がない限り対象外とする。

## Reference map

- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - ルールの置き場所、`config.toml` / permissions / MCP / `AGENTS.md` の責務分離で迷ったときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - `developer_instructions` を新設・改訂するときに読む。
- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前の確認、自己レビュー、最終報告の項目を確認するときに読む。

## OpenAI docs MCP

- repo から確認できる事実は先に回収する。
- Codex CLI、設定キー、`developer_instructions`、permissions の意味を repo だけでは確定できないときだけ使う。
- repo-wide の OpenAI developer docs MCP 利用ルールが `AGENTS.md` にある場合は、それを正本とする。
- 記憶だけで設定キーや契約を断定しない。

## Final reporting

- 最終報告では、変更内容、最小ハーネスとして成立する根拠、実行した確認、残っている制約や未解決事項を述べる。
- `AGENTS.md`、`~/.codex/config.toml`、存在する場合の repo-scoped `.codex/config.toml`、この skill の間に矛盾があれば明記する。
