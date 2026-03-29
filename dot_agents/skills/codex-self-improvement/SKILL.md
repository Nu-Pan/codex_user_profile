---
name: codex-self-improvement
description: Use when improving Codex itself rather than product code, especially when editing `AGENTS.md`, `~/.codex/**/*`, repo-scoped `.codex/**/*`, this bundle skill, or related `~/.agents/skills/codex-self-improvement-*` skills. Use as the entry point for workflow routing, wording cleanup, config placement, workflow decomposition, and Codex/OpenAI docs contract checks. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、この bundle skill、または関連 `~/.agents/skills/codex-self-improvement-*` skills を追加・変更するとき
- skill 文面を、責務を変えずに短く直接的な表現へ整えたいとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善したいとき
- ユーザーが示した reusable workflow を profile、bundle skill、component skills へ分解して Codex に取り込みたいとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この skill は Codex 自己改善 workflow の入口であり、読むべき component skill を選ぶための導線だけを持つ。
- session 契約の正本は `profiles.codex_meta.developer_instructions` とする。
- repo-wide の入口は `AGENTS.md`、durable settings は `config.toml`、phase-local な詳細ルールは component skills とその `references/` を正本とする。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、必要なら既存差分を確認する。
2. 置き場所や責務分離で迷うなら `codex-self-improvement-placement` を使う。
3. reusable workflow や `developer_instructions` を変えるなら `codex-self-improvement-workflow` を使う。
4. skill 文面を責務そのままで整理するなら `codex-self-improvement-skill-writing` を使う。
5. 編集前後の checklist、validation、最終報告は `codex-self-improvement-review` で確認する。

- フェーズ順は推奨順序であり、必要に応じて往復してよい。
- 文面整理だけの task は `codex-self-improvement-skill-writing` と `codex-self-improvement-review` だけで足りることが多い。責務や置き場所が変わる場合だけ `codex-self-improvement-placement` / `codex-self-improvement-workflow` へ広げる。
- Codex 契約や repo から確認できない設定キーの意味を確定する必要がある場合だけ OpenAI developer docs MCP を使う。

## Component skills

- [`codex-self-improvement-placement`](../codex-self-improvement-placement/SKILL.md): `AGENTS.md` / `config.toml` / permissions / MCP / canonical path の置き場所を判断する。
- [`codex-self-improvement-workflow`](../codex-self-improvement-workflow/SKILL.md): reusable workflow を `profile` + `束ね skill` + `役割別 skill` に分解し、`developer_instructions` を設計する。
- [`codex-self-improvement-skill-writing`](../codex-self-improvement-skill-writing/SKILL.md): skill を構成する文章を簡素化し、bundle skill / component skill / reference の責務境界を保ったまま読みやすくする。
- [`codex-self-improvement-review`](../codex-self-improvement-review/SKILL.md): checklist、validation、reference への一般化、最終報告を行う。

## Quick start

- `AGENTS.md`、`~/.codex/config.toml`、この skill を確認する。
- [`references/orchestration.md`](references/orchestration.md) を見て、今回の route を 1 つ選ぶ。
- 選んだ component skill の `SKILL.md` と必要な `references/` だけを読む。

## Repo path notes

- guidance、最終報告、他のリポジトリから参照される説明で見せる path の正本は `~/.codex/...` / `~/.agents/...` とする。
- `dot_codex/...` / `dot_agents/...` は、HOME 配下設定を mirror した checkout 上で実ファイルを操作するときだけ使う repo 内 path として扱う。
- canonical path とローカル作業 path を混同せず、cross-repo の説明に `dot_codex/...` / `dot_agents/...` を持ち出さない。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - 推奨順序、component skill の選び方、往復条件を確認するときに読む。
