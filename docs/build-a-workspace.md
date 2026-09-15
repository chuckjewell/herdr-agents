# Build a workspace

This page is a seating-chart recipe for an agent that already loaded the official Herdr skill. Humans can read it. Use it only when the user asked you to create layout. Requires `HERDR_ENV=1`.

Load the official Herdr skill first (`npx skills add herdrdev/herdr --skill herdr -g`). Extra rules (tab titles, sticky `done`, live `get`) are in `agent-behavior`. Do not fork herdr.

`--no-focus` on creates so you do not steal the user’s tab. Do not close panes you did not create. The installed `herdr` binary is the syntax authority (`herdr --help`). If flags may have changed, run `herdr workspace` / `herdr tab` / `herdr agent` / `herdr pane` with no subcommand. Never run bare `herdr` (that attaches the TUI).

## 0. Precheck

```bash
test "${HERDR_ENV:-}" = 1
herdr pane current --current
herdr workspace list
```

Parse opaque IDs from JSON. Do not invent `w1:p4`.

## 1. Workspace

One workgroup = one workspace, usually one `--cwd` (the product git root).

```bash
herdr workspace create --cwd /path/to/repo --label "Noveon Os" --no-focus
```

Read `.result` for `workspace_id` (example `w2`). The create already has a first tab + pane at a shell prompt.

Rename the first tab immediately so it is a seat, not "Tab 1":

```bash
herdr tab rename <tab_id> "Astra"
```

List tabs: `herdr tab list --workspace <workspace_id>`.

## 2. More seats (tabs)

Each additional role is a **new tab**, not a split, unless the user asked for a split view.

```bash
herdr tab create --workspace <workspace_id> --cwd /path/to/repo --label "Tools" --no-focus
herdr tab create --workspace <workspace_id> --cwd /path/to/repo --label "Builder 1" --no-focus
# …
```

Same cwd unless a seat truly needs another tree (`app/`, a worktree, another repo).

Default: **one tab, one pane, one agent.** Do not nest vendor subagents (Codex/Claude/Grok “spawn a child”). Herdr only sees the pane occupant; nested work is invisible, so the parent can look `idle`/`done` and get a new prompt queued on top of work that is still running.

Optional: split a **helper terminal** (logs, tests) next to the agent — not a second hidden agent.

```bash
herdr pane split --pane <pane_id> --direction right --cwd "$PWD" --no-focus
```

`herdr agent start` is for that case: Herdr (or a lead agent) just created an empty sibling pane and needs to launch a CLI into it. It never creates layout. Day-to-day: type `grok` / `claude` / `codex` in the seat’s own shell.

## 3. Start agents

The pane must be an **interactive shell**. **Ask the user** to start their desired agent in each pane (`grok`, `claude`, `codex`, …). Do not start CLIs for them unless they asked. If the integration is installed, Herdr recognizes the kind.

Optional: `herdr agent` name the occupant after it is live (`[a-z][a-z0-9_-]{0,31}`). Use the **role**, not the vendor (`tools`, not `cursor2`).

## 4. First packet, not a novel

After start, send **one** bounded hello that is the actual job or a "idle until packet" hold — not a dump of this whole kit.

```bash
herdr agent prompt astra 'FROM: human
TO: astra
SUBJECT: You are lead for workspace Os. Read AGENTS.md and .claude/skills/conduct/SKILL.md. ACK role. Do not merge unasked.'
```

`--wait` only when you will harvest this turn. Wait tracks **lifecycle**, not your packet. Already-working may satisfy wait without having done the work.

## 5. Active list (the roster)

There is no separate Herdr "active list" file. The roster is:

```bash
herdr tab list --workspace "$HERDR_WORKSPACE_ID"
herdr agent list
herdr pane list --workspace "$HERDR_WORKSPACE_ID"
```

Keep a **markdown roster** in the product repo (copy [`examples/noveon-os.md`](../examples/noveon-os.md)) so humans and agents agree on seats. Tab labels can be renamed; pane IDs cannot be predicted after a move.

## 6. Hygiene

- Do not prompt `working` panes (WIP=1).
- `done` = harvest receipt; the badge will stay `done` until something focuses the pane. That is not a new event by itself.
- `blocked` = inspect UI; do not send inferred dialog answers.
- Never kill the Herdr server to "fix" a CLI mismatch. Use a compatible `herdr` on PATH.
- Skill file edits do not hot-reload occupants. Adoption = send path+sha256, require full-read ACK, no session reset.

## Example: four-seat starter

Workspace `Acme Api`, cwd `$REPO`:

| Tab label | Agent name | Kind | Job |
|---|---|---|---|
| Lead | `lead` | grok or claude | packets + merge |
| Builder | `builder` | cursor | one PR at a time |
| Review | `review` | claude | independent grade |
| Process | `process` | grok or codex | written-law closeout |

Create workspace → rename first tab Lead → start `lead` → three `tab create` → start the other three → put [`examples/AGENTS.snippet.md`](../examples/AGENTS.snippet.md) in `$REPO/AGENTS.md`.
