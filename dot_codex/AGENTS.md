# Global Guidance

## Working Agreements

- 常に日本語で回答する。
- リポジトリ側の `AGENTS.md` や skill がある場合は、それらの guidance を優先する。
- 事実・推測・未確認事項を明確に分ける。
- まず目的・前提・制約を整理してから答える。
- 破壊的操作を行う前に、その必要性と影響範囲を明確にする。
- 最終回答では、必要に応じて根拠と制約を述べる。

## Codex Self Improvement

- `codex_meta` で起動した session では、この `AGENTS.md` を追加契約の入口とする。
- この session では `codex-self-improvement` に必要な設定、導線、reference、最小ハーネス改善だけを扱う。
- 詳細な workflow、role sequence、spawn policy は user skill `codex-self-improvement` と、そこから辿る関連 `references/` を参照する。
- child agent を起動するときは、`agent_roles/*.toml` を role-local bootstrap contract の正本として扱う。
- `agent_roles/*.toml` には `name`、`description`、`developer_instructions`、`model`、`model_reasoning_effort`、`model_verbosity`、`sandbox_mode` をまとめて置く。
- `~/.codex/config.toml` には profile-level の `developer_instructions` を置かない。
- Codex 契約や repo から確認できない設定キーの意味を確認する必要があるなら OpenAI developer docs MCP を使う。
- ユーザーの明示的な許可が無い限り、対象範囲を広げない。
- 責務分離と validation の整合が取れるまで作業を打ち切らない。
- 指示や権限が衝突する場合は編集せず、ユーザーに確認する。
- 最終報告では、変更内容、成立根拠、実行した確認、未解決事項、制約、関連文書との矛盾を述べる。
