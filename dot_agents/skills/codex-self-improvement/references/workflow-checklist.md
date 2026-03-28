# Workflow Checklist

## Before editing

必ず確認する。

- `AGENTS.md`
- `~/.codex/config.toml`
- 現在の `codex-self-improvement` skill と、今回触る参照文書
- 変更対象ファイルに既存の未コミット差分がある場合は、その内容

必要な場合だけ確認する。

- repo-scoped `.codex/config.toml` や `.codex/**/*`
- 変更対象がユーザー設定側に及ぶなら、その差分
- task 文書がある repo なら対応する task 文書
- Codex 契約や repo から確認できない設定キーの意味を確認する必要がある場合だけ、OpenAI developer docs MCP

## Preferred editable scope

- `AGENTS.md`
- `~/.codex/config.toml`
- 存在する場合の repo-scoped `.codex/**/*`
- `~/.agents/skills/codex-self-improvement/**/*`

## Usually do not edit

- `README.md`
- 上記以外の `doc/**/*.md`
- プロダクト本体コード
- テストコード
- 依存関係や開発環境設定
- hooks、周辺自動化の追加実装

## Validation

- `developer_instructions` を更新したら、少なくとも 1 回は instruction chain の見え方を確認する。
- 確認候補:
  - `codex --ask-for-approval never "Summarize the current instructions."`
  - `codex --cd <subdir> --ask-for-approval never "Show which instruction files are active."`
  - `codex --ask-for-approval never '$codex-self-improvement Summarize the Codex self-improvement workflow.'`
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。

## Self review

最低 1 回、以下を点検すること。

- `developer_instructions`、`AGENTS.md`、permissions の責務分離が崩れていないか
- MCP rule の置き場所が `config.toml`、`AGENTS.md`、存在する場合の task 文書、`developer_instructions` のどれかで一意に説明できるか
- `developer_instructions` を「正本そのもの」と誤解させる表現になっていないか
- profile 名の自己認識を前提にしたルールが紛れ込んでいないか
- 編集可能範囲が必要以上に広がっていないか
- 同じルールが複数箇所に重複していないか
- `instructions` や `model_instructions_file` と責務が混線していないか
- 共有設定に環境依存の絶対 path が残っていないか
- 可搬性と hard gate が衝突した箇所で `permissions` 撤廃を検討したか

## Final reporting

- 何を変更したか
- なぜその変更で Codex 自己改善の最小ハーネスとして成立すると判断したか
- 実行した確認内容
- 残っている制約や未解決事項
- `AGENTS.md`、`~/.codex/config.toml`、存在する場合の repo-scoped `.codex/config.toml`、この skill の間に矛盾があればその内容
