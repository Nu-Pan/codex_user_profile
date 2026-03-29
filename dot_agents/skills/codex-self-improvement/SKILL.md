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

- この root skill は Codex 自己改善 workflow の入口である。
- 実作業は child agent に委ねる。
- 共通規約は `AGENTS.md`、root router contract は `~/.codex/config.toml` の `[profiles.codex_meta].developer_instructions`、routing と handoff は [`references/orchestration.md`](references/orchestration.md) を正本とする。
- role ごとの入出力と write policy は [`references/role-contracts.md`](references/role-contracts.md) を正本とする。
- child agent role の実体は `agent_roles/*.toml` に置く standalone custom agent config であり、各 role の `developer_instructions` が読む reference を閉じる。

## Recommended flow

1. `AGENTS.md`、`~/.codex/config.toml`、変更対象、既存差分を確認する。
2. [`references/orchestration.md`](references/orchestration.md) と [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) を読み、root router contract と配置判断の前提を揃える。
3. 必要な custom skill と child role を確認し、既存 role で足りるならその role を使う。
4. child agent への handoff は task summary、対象ファイル、明示した制約、観測済みの local facts だけに絞る。
5. child agent の完了待機は timeout を使わず、完了まで待つ。
6. Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Child agent roles

- `si_scope`: `AGENTS.md` / `config.toml` / permissions / MCP / canonical path / root router contract の置き場所を判断する。
- `si_design`: reusable workflow を `profile`、root skill、child agent roles、`references/`、durable 設定へ分解する。
- `si_editor`: bounded な prose / config 編集を行い、意図した責務境界を崩さずに文面と設定を更新する。
- `si_audit`: validation、cross-doc consistency、一般化判断、最終報告観点を確認する。

## Quick start

- `codex_meta` profile で開始する。
- `AGENTS.md`、`~/.codex/config.toml`、この root skill を確認する。
- 最小 role sequence は [`references/orchestration.md`](references/orchestration.md) を読む。
- role の入出力と write policy は [`references/role-contracts.md`](references/role-contracts.md) を読む。
- 置き場所や `developer_instructions` の使い分けで迷うときは [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) と [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md) を読む。

## Repo path notes

- path 表記の正本は `~/.codex/...` / `~/.agents/...` とする。repo 内の実ファイルを触るときだけ `dot_codex/...` / `dot_agents/...` を使う。

## Reference map

- [`references/orchestration.md`](references/orchestration.md)
  - root/child の routing、推奨 role sequence、child agent の完了待機ポリシー、handoff の正本を確認するときに読む。
- [`references/role-contracts.md`](references/role-contracts.md)
  - `si_scope`、`si_design`、`si_editor`、`si_audit` に渡す入力、期待出力、write policy を確認するときに読む。
- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - `AGENTS.md`、profile-level `developer_instructions`、role-level `developer_instructions`、`config.toml`、permissions、MCP の置き場所を確認するときに読む。
- [`references/developer-instructions-guide.md`](references/developer-instructions-guide.md)
  - profile-level と role-level の `developer_instructions` の書式と責務分離を確認するときに読む。
- [`references/workflow-to-profile-role.md`](references/workflow-to-profile-role.md)
  - profile、root skill、child agent roles、role config、`references/` への分解基準を確認するときに読む。
- [`references/model-selection.md`](references/model-selection.md)
  - OpenAI 公式 docs に沿って `model` / `model_reasoning_effort` / `model_verbosity` の tier を選ぶ基準を確認するときに読む。
- [`references/editor-guide.md`](references/editor-guide.md)
  - prose / config / reference の文章を短く直接的に保ち、OpenAI 公式 docs で足りる内容を公式 docs 参照へ寄せる基準を確認するときに読む。
- [`references/workflow-checklist.md`](references/workflow-checklist.md)
  - 編集前確認、validation、自己レビュー、最終報告、child agent の完了待機を timeout なしで待つ観点を確認するときに読む。
