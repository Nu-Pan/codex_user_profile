# Developer Instructions Guide

## Purpose

- `AGENTS.md` は root agent と child agent の両方に共通する最小規約を置く。
- `profile-level developer_instructions` は root profile の router / orchestrator 契約を置く。
- `agent_roles/*.toml` の `developer_instructions` は child agent role の role-local bootstrap contract を置く。
- `developer_instructions` は must-read の入口であり、workflow 本文の正本ではない。
- repo 全体ルールや handbook の本体は `AGENTS.md`、profile-level `developer_instructions`、root skill、role contract に分けて戻す。

## What each layer includes

### `AGENTS.md`

- root agent と child agent に共通する最小規約
- 事実・推測・未確認事項の分離
- 破壊的操作前の確認
- 共有して守る品質基準と報告基準
- 指示衝突時や権限衝突時の扱い
- profile 固有 routing ではなく共有前提だけ

### `profile-level developer_instructions`

- 応答言語や最終出力の基礎スタイル
- その profile の mission
- root agent を router / orchestrator に限定する方針
- Codex CLI に何かをさせる前に、対応する custom skill と child role を用意する方針
- 実施前に読むべき正本や task 文書
- その profile で許容する作業モード
- 品質基準、自己レビュー基準、報告要件
- 指示衝突時や権限衝突時の扱い
- その profile に固有で必要な追加参照先や追加制約

### `role-level developer_instructions`

- 応答言語や最終出力の基礎スタイル
- その role の mission
- 着手前に読むべき正本や task 文書
- その role で許容する作業モード
- 品質基準、自己レビュー基準、報告要件
- 指示衝突時や権限衝突時の扱い
- その role に固有で必要な追加参照先や追加制約

## What not to include

- その層より広い責務の丸写し
- `doc/spec/*.md` や `doc/tech/*.md` の内容の丸写し
- root skill の `Recommended flow` や child agent role 一覧の丸写し
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
- 原則ではなく、その層に必要な最小限の契約だけを書く。
- 既定では must-read を `AGENTS.md` と root skill に留め、child agent roles や詳細 reference はそこから辿らせる。
- この skill family では `root skill`、`child agent role`、`reference`、`role config` を正本語彙として使い、独自の言い換えを増やさない。
- 長くなるルールは `AGENTS.md`、profile-level `developer_instructions`、root skill に逃がし、そこには参照だけを書く。

## Minimal templates

### `profile-level developer_instructions`

```text
- 常に <language> で回答する。
- この profile の目的は <mission> である。
- 実施前に `AGENTS.md` と root skill `<root-skill-name>` を読み、共通規約と導線を正本として扱う。
- Codex CLI に何かをさせる前に、対応する custom skill と child role を確認し、無ければ先に作成する。
- この profile では <allowed_modes> だけを扱う。
- <quality_bar> を満たすまで作業を打ち切らない。
- 指示や権限が衝突する場合は <escalation_rule>。
- 最終報告では <reporting_items> を必ず述べる。
```

### `role-level developer_instructions`

```text
- 常に <language> で回答する。
- この role の目的は <mission> である。
- 実施前に <must_read_docs> を読む。
- root handoff が薄い前提で <bootstrap steps> を行う。
- <output contract> を返す。
- repo-tracked file は編集しない。
```

## Optional extra line

- Codex 契約や OpenAI developer docs の確認が task の一部である profile に限り、参照先の行を追加してよい。
- 例:

```text
- Codex 契約や repo から確認できない設定キーの意味を確認する必要があるなら OpenAI developer docs MCP を使う。
```

- この条件付き項目は `codex_meta` のような root profile では有効だが、`question` や `spec_doc` の共通要件にはしない。

## Role config lens

- `agent_roles/*.toml` の `developer_instructions` には、その role が読む `references/` と bootstrap 条件を短く書く。
- そこには role-local の mission、期待出力、read-first docs を閉じる。
- root skill 側に同じ詳細を再掲しない。
- 1 role 1 purpose、1 行 1 意図を守る。
