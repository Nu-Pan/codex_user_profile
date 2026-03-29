---
name: codex-self-improvement
description: Use when improving Codex itself by editing `AGENTS.md`, `~/.codex/**/*`, repo-scoped `.codex/**/*`, or this skill family. Use as the root entrypoint for role-based self-improvement routing across placement, workflow redesign, bounded edits, and audit. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、この root skill、または関連 references / child agent role / role config を追加・変更するとき
- skill family の文面、語彙、責務境界、導線を role-based architecture へまとめて見直したいとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善したいとき
- ユーザーが示した reusable workflow を `profile`、root skill、child agent roles、`references/`、durable 設定に分解して Codex に取り込みたいとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この root skill は Codex 自己改善 workflow の入口であり、root session は task framing、child agent 起動、最終統合だけを担当し、実作業は child agent に委ねる。
- session 契約の正本は `profiles.codex_meta.developer_instructions`、repo-wide の入口は `AGENTS.md`、routing と詳細判断の正本は関連 `references/` と child agent role contract である。
- ここには導線だけを置き、手順の本文は `references/` に逃がす。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、既存差分を確認する。
2. [`references/orchestration.md`](references/orchestration.md) と [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) で、最小 role sequence と置き場所の判断を確認する。
3. 少なくとも 1 つの child agent role を起動し、task summary、対象ファイル、期待出力だけを渡す。
4. repo-tracked な編集は `si_editor` に寄せ、編集後は `si_audit` で validation と残余リスクを点検する。

- 既定 role sequence、sequence を広げる条件、spawn policy は [`references/orchestration.md`](references/orchestration.md) を正本とする。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。
- 迷ったら `si_scope` で置き場所と責務境界を確定し、必要なときだけ後続 role を足す。

## Child agent roles

- `si_scope`: `AGENTS.md` / `config.toml` / permissions / MCP / canonical path / session 契約の置き場所を判断する。
- `si_design`: reusable workflow を `profile`、root skill、child agent roles、`references/`、durable 設定へ分解する。
- `si_editor`: bounded な prose / config 編集を行い、意図した責務境界を崩さずに文面と設定を更新する。
- `si_audit`: validation、cross-doc consistency、一般化判断、最終報告観点を確認する。

## Quick start

- `codex_meta` profile で開始する。
- `AGENTS.md`、`~/.codex/config.toml`、この root skill を確認する。
- [`references/orchestration.md`](references/orchestration.md) の `Default role sequence` と `Choosing child agent roles` を見て最小 role sequence を決める。
- 置き場所や session 契約で迷うときは [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) と [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md) を読む。
- 各 role に何を渡し、何を返させるかは [`references/role-contracts.md`](references/role-contracts.md) を読む。

## Repo path notes

- path 表記の正本は `~/.codex/...` / `~/.agents/...` とする。repo 内の実ファイルを触るときだけ `dot_codex/...` / `dot_agents/...` を使う。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - root/child の routing、推奨 role sequence、handoff の正本を確認するときに読む。
- [`references/role-contracts.md`](references/role-contracts.md)
  - `si_scope`、`si_design`、`si_editor`、`si_audit` に渡す入力、期待出力、write policy を確認するときに読む。
- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - `AGENTS.md`、`developer_instructions`、`config.toml`、permissions、MCP の置き場所を確認するときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - `developer_instructions` の session 契約と書式を確認するときに読む。
- [`references/workflow-to-profile-role.md`](references/workflow-to-profile-role.md)
  - profile、root skill、child agent roles、role config、`references/` への分解基準を確認するときに読む。
- [`references/editor-guide.md`](references/editor-guide.md)
  - prose / config / reference の文章を短く直接的に保つ基準を確認するときに読む。
- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前確認、validation、自己レビュー、最終報告の観点を確認するときに読む。
