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

You are setup air traffic control (ATC): design session, then standup. Do not merge. Do not invent work. Do not nest vendor subagents. Do not start CLIs; ask the human.

Load the **official** Herdr skill before any `herdr` mutate (`npx skills add herdrdev/herdr --skill herdr -g`). Team extras: `agent-behavior` § Herdr extras — do not fork herdr. EMAIL format lives in `skills/conduct`. Templates and baselines live in **HERDR_AGENTS_KIT** (AGENTS.md `HERDR_AGENTS_KIT`, or `.agents/herdr-agents.path`, or ask the human and write that file). Do not resolve `examples/` relative to the product cwd.

Each **new workspace** (Os, App, OverSeer, a friend's team) repeats this whole skill. Do not skip the design session because "we already have Os."

This walk is **multi-turn**. After each human gate, stop and wait. When they say continue (or start a CLI / confirm a roster), resume the **last unfinished step**. Do not restart from step 1 unless they say the roster changed. Do not skip a phase. Do not start phase N until its **gate** is met.

### Phases (order is mandatory)

| # | Phase | Gate before this phase | Waiting on human |
|---|---|---|---|
| 1 | Design (project type, starter roster, extras, loop fit) | — | Comfortable + **ready to build** |
| 2 | Write skills + roster file + any `conduct`/AGENTS edits | Explicit ready-to-build | Confirm files if you cannot write |
| 3 | Herdr workspace + named tabs (empty shells) | Phase 2 files in place | — (you do this) |
| 4 | User starts **lead** CLI | Tabs exist | Start lead agent in lead tab |
| 5 | Onboard lead (herdr + agent-behavior, EMAIL ACK) | `herdr agent get` lead = live | — (you EMAIL; they ACK) |
| 6 | User starts the **other** CLIs | Lead onboard ACK harvested | Start remaining agents |
| 7 | Lead onboards the rest (same two skills) | Those panes live | — (lead EMAIL; you harvest) |

**Status to the human** at every stop (educate, don't assume they remember):

```
WHERE WE ARE: phase N — <name>
JUST FINISHED: …
GATE FOR NEXT: …
WAITING ON YOU: …   (or none)
STILL LEFT: phase N+1 … through 7
```

Do not create Herdr tabs (phase 3) before phase 1 go-ahead and phase 2. Do not onboard a pane that is not live. Product packets only after phase 7.

## 1. Design session (needs vs baselines)

**Ask first:** what kind of project is this? (web app, API, engine/correctness, mobile, research, mixed, …)

Then **propose a starter team** so they have something to argue with. Do not wait for them to invent seats from a blank page.

Keep **our lead** (sequence, packets, lease, guarded merge; cannot self-grade as independent) unless they have a better concept.

Starter shapes (edit hard):

| Project | Propose |
|---|---|
| Default / unknown | Lead, Builder, Review (hostile or semantic), Process |
| Web / UI | that set **plus** a UI/browser tester (click, forms, viewports — e.g. a `dev-browser` skill on that seat) |
| Engine / high-stakes correctness | Os-like: Lead, Builder(s), Hostile, Semantic/source, Process; Advice optional |
| Product app + backend | App-like: Lead, UI, Fullstack, Review, Process |
| Tiny / solo+one bot | Lead + Builder only; Process can be the human |

Baselines to steal from (not a clone mandate): `$HERDR_AGENTS_KIT/docs/workspaces.md`, `examples/noveon-os.md`, `examples/noveon-app.md`. Catalog: lead, builder, hostile/repro, semantic/source, process, advice, OverSeer.

**Use-case extra seat:** if a kit skill or a product skill would make the team better (web → UI tester; data → spreadsheet seat; docs → writer), **name it** and say why. That is an extra tab + optional repo skill on that occupant — not a unique fork of herdr/conduct.

Write the roster in the product repo (markdown, not only chat): workspace label, cwd, tab = seat, job / authority / ban, suggested CLI kind (role is the tab, not the vendor), **skills on that seat** (official herdr + agent-behavior minimum; process on Process; extra product skills e.g. `dev-browser` on a UI tester). Equip them with our kit quality or better for the use case — do not stand up a thinner occupant than Lead/Builder in our baselines.

**Loop fit:** read `$HERDR_AGENTS_KIT/docs/conductor-loop.md` (human story; you use it here as the checklist). Our loop needs: a lead who sequences and merges; EMAIL packets; WIP=1; independent review of builder work; Process (occupant or human); no nested subagents.

If the roster **cannot** run that loop, say so and **propose loop changes** before go-ahead, for example:

- Lead+Builder only → human reviews, or lead is not independent; edit `conduct` / AGENTS snippet (single review or human Process).
- No Process seat → human Process, or drop Process from the merge gate.
- One reviewer, not dual → change dual ACCEPT to one ACCEPT in `conduct`.
- Extra specialist (UI tester) → they are a builder-like lane, not a substitute for independent review of their own output.

Get a yes on **both** the roster **and** any loop edits. Iterate until they are comfortable.

**Do not create anything in Herdr** until they explicitly say the team is **ready to build** (go-ahead). “Looks ok” / a shrug is not go-ahead. After go-ahead, step 2 then 3.

## 2. Write skills for this team

In the product checkout (cwd the panes will use):

1. `$HERDR_AGENTS_KIT/scripts/install-skills.sh --repo <product>` if not already linked (conduct, process, agent-behavior, **this skill** — not official herdr).
2. Paste `examples/AGENTS.snippet.md` into `AGENTS.md` if missing. Codex needs that block.
3. Save the roster next to it (copy Os/App examples and edit).
4. Process seat also loads `skills/process`. Advice seat does not get merge authority.

Do not write a unique SKILL.md per tab unless it is a real extra (e.g. `dev-browser` for UI tester). Seats share official herdr + agent-behavior; product packets use `conduct`. Role comes from the **tab name + roster**. If step 1 agreed loop edits, apply them to `conduct` / AGENTS snippet **now**, before layout.

## 3. Configure Herdr from the roster

Only after explicit **ready to build**.

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
