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
git clone <this-repo> ~/code/herdr-agents
cd ~/code/herdr-agents
chmod +x scripts/install-skills.sh
./scripts/install-skills.sh --repo /path/to/your/product
```

Without `--repo`, only user-global `herdr` is linked.

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

### 3. Put the team block in the product repo

Paste [`examples/AGENTS.snippet.md`](examples/AGENTS.snippet.md) into that repo’s `AGENTS.md`. Keep your product rules. This block is only Herdr-team law: WIP=1, EMAIL `FROM`/`TO`/`SUBJECT`, Process is not a third grade.

### 4. Open Herdr, get one pane inside it

Confirm `HERDR_ENV=1` in that pane. That occupant needs the Herdr skill (step 2). Ask it to **build the roster** — not to invent one:

- Recipe: [`docs/build-a-workspace.md`](docs/build-a-workspace.md)
- Example seats: [`examples/noveon-os.md`](examples/noveon-os.md) (engine factory) or [`examples/noveon-app.md`](examples/noveon-app.md) (product/UI)

`--no-focus` on creates. **One pane per agent.** Leave each new tab at a shell prompt and launch the agent CLI there (`grok`, `claude`, …). Herdr picks up the kind if that integration is installed. Do not use vendor nested subagents — Herdr cannot see their progress, and the parent can look idle while work is still running (new prompts then queue). `herdr agent start` is only for a sibling pane Herdr just split.

### 5. Learn the two workgroups (optional, but the point of the examples)

[`docs/workspaces.md`](docs/workspaces.md): **Os** = correctness factory (dual review + Process before merge). **App** = product/UI, same git root, **different WIP pool and merge owner**. **OverSeer** = only cross-workspace talker (Hermes crons that ping stuck leads). Invent yours from merge-object + who cannot self-grade.

### 6. Run the team as EMAIL, not novels

Every dispatch and every FINAL is mail-shaped. Occupants load that from [`skills/conduct/SKILL.md`](skills/conduct/SKILL.md). Fill-in template: [`examples/packet.md`](examples/packet.md).

Loop: [`docs/operating-loop.md`](docs/operating-loop.md) — harvest receipts, dual independent review, Process written-law, one finalizer.

Tab labels are cosmetic. Prompt **pane ID** (`w1:pD`) or **live agent name**, never “Sage” as a title.

| `agent_status` | Meaning |
|---|---|
| `idle` | Ready and seen |
| `done` | Ready, **unseen** — harvest; CLI read does not clear it |
| `working` | Do not prompt |
| `blocked` | Inspect UI; ask the user (upstream rule) |

Runtime `done` ≠ packet done. A receipt not delivered (path+sha256) is not done.

### 7. Onboard every seat (and again after a swap)

The lead sends herdr + conduct to each pane and harvests an **EMAIL role ACK** ([`docs/onboarding.md`](docs/onboarding.md)). Role is tab + roster, not “I am Codex.”

You can **change the agent in a pane**: exit Codex, run `grok` in that same terminal, tell the lead to onboard the pane. Herdr recognizes the new kind if its integration is installed. Same role (tab + roster). Do not reset the rest of the workspace.

---

## Repo map

| Path | When you need it |
|---|---|
| [`scripts/install-skills.sh`](scripts/install-skills.sh) | Step 2 |
| [`docs/build-a-workspace.md`](docs/build-a-workspace.md) | Step 4 (agent recipe) |
| [`docs/workspaces.md`](docs/workspaces.md) | Step 5 |
| [`docs/operating-loop.md`](docs/operating-loop.md) | Step 6 |
| [`docs/onboarding.md`](docs/onboarding.md) | Step 7 — roll-call + pane swap |
| [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md) | What we inserted vs upstream |
| [`examples/`](examples/) | Rosters, AGENTS snippet, EMAIL skeleton |
| [`skills/herdr/`](skills/herdr/) | Drive Herdr |
| [`skills/conduct/`](skills/conduct/) | EMAIL, WIP=1, harvest |
| [`skills/process/`](skills/process/) | Written-law closeout, not a product grade |
| [`skills/agent-behavior/`](skills/agent-behavior/) | Generic assign → harvest → wait |

## Not packed

- `~/.config/herdr/session.json` (live IDs)
- Noveon extract engine doctrine
- Campaign `artifacts/` / Lane Watch DB

Lane Watch is optional (`tools/lane_watch.py` in our extract checkout). Start with markdown packets.

## Origin

Live extract/engine campaign. This repo is the shareable source. `herdr --skill` prints whatever the **installed binary** ships; prefer this kit’s `skills/herdr` after install so extras (tab titles, sticky `done`, `PATH`) stay consistent.
