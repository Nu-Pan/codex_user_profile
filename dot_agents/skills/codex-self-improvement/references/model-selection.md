# Model Selection

## Purpose

- OpenAI 公式 docs に沿って、Codex self-improvement workflow で model / reasoning effort / verbosity を選ぶ基準をまとめる。
- この文書は model の「重さ」を選ぶ判断基準の正本であり、個別 role config の値そのものは置かない。

## Default stance

- まず OpenAI の最新 model guide と各 model の API docs を確認する。
- task fit を先に見る。general-purpose、reasoning、coding-agent のどれに寄るかを切り分ける。
- reasoning が深い task、複数段階の推論、厳密な検証が要る task では reasoning 寄りの model を優先する。
- まずは quality bar を満たす最小の model と reasoning effort から始める。
- model を上げる前に、prompt の固定と eval での比較を優先する。

## When changing a model

1. まず既存 prompt と task 条件をできるだけ固定する。
2. model と reasoning effort を同時に大きく変えない。
3. 変更後は eval や再現可能な確認で差分を見る。
4. latency、cost、quality のどれを優先したかを残す。

## Official docs to consult

- [Choosing models and APIs](https://developers.openai.com/api/docs/guides/text/#choosing-models-and-apis)
  - reasoning model と chat model の違い、Responses API の推奨を確認するときに読む。
- [Migrating from other models to GPT-5.4](https://developers.openai.com/api/docs/guides/latest-model/#migrating-from-other-models-to-gpt-54)
  - 既存 model から移行するときの reasoning level の当て方を確認するときに読む。
- [GPT-5.4 Model](https://developers.openai.com/api/docs/models/gpt-5.4)
  - gpt-5.4 の reasoning.effort 対応値を確認するときに読む。
- [Practical Guide for Model Selection for Real‑World Use Cases](https://developers.openai.com/cookbook/examples/partners/model_selection_guide/model_selection_guide/)
  - 現実の use case に対する model 選定の考え方を確認するときに読む。
