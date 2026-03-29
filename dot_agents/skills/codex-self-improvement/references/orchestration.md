# Orchestration

## Purpose

- これは routing と handoff の正本である。
- child agent は root の handoff が最小でも、自分の role config と local artifacts から起動できる前提で設計する。

## Canonical terms

- `root session`: `codex_meta` profile で起動し、task summary、role selection、最終統合を担当する親 session。
- `child agent`: root session が 1 つの責務だけを任せるために起動する agent。
- `child agent role`: `si_scope`、`si_design`、`si_editor`、`si_audit` のような child agent の責務名。
- `role config`: `agents.<name>.config_file` から読む standalone custom agent TOML layer。child agent role ごとの `name`、`description`、`developer_instructions`、model、reasoning、verbosity、sandbox_mode を置く。
- `root skill`: workflow 全体の入口と導線を持つ skill。既定では `codex-self-improvement` を指す。
- `reference`: `references/` 配下の詳細文書。入口説明の正本にはしない。
- `session 契約`: root session に対する追加行動契約。Codex 自己改善では `AGENTS.md` に置く。
- `durable 設定`: `config.toml` に置く継続設定。
- `canonical path`: deploy 後に見える `~/.codex/...` / `~/.agents/...`。
- `local working path`: repo 内で mirror を編集するときの `dot_codex/...` / `dot_agents/...`。
- `role sequence`: 今回使う child agent role の順序。
- `wait policy`: child agent の完了を待つ運用規則。既定では timeout を置かず、完了まで待つ。
- `bootstrap packet`: child agent に渡す最小 handoff。task summary、対象ファイル、明示した制約、観測済みの local facts を含める。

## Entry checks

- `AGENTS.md`、`~/.codex/config.toml`、変更対象、既存差分を確認する。
- 変更対象が repo-scoped `.codex/**/*` や user skill 側に及ぶ場合は、その現状も先に確認する。
- 複数文書をまたいで編集する場合は、この文書の正本語彙に揃える。
- 置き場所の判断が先なら [`config-and-rule-placement.md`](config-and-rule-placement.md) を先に読む。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Default role sequence

- root session は task を要約し、最小 role sequence を選んで child agent を起動する。root session 単独で完結させない。
- child agent への handoff は最小に保ち、child agent 側で current config、current diff、対象ファイル、role config、関連 reference を読めば不足分を復元できるようにする。
- child agent の完了待機では timeout を使わず、完了まで待つ。途中で打ち切って次へ進めない。
- 置き場所、権限、canonical path、session 契約が曖昧な場合だけ `si_scope` を足す。
- reusable workflow、profile、role config の責務分離を再設計する場合だけ `si_design` を足す。
- repo-tracked な prose / config 編集は `si_editor` へ寄せる。
- repo-tracked な編集を行った後は、既定で `si_audit` を最後に足す。
- 同時に複数 role を広げすぎず、必要条件が出たときだけ前段または後段を足す。

## Choosing child agent roles

- `si_scope`: `AGENTS.md` / `config.toml` / permissions / MCP / canonical path / `developer_instructions` の置き場所判断が必要なときに使う。
- `si_design`: reusable workflow を `profile`、root skill、child agent roles、`reference`、durable 設定へ分解したいときに使う。
- `si_editor`: 承認済み write scope の prose / config を更新し、責務を変えずに整理したいときに使う。
- `si_audit`: diff の妥当性、責務分離、validation、残余リスクを点検したいときに使う。

## Handoff rules

- root session は routing、child agent 起動、最終統合だけを持ち、深い局所判断は child agent 側へ逃がす。
- root session は task summary と local facts を短く渡し、child agent に背景説明を抱え込ませない。
- child agent は handoff が薄い場合でも、自分の role config、対象ファイル、現行 diff、現行 config から必要文脈を復元する。
- 足りない情報が placement、権限、安全性、期待出力に影響する場合だけ、追加確認を返す。
- `si_scope` は placement decision と edit scope を返し、repo-tracked patch は返さない。
- `si_design` は architecture decision と target artifact list を返し、repo-tracked patch は返さない。
- `si_editor` は承認済み write scope の repo-tracked patch を担当する。
- `si_audit` は findings、validation、残余リスクを返し、repo-tracked patch は返さない。
- spawn policy や role ごとの入力条件で迷ったら [`role-contracts.md`](role-contracts.md) へ戻る。
- 一般化できる原則が見えたら、task 固有の説明を増やす前に対応する `references/` へ引き上げる。
