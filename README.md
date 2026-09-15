# Herdr agents

This page is for you if you want to run several coding agents as a team in [Herdr](https://herdr.dev).

You will get: named seats, mail-shaped packets between them, two independent reviews, then merge.

- **Herdr** is the multiplexer: workspaces, tabs, panes, and whether an agent is idle or working.
- **This repo** is who sits where and how work is handed off.
- **Your `AGENTS.md`** is product rules. Agents load it from the pane working directory.

Read [`docs/conductor-loop.md`](docs/conductor-loop.md) to see how that handoff works and where to change it. That file is for humans. Do not load it into agents.

Install Herdr’s own skill. Do not replace it with a fork:

```bash
npx skills add herdrdev/herdr --skill herdr -g
```

We keep a few extra rules (tab titles are not IDs; `done` stays after a CLI read; check live status before you prompt) in [`skills/agent-behavior/SKILL.md`](skills/agent-behavior/SKILL.md). Why: [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md).

---

## Walkthrough (first time)

### 1. Install Herdr and integrations

```bash
curl -fsSL https://herdr.dev/install.sh | sh
herdr
```

The first run walks you through setup. Then install an **integration** for each CLI you will run in a pane (Grok, Claude, Codex, Cursor, Hermes, and so on). Use the setup menu, or:

```bash
herdr integration install grok
```

Run `herdr integration` with no subcommand to list kinds. Herdr uses integrations to **recognize** the occupant when you type `grok` in a pane.

Do not run bare `herdr` from inside an agent pane (that attaches another TUI). Human guide: [herdr.dev/agent-guide.md](https://herdr.dev/agent-guide.md).

### 2. Install the official Herdr skill, then this kit

In a **human** terminal (not nested in Herdr):

```bash
npx skills add herdrdev/herdr --skill herdr -g
```

That command puts the skill where Claude, Codex, Cursor, Grok, and similar tools look. Leave that file official.

Then install **team** skills from this repo (not the Herdr skill):

```bash
git clone https://github.com/chuckjewell/herdr-agents.git ~/code/herdr-agents
cd ~/code/herdr-agents
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh
./scripts/install-skills.sh --repo /path/to/product
```

`--repo` links `conduct`, `process`, `agent-behavior`, and `team-onboarding` into the product (`.agents/skills` plus Claude/Cursor/Grok copies). It writes `HERDR_AGENTS_KIT` so agents can find examples. It does not overwrite the official Herdr skill.

Paste [`examples/AGENTS.snippet.md`](examples/AGENTS.snippet.md) into the product `AGENTS.md`. Codex needs that block; it does not always load `.claude/skills`.

Running agents do not pick up new skill files until you send path + hash and they ACK. Do not reset sessions to force a reload.

### 3. Run team-onboarding

This is planning / air traffic control (ATC). Use the same class of model you want for the lead.

1. In Herdr, start that agent in a pane.
2. Paste the prompt in [`examples/run-team-onboarding.md`](examples/run-team-onboarding.md).
3. Talk through **team makeup** (several turns is normal). It should propose a starter roster, extra seats for your project type, and whether that roster can run [our loop](docs/conductor-loop.md). If not, it should propose edits. Keep **our lead** unless you have a better idea. Say the team is **ready to build** before it creates Herdr tabs. After each stop it should say where you are and what is still left.
4. When asked, start the **lead** CLI. Tell it the pane is live. Then start the other CLIs when asked.
5. It onboards the lead with official **herdr** + **agent-behavior**. Then it tells the lead to onboard every other pane with those same two skills. If it goes idle mid-walk, paste the continue line from the example file.

This is several conversations, not one paste. Repeat for each new workspace.

Exact walk (for the agent): [`skills/team-onboarding/SKILL.md`](skills/team-onboarding/SKILL.md). Short index: [`docs/onboarding.md`](docs/onboarding.md).

Prompt a **pane ID** (for example `w1:pD`) or a **live agent name**, never a tab title.

| Status | Meaning |
|---|---|
| `idle` | Ready, and someone has seen the last completion |
| `done` | Ready, last completion unseen. A CLI read does not clear this. |
| `working` | Do not prompt |
| `blocked` | Inspect the UI. Ask the user before answering. |

A Herdr `done` is not a finished packet. A packet is done when a receipt path and sha256 reach the requester.

### 4. Day to day: onboard one pane

Not team-onboarding. Exit the old CLI. Start the new one in that shell. Tell the **lead** to onboard that pane ([`skills/agent-behavior/SKILL.md`](skills/agent-behavior/SKILL.md)). Same EMAIL ACK. Same role.

---

## Files in this repo

| Path | When you need it |
|---|---|
| [`scripts/install-skills.sh`](scripts/install-skills.sh) | Team skills only (not official Herdr) |
| [`examples/run-team-onboarding.md`](examples/run-team-onboarding.md) | Paste this to a strong ATC agent |
| [`docs/build-a-workspace.md`](docs/build-a-workspace.md) | Layout commands (used by team-onboarding) |
| [`docs/workspaces.md`](docs/workspaces.md) | Example workgroups: Engine, Product, OverSeer |
| [`docs/operating-loop.md`](docs/operating-loop.md) | Short packet and harvest notes |
| [`docs/conductor-loop.md`](docs/conductor-loop.md) | How the loop works and where to change it |
| [`docs/onboarding.md`](docs/onboarding.md) | Short standup index |
| [`skills/team-onboarding/`](skills/team-onboarding/) | First-time standup (agent skill) |
| [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md) | Why extras live in agent-behavior |
| [`examples/`](examples/) | Rosters, AGENTS snippet, EMAIL templates |
| [`skills/conduct/`](skills/conduct/) | EMAIL, one packet per seat, harvest |
| [`skills/process/`](skills/process/) | Written-law closeout, not a product grade |
| [`skills/agent-behavior/`](skills/agent-behavior/) | Herdr extras + day-to-day pane onboard |

## What this repo does not include

- Your live Herdr layout (`~/.config/herdr/session.json`)
- Product-specific engine rules from any one company
- Campaign artifacts and Lane Watch databases

Lane Watch is optional. A markdown list of packets is enough to start.

## Where this came from

We extracted this from how we run engine work in Herdr. Official skill: `npx skills add herdrdev/herdr --skill herdr -g`.
