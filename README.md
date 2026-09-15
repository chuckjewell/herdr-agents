# Herdr agents

A portable kit for running **several coding agents as a visible team** inside [Herdr](https://herdr.dev).

```
Herdr          = rooms, panes, agent lifecycle
This kit       = seating chart + how the team hands work
Your AGENTS.md = product law in the repo the panes sit in
```

Herdr does not store your doctrine. Occupants load `AGENTS.md` and skills from **cwd**. The **Herdr skill** is what makes an agent good at *building the rooms*. This kit adds *which seats* and *EMAIL packets*.

`skills/herdr` is [upstream v0.9.0](https://github.com/herdrdev/herdr/blob/v0.9.0/skills/herdr/SKILL.md) with a few inserts ([what/why](docs/herdr-skill-delta.md)). Wait/stall/blocked/server rules stay as upstream wrote them.

---

## Walkthrough (new Herdr user)

### 1. Install Herdr and agent integrations

The binary in `PATH` is syntax authority (`herdr --help`). **Never** run bare `herdr` from an agent (it attaches the TUI). Official first-run: [herdr.dev/agent-guide.md](https://herdr.dev/agent-guide.md).

Install integrations for every CLI you will run in a pane (Grok, Claude, Codex, Cursor, Hermes, …). That is how Herdr **recognizes** the occupant — you can just type `grok` or `codex` in the pane’s shell.

- **Setup menu** during Herdr install, or later in Herdr settings
- **CLI:** `herdr integration status` then `herdr integration install grok` (and `claude`, `codex`, `cursor`, `hermes`, …). Run `herdr integration` with no subcommand for the current list.

### 2. Clone this kit and install skills where every client looks

One canonical copy, then **symlinks**. Do not fork a skill per vendor.

```bash
git clone <this-repo> ~/code/herdr-agents   # after you push; until then use the local path
cd ~/code/herdr-agents
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh                          # user-global herdr for every client
./scripts/install-skills.sh --repo /path/to/product  # team skills + .agents/herdr-agents.path
```

`--repo` also writes `HERDR_AGENTS_KIT` so occupants can find examples/docs from a product cwd.

| Client | User-global | In the product repo (cwd) |
|---|---|---|
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| Cursor | `~/.cursor/skills/` | `.cursor/skills/` |
| Grok | `~/.grok/skills/` (also scans Claude/Cursor/`.agents`) | `.grok/skills/`, `.agents/skills/` |
| Codex | `~/.codex/skills/` | **`AGENTS.md` always-on**; optional `.agents/skills/` |
| Hermes | `~/.hermes/skills/` | vendor-specific |

Grok (and some others) also walk **`.agents/skills/`** from cwd to repo root. The installer puts team skills there first, then points `.claude` / `.cursor` / `.grok` at the same directories so they cannot drift.

**Codex** will not reliably load a repo `.claude/skills` tree. Put the EMAIL/WIP block in [`examples/AGENTS.snippet.md`](examples/AGENTS.snippet.md) into `AGENTS.md` so Codex sees the same law.

Already-running occupants do **not** hot-reload. Send path+sha256 and require a full-read ACK. Do not reset sessions.

### 3. Open a Herdr pane and run **team-onboarding**

User-global `herdr` skill must already be linked (step 2). Start any CLI in a pane, then load [`skills/team-onboarding/SKILL.md`](skills/team-onboarding/SKILL.md). That skill is the rest of standup:

design session (your needs vs Os/App/OverSeer baselines) → write roster + AGENTS snippet (`HERDR_AGENTS_KIT`) → named workspace/tabs → **you** start the **lead** CLI → onboard lead like any seat → **you** start the other CLIs → lead onboards the team.

Do not start agents for the user. One pane per agent; no nested subagents. Repeat this skill for each new workspace.

Human index: [`docs/onboarding.md`](docs/onboarding.md). Baselines: [`docs/workspaces.md`](docs/workspaces.md). EMAIL day-to-day: [`skills/conduct/SKILL.md`](skills/conduct/SKILL.md) / [`examples/packet.md`](examples/packet.md). Loop: [`docs/operating-loop.md`](docs/operating-loop.md).

Prompt **pane ID** or **live agent name**, never a tab title. `idle` = ready seen; `done` = ready unseen (CLI read does not clear it); `working` = do not prompt; `blocked` = ask the user.

### 4. Day-to-day: **agent-behavior** pane onboard

Not team-onboarding. Exit Codex, run `grok` in that shell, tell the **lead** to onboard that pane ([`skills/agent-behavior/SKILL.md`](skills/agent-behavior/SKILL.md)). Same EMAIL ACK. Same role.

---

## Repo map

| Path | When you need it |
|---|---|
| [`scripts/install-skills.sh`](scripts/install-skills.sh) | Step 2 |
| [`docs/build-a-workspace.md`](docs/build-a-workspace.md) | Layout recipe used by team-onboarding |
| [`docs/workspaces.md`](docs/workspaces.md) | Os / App / OverSeer baselines |
| [`docs/operating-loop.md`](docs/operating-loop.md) | Packets after standup |
| [`docs/onboarding.md`](docs/onboarding.md) | Human index |
| [`skills/team-onboarding/`](skills/team-onboarding/) | First standup walk |
| [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md) | What we inserted vs upstream |
| [`examples/`](examples/) | Rosters, AGENTS snippet, EMAIL skeleton |
| [`skills/herdr/`](skills/herdr/) | Drive Herdr |
| [`skills/conduct/`](skills/conduct/) | EMAIL, WIP=1, harvest |
| [`skills/process/`](skills/process/) | Written-law closeout, not a product grade |
| [`skills/agent-behavior/`](skills/agent-behavior/) | Day-to-day pane onboard + assign → harvest → wait |

## Not packed

- `~/.config/herdr/session.json` (live IDs)
- Noveon extract engine doctrine
- Campaign `artifacts/` / Lane Watch DB

Lane Watch is optional (`tools/lane_watch.py` in our extract checkout). Start with markdown packets.

## Origin

Live extract/engine campaign. This repo is the shareable source. `herdr --skill` prints whatever the **installed binary** ships; prefer this kit’s `skills/herdr` after install so extras (tab titles, sticky `done`, `PATH`) stay consistent.
