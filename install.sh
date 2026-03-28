#!/usr/bin/env bash
set -euo pipefail

# パスを展開
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
timestamp="$(date +%Y%m%d%H%M%S)"

# リンクを貼る関数
link_path() {
  local source_path="$1"
  local target_path="$2"
  local backup_path

  mkdir -p "$(dirname "$target_path")"

  if [[ -L "$target_path" ]]; then
    if [[ "$(readlink -f "$target_path")" == "$source_path" ]]; then
      echo "already linked: $target_path"
      return
    fi
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="${target_path}.bak.${timestamp}"
    mv "$target_path" "$backup_path"
    echo "backed up: $target_path -> $backup_path"
  fi

  ln -s "$source_path" "$target_path"
  echo "linked: $target_path -> $source_path"
}

# .codex 系のリンク
link_path "$repo_root/dot_codex/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_path "$repo_root/dot_codex/config.toml" "$HOME/.codex/AGENTS.toml"

# .agents 系のリンク
mkdir -p "$HOME/.agents/skills"

for source_path in "$repo_root"/dot_agents/skills/*; do
  [[ -e "$source_path" ]] || continue
  link_path "$source_path" "$HOME/.agents/skills/$(basename "$source_path")"
done

for target_path in "$HOME"/.agents/skills/*; do
  [[ -L "$target_path" ]] || continue
  source_path="$repo_root/dot_agents/skills/$(basename "$target_path")"
  if [[ ! -e "$source_path" || "$(readlink -f "$target_path")" != "$source_path" ]]; then
    rm "$target_path"
    echo "removed stale link: $target_path"
  fi
done
