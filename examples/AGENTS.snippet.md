# AGENTS.md snippet — Herdr team

Copy this **block** into the product repo your Herdr panes `cwd` into. Do not replace your product law with it. Do not paste Noveon OCR/ILPA doctrine unless that is your product.

```
## Herdr team (layout lives in Herdr; law lives here)

HERDR: named workspace + one pane per agent. Prompt pane ID or live agent name, never tab label. No vendor nested subagents (Herdr cannot track them; parent looks idle and new work queues).
WIP=1 per lane. Do not prompt working panes. Runtime done ≠ receipt delivered.
PACKET: FROM/TO/SUBJECT, exact pins, bounded DO, durable receipt path, one callback with sha256.
LEAD: sequence, lease, guarded merge. BUILDER: one overlapping surface. Cannot self-grade as independent.
REVIEW: independent semantic/source AND hostile/repro at exact HEAD/BASE.
PROCESS: written-law/provenance only — not a third product grade, not merge.
ADVICE: no execution or merge authority.
BAN: merge/restamp/denominator change outside recorded authority. unavailable, never invented 0.
SKILL_ADOPTION: path+sha256 + full-read ACK; no session reset.
ONBOARD: lead rolls herdr+conduct to each pane; EMAIL ACK of role (tab/roster, not vendor). Swap occupant: exit, start the new CLI in that shell, tell the lead to onboard the pane.
```

Install matching skills so every client in this cwd can see them:

```bash
/path/to/herdr-agents/scripts/install-skills.sh --repo "$PWD"
```

That links `.agents/skills` (shared) and `.claude` / `.cursor` / `.grok`. Codex still needs **this AGENTS.md block** — it does not reliably load `.claude/skills`.
