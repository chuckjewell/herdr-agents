# Herdr agents

Named seats in [Herdr](https://herdr.dev), EMAIL packets between them, two independent reviews, then merge.

- **Herdr** — workspaces, tabs, panes, occupant lifecycle.
- **This repo** — who sits where, and how work is handed off.
- **Your `AGENTS.md`** — product rules. Agents load these from the pane cwd.

How that handoff works (and how to change it): [`docs/conductor-loop.md`](docs/conductor-loop.md). That's for you, not for agents.

Install Herdr's own skill and leave it official:

```bash
npx skills add herdrdev/herdr --skill herdr -g
```

Our extras (tab titles aren't IDs, sticky `done`, live `agent get`) are in [`skills/agent-behavior`](skills/agent-behavior/SKILL.md). Details: [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md).

---

## Walkthrough (new Herdr user)

### 1. Install Herdr and agent integrations

```bash
curl -fsSL https://herdr.dev/install.sh | sh
herdr
```

First run walks you through onboarding. Install integrations for every CLI you will run in a pane (Grok, Claude, Codex, Cursor, Hermes, …) — setup menu, or `herdr integration install grok` (and `claude`, `codex`, `cursor`, `hermes`). `herdr integration` with no subcommand lists targets. That is how Herdr **recognizes** an occupant when you type `grok` in a pane.

Never run bare `herdr` **from an agent pane** (nested attach). Human guide: [herdr.dev/agent-guide.md](https://herdr.dev/agent-guide.md).

### 2. Install the official Herdr skill (all agent types)

From a **human** terminal, not from inside a nested `herdr`:

```bash
npx skills add herdrdev/herdr --skill herdr -g
```

That is Herdr’s own installer; it places the skill where Claude, Codex, Cursor, Grok, etc. look. Leave it official. Our extras are in **agent-behavior**, loaded at onboard.

```bash
git clone https://github.com/chuckjewell/herdr-agents.git ~/code/herdr-agents
cd ~/code/herdr-agents
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh                 # ~/.agents/skills so the standup pane can find team-onboarding
./scripts/install-skills.sh --repo /path/to/product
```

`--repo` links the same team skills into the product (`.agents/skills` + Claude/Cursor/Grok copies) and writes `HERDR_AGENTS_KIT`. It does **not** overwrite official herdr. Paste [`examples/AGENTS.snippet.md`](examples/AGENTS.snippet.md) into product `AGENTS.md`. Codex needs that block.

### 3. Run team-onboarding with a strong agent

Standup is planning / air traffic control (ATC). Use the same class of model you want for the lead.

1. In Herdr, start that agent in a pane.
2. Paste the prompt in [`examples/run-team-onboarding.md`](examples/run-team-onboarding.md) (point it at this kit’s `skills/team-onboarding/SKILL.md`).
3. Work the **team makeup** with it (several turns is normal). It should propose a starter roster, extra seats/skills for the use case, and flag if that roster cannot run [our loop](docs/conductor-loop.md) — then propose loop edits. Keep **our lead** unless you have a better concept. Say the team is **ready to build** before it creates Herdr tabs. After each stop it should say **where you are** and what is still left.
4. When asked, start the **lead** CLI, then tell it the pane is live. Then start the other CLIs when asked.
5. It onboards the **lead** with official **herdr** + **agent-behavior**. Then it tells the lead to onboard every other pane with those **same two skills**. If it goes idle mid-walk, paste the continue line from that example file.

Exact walk: [`skills/team-onboarding/SKILL.md`](skills/team-onboarding/SKILL.md). Human index: [`docs/onboarding.md`](docs/onboarding.md). Repeat for each new workspace.

Prompt **pane ID** or **live agent name**, never a tab title. `idle` = ready seen; `done` = ready unseen; `working` = do not prompt; `blocked` = ask the user.

### 4. Day-to-day: **agent-behavior** pane onboard

Not team-onboarding. Exit Codex, run `grok` in that shell, tell the **lead** to onboard that pane ([`skills/agent-behavior/SKILL.md`](skills/agent-behavior/SKILL.md)). Same EMAIL ACK. Same role.

---

## Repo map

| Path | When you need it |
|---|---|
| [`scripts/install-skills.sh`](scripts/install-skills.sh) | Team skills only (not official herdr) |
| [`examples/run-team-onboarding.md`](examples/run-team-onboarding.md) | Paste to a strong air-traffic-control (ATC) agent |
| [`docs/build-a-workspace.md`](docs/build-a-workspace.md) | Layout recipe used by team-onboarding |
| [`docs/workspaces.md`](docs/workspaces.md) | Os / App / OverSeer baselines |
| [`docs/operating-loop.md`](docs/operating-loop.md) | Compact packet/harvest cheat |
| [`docs/conductor-loop.md`](docs/conductor-loop.md) | Human: what the loop does, where to change it (not a skill) |
| [`docs/onboarding.md`](docs/onboarding.md) | Human index |
| [`skills/team-onboarding/`](skills/team-onboarding/) | First standup walk |
| [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md) | Why extras live in agent-behavior |
| [`examples/`](examples/) | Rosters, AGENTS snippet, EMAIL skeleton |
| [`skills/conduct/`](skills/conduct/) | EMAIL, WIP=1, harvest |
| [`skills/process/`](skills/process/) | Written-law closeout, not a product grade |
| [`skills/agent-behavior/`](skills/agent-behavior/) | Herdr extras + day-to-day pane onboard |

## Not packed

- `~/.config/herdr/session.json` (live IDs)
- Noveon extract engine doctrine
- Campaign `artifacts/` / Lane Watch DB

Lane Watch is optional (`tools/lane_watch.py` in our extract checkout). Start with markdown packets.

## Origin

Extracted from how we run engine work in Herdr. Official skill: `npx skills add herdrdev/herdr --skill herdr -g`.
