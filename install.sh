#!/usr/bin/env bash
set -euo pipefail

# パスを展開
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

remove_path() {
  local target_path="$1"
  local message="$2"

  if [[ ! -e "$target_path" && ! -L "$target_path" ]]; then
    return
  fi

  rm -rf -- "$target_path"
  echo "$message: $target_path"
}

cleanup_backups_for_target() {
  local target_path="$1"
  local target_dir
  local target_name
  local backup_path

  target_dir="$(dirname "$target_path")"
  target_name="$(basename "$target_path")"

  if [[ ! -d "$target_dir" ]]; then
    return
  fi

  while IFS= read -r backup_path; do
    rm -rf -- "$backup_path"
    echo "removed obsolete backup: $backup_path"
  done < <(find "$target_dir" -maxdepth 1 -mindepth 1 -name "${target_name}.bak.*" -print | sort)
}

cleanup_known_backups() {
  local source_path

  cleanup_backups_for_target "$HOME/.codex/AGENTS.md"
  cleanup_backups_for_target "$HOME/.codex/config.toml"
  cleanup_backups_for_target "$HOME/.codex/AGENTS.toml"

  for source_path in "$repo_root"/dot_agents/skills/*; do
    [[ -e "$source_path" ]] || continue
    cleanup_backups_for_target "$HOME/.agents/skills/$(basename "$source_path")"
  done
}

# リンクを貼る関数
link_path() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname "$target_path")"

  if [[ -L "$target_path" ]]; then
    if [[ "$(readlink -f "$target_path")" == "$source_path" ]]; then
      echo "already linked: $target_path"
      return
    fi
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    remove_path "$target_path" "removed existing path"
  fi

  ln -s "$source_path" "$target_path"
  echo "linked: $target_path -> $source_path"
}

cleanup_legacy_path() {
  local target_path="$1"

  remove_path "$target_path" "removed legacy path"
}

# .codex 系のリンク
link_path "$repo_root/dot_codex/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_path "$repo_root/dot_codex/config.toml" "$HOME/.codex/config.toml"
cleanup_legacy_path "$HOME/.codex/AGENTS.toml"

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

cleanup_known_backups
