---
name: codex-self-improvement
description: Use when improving Codex itself by editing `AGENTS.md`, `~/.codex/**/*`, repo-scoped `.codex/**/*`, or this skill family. Use as the entry point for route selection across placement, workflow design, prose cleanup, and review. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、この bundle skill、または関連 `~/.agents/skills/codex-self-improvement-*` を追加・変更するとき
- skill family の文面、語彙、責務境界、導線をまとめて見直したいとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善したいとき
- ユーザーが示した reusable workflow を `profile`、`bundle skill`、`component skill` に分解して Codex に取り込みたいとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この bundle skill は Codex 自己改善 workflow の入口であり、route 選定、正本語彙、component skill への handoff を定義する。
- この workflow の session 契約の正本は `profiles.codex_meta.developer_instructions`、repo-wide の入口は `AGENTS.md`、phase-local な詳細は関連 component skills と `references/` とする。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、必要なら既存差分を確認する。
2. [`references/orchestration.md`](references/orchestration.md) で正本語彙と最小 route を確認する。
3. 選んだ route に必要な component skills と `references/` だけを読む。
4. 編集後は `codex-self-improvement-review` で validation と最終報告観点を確認する。

- 既定 route は `codex-self-improvement-skill-writing` -> `codex-self-improvement-review` とする。
- 置き場所判断が要る場合だけ `codex-self-improvement-placement`、workflow 分解や `developer_instructions` 設計が要る場合だけ `codex-self-improvement-workflow` を前に足す。
- bundle skill と component skill 群をまとめて総点検するときは `codex-self-improvement-placement` -> `codex-self-improvement-workflow` -> `codex-self-improvement-skill-writing` -> `codex-self-improvement-review` を既定にする。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Component skills

- [`codex-self-improvement-placement`](../codex-self-improvement-placement/SKILL.md): `AGENTS.md` / `config.toml` / permissions / MCP / canonical path の置き場所を判断する。
- [`codex-self-improvement-workflow`](../codex-self-improvement-workflow/SKILL.md): reusable workflow を `profile`、`bundle skill`、`component skill`、`reference`、durable 設定へ分解する。
- [`codex-self-improvement-skill-writing`](../codex-self-improvement-skill-writing/SKILL.md): skill 文面を簡素化し、正本語彙を揃え、bundle skill / component skill / reference の責務境界を保つ。
- [`codex-self-improvement-review`](../codex-self-improvement-review/SKILL.md): checklist、validation、一般化判断、最終報告観点を確認する。

## Quick start

- `AGENTS.md`、`~/.codex/config.toml`、この bundle skill を確認する。
- [`references/orchestration.md`](references/orchestration.md) の `Route selection` と `Typical routes` を見て route を決める。
- その route に必要な component skills と `references/` だけを読む。

## Repo path notes

- path 表記の正本は `~/.codex/...` / `~/.agents/...` とする。repo 内の実ファイルを触るときだけ `dot_codex/...` / `dot_agents/...` を使う。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - 推奨順序、route の広げ方、正本語彙、往復条件を確認するときに読む。
