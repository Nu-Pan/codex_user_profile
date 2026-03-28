---
name: codex-self-improvement
description: Use when improving Codex itself rather than product code, especially when editing `~/.codex/config.toml`, `.codex/**/*`, `AGENTS.md`, profiles, permissions, or Codex guidance. Use for Codex self-improvement tasks that need minimal-harness rules, config responsibility splitting, or Codex/OpenAI docs contract checks. Do not use for product implementation, ordinary tests, or environment setup.
---

# Codex Self Improvement

## Use when

- `AGENTS.md`、`.codex/**/*`、または Codex 自己改善ルールを記録する user skill を追加・変更するとき
- `profiles`、`developer_instructions`、permissions など Codex の挙動設定を改善するとき
- `~/.codex/config.toml` と `.codex/config.toml` の責務分離を見直すとき

## Do not use when

- `ticket_guys_b_team` 本体の仕様確認や実装だけを行うとき
- テスト追加・修正や開発環境整備が主目的で、Codex 自体の設定は触らないとき

## Goal

この skill は、Codex エージェント自身の挙動を改善するときの最小ルールを定義する。

## Contract first

- `developer_instructions` は Codex の session に追加で注入される developer instructions であり、optional な文字列である。
- `AGENTS.md` は別系統の project guidance であり、Codex は起動時に project root から current working directory まで instruction chain を構築して読む。
- `permissions` と `default_permissions` は文章上のルールではなく hard gate である。
- `instructions` は reserved for future use なので、この repo の運用ルール置き場として使わない。
- `model_instructions_file` は built-in instructions を置き換え、`AGENTS.md` ベースの運用を外すための強い設定なので、通常の repo 運用では使わない。

## Baseline

- profile 名の自己認識に依存しない。
- repo 全体の入口、作業分類、文書ルーティングは `AGENTS.md` を正本とする。
- `developer_instructions` は profile ごとの追加行動契約として扱う。
- durable な個人設定は `~/.codex/config.toml` を基点にし、repo 共有 override が必要な場合だけ `.codex/config.toml` を使う。
- 実際の編集可能範囲は `config.toml` の permissions を hard gate とする。
- repo から確認できる事実は先に回収し、Codex 契約の確認が必要なときだけ OpenAI developer docs MCP を使う。
- まずは Codex が自己改善を始められる最小ハーネスを優先し、周辺自動化へ広げない。
- ユーザーの明示的な許可が無い限り、対象範囲を広げない。

## First checks

- `AGENTS.md`
- `~/.codex/config.toml`
- `.codex/config.toml`
- 変更対象の `.codex/**/*`
- 変更対象がユーザー設定側に及ぶなら、その差分
- 変更対象ファイルに既存の未コミット差分がある場合は、その内容
- Codex や OpenAI developer docs の契約確認が必要な場合だけ、OpenAI developer docs MCP

## Where each rule belongs

### `developer_instructions`

- profile ごとの追加行動契約だけを書く。
- その session で直ちに守るべき role、作業境界、検証基準、報告基準を書く。
- MCP 利用規則は、その profile に固有の義務である場合だけ書く。
- profile 名を推測しなくても成立する自己完結な指示にする。
- `AGENTS.md` や permissions を読まなくても最低限の振る舞いが定まるようにする。
- ただし repo 全体の仕様や長い手順を抱え込ませない。

### `AGENTS.md`

- repo 全体のブートストラップ兼ルータだけを書く。
- 作業分類、必読文書、禁止事項、仕様文書の入口を置く。
- Codex 自己改善タスクの導線は示してよい。
- repo-wide に常時有効な MCP 利用方針だけを置く。
- profile ごとの細かい session 契約は置かない。

### `config.toml` の permissions

- 実際に書ける場所を強制する。
- 文章上のルールだけに依存しない。
- `developer_instructions` で path ごとの write 権限を再定義しない。

### `model_instructions_file`

- built-in instructions を置き換える強い設定なので、通常運用では使わない。
- 採用するなら、`AGENTS.md` 運用を置き換える意図が本当に必要なときだけに限定する。

### `instructions`

- reserved for future use とされているため、この設計対象に含めない。

### `config.toml` の `mcp_servers`

- MCP server の実設定を書く。
- server の有無、`command`、`args`、`url`、`env`、timeout、enabled state など durable preferences を置く。
- 新しい MCP server を追加しただけなら、まずここだけを更新対象として検討する。

## MCP rule placement

- `~/.codex/config.toml`
  - 個人設定として持つ durable preferences を置く。
  - 個人用 profile、permissions、MCP server inventory の正本候補とする。
- `.codex/config.toml`
  - repo 共有 override だけを書く。
  - repo 全員に共有したい profile や project-scoped 設定だけを置く。
- `AGENTS.md`
  - repo-wide に常時有効な MCP 利用方針だけを書く。
  - 新しい MCP server を追加しただけでは追記しない。
- `doc/task/*.md`
  - 特定の作業タイプでだけ必要な MCP 利用判断基準を書く。
  - 例: Codex 自己改善時だけ契約確認で OpenAI developer docs MCP を再確認する。
- `developer_instructions`
  - 特定 profile でだけ必要な MCP 利用契約を書く。
  - server 一覧や接続設定は書かない。

## When adding an MCP server

- まず `~/.codex/config.toml` の `mcp_servers` を確認する。
- repo 共有 override が必要なときだけ `.codex/config.toml` を追加で確認する。
- repo-wide に常時有効な利用方針が新たに必要な場合だけ `AGENTS.md` を更新する。
- 特定の作業タイプでだけ必要な利用判断基準なら対応する `doc/task/*.md` を更新する。
- 特定 profile でだけ必要な追加契約なら `developer_instructions` を更新する。
- 同じ rule を複数箇所に増やさず、最小スコープの置き場所を選ぶ。
- 狭い層で再掲する場合も、server inventory や接続設定は `config.toml` に戻し、行動契約だけを書く。

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

## `developer_instructions` writing style

- 1 行 1 意図の短い箇条書きにする。
- 直接命令形で書く。
- あいまいな努力目標ではなく、観測可能な行動に落とす。
- 原則ではなく、その profile に必要な最小限の契約だけを書く。
- 長くなるルールは `AGENTS.md` や user skill に逃がし、そこには参照だけを書く。

## Template

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
- Codex や OpenAI developer docs の契約確認が必要なら OpenAI developer docs MCP を使う。
```

- この条件付き項目は `codex_meta` のような Codex 自己改善 profile には有効だが、`question` や `spec_doc` の共通要件にはしない。

## Current profile lens

- `question`
  - mission は「質問応答」。
  - allowed modes は「編集しない」「明示依頼がない限り実行しない」。
  - quality bar は「事実・推測・未確認事項を分ける」。
- `codex_meta`
  - mission は「Codex 自己改善」。
  - must read は `AGENTS.md` とこの skill。
  - allowed modes は「最小ハーネスから進める」。
  - 条件付き追加項目として OpenAI developer docs MCP の行を持ってよい。
- `spec_doc`
  - mission は「仕様策定」。
  - allowed modes は「仕様作業を優先し、コード実装に飛ばない」。
  - quality bar は「自己レビューで整合性を点検する」。

## Good examples

- `常に日本語で回答する。`
- `実施前に \`AGENTS.md\` と user skill \`codex-self-improvement\` を確認する。`
- `指示や権限が衝突する場合は編集せず、ユーザーに確認する。`
- `最終報告では、変更内容、成立根拠、未解決事項、制約を述べる。`

## Conditional good example

- `Codex や OpenAI developer docs の契約確認が必要なら OpenAI developer docs MCP を使う。`

## Bad examples

- `この repo の仕様は全部ここに書く。`
- `\`AGENTS.md\` の禁止事項をそのまま全文コピーする。`
- `書き込み可能 path は A, B, C である。`
- `自分は codex_meta profile だと理解して振る舞う。`
- `必ず step by step で思考過程を全部出力する。`

## Reinterpreting `everything-claude-code`

- 永続的な project guidance は `AGENTS.md` 側に寄せる。
- role や mode ごとの狭い追加契約だけを `developer_instructions` に置く。
- 大きな handbook をそのまま profile ごとに埋め込まない。
- 参考にするのは責務分離であり、文面の移植ではない。

## Editable scope

- `AGENTS.md`
- `~/.codex/config.toml`
- `.codex/**/*`
- `~/.agents/skills/codex-self-improvement/**/*`

## Usually do not edit

- `README.md`
- 上記以外の `doc/**/*.md`
- `ticket_guys_b_team` 本体コード
- テストコード
- 依存関係や開発環境設定
- hooks、周辺自動化の追加実装

## OpenAI docs rule

- repo-wide の OpenAI developer docs MCP 利用ルールは `AGENTS.md` の `OpenAI Docs` 節を正本とする。
- この skill では、Codex 自己改善時にその特例をどう扱うかだけを定義する。
- 新しい MCP server を追加しても、この OpenAI Docs 特例にならって `AGENTS.md` に一般 rule を増やさない。
- Codex CLI、`config.toml`、profiles、permissions、`AGENTS.md`、`developer_instructions` に関わる確認では、必ず OpenAI developer docs MCP を使う。
- 記憶だけで設定キーや契約を断定しない。

## Implementation principles

- `developer_instructions` には、その session に必要な最小限の追加契約だけを書く。
- `AGENTS.md` には、repo 全体の入口と文書ルーティングだけを書く。
- 詳細ルールはこの skill に集約し、`AGENTS.md` と `developer_instructions` に同じ細則を重複させない。
- 個人設定として完結する profile や permissions は `~/.codex/config.toml` を優先し、repo 共有 override だけを `.codex/config.toml` に残す。
- MCP rule は `config.toml`、`AGENTS.md`、task 文書、`developer_instructions` のうち最小スコープへ置く。
- 書き込み権限の最小化を優先し、必要以上に writable roots や permissions を広げない。
- 指示と権限のどちらかが矛盾する場合は、実装に進まずユーザー確認を行う。

## Validation

- `developer_instructions` を更新したら、少なくとも 1 回は instruction chain の見え方を確認する。
- 確認候補:
  - `codex --ask-for-approval never "Summarize the current instructions."`
  - `codex --cd <subdir> --ask-for-approval never "Show which instruction files are active."`
  - `codex --ask-for-approval never "$codex-self-improvement Summarize the Codex self-improvement workflow."`
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。

## Self review

最低 1 回、以下を点検すること。

- `developer_instructions`、`AGENTS.md`、permissions の責務分離が崩れていないか
- MCP rule の置き場所が `config.toml`、`AGENTS.md`、task 文書、`developer_instructions` のどれかで一意に説明できるか
- `developer_instructions` を「正本そのもの」と誤解させる表現になっていないか
- profile 名の自己認識を前提にしたルールが紛れ込んでいないか
- 編集可能範囲が必要以上に広がっていないか
- 同じルールが複数箇所に重複していないか
- `instructions` や `model_instructions_file` と責務が混線していないか

## Reporting

- 何を変更したか
- なぜその変更で Codex 自己改善の最小ハーネスとして成立すると判断したか
- 実行した確認内容
- 残っている制約や未解決事項
- `AGENTS.md`、`~/.codex/config.toml`、`.codex/config.toml`、この skill の間に矛盾があればその内容
