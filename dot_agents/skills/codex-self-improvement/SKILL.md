---
name: codex-self-improvement
description: Use when improving Codex itself rather than product code, especially when editing `AGENTS.md`, `~/.codex/**/*`, repo-scoped `.codex/**/*`, this bundle skill, its related component skills, or related workflow settings. Use as the entry point for route selection, wording cleanup, terminology normalization, placement decisions, workflow decomposition, and Codex/OpenAI docs contract checks. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、この bundle skill、または関連 `~/.agents/skills/codex-self-improvement-*` の component skills を追加・変更するとき
- skill 文面を、責務を変えずに短く直接的な表現へ整えたいとき
- 同じ概念に複数の呼び方が混在しており、bundle skill / component skills / `references/` を通して正本語彙へ揃えたいとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善したいとき
- ユーザーが示した reusable workflow を `profile`、`bundle skill`、`component skill` に分解して Codex に取り込みたいとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この bundle skill は Codex 自己改善 workflow の入口であり、route 選定、正本語彙、component skill への導線を定義する。
- session 契約の正本は `profiles.codex_meta.developer_instructions`、repo-wide の入口は `AGENTS.md`、phase-local な詳細は関連 component skills と `references/` とする。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、必要なら既存差分を確認する。
2. [`references/orchestration.md`](references/orchestration.md) で正本語彙を合わせ、最小 route を 1 つ選ぶ。
3. 選んだ route に必要な component skills と `references/` だけを読む。
4. 編集後は `codex-self-improvement-review` で validation と最終報告観点を確認する。

- route を広げるのは、置き場所判断が要るときの `codex-self-improvement-placement` と、workflow 分解や `developer_instructions` 設計が要るときの `codex-self-improvement-workflow` だけに留める。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Component skills

- [`codex-self-improvement-placement`](../codex-self-improvement-placement/SKILL.md): `AGENTS.md` / `config.toml` / permissions / MCP / canonical path の置き場所を判断する。
- [`codex-self-improvement-workflow`](../codex-self-improvement-workflow/SKILL.md): reusable workflow を `profile` + `bundle skill` + `component skill` に分解し、`developer_instructions` を設計する。
- [`codex-self-improvement-skill-writing`](../codex-self-improvement-skill-writing/SKILL.md): skill を構成する文章を簡素化し、同じ概念の呼び方を揃え、bundle skill / component skill / reference の責務境界を保ったまま読みやすくする。
- [`codex-self-improvement-review`](../codex-self-improvement-review/SKILL.md): checklist、validation、reference への一般化、最終報告を行う。

## Quick start

- `AGENTS.md`、`~/.codex/config.toml`、この bundle skill を確認する。
- [`references/orchestration.md`](references/orchestration.md) で今回の route と正本語彙を確認する。
- その route に必要な component skills と `references/` だけを読む。

## Repo path notes

- path 表記の正本は `~/.codex/...` / `~/.agents/...` とする。repo 内の実ファイルを触るときだけ `dot_codex/...` / `dot_agents/...` を使う。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - 推奨順序、route の広げ方、正本語彙、往復条件を確認するときに読む。
