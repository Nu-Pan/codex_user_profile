# Workflow To Profile, Root Skill, And Roles

## Purpose

- ユーザーが提示した再利用可能な workflow を、Codex が繰り返し扱える `profile`、root skill、child agent roles、role config、`references/` に分解するときの基準を定義する。
- この文書は「どこに何を書くか」と「最小テンプレ」を定め、role-based self-improvement workflow の迷いを減らす。
- file placement 自体が曖昧な場合は、この文書だけで決め切らず `codex-self-improvement-placement` 側の reference へ戻る。

## Terms

- `profile`: その workflow を実行する session 契約を与える。
- `root skill`: workflow 全体の導線、推奨 role sequence、読むべき reference、child agent への入口を与える。
- `child agent role`: 1 つの責務だけを持つ focused な agent type を指す。
- `role config`: child agent role に適用する model / reasoning tier 用の TOML layer を指す。
- `reference`: `references/` 配下の詳細文書を指す。
- `session 契約`: `developer_instructions` に置く追加行動契約を指す。
- `durable 設定`: `config.toml` に置く継続設定を指す。

## Default model

- 既定では、新しい典型 workflow は `profile` と 1 つの root skill で表現する。
- workflow に複数の責務やレビュー観点がある場合は、root skill の下に複数の child agent roles を置く。
- `profile` は session 契約だけを持ち、workflow の本文や role 分担を抱え込まない。
- root skill は「最初に何を読み、どの順で進め、必要ならどの role を起動するか」を示す。
- child agent role は、その責務に必要な入力条件、期待出力、write policy だけに閉じる。
- role config は、既定では model、reasoning、verbosity の tier だけを持つ。
- `reference` は、各 role から必要時にだけ読む詳細手順と例外条件を持つ。
- role sequence は既定では推奨順序であり、hard gate にはしない。往復や省略があり得る場合は root skill 側で条件を説明する。

## When to add each artifact

### `profile`

- session の mission が既存 profile と明確に異なる。
- allowed modes、quality bar、報告基準、must-read が既存 profile では不足する。
- sandbox、network、approval、model など durable な実行前提を workflow ごとに切り替えたい。

### root skill

- workflow 全体の導線を 1 つの入口で示したい。
- 同じ workflow で複数の child agent role を使い分ける。
- must-read と spawn policy を再利用したい。

### child agent role

- planner、placement analyst、editor、auditor のように責務が明確に分かれる。
- その責務だけで再利用できる入力条件、期待出力、判断基準がある。
- root session にその責務を抱え込ませると model cost か prompt 長が増える。

### role config

- その role だけ model / reasoning tier を root と変えたい。
- 同じ role を繰り返し起動するとき、毎回 CLI override で指定したくない。
- role 固有の session 契約は不要で、durable な推論 tier だけを固定したい。

### `reference`

- role に閉じた詳細手順、判断基準、例外条件、短いテンプレ断片がある。
- root skill に長い説明を載せず、必要時だけ読ませたい。

## Decomposition recipe

1. workflow から mission、must-read、allowed modes、quality bar、衝突時の扱い、報告要件だけを抜き出し、`developer_instructions` に入れる。
2. workflow から end-to-end の導線、推奨 role sequence、child agent への handoff を抜き出し、root skill に入れる。
3. workflow から focused な責務を抜き出し、child agent role に切る。
4. role ごとに必要な model / reasoning tier だけを抜き出し、role config に入れる。
5. role ごとの再利用可能な詳細手順、判断基準、テンプレ断片を `references/` に入れる。
6. durable 設定だけを抜き出し、`config.toml` に入れる。
7. repo-wide router が本当に必要かを最後に判断し、必要なときだけ `AGENTS.md` を触る。

## Default placement summary

### `AGENTS.md`

- repo 全体の router だけを書く。
- 新しい workflow のために repo-wide 導線が本当に必要な場合だけ更新する。

### `~/.codex/config.toml`

- `profiles.<name>` を追加する。
- `agents.<role>` と `config_file` の対応を書く。
- durable な sandbox、network、approval、model、`developer_instructions` を置く。

### `profiles.<name>.developer_instructions`

- mission、must-read、allowed modes、quality bar、衝突時の扱い、最終報告要件だけを書く。
- 既定では、must-read には `AGENTS.md` と root skill だけを明示する。
- child agent role を直接 must-read に並べるのは例外であり、root skill を経由すると入口が壊れる場合だけに限る。
- 詳細 workflow や長いテンプレ本文は書かない。

### `~/.agents/skills/<root-skill-name>/SKILL.md`

- trigger 条件、目的、推奨 role sequence、child agent role の導線、reference map を置く。
- session 契約の正本にはならない。

### `~/.agents/skills/<root-skill-name>/agent_roles/*.toml`

- child agent role ごとの model / reasoning / verbosity tier だけを置く。
- role 固有の session 契約は置かない。

### `~/.agents/skills/<name>/references/`

- workflow routing、role contract、判断基準、テンプレ断片、variant ごとの差分を書く。
- role ごとの局所判断基準は、その role が読む reference 側へ置く。

## Minimal profile template

```toml
[profiles.<profile_name>]
sandbox_mode = "workspace-write"
developer_instructions = """
- 常に <language> で回答する。
- この session の目的は <mission> である。
- 実施前に `AGENTS.md` と user skill `<root-skill-name>` を確認し、そこを正本として扱う。
- この session では <allowed_modes> だけを扱う。
- 詳細な workflow、role sequence、spawn policy は user skill `<root-skill-name>` と、そこから辿る関連 `references/` を参照する。
- <quality_bar> を満たすまで作業を打ち切らない。
- 指示や権限が衝突する場合は編集せず、ユーザーに確認する。
- 最終報告では <reporting_items> を述べる。
"""
```

## Minimal role config template

```toml
model = "<model>"
model_reasoning_effort = "<effort>"
model_verbosity = "<verbosity>"
```

- role config には、既定では model tier 以外を入れない。

## Representative example

- `profile`
  - 目的は「Codex 自己改善」。
  - must-read は `AGENTS.md` と root skill `codex-self-improvement` に留める。
- root skill
  - 推奨順序として「現状確認 -> role 選定 -> 必要な child agent 起動 -> audit」を示す。
- child agent roles
  - `si_scope`: placement と editable scope を決める。
  - `si_design`: workflow / role split を設計する。
  - `si_editor`: 承認済み write scope を更新する。
  - `si_audit`: diff と validation を点検する。

## Validation defaults

- 自動 validation は、既定で非 TTY の `codex exec` だけを使う。
- 自動 validation の model は、既定で `gpt-5.4-mini` を指定する。
- 軽量 model で確認できる導線、局所責務、責務分離だけを自動 validation の対象にする。
- `codex exec -m gpt-5.4-mini -p <profile_name> "Summarize the current mission, allowed modes, and must-read documents in 3 bullets."` で profile の見え方を確認する。
- `codex exec -m gpt-5.4-mini -p <profile_name> '$<root-skill-name> Summarize the canonical roles, default spawn policy, and recommended role sequence in 4 bullets.'` で root skill の導線を確認する。
- `codex exec -m gpt-5.4-mini -p <profile_name> '$<root-skill-name> Given a request that changes placement rules, state which child roles you would use and in what order.'` で role routing を確認する。
- instruction や skill が古く見える場合は、Codex を対象 directory で再起動して確認する。
