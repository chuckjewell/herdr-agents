# Build a workspace (agent recipe)

Use this only when the user asked you to create Herdr layout. Requires `HERDR_ENV=1`.

The installed binary is syntax authority. Run `herdr --help` and `herdr workspace` / `herdr tab` / `herdr agent` / `herdr pane` with **no subcommand** if flags may have changed. Never bare `herdr` (TUI attach).

Preserve the user's focus: `--no-focus` on creates. Do not close panes you did not create.

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

Optional: split inside a tab only for a helper terminal next to the agent.

```bash
herdr pane split --pane <pane_id> --direction right --cwd "$PWD" --no-focus
```

## 3. Start agents

The pane must be an **interactive shell with no foreground process**. Agent start does not create layout.

```bash
herdr pane get <pane_id>   # confirm shell, not already an agent
herdr agent start astra --kind grok --pane <pane_id>
herdr agent start tools --kind cursor --pane <other_pane_id>
```

Names: `[a-z][a-z0-9_-]{0,31}`, unique while live. Use the **role**, not the vendor (`tools`, not `cursor2`).

Kinds are whatever `herdr agent start --help` lists today (`grok`, `cursor`, `claude`, `codex`, `hermes`, …).

If `agent_not_ready`: inspect/read that pane; do not start a duplicate.

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
