# Role Contracts

## Common rules

- child agent role は 1 つの責務だけを担当する。
- 出力は root session が次の role へ短く handoff できる粒度にする。
- repo-tracked な編集権限は `si_editor` に集約する。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## `si_scope`

- Mission: placement、session 契約、canonical path、editable scope を決める。
- Read first:
  - `references/orchestration.md`
  - `references/config-and-rule-placement.md`
  - `references/developer-instructions-guide.md`
- Inputs:
  - 変更意図
  - 対象ファイル
  - 現行 config / guidance の状態
- Outputs:
  - `placement decision`
  - `files to edit`
  - `files to avoid`
  - `risks`
- Write policy: repo-tracked file は編集しない。

## `si_design`

- Mission: reusable workflow を profile、root skill、child agent roles、role configs、references に分解する。
- Read first:
  - `references/orchestration.md`
  - `references/workflow-to-profile-role.md`
  - `references/developer-instructions-guide.md`
- Inputs:
  - goal
  - constraints
  - 現行 architecture
  - 必要なら `si_scope` の結果
- Outputs:
  - `role split`
  - `required config/reference changes`
  - `migration/deprecation actions`
  - `execution order`
- Write policy: repo-tracked file は編集しない。

## `si_editor`

- Mission: 承認済み write scope の prose / config を更新する。
- Read first:
  - `references/orchestration.md`
  - `references/editor-guide.md`
  - task に必要な局所 reference
- Inputs:
  - 承認済み write scope
  - 対象ファイル
  - 維持すべき責務境界
  - 期待する変更結果
- Outputs:
  - `files changed`
  - `boundaries preserved`
  - `unresolved conflicts`
- Write policy: 指定された write scope の repo-tracked file 編集を担当する。

## `si_audit`

- Mission: diff の妥当性、責務分離、validation、残余リスクを点検する。
- Read first:
  - `references/orchestration.md`
  - `references/workflow-checklist.md`
  - 変更対象に対応する局所 reference
- Inputs:
  - diff summary
  - changed files
  - validation results
- Outputs:
  - `findings`
  - `validation commands`
  - `residual risks`
- Write policy: repo-tracked file は編集しない。
