#!/usr/bin/env bash
# Symlink each plugin in this repo into ~/.claude/skills/.
#
# Skills-directory plugins are discovered in place rather than copied into the
# plugin cache, so the symlink means edits here are live. Re-run after adding
# a new plugin directory. Safe to run repeatedly.

set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="${HOME}/.claude/skills"

mkdir -p "$target"

for manifest in "$repo"/*/.claude-plugin/plugin.json; do
  [ -e "$manifest" ] || continue
  plugin_dir="$(dirname "$(dirname "$manifest")")"
  name="$(basename "$plugin_dir")"
  link="$target/$name"

  if [ -L "$link" ]; then
    current="$(readlink "$link")"
    if [ "$current" = "$plugin_dir" ]; then
      echo "ok       $name"
      continue
    fi
    ln -sfn "$plugin_dir" "$link"
    echo "relinked $name  (was $current)"
  elif [ -e "$link" ]; then
    echo "SKIP     $name  — $link exists and is not a symlink; move it first" >&2
  else
    ln -s "$plugin_dir" "$link"
    echo "linked   $name"
  fi
done

echo
echo "Restart Claude Code, then check: claude plugin list"
