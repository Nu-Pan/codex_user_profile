# Workflow To Profile And Skill

## Purpose

- ユーザーが提示した再利用可能な workflow を、Codex が繰り返し扱える `profile` と `skill` に分解するときの基準を定義する。
- この文書は「どこに何を書くか」と「最小テンプレ」を定め、実装時の迷いを減らす。

## Default story

- `profile` は、その workflow を実行する session 契約を与える。
- `skill` は、その workflow で繰り返し使う詳細手順、判断基準、参照資料、テンプレ断片を与える。
- 同じ workflow を profile だけで表現しようとして `developer_instructions` が長くなるなら、詳細は対応 skill に逃がす。
- 同じ workflow を skill だけで表現しようとして sandbox、報告基準、must-read、allowed modes が曖昧になるなら、対応 profile を追加する。

## When to add a profile

- session の mission が既存 profile と明確に異なる。
- allowed modes、quality bar、報告基準、must-read が既存 profile では不足する。
- sandbox、network、approval、model など durable な実行前提を workflow ごとに切り替えたい。
- その workflow を呼ぶたびに、同じ追加行動契約を毎回 prompt に書かせたくない。

## When to add a skill

- 具体的な作業手順、判断基準、参照先、テンプレ断片が再利用可能である。
- `developer_instructions` に入れるには長すぎる詳細 workflow がある。
- その workflow の trigger を metadata で拾えるようにしたい。
- 実装時にだけ読む詳細 reference を分離したい。

## When to add both

- session 契約の追加と、再利用可能な詳細 workflow の両方が必要である。
- 既定では、新しい典型 workflow は `profile` と対応 `skill` の組で表現する。
- 例外として、単なる durable 設定差分だけなら profile だけでよい。
- 例外として、既存 profile の行動契約で十分なら skill だけでよい。

## Default placement

### `AGENTS.md`

- repo 全体の router だけを書く。
- 新しい workflow のために repo-wide 導線が本当に必要な場合だけ更新する。
- profile や skill を追加しただけで、既定ではここを増やさない。

### `~/.codex/config.toml`

- `profiles.<name>` を追加する。
- profile 名は `lower_snake_case` を既定にする。
- durable な sandbox、network、approval、model、`developer_instructions` を置く。

### `profiles.<name>.developer_instructions`

- mission、must-read、allowed modes、quality bar、衝突時の扱い、最終報告要件だけを書く。
- 対応 skill が前提なら、must-read に user skill 名を明示してよい。
- 詳細 workflow や長いテンプレ本文は書かない。
- 詳細は対応 skill と `references/` を参照する一文に留める。

### `~/.agents/skills/<name>/SKILL.md`

- skill 名は `lower-hyphen-case` を既定にする。
- trigger 条件、目的、quick start、reference map を置く。
- session 契約の正本にはならない。
- 長い手順はここに抱え込まず、必要な reference への導線だけを置く。

### `~/.agents/skills/<name>/references/`

- 詳細手順、判断基準、変換ルール、テンプレ断片、variant ごとの注意点を置く。
- 既存 reference で受けきれないときだけ新規ファイルを足す。
- 1 つの workflow で複数 variant がある場合は、SKILL.md から直接たどれる 1 段構成に留める。

## Workflow decomposition checklist

- workflow から session 契約だけを抜き出し、`developer_instructions` に入れる。
- workflow から再利用可能な詳細手順を抜き出し、skill と `references/` に入れる。
- durable 設定だけを抜き出し、`config.toml` に入れる。
- repo-wide router が本当に必要かを最後に判断し、必要なときだけ `AGENTS.md` を触る。
- 同じ rule を `developer_instructions` と skill の両方へ重複させない。

## Minimal profile template

```toml
[profiles.<profile_name>]
sandbox_mode = "workspace-write"
developer_instructions = """
- 常に <language> で回答する。
- この session の目的は <mission> である。
- 実施前に `AGENTS.md` と user skill `<skill-name>` を確認し、そこを正本として扱う。
- この session では <allowed_modes> だけを扱う。
- 詳細な workflow、判断基準、テンプレ断片は user skill `<skill-name>` とその `references/` を参照する。
- <quality_bar> を満たすまで作業を打ち切らない。
- 指示や権限が衝突する場合は編集せず、ユーザーに確認する。
- 最終報告では <reporting_items> を述べる。
"""
```

- network、approval、model はその workflow に必要な場合だけ追加する。
- `developer_instructions` は template の可変項目を埋めるだけに留め、workflow 本文の置き場所にしない。

## Minimal skill template

```markdown
---
name: <skill-name>
description: Use when <trigger condition>. Use for <workflow>. Do not use for <out-of-scope>.
---

# <Skill Title>

## Use when

- <trigger condition>

## Purpose

- この skill は <workflow> の再利用可能な詳細手順と判断基準を定義する。
- session 契約の正本は対応 profile の `developer_instructions` とする。

## Quick start

- `AGENTS.md` と必要な reference を確認する。
- まず <first decomposition step> を行う。

## Reference map

- [`references/<doc>.md`](references/<doc>.md)
  - <when to read>
```

- SKILL.md が長くなり始めたら、手順詳細は `references/` へ移す。
- `agents/openai.yaml` は UI metadata が必要になったときだけ追加する。

## Validation defaults

- `codex exec -p <profile_name> "Summarize the current mission, allowed modes, and must-read documents."` で profile の見え方を確認する。
- `codex exec '$<skill-name> Summarize this workflow and which references you would read first.'` で skill の trigger と導線を確認する。
- `codex exec -p <profile_name> '$<skill-name> Explain how this workflow is split between developer_instructions, SKILL.md, references, and config.toml.'` で責務分離を確認する。
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。
