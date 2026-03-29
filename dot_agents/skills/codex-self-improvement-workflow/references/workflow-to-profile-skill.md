# Workflow To Profile And Skill

## Purpose

- ユーザーが提示した再利用可能な workflow を、Codex が繰り返し扱える `profile`、`bundle skill`、`component skill` に分解するときの基準を定義する。
- この文書は「どこに何を書くか」と「最小テンプレ」を定め、複数 skill を前提にした設計の迷いを減らす。
- file placement 自体が曖昧な場合は、この文書だけで決め切らず `codex-self-improvement-placement` 側の reference へ戻る。

## Terms

- `profile`: その workflow を実行する session 契約を与える。
- `bundle skill`: workflow 全体の導線、推奨フェーズ順、読むべき reference、component skill への入口を与える。
- `component skill`: 1 つのフェーズ、観点、責務に閉じた詳細手順、判断基準、テンプレ断片を与える。
- `reference`: `references/` 配下の詳細文書を指す。
- `session 契約`: `developer_instructions` に置く追加行動契約を指す。
- `durable 設定`: `config.toml` に置く継続設定を指す。
- workflow で繰り返し使う概念名は、bundle skill または対応 reference のどこかで正本語彙を固定し、component skills 側で別名を増やさない。

## Default model

- 既定では、新しい典型 workflow は `profile` と 1 つの `bundle skill` で表現する。
- workflow に複数の責務やレビュー観点がある場合は、`bundle skill` の下に複数の `component skills` を置く。
- `profile` は session 契約だけを持ち、workflow の本文や役割分担を抱え込まない。
- `bundle skill` は「最初に何を読み、どの順で進め、必要ならどの skill へ降りるか」を示す。
- `component skill` は、その責務に必要な入力条件、期待出力、判断基準だけに閉じる。
- `reference` は、各 skill から必要時にだけ読む詳細手順と例外条件を持つ。
- フェーズ順は既定では推奨順序であり、hard gate にはしない。往復や省略があり得る場合は `bundle skill` 側で条件を説明する。
- 同じ workflow を profile だけで表現しようとして `developer_instructions` が長くなるなら、詳細は `bundle skill` と `component skill` に逃がす。
- 同じ workflow を skills だけで表現しようとして sandbox、報告基準、must-read、allowed modes が曖昧になるなら、対応 profile を追加する。

## When to add each artifact

### `profile`

- session の mission が既存 profile と明確に異なる。
- allowed modes、quality bar、報告基準、must-read が既存 profile では不足する。
- sandbox、network、approval、model など durable な実行前提を workflow ごとに切り替えたい。
- その workflow を呼ぶたびに、同じ追加行動契約を毎回 prompt に書かせたくない。

### `bundle skill`

- workflow 全体の導線を 1 つの入口で示したい。
- 同じ workflow で複数のフェーズ、観点、役割を使い分ける。
- `developer_instructions` から複数 skill を直接列挙するより、1 つの入口に集約したい。
- 途中で読むべき reference や、component skill の選び方を再利用したい。

### `component skill`

- planner、checker、executor、reviewer のように責務が明確に分かれる。
- そのフェーズだけで再利用できる手順、判断基準、テンプレ断片がある。
- 入力条件と期待出力を、その skill 単体で短く説明できる。
- workflow 全体を繰り返さず、局所責務だけに閉じた説明へ分割できる。

### one skill で足りる場合

- workflow が単一フェーズで完結し、導線と局所手順を分ける利得が小さい。
- 追加の役割分割をしても、責務より重複の方が増える。
- `developer_instructions` から読ませる入口が 1 つで十分で、component skill を経由させる理由が弱い。

### `profile` + 複数 skill が要る場合

- session 契約の追加と、workflow 全体の導線と、再利用可能な局所手順のすべてが必要である。
- 既定では、複数責務を持つ workflow は `profile` + `bundle skill` + 必要な `component skills` の組で表現する。
- 例外として、単なる durable 設定差分だけなら profile だけでよい。
- 例外として、既存 profile の行動契約で十分なら、`bundle skill` と `component skill` だけでよい。

## Decomposition recipe

1. workflow から mission、must-read、allowed modes、quality bar、衝突時の扱い、報告要件だけを抜き出し、`developer_instructions` に入れる。
2. workflow から end-to-end の導線、推奨フェーズ順、component skill への handoff を抜き出し、`bundle skill` に入れる。
3. workflow から再利用可能な局所手順、判断基準、テンプレ断片を抜き出し、`component skill` と `references/` に入れる。
4. workflow 全体で使う概念名は、bundle skill または対応 reference で正本化し、component skills と `references/` で別名を増やさない。
5. durable 設定だけを抜き出し、`config.toml` に入れる。
6. repo-wide router が本当に必要かを最後に判断し、必要なときだけ `AGENTS.md` を触る。
7. 同じ rule を `developer_instructions`、`bundle skill`、`component skill` に重複させない。

## Default placement summary

- file placement の詳細ルールは `codex-self-improvement-placement` 側を正本とし、ここでは workflow 分解に必要な既定だけを扱う。

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
- 既定では、must-read には `AGENTS.md` と `bundle skill` だけを明示する。
- `component skill` を直接 must-read に並べるのは例外であり、`bundle skill` を経由すると入口が壊れる場合だけに限る。
- 詳細 workflow や長いテンプレ本文は書かない。
- 詳細は `bundle skill` と、そこから辿る関連 skill / `references/` を参照する一文に留める。

### `~/.agents/skills/<bundle-name>/SKILL.md`

- skill 名は `lower-hyphen-case` を既定にする。
- trigger 条件、目的、推奨フェーズ順、component skill の導線、reference map を置く。
- session 契約の正本にはならない。
- 各フェーズの細かい手順は抱え込まず、必要な `component skills` や reference への入口に留める。

### `~/.agents/skills/<component-name>/SKILL.md`

- skill 名は `lower-hyphen-case` を既定にする。
- trigger 条件、担当フェーズ、入力条件、期待出力、局所判断基準、reference map を置く。
- workflow 全体の導線や session 契約の正本にはならない。
- 他フェーズの手順は再掲しない。

### `~/.agents/skills/<name>/references/`

- 詳細手順、判断基準、変換ルール、テンプレ断片、variant ごとの注意点を置く。
- end-to-end の段取りやフェーズ間の受け渡しは `bundle skill` 側の reference に置く。
- フェーズ局所の深い判断基準は `component skill` 側の reference に置く。
- 既存 reference で受けきれないときだけ新規ファイルを足す。

## Minimal profile template

```toml
[profiles.<profile_name>]
sandbox_mode = "workspace-write"
developer_instructions = """
- 常に <language> で回答する。
- この session の目的は <mission> である。
- 実施前に `AGENTS.md` と user skill `<bundle-skill-name>` を確認し、そこを正本として扱う。
- この session では <allowed_modes> だけを扱う。
- 詳細な workflow、推奨フェーズ順、component skill への導線は user skill `<bundle-skill-name>` と、そこから辿る関連 skill / `references/` を参照する。
- <quality_bar> を満たすまで作業を打ち切らない。
- 指示や権限が衝突する場合は編集せず、ユーザーに確認する。
- 最終報告では <reporting_items> を述べる。
"""
```

- network、approval、model はその workflow に必要な場合だけ追加する。
- `developer_instructions` は template の可変項目を埋めるだけに留め、workflow 本文の置き場所にしない。

## Minimal bundle skill template

```markdown
---
name: <bundle-skill-name>
description: Use when <trigger condition>. Use for <workflow>. Do not use for <out-of-scope>.
---

# <Bundle Skill Title>

## Use when

- <trigger condition>

## Purpose

- この skill は <workflow> 全体の導線、推奨フェーズ順、component skill への入口を定義する。
- session 契約の正本は対応 profile の `developer_instructions` とする。

## Recommended flow

1. <phase 1>
2. <phase 2>
3. <phase 3>

- 往復や省略があり得る条件があるなら、ここで短く述べる。

## Component skills

- `<component-skill-a>`: <phase or responsibility>
- `<component-skill-b>`: <phase or responsibility>

## Quick start

- `AGENTS.md` と必要な reference を確認する。
- まず <first orchestration step> を行う。

## Reference map

- [`references/<doc>.md`](references/<doc>.md)
  - <when to read>
```

- `bundle skill` は、workflow 全文の置き場所ではなく、入口と導線の置き場所として使う。
- `bundle skill` が長くなり始めたら、詳細手順は `component skill` 側の skill / reference へ移す。

## Minimal component skill template

```markdown
---
name: <component-skill-name>
description: Use when <trigger condition>. Use for <phase responsibility>. Do not use for <out-of-scope>.
---

# <Component Skill Title>

## Use when

- <trigger condition>

## Purpose

- この skill は <phase responsibility> に必要な再利用可能な詳細手順と判断基準を定義する。
- workflow 全体の導線は対応する `bundle skill` を正本とする。

## Inputs

- <required inputs or preconditions>

## Outputs

- <expected deliverables>

## Quick start

- 必要な reference を確認する。
- まず <first local step> を行う。

## Reference map

- [`references/<doc>.md`](references/<doc>.md)
  - <when to read>
```

- `component skill` は、他フェーズの段取りや session 契約を再掲しない。
- `agents/openai.yaml` は UI metadata が必要になったときだけ追加する。

## Representative example: 修正 workflow

- `profile`
  - 目的は「高品質な修正作業を行う」。
  - must-read は `AGENTS.md` と修正 workflow の `bundle skill` に留める。
- `bundle skill`
  - 推奨順序として「修正プラン作成 -> プラン妥当性確認 -> 修正実施 -> 修正結果レビュー」を示す。
  - プラン差し戻しや実装後の再計画があり得るなら、その往復条件をここで説明する。
- `component skill`
  - `fix-plan`: 修正方針、影響範囲、変更案を作る。
  - `fix-plan-review`: plan の穴、リスク、確認不足を指摘する。
  - `fix-implementation`: 承認済み plan に沿って修正する。
  - `fix-result-review`: 変更結果の妥当性、回帰、検証不足を確認する。

## Validation defaults

- 自動 validation は、既定で非 TTY の `codex exec` だけを使う。
- 自動 validation の model は、既定で `gpt-5.4-mini` を指定する。
- 軽量 model で確認できる導線、局所責務、責務分離だけを自動 validation の対象にする。
- TTY 前提の対話的確認は人間向け手動確認として別扱いにし、Codex の自動 validation 候補には入れない。
- `codex exec -m gpt-5.4-mini -p <profile_name> "Summarize the current mission, allowed modes, and must-read documents in 3 bullets."` で profile の見え方を確認する。
- `codex exec -m gpt-5.4-mini '$<bundle-skill-name> Summarize this workflow, the recommended phases, and which component skills you would read.'` で `bundle skill` の導線を確認する。
- `codex exec -m gpt-5.4-mini '$<component-skill-name> Summarize your phase, inputs, outputs, local decision criteria, and reference map in 4 bullets.'` で `component skill` の局所責務を確認する。
- `codex exec -m gpt-5.4-mini -p <profile_name> '$<bundle-skill-name> Summarize how this workflow is split between developer_instructions, bundle skill, component skills, references, and config.toml in 4 bullets.'` で責務分離を確認する。
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。
