# Orchestration

## Entry checks

- `AGENTS.md`、`~/.codex/config.toml`、変更対象、必要なら既存差分を確認する。
- 変更対象が repo-scoped `.codex/**/*` や user skill 側に及ぶ場合は、その現状も先に確認する。
- Codex 契約や設定キーの意味が repo から確定できない場合だけ OpenAI developer docs MCP を使う。

## Choosing component skills

- [`codex-self-improvement-placement`](../codex-self-improvement-placement/SKILL.md)
  - `AGENTS.md` / `config.toml` / permissions / MCP / canonical path の置き場所判断が必要なときに使う。
- [`codex-self-improvement-workflow`](../codex-self-improvement-workflow/SKILL.md)
  - reusable workflow を `profile`、`束ね skill`、`役割別 skill` に分解したいときに使う。
- [`codex-self-improvement-review`](../codex-self-improvement-review/SKILL.md)
  - 編集前 checklist、validation、一般化判断、最終報告をまとめたいときに使う。

## Recommended sequence

1. 現状確認と既存差分の把握を行う。
2. rule placement や権限境界が曖昧なら `placement` を先に使う。
3. reusable workflow の導線や `developer_instructions` を変えるなら `workflow` を使う。
4. 実際の編集後に `review` で validation と最終報告観点を確認する。

- placement 判断が変わったら、workflow 設計や編集方針へ戻ってよい。
- 新規 profile と bundle/component skills を同時に足した場合は、最後に責務分離をまとめて見直す。

## Handoff rule

- bundle skill は入口と導線だけを持ち、phase-local な詳細は component skill 側へ逃がす。
- component skill は自分の責務に必要な reference だけを読む。
- 一般化できる原則が見えたら、task 固有の説明を増やす前に対応する `references/` へ引き上げる。
