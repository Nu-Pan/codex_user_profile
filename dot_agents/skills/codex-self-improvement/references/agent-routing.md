# Agent Routing

## Purpose

- これは routing の互換サマリである。正本は [`orchestration.md`](orchestration.md) を読む。

## Short summary

- root session は task framing、role selection、handoff、最終統合だけを担う。
- child agent は原則として必ず起動し、full history ではなく task summary と必要最小限の制約だけを渡す。
- repo-tracked な編集は `si_editor` に寄せ、編集後は既定で `si_audit` を通す。
- 置き場所や責務分離で迷ったら `si_scope`、workflow の分解で迷ったら `si_design` を使う。

## If you need more detail

- spawn policy、handoff package、role ごとの入力条件は [`orchestration.md`](orchestration.md) を読む。
- role ごとの Inputs / Outputs / Write policy は [`role-contracts.md`](role-contracts.md) を読む。
