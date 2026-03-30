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

- この root skill は Codex 自己改善の入口である。
- root session は `~/.codex/config.toml` の top-level `developer_instructions` を root router contract の正本として扱い、直接解決せず routing と handoff だけを持つ。
- 実作業は対応する custom skill と child agent に委ね、対応する custom skill が無い場合は task に必要な最小責務だけを持つ built-in child agent へ移譲する。
- 共通規約は `AGENTS.md`、role contract は [`references/role-contracts.md`](references/role-contracts.md)、配置判断は [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) を正本とする。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、既存差分を確認する。この repo では、repo root の `README.md` に列挙された 3 つの典型プロンプト例だけを入口の local facts として確認する。
2. [`references/orchestration.md`](references/orchestration.md) と [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) を読み、routing と placement の前提を揃える。
3. 必要な custom skill と child agent role を確認し、既存 role で足りるならその role を使う。対応する custom skill が無い場合は、その場限りの built-in child agent を起動して task を移譲する。
4. child agent への handoff は bootstrap packet に絞る。bootstrap packet には task summary、対象ファイル、明示した制約、観測済みの local facts を入れる。
5. root session は child agent に委譲した task を自分で引き取って直接解決しない。child agent の完了待機は timeout を使わず、完了まで待つ。Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Child agent roles

- `si_scope`: `AGENTS.md`、`~/.codex/config.toml`、配置判断 reference を使って、置き場所と edit scope を決める。
- `si_design`: reusable workflow を `profile`、root skill、child agent roles、`references/`、durable 設定へ分解する。
- `si_editor`: 承認済み write scope の prose / config を更新する。
- `si_audit`: validation、cross-doc consistency、一般化判断、最終報告観点を確認する。

## Quick start

- `codex_meta` profile で開始する。
- `AGENTS.md`、`~/.codex/config.toml`、この root skill を読み、次に `references/orchestration.md` と [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) を読む。
- role の mission、inputs、outputs、write policy は [`references/role-contracts.md`](references/role-contracts.md) を読む。
- `developer_instructions` の使い分けで迷うときは [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md) を読む。
- 最初の child agent は、迷いがなければ最小 role sequence に従い、迷いがあれば `si_scope` から始める。対応する custom skill が無い場合は built-in child agent を使う。

## Repo path notes

- path 表記の正本は `~/.codex/...` / `~/.agents/...` とする。repo 内の実ファイルを触るときだけ `dot_codex/...` / `dot_agents/...` を使う。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - root/child の routing、推奨 role sequence、wait policy、handoff を確認するときに読む。
- [`references/role-contracts.md`](references/role-contracts.md)
  - `si_scope`、`si_design`、`si_editor`、`si_audit` の mission、inputs、outputs、write policy を確認するときに読む。
- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - `AGENTS.md`、top-level `developer_instructions`、role config、`config.toml`、permissions、MCP の置き場所を確認するときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - top-level と role-level の `developer_instructions` の書式と責務分離を確認するときに読む。
- [`references/workflow-to-profile-role.md`](references/workflow-to-profile-role.md)
  - workflow を `profile`、root skill、child agent roles、role config、`references/` に分解する基準を確認するときに読む。
- [`references/model-selection.md`](references/model-selection.md)
  - OpenAI 公式 docs に沿って `model` / `model_reasoning_effort` / `model_verbosity` の tier を選ぶ基準を確認するときに読む。
- [`references/editor-guide.md`](references/editor-guide.md)
  - prose / config / reference を短く直接的に保つ基準を確認するときに読む。
- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前確認、validation、自己レビュー、最終報告を確認するときに読む。
