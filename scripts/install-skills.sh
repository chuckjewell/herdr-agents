#!/usr/bin/env bash
# Link this kit's skills where common agent CLIs look.
# Usage:
#   ./scripts/install-skills.sh              # user-global herdr (+ shared .agents)
#   ./scripts/install-skills.sh --repo PATH  # also team skills into that checkout
set -euo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
CANON="$KIT/skills"

USER_CLIENTS=(claude grok cursor codex hermes)
TEAM_SKILLS=(herdr conduct process agent-behavior)

link_skill() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "  $dest -> $src"
}

echo "kit=$KIT"

echo "User-global herdr (and .agents shared):"
mkdir -p "$HOME/.agents/skills"
for client in "${USER_CLIENTS[@]}"; do
  link_skill "$CANON/herdr" "$HOME/.$client/skills/herdr"
done
link_skill "$CANON/herdr" "$HOME/.agents/skills/herdr"
link_skill "$CANON/agent-behavior" "$HOME/.agents/skills/agent-behavior"
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
    # Same inode via .agents so vendors do not drift
    for vendor in claude cursor grok; do
      link_skill "$REPO/.agents/skills/$s" "$REPO/.$vendor/skills/$s"
    done
  done
  echo "Paste examples/AGENTS.snippet.md into $REPO/AGENTS.md (Codex always-on wire)."
fi

echo "Done. Occupants already running do not hot-reload; send path+sha256 and require a full-read ACK."
