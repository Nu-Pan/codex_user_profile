# Developer Instructions Guide

## Purpose

- `developer_instructions` には、profile ごとの追加行動契約だけを書く。
- repo 全体ルールや handbook の本体は `AGENTS.md` や、存在する場合の task 文書へ戻す。

## `developer_instructions` should include

- 応答言語や最終出力の基礎スタイル
- その profile の mission
- 着手前に読むべき正本や task 文書
- その session で許容する作業モード
- 品質基準、自己レビュー基準、報告要件
- 指示衝突時や権限衝突時の扱い
- その profile に固有で必要な追加参照先や追加制約

## `developer_instructions` should not include

- `AGENTS.md` にある repo 全体ルールの丸写し
- `doc/spec/*.md` や `doc/tech/*.md` の内容の丸写し
- permissions の path 一覧や writable roots の詳細再掲
- MCP server の一覧、接続設定、認証設定
- 長大な実装規約、網羅的な workflow マニフェスト、恒久的な project handbook
- profile 名を自分で推測できる前提の文言
- chain-of-thought を強制する文言
- sandbox や approval_policy と矛盾する指示
- 全 profile に不要な source 指示を共通テンプレへ押し込むこと
- 新しい MCP server を追加するたびに `AGENTS.md`、`developer_instructions`、task 文書へ同じ rule を増やすこと

## Writing style

- 1 行 1 意図の短い箇条書きにする。
- 直接命令形で書く。
- あいまいな努力目標ではなく、観測可能な行動に落とす。
- 原則ではなく、その profile に必要な最小限の契約だけを書く。
- 長くなるルールは `AGENTS.md` や `束ね skill` に逃がし、そこには参照だけを書く。

## Canonical template

`developer_instructions` を新設・改訂するときは、まず次の骨格から始める。

```text
- 常に <language> で回答する。
- この session の目的は <mission> である。
- 実施前に <must_read_docs> を読み、そこを正本として扱う。
- この session では <allowed_modes> だけを扱う。
- <quality_bar> を満たすまで作業を打ち切らない。
- 指示や権限が衝突する場合は <escalation_rule>。
- 最終報告では <reporting_items> を必ず述べる。
```

このテンプレで可変にするのは以下で十分である。

- `language`
- `mission`
- `must_read_docs`
- `allowed_modes`
- `quality_bar`
- `escalation_rule`
- `reporting_items`

## Optional extra line

- Codex 契約や OpenAI developer docs の確認がタスクの一部である profile に限り、参照先の行を追加してよい。
- 例:

```text
- Codex 契約や repo から確認できない設定キーの意味を確認する必要があるなら OpenAI developer docs MCP を使う。
```

- この条件付き項目は `codex_meta` のような Codex 自己改善 profile には有効だが、`question` や `spec_doc` の共通要件にはしない。

## When a workflow is implemented as profile + bundle skill

- `developer_instructions` には session 契約だけを書く。
- 既定では、must-read には `AGENTS.md` と `束ね skill` だけを入れる。
- `役割別 skill` は `developer_instructions` から直接列挙せず、`束ね skill` から辿らせる。
- 詳細な workflow、判断基準、テンプレ断片は `束ね skill`、必要に応じて `役割別 skill` とその `references/` へ逃がす。
- `developer_instructions` では、詳細が別文書にあることを 1 行で示せば十分である。

例:

```text
- 実施前に `AGENTS.md` と user skill `my-workflow` を確認し、そこを正本として扱う。
- 詳細な workflow、推奨フェーズ順、役割別 skill への導線は user skill `my-workflow` と、そこから辿る関連 skill / `references/` を参照する。
```

- 逆に、workflow 全文、variant ごとの差分、役割別 skill の一覧全文、長いテンプレ本文を `developer_instructions` に埋め込まない。

## Example profile lens

以下は profile 設計の例であり、profile 名の自己認識を要求するルールではない。

- `question`
  - mission は「質問応答」。
  - allowed modes は「編集しない」「明示依頼がない限り実行しない」。
  - quality bar は「事実・推測・未確認事項を分ける」。
- `codex_meta`
  - mission は「Codex 自己改善」。
  - must read は `AGENTS.md` と bundle skill `codex-self-improvement`。
  - allowed modes は「最小ハーネスから進める」。
  - workflow を新しい profile + `束ね skill` + `役割別 skill` に分解する場合でも、詳細は関連 skill と `references/` に置く。
  - 条件付き追加項目として OpenAI developer docs MCP の行を持ってよい。
- `spec_doc`
  - mission は「仕様策定」。
  - allowed modes は「仕様作業を優先し、コード実装に飛ばない」。
  - quality bar は「自己レビューで整合性を点検する」。

## Good examples

- `常に日本語で回答する。`
- `実施前に \`AGENTS.md\` と user skill \`codex-self-improvement\` を確認する。`
- `詳細な workflow、推奨フェーズ順、役割別 skill への導線は user skill \`fix-workflow\` と、そこから辿る関連 skill / \`references/\` を参照する。`
- `指示や権限が衝突する場合は編集せず、ユーザーに確認する。`
- `最終報告では、変更内容、成立根拠、未解決事項、制約を述べる。`
- `Codex 契約や repo から確認できない設定キーの意味を確認する必要があるなら OpenAI developer docs MCP を使う。`

## Bad examples

- `この repo の仕様は全部ここに書く。`
- `\`AGENTS.md\` の禁止事項をそのまま全文コピーする。`
- `まず \`fix-plan\`、\`fix-plan-review\`、\`fix-implementation\`、\`fix-result-review\` を全部読め。`
- `書き込み可能 path は A, B, C である。`
- `自分は codex_meta profile だと理解して振る舞う。`
- `必ず step by step で思考過程を全部出力する。`

## Reinterpreting `everything-claude-code`

- 永続的な project guidance は `AGENTS.md` 側に寄せる。
- role や mode ごとの狭い追加契約だけを `developer_instructions` に置く。
- 大きな handbook をそのまま profile ごとに埋め込まない。
- 参考にするのは責務分離であり、文面の移植ではない。
