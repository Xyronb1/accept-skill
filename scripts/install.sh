#!/usr/bin/env bash
# Installs the /accept skill into Claude Code (macOS / Linux).
# Usage: bash scripts/install.sh [target_skills_folder]
#   default target: ~/.claude/skills   (single project: <project>/.claude/skills)
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$(cd "$script_dir/.." && pwd)/skill/accept"
target="${1:-$HOME/.claude/skills}"

if [ ! -f "$source_dir/SKILL.md" ]; then
  echo "ERROR: Skill files not found: $source_dir" >&2
  echo "Make sure you cloned or extracted the repository without changing its folder layout." >&2
  exit 2
fi

mkdir -p "$target"
target_skill="$target/accept"

if [ -e "$target_skill" ]; then
  # The backup goes OUTSIDE the skills folder; inside it Claude Code would load a second /accept.
  backup_root="$(dirname "$target")/skills_backup"
  mkdir -p "$backup_root"
  backup="$backup_root/accept_$(date +%Y%m%d_%H%M%S)"
  mv "$target_skill" "$backup"
  echo "Previous installation backed up to: $backup"
fi

cp -R "$source_dir" "$target_skill"

if [ ! -f "$target_skill/SKILL.md" ]; then
  echo "ERROR: Could not verify the copy." >&2
  exit 1
fi

echo "Installed: $target_skill"
echo "Next: fill in context.md with your own details, restart Claude Code, then type /accept."
exit 0
