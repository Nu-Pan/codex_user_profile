# Workflow Checklist

## Before editing

必ず確認する。

- `AGENTS.md`
- `~/.codex/config.toml`
- 現在の root skill `codex-self-improvement`、必要な compatibility skill や child agent role 関連文書、今回触る参照文書
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
- mirror checkout を編集している場合の対応する local working path。例: `dot_codex/**/*`、`dot_agents/skills/codex-self-improvement*/**/*`

## Usually do not edit

- `README.md`
- 上記以外の `doc/**/*.md`
- プロダクト本体コード
- テストコード
- 依存関係や開発環境設定
- hooks、周辺自動化の追加実装

## Validation

- この文書を validation の正本として扱う。
- `developer_instructions` を更新したら、少なくとも 1 回は instruction chain の見え方を確認する。
- 既存 root skill を編集したら、その skill 単体で trigger、既定 route、読むべき reference、child agent role への導線が見え、正本語彙への導線が残っていることを確認する。
- child agent の完了待機では timeout を使わず、完了まで待つ運用になっていることを確認する。
- 既存 compatibility skill を編集したら、その skill 単体で legacy 名から canonical な root skill と child agent role へ handoff できることを確認する。
- 既存 `references/` を編集したら、その文書単体で判断基準や例外条件が見え、root skill や role contract と入口説明を重複していないことを確認する。
- 語彙統一を行ったら、同じ概念が root skill / compatibility skills / `references/` / role contract で別名のまま残っていないか、正本語彙がどこか 1 か所で追えるかを確認する。
- 新規 profile を追加したら、その profile 単体で mission、allowed modes、must-read が見えることを確認する。
- 新規 root skill を追加したら、その skill 単体で trigger、推奨 role sequence、読むべき reference、child agent role への導線が見えることを確認する。
- 新規 child agent role を追加したら、その role config と role contract から役割、入力条件、期待出力、読むべき reference が見えることを確認する。
- profile と root skill を同時に追加したら、組み合わせたときの責務分離も確認する。
- Codex CLI で自動実行する validation は、非 TTY で安全に回せる `codex exec` だけに限定する。
- 自動 validation の model は既定で `gpt-5.4-mini` を使い、軽量 model で確認できる導線、局所責務、責務分離だけを対象にする。
- `codex --ask-for-approval never ...` や `codex --cd ...` のような TTY 前提コマンドは、人間向け手動確認として案内し、Codex の自動 validation 候補には入れない。
- 軽量 model で成立しない長い説明、深い推論、対話的 UI 操作は、自動 validation の対象に含めない。
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。

## Validation command candidates

### Automated non-TTY checks

- `codex exec -m gpt-5.4-mini -p codex_meta "Summarize the current mission, allowed modes, and must-read documents in 3 bullets."`
- `codex exec -m gpt-5.4-mini '$codex-self-improvement Summarize the canonical root skill, child agent roles, and default spawn policy in 4 bullets.'`
- `codex exec -m gpt-5.4-mini -p codex_meta '$codex-self-improvement Explain how developer_instructions, root skill, child agent roles, references, and config.toml divide responsibilities.'`
- `codex exec -m gpt-5.4-mini '$codex-self-improvement Summarize the wait policy for child agents and whether timeout is allowed.'`

### Manual TTY checks for humans

- `codex --ask-for-approval never "Summarize the current instructions."`
- `codex --cd <subdir> --ask-for-approval never "Show which instruction files are active."`
- これらは TTY 前提なので、Codex は自動実行せず、人間に手動確認として案内する。

## Generalize to references

- 今回の修正内容のうち、task 固有の事情ではなく、今後の `codex-self-improvement` でも再利用できる方向性、判断基準、運用原則がないかを必ず検討する。
- 特に、人間が示した方向性、責務分離の判断、レビュー観点、文書配置の原則のように、別の自己改善タスクでも再利用しうる要素を候補にする。
- 候補がある場合は、どの `references/` 文書へ引き上げるのが適切かを先に判断し、既存文書への追記を優先する。既存文書で受けきれない場合だけ新しい reference 文書を検討する。
- task 固有の事情しか残らない場合は `references/` へ引き上げず、その判断を最終報告で明示する。

## Self review

最低 1 回、以下を点検すること。

- `developer_instructions`、`AGENTS.md`、permissions の責務分離が崩れていないか
- 典型 workflow の session 契約が `developer_instructions` に閉じ、全体導線が root skill に、詳細手順が `references/` / role contract に逃がされているか
- root skill が編集作業や検証作業を抱え込まず、実作業が child agent に分離されているか
- child agent の完了待機で timeout を使わず、完了まで待つ運用が明文化されているか
- MCP rule の置き場所が `config.toml`、`AGENTS.md`、存在する場合の task 文書、`developer_instructions` のどれかで一意に説明できるか
- `developer_instructions` を「正本そのもの」と誤解させる表現になっていないか
- profile 名の自己認識を前提にしたルールが紛れ込んでいないか
- profile 名が `lower_snake_case`、skill 名が `lower-hyphen-case` の既定に沿っているか
- `developer_instructions` が child agent role を直接抱え込みすぎず、既定どおり root skill を入口にし、child agent 起動が原則必須になっているか
- root skill、role contract、compatibility skill の責務が重複していないか
- root skill には route の概要だけを残し、詳細な選択条件や例外は `references/` や role contract へ逃がせているか
- 同じ概念が root skill / compatibility skills / `references/` / role contract で別名のまま共存していないか
- skill 文面が 1 行 1 意図になっており、`Use when`、`Purpose`、`Quick start`、`Reference map` に同じ説明を重複させていないか
- 文面簡素化で trigger、責務、正本、handoff、禁止条件を削りすぎていないか
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
- TTY 前提の確認が必要だった場合は、人間へ案内した手動確認内容と、自動 validation に入れなかった理由
- 語彙統一を行った場合は、採用した正本語彙と対象範囲
- 新規 profile、root skill、child agent role を追加した場合は、それぞれの単体確認と必要な組み合わせ確認の結果
- 残っている制約や未解決事項
- 修正内容のエッセンスを `references/` へ引き上げたか、見送ったか、その判断
- `AGENTS.md`、`~/.codex/config.toml`、存在する場合の repo-scoped `.codex/config.toml`、root skill と関連 role contract / compatibility skill の間に矛盾があればその内容
