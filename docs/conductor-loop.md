# How work moves on a running team

This page is for humans. It is not a skill. Do not load it into agents.

It explains what our process does after a team exists, and **which files to edit** if you want a different process.

Keep the official Herdr skill. Change EMAIL, who reviews, and who is allowed to merge if that fits you better.

Short notes: [`operating-loop.md`](operating-loop.md). Agents load: official herdr skill, `agent-behavior`, `conduct`, `process`.

**EMAIL** here means a mail-shaped message: `FROM`, `TO`, `SUBJECT`, then pins and the work. **WIP=1** means one active packet on a seat (and one writer on overlapping files).

## Which file does what

| File | Job |
|---|---|
| Official herdr skill | Panes and status (`idle`, `working`, `done`, `blocked`). Prompt and wait. Install with `npx skills add herdrdev/herdr --skill herdr -g`. |
| `agent-behavior` | Extra Herdr rules (tab titles, sticky `done`, live `get`). Lead steps: assign, harvest, wait, merge. Onboard a new occupant in an existing seat. |
| `conduct` | Our policy: EMAIL, WIP=1, two independent reviews, Process, one merge owner. |
| `process` skill | The Process occupant: check pins and receipts. Not a third product grade. |

Herdr only knows panes. It does not know “reviewer” or “merge.” Herdr moves text in terminals. `agent-behavior` is air traffic control (ATC). `conduct` is our review and merge policy.

## From packet to merge

```
lead sends an EMAIL packet (one owner, one surface, receipt path)
        ↓
builder ACK → working → receipt + sha256 callback
        ↓
lead harvests
        ↓
  need a fix?  → new packet to the builder (repeat until reviews can pass)
  ready?       → two independent reviews at the exact HEAD
        ↓
semantic/source ACCEPT  AND  hostile/repro ACCEPT
        ↓
  either RED?  → fold-in packet, same HEAD/BASE pins, repeat
        ↓
Process: written-law GREEN_SCOPED (or an exact hold)
        ↓
lead squash --match-head-commit <reviewed tip> → fast-forward default branch
        ↓
builder may take other work; lead assigns the next lawful packet
```

The point is to cycle until **both reviews are green**. A builder “looks good” is not dual review. Code the lead wrote still goes through the two independent seats.

## Keeping lanes busy without stepping on each other

- One packet per seat. One writer per overlapping path. Do not send a second EMAIL to a `working` pane.
- After the PR is in review, the builder may take **other** work (different files).
- Packets on different paths may run at the same time.
- Idle is allowed. If nothing lawful remains, the lead reports blockers. Do not invent tasks to fill the status bar.
- OverSeer (optional): a Hermes **agent cron** pings leads across workspaces. Ask Hermes to create the cron. A pulse is not a reason to invent work. See [`workspaces.md`](workspaces.md).
- Do not use nested vendor subagents. Herdr cannot see them. The parent looks idle, and new work can queue on unfinished work.

## Two reviews, then Process, then merge

1. **Semantic/source** — is it true against the source? Different occupant than the builder. Exact HEAD and BASE.
2. **Hostile/repro** — can we break it? Different occupant than (1) and the builder.
3. If RED: named fold-in, same reviewers at the **new** HEAD. Repeat until both ACCEPT (or a recorded HOLD that names the unblock).
4. **Process** — did the recorded law happen? Pins match, dual receipts exist, no extra gate. `PROCESS_GREEN_SCOPED` or HOLD.
5. **Lead merge** — only then. One lease. `--match-head-commit` at the reviewed tip. Workers never merge themselves.

If you want one reviewer, or CI instead of Process, **edit `conduct` and the AGENTS snippet**. Do not fork the official Herdr skill to encode merge policy.

## What to keep vs what to change

| Keep | Change if you want |
|---|---|
| Official Herdr skill, one pane per agent, no nested subagents | Number and names of seats |
| Receipt + sha256, EMAIL as the envelope | Two reviewers vs one vs CI only |
| Live `agent get` before you prompt | Process occupant vs a human checklist |
| Sticky `done` is not a new event | Who is allowed to squash |

Your product `AGENTS.md` still owns domain rules. This kit does not include ours.
