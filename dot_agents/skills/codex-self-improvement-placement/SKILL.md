---
name: codex-self-improvement-placement
description: Use when Codex self-improvement work needs a placement decision for `AGENTS.md`, `config.toml`, permissions, MCP rules, or canonical paths. Use for deciding where a rule belongs and how to keep the minimal harness small. Do not use for workflow decomposition or final reporting by itself.
---

# Codex Self Improvement Placement

## Use when

- `AGENTS.md`、`developer_instructions`、`config.toml`、permissions、MCP rule のどこへ置くべきかを判断したいとき
- canonical path と local working path の使い分けで迷うとき
- 可搬性、hard gate、最小 writable scope の衝突を整理したいとき

## Purpose

- この skill は Codex 自己改善における rule placement と config placement の再利用可能な判断基準を定義する。
- workflow 全体の導線は bundle skill `codex-self-improvement` を正本とする。

## Inputs

- 変更したい rule、設定、または workflow 上の要件
- 現在の `AGENTS.md`、`config.toml`、対象 skill / reference の状態
- 必要なら既存の未コミット差分

## Outputs

- どの rule をどのファイルへ置くかの判断
- 編集対象と非編集対象の切り分け
- 可搬性、permissions、MCP 利用方針に関する注意点

## Quick start

- bundle skill `codex-self-improvement` と現在の `AGENTS.md`、`~/.codex/config.toml` を確認する。
- まず [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md) を読み、今回の変更がどの層の責務かを判定する。

## Reference map

- [`references/config-and-rule-placement.md`](references/config-and-rule-placement.md)
  - path 表記の canonical rule、`AGENTS.md` / `developer_instructions` / `config.toml` / permissions / MCP の責務分離で迷ったときに読む。
