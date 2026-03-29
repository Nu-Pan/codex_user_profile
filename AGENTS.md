# Repo Guidance

- 共通ルールは `~/.codex/AGENTS.md` を主とし、本ファイルにはこのリポジトリ固有の差分だけを書く。
- この作業ツリーに `dot_codex/**/*` と `dot_agents/**/*` がある場合、それらは `~/.codex/**/*` と `~/.agents/**/*` を mirror した repo 内 path として扱う。
- path を他のリポジトリや repo 非依存の guidance へ見せるときの正本は `~/.codex/...` / `~/.agents/...` とし、`dot_codex/...` / `dot_agents/...` はこの作業ツリー上の実ファイルを指すときだけ使う。
- `AGENTS.md`、`dot_codex/**/*`、`dot_agents/skills/codex-self-improvement*/**/*` を変更するタスクでは、`dot_agents/skills/codex-self-improvement/SKILL.md` を入口とし、必要な関連 skill / `references/` を辿る。
- 詳細ルールは `dot_agents/skills/codex-self-improvement/SKILL.md` から辿る関連 skill / `references/` を正本とし、本ファイルへ細則を重複させない。
