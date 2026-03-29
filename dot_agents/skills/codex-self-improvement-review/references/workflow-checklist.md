# Workflow Checklist

## Before editing

必ず確認する。

- `AGENTS.md`
- `~/.codex/config.toml`
- 現在の bundle skill `codex-self-improvement`、必要な component skills、今回触る参照文書
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
- `~/.agents/skills/codex-self-improvement*/**/*`

## Usually do not edit

- `README.md`
- 上記以外の `doc/**/*.md`
- プロダクト本体コード
- テストコード
- 依存関係や開発環境設定
- hooks、周辺自動化の追加実装

## Validation

- `developer_instructions` を更新したら、少なくとも 1 回は instruction chain の見え方を確認する。
- 新規 profile を追加したら、その profile 単体で mission、allowed modes、must-read が見えることを確認する。
- 新規 `束ね skill` を追加したら、その skill 単体で trigger、推奨順序、読むべき reference、役割別 skill への導線が見えることを確認する。
- 新規 `役割別 skill` を追加したら、その skill 単体で担当フェーズ、入力条件、期待出力、読むべき reference が見えることを確認する。
- profile と `束ね skill` を同時に追加したら、組み合わせたときの責務分離も確認する。
- 確認候補:
  - `codex exec -p <profile_name> "Summarize the current mission, allowed modes, and must-read documents."`
  - `codex exec '$<bundle-skill-name> Summarize this workflow, the recommended phases, and which component skills you would read.'`
  - `codex exec '$<component-skill-name> Summarize your phase, inputs, outputs, and review criteria.'`
  - `codex exec -p <profile_name> '$<bundle-skill-name> Explain how this workflow is split between developer_instructions, bundle skill, component skills, references, and config.toml.'`
  - `codex --ask-for-approval never "Summarize the current instructions."`
  - `codex --cd <subdir> --ask-for-approval never "Show which instruction files are active."`
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。

## Generalize to references

- 今回の修正内容のうち、task 固有の事情ではなく、今後の `codex-self-improvement` でも再利用できる方向性、判断基準、運用原則がないかを必ず検討する。
- 特に、人間が示した方向性、責務分離の判断、レビュー観点、文書配置の原則のように、別の自己改善タスクでも再利用しうる要素を候補にする。
- 候補がある場合は、どの `references/` 文書へ引き上げるのが適切かを先に判断し、既存文書への追記を優先する。既存文書で受けきれない場合だけ新しい reference 文書を検討する。
- task 固有の事情しか残らない場合は `references/` へ引き上げず、その判断を最終報告で明示する。

## Self review

最低 1 回、以下を点検すること。

- `developer_instructions`、`AGENTS.md`、permissions の責務分離が崩れていないか
- 典型 workflow の session 契約が `developer_instructions` に閉じ、全体導線が `束ね skill` に、詳細手順が `役割別 skill` / `references/` に逃がされているか
- MCP rule の置き場所が `config.toml`、`AGENTS.md`、存在する場合の task 文書、`developer_instructions` のどれかで一意に説明できるか
- `developer_instructions` を「正本そのもの」と誤解させる表現になっていないか
- profile 名の自己認識を前提にしたルールが紛れ込んでいないか
- profile 名が `lower_snake_case`、skill 名が `lower-hyphen-case` の既定に沿っているか
- `developer_instructions` が `役割別 skill` を直接抱え込みすぎず、既定どおり `束ね skill` を入口にしているか
- `束ね skill` と `役割別 skill` の責務が重複していないか
- フェーズ順が推奨順序として書かれており、hard gate と誤読される表現になっていないか
- 編集可能範囲が必要以上に広がっていないか
- 同じルールが複数箇所に重複していないか
- `instructions` や `model_instructions_file` と責務が混線していないか
- 共有設定に環境依存の絶対 path が残っていないか
- 可搬性と hard gate が衝突した箇所で `permissions` 撤廃を検討したか
- 今回の修正のエッセンスを `references/` へ一般化できるかを検討し、再利用できるものだけを引き上げたか

## Final reporting

- 何を変更したか
- なぜその変更で Codex 自己改善の最小ハーネスとして成立すると判断したか
- 実行した確認内容
- 新規 profile、`束ね skill`、`役割別 skill` を追加した場合は、それぞれの単体確認と必要な組み合わせ確認の結果
- 残っている制約や未解決事項
- 修正内容のエッセンスを `references/` へ引き上げたか、見送ったか、その判断
- `AGENTS.md`、`~/.codex/config.toml`、存在する場合の repo-scoped `.codex/config.toml`、bundle skill と関連 component skills の間に矛盾があればその内容
