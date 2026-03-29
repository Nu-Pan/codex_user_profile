---
name: codex-self-improvement
description: Use when improving Codex itself rather than product code, especially when editing `AGENTS.md`, `~/.codex/config.toml`, repo-scoped `.codex/**/*`, this bundle skill, or related `~/.agents/skills/codex-self-improvement-*` component skills. Use for Codex self-improvement workflow orchestration, minimal-harness rules, config responsibility splitting, workflow decomposition into profiles plus bundle/component skills, or Codex/OpenAI docs contract checks. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、この bundle skill、または関連 `~/.agents/skills/codex-self-improvement-*` component skills を追加・変更するとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善するとき
- `~/.codex/config.toml` と repo-scoped `.codex/config.toml` の責務分離を見直すとき
- ユーザーが示した再利用可能な workflow を、新規 profile、束ね skill、役割別 skill に分解して Codex に実装するとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この skill は Codex 自己改善 workflow 全体の入口、推奨フェーズ順、関連 component skill への導線を定義する。
- session 契約の正本は `profiles.codex_meta.developer_instructions` とする。
- repo-wide の入口は `AGENTS.md`、durable settings は `config.toml`、phase-local な詳細ルールは関連 component skills とその `references/` を正本とする。
- workflow を Codex に取り込むときは、session 契約、durable 設定、全体導線、役割別の詳細手順を分解し、どれを profile、束ね skill、役割別 skill に置くかをここから判断する。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、必要なら既存差分を確認する。
2. ルールや設定の置き場所判断が必要なら `codex-self-improvement-placement` を使う。
3. reusable workflow の分解や `developer_instructions` 設計が必要なら `codex-self-improvement-workflow` を使う。
4. 編集前後の checklist、validation、最終報告は `codex-self-improvement-review` で確認する。

- フェーズ順は推奨順序であり、必要に応じて往復してよい。
- Codex 契約や repo から確認できない設定キーの意味を確定する必要がある場合だけ OpenAI developer docs MCP を使う。

## Component skills

- [`codex-self-improvement-placement`](../codex-self-improvement-placement/SKILL.md): `AGENTS.md` / `config.toml` / permissions / MCP / canonical path の置き場所を判断する。
- [`codex-self-improvement-workflow`](../codex-self-improvement-workflow/SKILL.md): reusable workflow を `profile` + `束ね skill` + `役割別 skill` に分解し、`developer_instructions` を設計する。
- [`codex-self-improvement-review`](../codex-self-improvement-review/SKILL.md): checklist、validation、reference への一般化、最終報告を行う。

## Quick start

- `AGENTS.md`、`~/.codex/config.toml`、この skill を確認する。
- まず [`references/orchestration.md`](references/orchestration.md) を見て、今回の task に必要な component skill を選ぶ。
- phase-local な判断基準は、選んだ component skill の `SKILL.md` と `references/` だけを追加で読む。

## Repo path notes

- guidance、最終報告、他のリポジトリから参照される説明で見せる path の正本は `~/.codex/...` / `~/.agents/...` とする。
- `dot_codex/...` / `dot_agents/...` は、HOME 配下設定を mirror した checkout 上で実ファイルを操作するときだけ使う repo 内 path として扱う。
- canonical path とローカル作業 path を混同せず、cross-repo の説明に `dot_codex/...` / `dot_agents/...` を持ち出さない。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - 推奨順序、component skill の選び方、往復条件を確認するときに読む。
