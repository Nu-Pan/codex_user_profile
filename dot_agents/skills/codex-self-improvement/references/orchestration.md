# Orchestration

## Purpose

- これは routing と handoff の正本である。

## Canonical terms

- `root session`: `codex_meta` profile で起動し、task summary、role selection、最終統合を担当する親 session。
- `child agent`: root session が 1 つの責務だけを任せるために起動する agent。
- `agent role`: `si_scope`、`si_design`、`si_editor`、`si_audit` のような child agent の責務名。
- `role config`: `agents.<name>.config_file` から読む TOML layer。model、reasoning、verbosity の tier を固定する。
- `root skill`: workflow 全体の入口と導線を持つ skill。既定では `codex-self-improvement` を指す。
- `reference`: `references/` 配下の詳細文書。入口説明の正本にはしない。
- `session 契約`: `developer_instructions` に置く追加行動契約。
- `durable 設定`: `config.toml` に置く継続設定。
- `canonical path`: deploy 後に見える `~/.codex/...` / `~/.agents/...`。
- `local working path`: repo 内で mirror を編集するときの `dot_codex/...` / `dot_agents/...`。
- `role sequence`: 今回使う child agent role の順序。
- `wait policy`: child agent の完了を待つ運用規則。既定では timeout を置かず、完了まで待つ。

## Entry checks

- `AGENTS.md`、`~/.codex/config.toml`、変更対象、既存差分を確認する。
- 変更対象が repo-scoped `.codex/**/*` や user skill 側に及ぶ場合は、その現状も先に確認する。
- 複数文書をまたいで編集する場合は、この文書の正本語彙に揃える。
- 置き場所の判断が先なら [`config-and-rule-placement.md`](config-and-rule-placement.md) を先に読む。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Default role sequence

- root session は task を要約し、最小 role sequence を選んで child agent を起動する。root session 単独で完結させない。
- child agent の完了待機では timeout を使わず、完了まで待つ。途中で打ち切って次へ進めない。
- 置き場所、権限、canonical path、session 契約が曖昧な場合だけ `si_scope` を足す。
- reusable workflow、profile、role config の責務分離を再設計する場合だけ `si_design` を足す。
- repo-tracked な非自明編集や複数文書の文面整理は `si_editor` へ寄せる。
- repo-tracked な編集を行った後は、既定で `si_audit` を最後に足す。
- 同時に複数 role を広げすぎず、必要条件が出たときだけ前段または後段を足す。

## Choosing child agent roles

- `si_scope`
  - `AGENTS.md` / `config.toml` / permissions / MCP / canonical path / `developer_instructions` の置き場所判断が必要なときに使う。
- `si_design`
  - reusable workflow を `profile`、root skill、child agent roles、`reference`、durable 設定へ分解したいときに使う。
- `si_editor`
  - 承認済み write scope の prose / config を更新し、責務を変えずに整理したいときに使う。
- `si_audit`
  - diff の妥当性、責務分離、validation、残余リスクを点検したいときに使う。

## Typical sequences

- 文面整理や語彙統一、bounded config 編集: `si_editor` -> `si_audit`
- 置き場所判断や責務分離が先に必要: `si_scope` -> 必要なら `si_design` または `si_editor` -> `si_audit`
- reusable workflow を `profile` / root skill / child agent roles へ分解したい: `si_scope` -> `si_design` -> 必要なら `si_editor` -> `si_audit`
- 既存 self-improvement 文書群をまとめて総点検したい: `si_scope` -> `si_design` -> `si_editor` -> `si_audit`

## Recommended sequence

1. 現状確認と既存差分の把握を行う。
2. `Choosing child agent roles` に従って最小 role sequence を選ぶ。
3. role sequence を広げる条件が出た場合だけ `si_scope` または `si_design` を足す。
4. 実際の編集後に `si_audit` 相当の観点で validation と最終報告観点を確認する。

- placement 判断が変わったら、workflow 設計や編集方針へ戻ってよい。
- 新規 profile、root skill、role config を同時に足した場合は、最後に責務分離をまとめて見直す。

## Handoff rules

- root session は routing、child agent 起動、最終統合だけを持ち、深い局所判断は child agent 側へ逃がす。
- `si_scope` は placement decision と edit scope を返し、repo-tracked patch は返さない。
- `si_design` は architecture decision と target artifact list を返し、repo-tracked patch は返さない。
- `si_editor` は承認済み write scope の repo-tracked patch を担当する。
- `si_audit` は findings、validation、残余リスクを返し、repo-tracked patch は返さない。
- spawn policy や role ごとの入力条件で迷ったら [`role-contracts.md`](role-contracts.md) へ戻る。
- 一般化できる原則が見えたら、task 固有の説明を増やす前に対応する `references/` へ引き上げる。
