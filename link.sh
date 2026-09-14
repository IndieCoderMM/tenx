#!/usr/bin/env bash
# Symlink each plugin in this repo into ~/.claude/skills/ and expose its
# individual skills to Codex through ~/.codex/skills/.
#
# Skills-directory plugins are discovered in place rather than copied into the
# plugin cache, so the symlink means edits here are live. Re-run after adding
# a new plugin directory. Safe to run repeatedly.

set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_target="${HOME}/.claude/skills"
codex_target="${HOME}/.codex/skills"

mkdir -p "$claude_target" "$codex_target"

for manifest in "$repo"/*/.claude-plugin/plugin.json; do
  [ -e "$manifest" ] || continue
  plugin_dir="$(dirname "$(dirname "$manifest")")"
  name="$(basename "$plugin_dir")"
  link="$claude_target/$name"

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

for skill_manifest in "$repo"/*/skills/*/SKILL.md; do
  [ -e "$skill_manifest" ] || continue
  skill_dir="$(dirname "$skill_manifest")"
  plugin_dir="$(dirname "$(dirname "$skill_dir")")"
  plugin_name="$(basename "$plugin_dir")"
  skill_name="$(basename "$skill_dir")"
  link="$codex_target/$skill_name"

  if [ -L "$link" ]; then
    current="$(readlink "$link")"
    if [ "$current" = "$skill_dir" ]; then
      echo "ok       codex/$skill_name"
      continue
    fi
    ln -sfn "$skill_dir" "$link"
    echo "relinked codex/$skill_name  (was $current)"
  elif [ -e "$link" ]; then
    echo "SKIP     codex/$skill_name  — $link exists and is not a symlink; move it first" >&2
  else
    ln -s "$skill_dir" "$link"
    echo "linked   codex/$skill_name  ($plugin_name)"
  fi
done

echo
echo "Restart Claude Code or Codex to load newly linked plugins and skills."
