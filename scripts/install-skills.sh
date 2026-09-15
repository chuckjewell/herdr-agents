#!/usr/bin/env bash
# Team skills only. Official Herdr skill: npx skills add herdrdev/herdr --skill herdr -g
# Do not fork herdr. Extras live in agent-behavior.
# Usage:
#   ./scripts/install-skills.sh              # user-global team skills via ~/.agents
#   ./scripts/install-skills.sh --repo PATH  # also into that checkout
set -euo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
CANON="$KIT/skills"
TEAM_SKILLS=(conduct process agent-behavior team-onboarding)

link_skill() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "  $dest -> $src"
}

echo "kit=$KIT"
echo "Not installing herdr skill here. Run: npx skills add herdrdev/herdr --skill herdr -g"
echo "Herdr extras are in $CANON/agent-behavior (keep official herdr upgradable)"

mkdir -p "$HOME/.agents/skills"
for s in "${TEAM_SKILLS[@]}"; do
  link_skill "$CANON/$s" "$HOME/.agents/skills/$s"
done
link_skill "$CANON/agent-behavior" "$HOME/.claude/skills/agent-behavior"

REPO=""
if [[ "${1:-}" == "--repo" ]]; then
  REPO="$(cd "${2:?need repo path}" && pwd)"
fi

if [[ -n "$REPO" ]]; then
  echo "Repo-local team skills ($REPO):"
  for vendor in agents claude cursor grok; do
    mkdir -p "$REPO/.$vendor/skills"
  done
  for s in "${TEAM_SKILLS[@]}"; do
    src="$CANON/$s"
    link_skill "$src" "$REPO/.agents/skills/$s"
    for vendor in claude cursor grok; do
      link_skill "$REPO/.agents/skills/$s" "$REPO/.$vendor/skills/$s"
    done
  done
  printf '%s\n' "$KIT" > "$REPO/.agents/herdr-agents.path"
  echo "Wrote $REPO/.agents/herdr-agents.path"
  echo "Paste examples/AGENTS.snippet.md into $REPO/AGENTS.md and set HERDR_AGENTS_KIT: $KIT"
fi

echo "Done. Occupants already running do not hot-reload; send path+sha256 and require a full-read ACK."
