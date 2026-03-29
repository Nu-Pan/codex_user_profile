# Workflow To Profile, Root Skill, And Roles

## Purpose

- ユーザーが提示した再利用可能な workflow を、`AGENTS.md`、profile-level `developer_instructions`、root skill、child agent roles、role config、`references/` に分解するときの基準を定義する。
- この文書は「どこに何を書くか」と「どこに書かないか」を定め、root router contract と child role bootstrap contract を混同しないためのものだ。
- file placement 自体が曖昧な場合は、この文書だけで決め切らず `references/config-and-rule-placement.md` へ戻る。

## Terms

- `AGENTS.md`: root agent と child agent の両方に共通する最小規約を置く。
- `profile-level developer_instructions`: root profile の router / orchestrator 契約を置く。
- `root skill`: workflow 全体の導線、推奨 role sequence、読むべき reference、child agent への入口を与える。
- `child agent role`: 1 つの責務だけを持つ focused な agent type を指す。
- `role config`: child agent role に適用する standalone custom agent TOML layer を指す。`name`、`description`、`developer_instructions`、`model`、`model_reasoning_effort`、`model_verbosity`、`sandbox_mode` を置く。
- `reference`: `references/` 配下の詳細文書を指す。
- `durable 設定`: `config.toml` に置く継続設定を指す。

## Default split

- `AGENTS.md` は共有規約だけを持つ。
- profile-level `developer_instructions` は root router contract だけを持つ。
- root skill は trigger、推奨 role sequence、reference map を持つ。
- child agent role は 1 つの責務だけを持つ。
- role config は model tier と role-local bootstrap を持つ。
- `reference` は詳細手順、判断基準、例外条件を持つ。
- role sequence は推奨順序であり、hard gate にしない。

## When to add each artifact

### `AGENTS.md`

- shared rule が既存 guidance と明確に異なる。
- 共有して守る品質基準、自己レビュー基準、報告基準、must-read が既存 guidance では不足する。
- root / child 共通の最小規約を明示したい。
- repo-wide に常時有効な router を置きたい場合は、routing ではなく shared rule の範囲だけを書く。

### profile-level `developer_instructions`

- root profile の mission が必要である。
- root profile を router / orchestrator に限定したい。
- Codex CLI に何かをさせる前に、対応する custom skill と child role を先に用意したい。
- task framing、child role 選定、child agent 起動、最小 handoff、完了待機、最終統合を profile の契約として固定したい。

### root skill

- workflow 全体の導線を 1 つの入口で示したい。
- 同じ workflow で複数の child agent role を使い分ける。
- must-read と spawn policy を再利用したい。
- root session に実作業を抱え込ませたくない。

### child agent role

- planner、placement analyst、editor、auditor のように責務が明確に分かれる。
- その責務だけで再利用できる入力条件、期待出力、判断基準がある。
- root session にその責務を抱え込ませると model cost か prompt 長が増える。

### role config

- その role だけ `model` / `model_reasoning_effort` / `model_verbosity` tier を root と変えたい。
- その role だけ sandbox_mode のような capability も root と変えたい。
- その role だけの developer_instructions、read-first docs、bootstrap 条件を role-local に閉じたい。
- 同じ role を繰り返し起動するとき、毎回 CLI override で指定したくない。
- role 固有の router contract は不要で、durable な推論 tier と role-local contract を固定したい。
- `model` / `model_reasoning_effort` / `model_verbosity` tier の選定原則は [`references/model-selection.md`](model-selection.md) を正本とする。
- child agent role の `.toml` は OpenAI 公式 docs の一般原則に従って埋める。Agents SDK 前提の構成はこの path では使わない。
- role config には選定結果と role-local contract を置き、判断基準の本文は置かない。

### `reference`

- role に閉じた詳細手順、判断基準、例外条件、短いテンプレ断片がある。
- root skill に長い説明を載せず、必要時だけ読ませたい。

## Decomposition recipe

1. workflow から mission、must-read、allowed modes、quality bar、衝突時の扱い、報告要件だけを抜き出し、`AGENTS.md` と profile-level `developer_instructions` に分けて入れる。
2. workflow から end-to-end の導線、推奨 role sequence、child agent への handoff を抜き出し、root skill に入れる。
3. workflow から focused な責務を抜き出し、child agent role に切る。
4. child agent role の contract には、最低限の入力と local bootstrap 条件を必ず書く。root の handoff が不完全でも動く前提で分解する。
5. role ごとに必要な `model` / `model_reasoning_effort` / `model_verbosity` tier を中心に抜き出し、OpenAI 公式 docs の一般原則に沿う設定として role config に入れる。
6. role ごとの再利用可能な詳細手順、判断基準、テンプレ断片を `references/` に入れる。
7. durable 設定だけを抜き出し、`config.toml` に入れる。
8. root router contract が本当に必要かを最後に判断し、必要なときだけ profile-level `developer_instructions` を触る。router は起動導線だけを持ち、実作業は child agent に委ねる。
9. validation の詳細は [`workflow-checklist.md`](workflow-checklist.md) を正本とする。

## Placement note

- 置き場所の正本は [`references/config-and-rule-placement.md`](config-and-rule-placement.md) とする。
- ここでは workflow を profile、root skill、child agent role、role config、references に切る観点だけを残す。

## Minimal templates

### profile-level template

```md
- 常に <language> で回答する。
- この session の目的は <mission> である。
- 実施前に `AGENTS.md` と root skill `<root-skill-name>` を確認し、`~/.codex/config.toml` の profile-level `developer_instructions` を共通の root router contract として扱う。
- この session では <allowed_modes> だけを扱う。
- 詳細な workflow、role sequence、spawn policy は root skill `<root-skill-name>` と、そこから辿る関連 `references/` を参照する。
- <quality_bar> を満たすまで作業を打ち切らない。
- 指示や権限が衝突する場合は編集せず、ユーザーに確認する。
- 最終報告では <reporting_items> を述べる。
```

```toml
[profiles.<profile_name>]
sandbox_mode = "workspace-write"
model = "<model>"
model_reasoning_effort = "<effort>"
model_verbosity = "<verbosity>"
developer_instructions = """
<profile-level contract>
"""
```

- profile-level の契約は `AGENTS.md` の共有規約と分け、`config.toml` には durable 設定と root router contract を残す。

### role config template

```toml
name = "<role-name>"
description = "<one-line mission>"
developer_instructions = """
- 常に <language> で回答する。
- この role の目的は <mission> である。
- 実施前に <read-first docs> を読む。
- root handoff が薄い前提で <bootstrap steps> を行う。
- <output contract> を返す。
- repo-tracked file は編集しない。
"""
model = "<model>"
model_reasoning_effort = "<effort>"
model_verbosity = "<verbosity>"
sandbox_mode = "<read-only|workspace-write>"
```

- これは基本形であり、role config には OpenAI 公式 docs の一般原則に沿う必要最小限の追加設定を置いてよい。
- たとえば、`si_scope` / `si_design` / `si_audit` は `sandbox_mode = "read-only"`、`si_editor` は `sandbox_mode = "workspace-write"` にする。
- `developer_instructions` には、その role が読む `references/` を短く明示する。

### root skill template

```markdown
---
name: <root-skill-name>
description: Use when <trigger condition>. Use for <workflow>. Do not use for <out-of-scope>.
---

# <Root Skill Title>

## Use when

- <trigger condition>

## Purpose

- この skill は <workflow> 全体の導線、推奨 role sequence、child agent role への入口を定義し、実作業は child agent role に委ねる。
- 共通規約は `AGENTS.md`、root router contract は `~/.codex/config.toml` の profile-level `developer_instructions`、child agent role の read-first docs は各 role config に閉じる。
- child agent role は、root handoff が最小でも local docs と local artifacts から自己起動できる前提で扱う。

## Recommended flow

1. <phase 1>
2. <phase 2>
3. <phase 3>

- 往復や省略があり得る条件があるなら、ここで短く述べる。

## Child agent roles

- `<child-agent-role-a>`: <phase or responsibility>
- `<child-agent-role-b>`: <phase or responsibility>
- child agent role の具体的な read-first docs は各 role config に閉じる。

## Quick start

- `AGENTS.md` と必要な reference を確認する。
- まず <first orchestration step> を行う。
- child agent に渡す handoff は task summary、対象ファイル、明示した制約、観測済みの local facts に絞る。

## Reference map

- [`references/<doc>.md`](references/<doc>.md)
  - <when to read>
```
