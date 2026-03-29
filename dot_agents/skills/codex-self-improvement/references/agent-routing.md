# Agent Routing

## Purpose

- root session がどこまでローカルで扱い、どこから child agent へ逃がすかの既定を定義する。
- role-based self-improvement workflow の spawn policy を 1 か所で追えるようにする。

## Root responsibilities

- `AGENTS.md`、`~/.codex/config.toml`、変更対象、既存差分を確認する。
- task を短い `task summary` に圧縮する。
- 最小 role sequence を選ぶ。
- child agent へ渡す入力を整え、結果を統合する。
- 最終報告と、必要な validation の実行または案内を行う。

## Spawn defaults

- child agent は必要な責務が出たときだけ起動する。既定では root session だけで開始する。
- `fork_context = false` を既定にする。
- child agent へは full history を渡さず、`task summary`、`files in scope`、`expected output` だけを渡す。
- child agent の入力に追加するのは、判断に必要な制約だけに絞る。
- 非 docs child agent は同時に 1 体までを既定にする。
- OpenAI developer docs の参照は専用 role に分けず、必要な role が直接行う。
- repo-tracked な非自明編集は `si_editor` に寄せる。
- repo-tracked な編集後は、既定で `si_audit` を通す。

## Stay local when

- 1 ファイルだけの機械的な更新で済む。
- placement、workflow redesign、cross-doc consistency の判断が不要である。
- 変更結果のリスクが低く、`si_audit` による最終確認だけで十分である。

## Use each role when

- `si_scope`
  - `AGENTS.md` / `developer_instructions` / `config.toml` / permissions / MCP / path guidance の置き場所を決める必要がある。
- `si_design`
  - workflow を `profile`、root skill、child agent roles、`references/`、durable 設定へ再分解する必要がある。
- `si_editor`
  - 承認済み write scope の prose / config を更新する必要がある。
- `si_audit`
  - diff の妥当性、責務分離、validation、残余リスクを点検したい。

## Child prompt package

- `task summary`
- `files in scope`
- `expected output`
- 必要なら `constraints`
- 必要なら直前 role の要約結果

## Handoff discipline

- `si_scope` と `si_design` の出力は、root session が次の role へ短く受け渡せる形に圧縮する。
- `si_editor` には write scope を明示し、他 role の責務まで抱え込ませない。
- `si_audit` には diff と validation 結果を渡し、findings first で返させる。
