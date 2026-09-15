---
name: team-onboarding
description: >
  Walk a human through standing up a Herdr agent team: map their needs
  to baseline roles, write roster and skills, configure workspace and
  named tabs, onboard the lead like any seat, then have the lead onboard
  the rest. Use when the user wants a new workspace, a new team, or
  "set up Herdr like Noveon." Requires HERDR_ENV=1 for layout steps.
---

# Team onboarding

You are the **setup air traffic control (ATC)** they started for planning — not a cheap builder packet. Design session then standup. Do not merge, do not invent busywork, do not nest vendor subagents. Do not start CLIs; ask the human.

Load the **official** Herdr skill before any `herdr` mutate (`npx skills add herdrdev/herdr --skill herdr -g`). Team extras: `agent-behavior` § Herdr extras — do not fork herdr. EMAIL format lives in `skills/conduct`. Templates and baselines live in **HERDR_AGENTS_KIT** (AGENTS.md `HERDR_AGENTS_KIT`, or `.agents/herdr-agents.path`, or ask the human and write that file). Do not resolve `examples/` relative to the product cwd.

Each **new workspace** (Os, App, OverSeer, a friend's team) repeats this whole skill. Do not skip the design session because "we already have Os."

This walk is **multi-turn**. After each human gate, stop and wait. When they say continue (or start a CLI / confirm a roster), resume the **last unfinished step**. Do not restart from step 1 unless they say the roster changed.

## 1. Design session (needs vs baselines)

Talk to the human. Baselines under `$HERDR_AGENTS_KIT` (examples, not a clone mandate):

- `docs/workspaces.md` — workgroups, OverSeer as only cross-workspace talker
- `examples/noveon-os.md` — engine/correctness factory
- `examples/noveon-app.md` — product/UI, separate WIP/merge owner

Catalog to map **from**: lead, builder, hostile/repro, semantic/source, process, advice, OverSeer.

Keep **our lead** (sequence, packets, lease, guarded merge; cannot self-grade as independent) unless they have a better concept. Drop seats they do not need. Do not copy a 12-tab Os for a three-seat job.

Write down, in the product repo (markdown roster, not only chat):

- Workspace label and cwd
- Tab name = seat name
- Job / authority / ban per seat
- Suggested CLI kind (grok, claude, codex, …) — role is the tab, not the vendor

Get a human yes on that roster before touching Herdr.

## 2. Write skills for this team

In the product checkout (cwd the panes will use):

1. `$HERDR_AGENTS_KIT/scripts/install-skills.sh --repo <product>` if not already linked (conduct, process, agent-behavior, **this skill** — not official herdr).
2. Paste `examples/AGENTS.snippet.md` into `AGENTS.md` if missing. Codex needs that block.
3. Save the roster next to it (copy Os/App examples and edit).
4. Process seat also loads `skills/process`. Advice seat does not get merge authority.

Do not write a unique SKILL.md per tab. Seats share herdr + conduct; role comes from the **tab name + roster**.

## 3. Configure Herdr from the roster

Integrations first (`herdr integration status` / `herdr integration install …`, or Herdr setup menu). Then `$HERDR_AGENTS_KIT/docs/build-a-workspace.md`:

- One workspace per workgroup
- One tab per seat, **named for the agent/role**
- One pane per agent; leave each tab at a **shell prompt**
- `herdr agent start` only if you just **split** a sibling pane
- `--no-focus`. Do not steal the user's tab. Do not close panes you did not create.

**Ask the user** to start their desired agent in the **lead pane first** (`grok`, `claude`, `codex`, …). Do not start CLIs for them. Wait until `herdr agent get` shows that occupant live, then step 4.

## 4. Onboard the lead (same as everyone)

EMAIL the lead **pane ID** (`$HERDR_AGENTS_KIT/examples/onboard-ack.md`): full-read **official herdr** + **agent-behavior** (path+sha256), ACK MATCH, state **role from the tab**, idle. That *is* lead onboard. No extra ceremony. Harvest ACK or they are not onboarded.

## 5. User starts the rest; lead onboards them

Ask the user to start the desired CLI in every other pane. Then EMAIL the lead: onboard those panes the **same way** — official herdr skill + agent-behavior skill, EMAIL role ACK (`$HERDR_AGENTS_KIT/examples/onboard-ack.md`); harvest ACKs; idle. You (setup agent) do not dual-prompt seats unless the lead is unavailable.

Product packets only after the roll-call is in.

## 6. Another workspace later

Same skill from step 1. App does not inherit Os's roll-call. OverSeer is a tiny workspace (Hermes + crons); still onboard its occupant.

## Later (not this skill)

Day-to-day pane onboard and swaps: `$HERDR_AGENTS_KIT/skills/agent-behavior/SKILL.md` (Pane onboard). Same EMAIL template. Same two skills (herdr + agent-behavior).
