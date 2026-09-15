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

You are running a **design session then a standup**, not a product packet. Do not merge, do not invent busywork, do not nest vendor subagents.

Load `skills/herdr/SKILL.md` before any `herdr` mutate. EMAIL format lives in `skills/conduct` — do not restate it here. Templates: `examples/onboard-ack.md`, `examples/packet.md`.

Each **new workspace** (Os, App, OverSeer, a friend's team) repeats this whole skill. Do not skip the design session because "we already have Os."

## 1. Design session (needs vs baselines)

Talk to the human. Baselines (examples, not a clone mandate):

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

1. `scripts/install-skills.sh --repo <product>` if not already linked (herdr, conduct, process, agent-behavior, **this skill**).
2. Paste `examples/AGENTS.snippet.md` into `AGENTS.md` if missing. Codex needs that block.
3. Save the roster next to it (copy Os/App examples and edit).
4. Process seat also loads `skills/process`. Advice seat does not get merge authority.

Do not write a unique SKILL.md per tab. Seats share herdr + conduct; role comes from the **tab name + roster**.

## 3. Configure Herdr from the roster

Integrations first (`herdr integration status` / `herdr integration install …`, or Herdr setup menu). Then `docs/build-a-workspace.md`:

- One workspace per workgroup
- One tab per seat, **named for the agent/role**
- One pane per agent; leave each tab at a **shell prompt**
- **Ask the user** to start their desired agent in each pane (`grok`, `claude`, `codex`, …). Do not start CLIs for them unless they asked
- Herdr recognizes the kind if the integration is installed
- `herdr agent start` only if you just **split** a sibling pane

`--no-focus`. Do not steal the user's tab. Do not close panes you did not create. Wait until occupants are live (`herdr agent get`) before step 4.

## 4. Onboard the lead (same as everyone)

The lead tab is already named. EMAIL that **pane ID** the onboard packet (`examples/onboard-ack.md`): read herdr + agent-behavior + conduct, hash ACK, state **role from the tab**, idle. That *is* lead onboard. No extra ceremony.

Harvest the EMAIL ACK. If none, they are not onboarded.

## 5. Lead onboards the team

EMAIL the lead: onboard every other pane in this workspace the same way; harvest ACKs; then idle. You (setup agent) do not dual-prompt seats unless the lead is unavailable.

Product packets only after the roll-call is in.

## 6. Another workspace later

Same skill from step 1. App does not inherit Os's roll-call. OverSeer is a tiny workspace (Hermes + crons); still onboard its occupant.

## Later (not this skill)

Day-to-day pane onboard and swaps: `skills/agent-behavior/SKILL.md` (Pane onboard). Same EMAIL template.
