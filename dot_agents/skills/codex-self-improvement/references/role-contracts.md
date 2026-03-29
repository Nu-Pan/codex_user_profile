# Role Contracts

## Common rules

- routing と spawn policy の正本は [`orchestration.md`](orchestration.md) にある。
- child agent role は 1 つの責務だけを担当する。
- child agent role は root handoff が最小でも、自分の role config と current repo state から起動できるように書く。
- 具体の read-first docs は role config の `developer_instructions` に閉じる。
- `AGENTS.md` は root / child 共通の規約に閉じ、root router contract は `~/.codex/config.toml` の top-level `developer_instructions` に置く。
- root session は task summary だけでなく、対象ファイル、明示した制約、観測済みの local facts も渡す。
- root session は必要に応じて role 出力を `summary` / `decision` / `next action` の relay envelope に正規化してよいが、role-specific の Outputs が source contract である。
- 出力は root session が次の role へ短く handoff できる粒度にする。
- repo-tracked な編集権限は `si_editor` に集約する。
- child agent は不足分を canonical files、current config、current diff、関連 reference から復元し、必要なときだけ確認を返す。
- 確認が必要なのは、欠けた情報が placement、権限、安全性、期待出力を変える場合に限る。
- root session は実作業を持たず、child agent の output を受けて routing と統合だけを行う。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## `si_scope`

- Mission: placement、root router contract、canonical path、editable scope を決める。
- Read first: `AGENTS.md`、`~/.codex/config.toml`、[`references/config-and-rule-placement.md`](config-and-rule-placement.md)、[`references/developer-instructions-guide.md`](developer-instructions-guide.md)。
- root handoff が薄い場合でも、対象ファイル、既存 diff、現行 guidance から placement を復元する。
- Inputs:
  - 変更意図
  - 対象ファイル
  - 現行 config / guidance の状態
  - root handoff が省略した local facts
- Outputs:
  - `placement decision`
  - `files to edit`
  - `files to avoid`
  - `risks`
- Write policy: repo-tracked file は編集しない。

## `si_design`

- Mission: reusable workflow を profile、root skill、child agent roles、role config、references に分解する。
- Read first: [`references/workflow-to-profile-role.md`](workflow-to-profile-role.md)、[`references/orchestration.md`](orchestration.md)、[`references/role-contracts.md`](role-contracts.md)、[`references/model-selection.md`](model-selection.md)。
- root handoff が薄い場合でも、現行の root skill、role config、reference、current diff から責務分割を復元する。
- Inputs:
  - goal
  - constraints
  - 現行 architecture
  - 必要なら `si_scope` の結果
  - root handoff が省略した context
- Outputs:
  - `role split`
  - `required config/reference changes`
  - `migration/deprecation actions`
  - `execution order`
- Write policy: repo-tracked file は編集しない。

## `si_editor`

- Mission: 承認済み write scope の prose / config を更新する。
- Read first: [`references/editor-guide.md`](editor-guide.md)、[`references/workflow-checklist.md`](workflow-checklist.md)、対象ファイルに対応する reference。
- role config を編集する場合は [`references/workflow-to-profile-role.md`](workflow-to-profile-role.md) と [`references/model-selection.md`](model-selection.md) も読む。
- root handoff が薄い場合でも、対象ファイルと局所 reference を読んで patch 方針を復元する。
- Inputs:
  - 承認済み write scope
  - 対象ファイル
  - 維持すべき責務境界
  - 期待する変更結果
  - root handoff が省略した編集前提
- Outputs:
  - `files changed`
  - `boundaries preserved`
  - `unresolved conflicts`
- Write policy: 指定された write scope の repo-tracked file 編集を担当する。

## `si_audit`

- Mission: diff の妥当性、責務分離、validation、残余リスクを点検する。
- Read first: [`references/workflow-checklist.md`](workflow-checklist.md)、[`references/orchestration.md`](orchestration.md)、[`references/role-contracts.md`](role-contracts.md)、変更対象に対応する reference。
- root handoff が薄い場合でも、changed files と diff を読んで validation 観点を復元する。
- Inputs:
  - diff summary
  - changed files
  - validation results
  - root handoff が省略した確認観点
- Outputs:
  - `findings`
  - `validation commands`
  - `residual risks`
- 返答は findings first にし、validation commands は必要なときだけ添える。
- Write policy: repo-tracked file は編集しない。
