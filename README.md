# Herdr agents

A portable kit for running **several coding agents as a visible team** inside [Herdr](https://herdr.dev): named workspaces, one agent per tab, bounded packets, receipts, and a lead who harvests instead of hoping.

This is not a Herdr `config.toml` dump and not a Noveon product dump. It is the **method**: how we split work, why the rooms look different, and how an agent can build the same kind of layout for *your* workgroups.

```
Herdr          = rooms, panes, agent lifecycle (the building)
This kit       = how the team is allowed to move in those rooms
Your AGENTS.md = product law for the repo the panes sit in
```

Herdr does not store Chuck/Astra/Process doctrine. Occupants load whatever `AGENTS.md` and skills exist in the pane's **cwd**. Put team law in the repo; put rooms in Herdr.

**The Herdr skill is what makes an agent good at building the rooms.** Give a pane `skills/herdr/SKILL.md` plus a roster (who sits where) and it will create workspaces, named tabs, and started agents the way we do here. This kit's extra docs are *which seats* and *how they hand work*, not a substitute for that skill.

Our `skills/herdr/SKILL.md` is [herdr `v0.9.0`](https://github.com/herdrdev/herdr/blob/v0.9.0/skills/herdr/SKILL.md) with a handful of inserts. We keep upstream’s wait/stall/blocked/server rules as written. What we added and why: [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md).

## Why this exists

One chat with one bot is a pair programmer. A campaign with builders, independent reviewers, and a lead who merges is a **team**. Teams fail in predictable ways:

- Two agents write the same surface.
- A "done" pane never tells anyone (Herdr `done` is sticky and unread).
- A lead dumps a novel into a working pane and blows WIP.
- Merge happens on vibes, not dual review + written law.
- Layout lives in one person's head (`session.json` on one laptop).

We treat those as operating bugs. The fix is **rooms + roles + packets + receipts**, not a smarter single model.

## What's in this repo

| Path | Role |
|---|---|
| [`docs/workspaces.md`](docs/workspaces.md) | Use cases: **Noveon Os** vs **Noveon App** (and OverSeer). How to invent your own. |
| [`docs/build-a-workspace.md`](docs/build-a-workspace.md) | Agent-executable recipe: create workspace, tabs, start agents. |
| [`docs/herdr-skill-delta.md`](docs/herdr-skill-delta.md) | What we changed vs upstream v0.9.0 and why (scars, not philosophy). |
| [`docs/operating-loop.md`](docs/operating-loop.md) | Packets, harvest, dual review, Process, no-reset skill refresh. |
| [`examples/`](examples/) | Concrete rosters and a packet skeleton. |
| [`examples/AGENTS.snippet.md`](examples/AGENTS.snippet.md) | The **one block** to add to a product `AGENTS.md`. |
| [`skills/herdr/`](skills/herdr/) | Canonical Herdr CLI skill (how an agent *drives* Herdr). |
| [`skills/agent-behavior/`](skills/agent-behavior/) | Generic conductor loop (assign → harvest → wait). |
| [`skills/conduct/`](skills/conduct/) | Portable lane orchestration (WIP=1, receipts, one finalizer). |
| [`skills/process/`](skills/process/) | Written-law checker: not a third product grade. |

Install the skills into each client you actually run (`~/.claude/skills`, `~/.grok/skills`, `~/.cursor/skills`). **One canonical copy, then symlink.** Do not keep three editors as three sources of truth.

```bash
# from this checkout
CANON="$PWD/skills"
for client in claude grok cursor; do
  mkdir -p "$HOME/.$client/skills"
  ln -sfn "$CANON/herdr" "$HOME/.$client/skills/herdr"
done
mkdir -p "$HOME/.agents/skills" "$HOME/.claude/skills"
ln -sfn "$CANON/agent-behavior" "$HOME/.agents/skills/agent-behavior"
ln -sfn "$CANON/agent-behavior" "$HOME/.claude/skills/agent-behavior"
```

Repo-local skills (`conduct`, `process`) belong **in the product checkout** the panes `cwd` into, e.g. `.claude/skills/conduct`, so every kind (Grok, Cursor, Codex) sees the same law.

## Mental model

```
workspace  = a workgroup (Os, App, Oversight)
tab        = one named seat (Astra, Tools, UI Builder)
pane       = the terminal
agent      = recognized occupant (grok / cursor / claude / …)
name       = live handle you prompt (`astra`, `tools`) — not the tab label
```

Tab labels are **cosmetic**. `herdr agent prompt` takes a **pane ID** (`w1:pD`) or a **live agent name**. Never a tab title. We learned that the expensive way.

States that actually matter:

| Herdr `agent_status` | Meaning |
|---|---|
| `idle` | Ready and seen |
| `done` | Ready, **unseen** completion — harvest; do not infer from the badge alone |
| `working` | WIP=1. Do not prompt. |
| `blocked` | Approval UI. Inspect; do not guess the dialog. |

A receipt not delivered (path + sha256 to the requester) is **not done**. Runtime `done` is not a successful packet.

## Quick start (human)

1. Install Herdr. The installed binary is syntax authority: `herdr --help`. **Never** run bare `herdr` from an agent (it attaches the TUI).
2. Clone this kit. Symlink `skills/herdr` as above.
3. Paste [`examples/AGENTS.snippet.md`](examples/AGENTS.snippet.md) into the product repo's `AGENTS.md`.
4. Copy `skills/conduct` and `skills/process` into that repo's `.claude/skills/` (and `.cursor/skills/` if you use Cursor).
5. In a pane that already has the Herdr skill, ask it to **build the roster** (Os, App, or your own). Point at [`docs/build-a-workspace.md`](docs/build-a-workspace.md) + [`examples/noveon-os.md`](examples/noveon-os.md). That skill is the setup muscle; the example is only the seating chart.

## Quick start (agent already in Herdr)

Read `skills/herdr/SKILL.md`, then `docs/build-a-workspace.md`. Create layout with `--no-focus`. Start agents only in empty shell panes. Do not steal the user's focused tab.

## What we deliberately did not pack

- `~/.config/herdr/session.json` — your live pane IDs and session UUIDs
- Noveon extract `AGENTS.md` engine doctrine (OCR, ILPA, Prisma) — product law, not Herdr
- `artifacts/`, Lane Watch SQLite, OPEN_PACKETS — campaign debt, not the playbook
- Grade / type-engine-review skills — those stay in the product repo

Lane Watch (`tools/lane_watch.py` in our extract checkout) is an **optional ledger** for long campaigns. The ideas (dispatch, respond, staged idle, one integration lease) are in [`docs/operating-loop.md`](docs/operating-loop.md). You can start with a markdown packet list.

## License / origin

Method distilled from a live multi-agent extract/engine campaign. `skills/herdr` is our compressed occupant skill (see origin note above). `skills/agent-behavior` matches `~/.agents/skills/agent-behavior`. This repo is the shareable source going forward.
