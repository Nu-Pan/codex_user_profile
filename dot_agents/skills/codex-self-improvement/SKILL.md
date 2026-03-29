---
name: codex-self-improvement
description: Use when improving Codex itself by editing `AGENTS.md`, `~/.codex/**/*`, repo-scoped `.codex/**/*`, or this skill family. Use as the root entrypoint for role-based self-improvement routing across placement, workflow redesign, bounded edits, and audit. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`~/.codex/**/*`、repo-scoped `.codex/**/*`、この root skill、または関連 `~/.agents/skills/codex-self-improvement-*` を追加・変更するとき
- skill family の文面、語彙、責務境界、導線を role-based architecture へまとめて見直したいとき
- `profiles`、`developer_instructions`、permissions、MCP 設定など Codex の挙動設定を改善したいとき
- ユーザーが示した reusable workflow を `profile`、root skill、child agent roles、`references/`、durable 設定に分解して Codex に取り込みたいとき

## Do not use when

- プロダクト本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Purpose

- この root skill は Codex 自己改善 workflow の入口であり、正本語彙、default spawn policy、child agent role 選定を定義する。
- この workflow の session 契約の正本は `profiles.codex_meta.developer_instructions`、repo-wide の入口は `AGENTS.md`、詳細判断の正本は関連 `references/` と child agent role contract とする。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、必要なら既存差分を確認する。
2. [`references/orchestration.md`](references/orchestration.md) で正本語彙と最小 role sequence を確認する。
3. 必要な child agent role だけを起動し、task summary、対象ファイル、期待出力だけを渡す。
4. repo-tracked な非自明編集は `si_editor` へ寄せる。
5. 編集後は `si_audit` 相当の観点で validation と最終報告観点を確認する。

- 既定 role sequence、sequence を広げる条件、spawn policy は [`references/orchestration.md`](references/orchestration.md) と [`references/agent-routing.md`](references/agent-routing.md) を正本とする。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。
- 旧 skill 名は compatibility entrypoint として残すが、canonical な入口にはしない。

## Child agent roles

- `si_scope`: `AGENTS.md` / `config.toml` / permissions / MCP / canonical path / session 契約の置き場所を判断する。
- `si_design`: reusable workflow を `profile`、root skill、child agent roles、`references/`、durable 設定へ分解する。
- `si_editor`: bounded な prose / config 編集を行い、意図した責務境界を崩さずに文面と設定を更新する。
- `si_audit`: validation、cross-doc consistency、一般化判断、最終報告観点を確認する。

## Quick start

- 軽量 root session と child role tier を使う場合は `codex_meta` profile で開始する。
- `AGENTS.md`、`~/.codex/config.toml`、この root skill を確認する。
- [`references/orchestration.md`](references/orchestration.md) の `Choosing child agent roles` と `Typical sequences` を見て最小 role sequence を決める。
- child agent の起動方針で迷うときは [`references/agent-routing.md`](references/agent-routing.md) を読む。
- 各 role に何を渡し、何を返させるかは [`references/role-contracts.md`](references/role-contracts.md) を読む。

## Repo path notes

- path 表記の正本は `~/.codex/...` / `~/.agents/...` とする。repo 内の実ファイルを触るときだけ `dot_codex/...` / `dot_agents/...` を使う。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - 推奨 role sequence、role の広げ方、正本語彙、往復条件を確認するときに読む。
- [`references/agent-routing.md`](references/agent-routing.md)
  - root session がどこまでローカルで扱い、どこから child agent へ逃がすか、spawn policy の既定を確認するときに読む。
- [`references/role-contracts.md`](references/role-contracts.md)
  - `si_scope`、`si_design`、`si_editor`、`si_audit` に渡す入力と期待出力を確認するときに読む。
