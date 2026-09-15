# AGENTS.md snippet — Herdr team

Copy this **block** into the product repo your Herdr panes `cwd` into. Do not replace your product law with it. Do not paste Noveon OCR/ILPA doctrine unless that is your product.

```
## Herdr team (layout lives in Herdr; law lives here)

HERDR: named workspace + one agent per tab. Prompt pane ID or live agent name, never tab label.
WIP=1 per lane. Do not prompt working panes. Runtime done ≠ receipt delivered.
PACKET: FROM/TO/SUBJECT, exact pins, bounded DO, durable receipt path, one callback with sha256.
LEAD: sequence, lease, guarded merge. BUILDER: one overlapping surface. Cannot self-grade as independent.
REVIEW: independent semantic/source AND hostile/repro at exact HEAD/BASE.
PROCESS: written-law/provenance only — not a third product grade, not merge.
ADVICE: no execution or merge authority.
BAN: merge/restamp/denominator change outside recorded authority. unavailable, never invented 0.
SKILL_ADOPTION: path+sha256 + full-read ACK; no session reset.
```

Install matching skills in this checkout:

- `.claude/skills/herdr` → symlink to this kit's `skills/herdr` (or rely on user-global)
- `.claude/skills/conduct` and `.claude/skills/process` from this kit
- `.cursor/skills/process` copy or symlink of the same process skill
