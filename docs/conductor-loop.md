# The day-to-day loop (ours)

**Human-readable.** Not a skill. Do not load this into agents. It explains what the running system is doing and **where to edit** if you want a different process.

This is **our** process after a team exists. Change it to match **yours**. Keep the official Herdr skill; change EMAIL, who reviews, and who is allowed to merge.

Compact cheat: [`operating-loop.md`](operating-loop.md). What agents actually load: official herdr skill, `agent-behavior`, `conduct`, `process`.

## Which file does what

| File | Job |
|---|---|
| **Official herdr skill** | Multiplexer: panes, `idle`/`working`/`done`/`blocked`, `prompt`/`wait`, no nested TUI. Upgradable via `npx skills add herdrdev/herdr --skill herdr -g`. |
| **`agent-behavior`** | Herdr extras (tab titles, sticky `done`, live `get`) + **conductor loop** (assign → start → callback → harvest → schedule → wait → merge → handoff) + pane onboard. |
| **`conduct`** | How *we* shape that loop: EMAIL, WIP=1, dual independent review, Process written-law, one merge lease. |
| **`process` skill** | Occupant who *is* Process: pins and receipts, not a third product grade. |

Herdr does not know “reviewer” or “merge.” It only knows panes. The split is: **herdr moves bytes in terminals; agent-behavior is air traffic control (ATC); conduct is our review/merge policy.**

## From packet to merge

```
lead ASSIGNs EMAIL packet (one owner, one surface, receipt path)
        ↓
builder ACK → working → receipt + sha256 callback
        ↓
lead HARVESTs
        ↓
  need a fix?  → successor packet to builder (cycle until the reviews can pass)
  ready?       → two independent reviews at exact HEAD
        ↓
semantic/source ACCEPT  AND  hostile/repro ACCEPT
        ↓
  either RED?  → fold-in packet, same HEAD/BASE pins, cycle
        ↓
Process: written-law GREEN_SCOPED (or exact hold)
        ↓
lead: guarded squash --match-head-commit <reviewed tip> → ff-only default branch
        ↓
builder may take orthogonal work; lead ASSIGNs next lawful packet
```

That cycle **until reviews are green** is the point. A builder “LGTM” is not dual review. Lead-authored code still goes through the two independent seats.

## Keeping lanes busy without stepping on each other

- **WIP=1** on a lane and on an overlapping path. No second EMAIL to `working`.
- **Orthogonal** work is allowed after the candidate is released (reviews own the PR; builder can take another packet).
- **Independent** packets run in parallel (different paths).
- **Idle is not a bug.** If nothing lawful remains, the lead reports blockers. Do not invent tasks to fill the status bar.
- OverSeer (optional): Hermes **agent cron** pulses leads across workspaces. Ask Hermes to create the cron. A pulse is not invent-work authority. See [`workspaces.md`](workspaces.md).
- Nested vendor subagents are banned: Herdr cannot see them, so the parent looks idle and new work **queues on unfinished work**.

## Multiple reviews, then Process, then merge

1. **Semantic/source** — is it true vs source? Different occupant than the builder. Exact HEAD/BASE.
2. **Hostile/repro** — can we break it? Different occupant than (1) and the builder.
3. RED → named fold-in → same reviewers at the **new** HEAD. Repeat until both ACCEPT (or a recorded HOLD with exact unblock).
4. **Process** — did the *law* happen? Pins match, dual receipts exist, no invented gate, no third taste of the code. `PROCESS_GREEN_SCOPED` or HOLD.
5. **Lead merge** — only then. One lease, `--match-head-commit` at the reviewed tip. Workers never self-merge.

If you do not want two reviewers, or you want CI instead of Process, **change `conduct` and the AGENTS snippet**. Do not fork the official herdr skill to encode your merge policy.

## What to keep vs what to change

| Keep | Change if you want |
|---|---|
| Official herdr skill, one pane per agent, no nested subagents | Number and names of seats |
| Receipt + sha256, EMAIL as the envelope | Dual review vs single reviewer vs CI-only |
| Live `agent get` before prompt | Process occupant vs a human checklist |
| Sticky `done` ≠ new event | Who is allowed to squash |

Your product `AGENTS.md` still owns domain law (we keep OCR/ILPA out of this kit on purpose).
