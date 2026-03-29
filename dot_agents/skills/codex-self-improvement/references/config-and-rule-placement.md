# Config And Rule Placement

## Contract facts

- `AGENTS.md` は project guidance であり、Codex は起動時に instruction chain を構築して読む。
- `agent_roles/*.toml` の `developer_instructions` は、child agent role の role-local bootstrap contract として扱う。
- `~/.codex/config.toml` は durable 設定の置き場所であり、この skill family では profile-level `developer_instructions` を置かない。
- `permissions` と `default_permissions` は、使う場合は文章上のルールではなく hard gate である。
- `instructions` は reserved for future use なので、この repo の運用ルール置き場として使わない。
- `model_instructions_file` は built-in instructions を置き換える強い設定であり、通常の repo 運用では使わない。

## Default stance

- repo 全体の入口、作業分類、文書ルーティングは `AGENTS.md` を正本とする。
- `codex_meta` の session 契約は `AGENTS.md` に置き、`~/.codex/config.toml` には置かない。
- child agent role の `developer_instructions` は `agent_roles/*.toml` に置く role-local bootstrap contract として扱う。
- durable 設定は `~/.codex/config.toml` を基点にし、repo 共有 override が必要な場合だけ `.codex/config.toml` を使う。
- repo-scoped `.codex/config.toml` や task 文書は、存在する repo でだけ前提にする。
- `permissions` は、実際の編集可能範囲を hard gate で強制したいときだけ採用する。
- 可搬性と HOME 配下の `permissions` が衝突する場合は、sandbox ベース運用への切り替えを先に検討する。
- repo から確認できる事実は先に回収し、Codex 契約の確認が必要なときだけ OpenAI developer docs MCP を使う。
- まずは Codex が自己改善を始められる最小ハーネスを優先し、周辺自動化へ広げない。
- ユーザーの明示的な許可が無い限り、対象範囲を広げない。

## Placement order

1. その変更が repo-wide router、session 契約、durable 設定、hard gate、task-local guidance のどれかを決める。
2. 共有範囲が repo-wide か、profile-local か、user-local か、task-local かを決める。
3. path を説明するときは canonical path か local working path かを切り分ける。
4. 可搬性と hard gate が衝突するなら、まず `permissions` 撤廃か sandbox ベース運用を検討する。

## Path visibility rule

- guidance、最終報告、他のリポジトリから参照される説明で path を示すときは、deploy 後に見える `~/.codex/...` / `~/.agents/...` を canonical path とする。
- `dot_codex/...` / `dot_agents/...` は、HOME 配下設定を mirror した checkout 上で実ファイルを編集するときだけ使う local working path であり、一般 guidance の正本にはしない。
- repo 固有の mirror path を、cross-repo の guidance や path 契約へ持ち出さない。

## Placement matrix

### `AGENTS.md`

- repo 全体の bootstrapping と router だけを書く。
- router の実行手順や作業本文は置かない。
- 作業分類、必読文書、禁止事項、仕様文書の入口を置く。
- `codex_meta` の session 契約もここに置く。
- Codex 自己改善タスクの導線は示してよい。
- repo-wide に常時有効な MCP 利用方針だけを置く。
- `~/.codex/config.toml` の profile-level `developer_instructions` は使わない。

### `developer_instructions`

- child agent role の追加行動契約だけを書く。
- その role で直ちに守るべき read-first docs、作業境界、検証基準、報告基準を書く。
- role 名を推測しなくても成立する自己完結な指示にする。
- `AGENTS.md` や permissions を読まなくても最低限の振る舞いが定まるようにする。
- repo 全体の仕様や長い手順を抱え込ませない。

### `~/.codex/config.toml`

- 個人設定として持つ durable 設定を置く。
- 個人用 profile、permissions、MCP server inventory の正本候補とする。
- profile-level の `developer_instructions` は置かない。
- 新しい MCP server を追加しただけなら、まず `mcp_servers` の更新可否をここで確認する。

### `~/.agents/skills/<root-skill-name>/agent_roles/*.toml`

- child agent role の standalone custom agent config を置く。
- `name`、`description`、`developer_instructions`、`model`、`model_reasoning_effort`、`model_verbosity`、`sandbox_mode` を置く。
- role-local の read-first docs と bootstrap 条件はここに閉じる。
- role-local な詳細判断の本文は `references/` に逃がす。

### `.codex/config.toml`

- repo 共有 override だけを書く。
- repo 全員に共有したい profile や project-scoped 設定だけを置く。
- 個人設定として完結する profile や permissions は持ち込まず、repo 共有に必要な差分だけを残す。

### `config.toml` の permissions

- 実際に書ける場所を hard gate で強制したいときだけ使う。
- 使う場合は文章上のルールだけに依存しない。
- `permissions.<name>.filesystem` のキーには絶対パスか特別トークンだけを使う。
- 共有設定では `~` や `$HOME` を起点にした擬似相対表記を前提にしない。
- project 配下だけで足りる場合は `:project_roots` を優先する。
- HOME 配下への権限が必要で、共有設定の可搬性を壊すなら、既定では `permissions` を撤廃して sandbox ベースで運用する。
- install 時に user-local config を生成して hard gate を維持する案は、ユーザーが明示的にそれを選んだ場合だけ採る。
- `developer_instructions` で path ごとの write 権限を再定義しない。

### `config.toml` の `mcp_servers`

- MCP server の実設定を書く。
- server の有無、`command`、`args`、`url`、`env`、timeout、enabled state など durable 設定を置く。

### task 文書（存在する場合）

- 特定の作業タイプでだけ必要な MCP 利用判断基準を書く。
- 例: Codex 自己改善時だけ契約確認で OpenAI developer docs MCP を再確認する。

### user skill の `SKILL.md`

- root skill なら、再利用可能な workflow の trigger、目的、推奨 role sequence、child agent role への導線、reference map を書く。
- root skill なら、child agent が root handoff の不足を local docs と local artifacts で埋められる前提も明示する。
- compatibility skill なら、旧 skill 名から canonical な root skill と child agent role へ handoff する導線を書く。
- session 契約や durable 設定の正本にはしない。
- 長い手順や variant ごとの詳細は `references/` と role contract へ逃がす。

### user skill の `references/`

- workflow の詳細手順、判断基準、テンプレ断片、variant ごとの差分を書く。
- end-to-end の導線や role 間の受け渡しは root skill 側の reference に置く。
- role 局所の深い判断基準は対応する reference や role contract に置く。
- role が自力で再開するための local bootstrap 条件は、必要なら agent_roles/*.toml の developer_instructions に置く。
- SKILL.md から必要時にだけ読める構成にする。
- 同じ詳細 rule を `developer_instructions` に再掲しない。

### `model_instructions_file`

- built-in instructions を置き換える強い設定なので、通常運用では使わない。
- 採用するなら、`AGENTS.md` 運用を置き換える意図が本当に必要なときだけに限定する。

### `instructions`

- reserved for future use とされているため、この設計対象に含めない。

## MCP rule placement

- `~/.codex/config.toml` に durable 設定と server inventory を置く。
- `.codex/config.toml` には repo 共有 override だけを置く。
- `AGENTS.md` には repo-wide に常時有効な MCP 利用方針と、Codex 自己改善タスク時の session 契約入口を書く。
- task 文書がある repo では、その文書に特定作業タイプだけに必要な判断基準を書く。
- child agent role の `developer_instructions` には、その role に必要な追加契約だけを書く。
- 同じ rule を複数箇所に増やさず、最小スコープの置き場所を選ぶ。
- 狭い層で再掲する場合も、server inventory や接続設定は `config.toml` に戻し、行動契約だけを書く。

## When codifying a typical workflow

- repo-wide router が必要かを最初に決め打ちしない。既定では `AGENTS.md` を増やさず、`profile` と root skill の組で表現し、必要な child agent role を root から起動する。
- workflow の session 契約は `AGENTS.md` に置く。
- workflow の durable 設定は `~/.codex/config.toml` の `profiles.<name>` に置く。
- workflow の trigger、推奨 role sequence、child agent role への短い導線は root skill の `SKILL.md` に置く。
- child agent role の read-first docs と bootstrap 条件は role config の `developer_instructions` に置く。
- workflow の局所手順、判断基準、テンプレ断片は関連 `references/` と role contract に置く。
- 同じ workflow を profile、root skill、child agent role、`references/` に分解するときでも、同一 rule を複数箇所へ複写しない。
- discoverability を高めたい場合も、まず skill metadata と must-read の参照を使い、repo-wide router の追加は最後に検討する。

## When adding an MCP server

1. まず `~/.codex/config.toml` の `mcp_servers` を確認する。
2. repo 共有 override が必要なときだけ `.codex/config.toml` を追加または確認する。
3. repo-wide に常時有効な利用方針が新たに必要な場合だけ `AGENTS.md` を更新する。
4. task 文書がある repo で、特定の作業タイプでだけ必要な利用判断基準なら対応する task 文書を更新する。
5. 特定 role でだけ必要な追加契約なら `agent_roles/*.toml` の `developer_instructions` を更新する。

## OpenAI docs rule

- repo-wide の OpenAI developer docs MCP 利用ルールを置く必要がある場合だけ `AGENTS.md` に書き、記載がある場合はそれを正本とする。
- Codex 自己改善 workflow では、その特例をどう扱うかだけを定義する。
- 新しい MCP server を追加しても、この OpenAI Docs 特例にならって `AGENTS.md` に一般 rule を増やさない。
- Codex CLI、設定キー、`developer_instructions`、permissions の意味を repo からだけでは確定できないときだけ OpenAI developer docs MCP を使う。
- 記憶だけで設定キーや契約を断定しない。

## Guardrails

- `AGENTS.md` には、その session に必要な最小限の追加契約だけを書く。
- child agent role の role-local bootstrap contract は `agent_roles/*.toml` の `developer_instructions` に置く。
- 新しい典型 workflow は、既定では新規 profile、root skill、必要な child agent roles に分解して扱う。
- workflow を分解するときは、session 契約を `AGENTS.md`、全体導線を root skill、詳細手順を `references/` と role contract、durable 設定を `config.toml` へ置く。
- child agent role には、root handoff が薄くても動ける最小 bootstrap 情報を必ず含める。
- role-local な詳細ルールは対応する `references/` や role contract に集約し、`AGENTS.md` と `agent_roles/*.toml` の `developer_instructions` に同じ細則を重複させない。
- 個人設定として完結する profile や permissions は `~/.codex/config.toml` を優先し、repo 共有 override だけを `.codex/config.toml` に残す。可搬性を壊す HOME 配下の `permissions` は既定では共有設定に持ち込まない。
- MCP rule は `config.toml`、`AGENTS.md`、存在する場合の task 文書、`agent_roles/*.toml` の `developer_instructions` のうち最小スコープへ置く。
- 書き込み権限の最小化を優先し、必要以上に writable roots や permissions を広げない。可搬性と hard gate が衝突する場合は、まず `permissions` 撤廃を検討する。
- 指示と権限のどちらかが矛盾する場合は、実装に進まずユーザー確認を行う。
