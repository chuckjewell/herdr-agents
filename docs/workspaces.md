# Workspaces (workgroups)

This page is for humans who are choosing seats. A Herdr **workspace** is a workgroup: named seats that share a working directory (usually one git checkout) and a job. It is not a git worktree.

We run several workspaces against the **same** extract checkout. They differ by who may touch what, and what “done” means.

## Noveon Os (`w1`) — engine

**Job:** Move the extraction engine. Dual independent review before merge.

Typical seats ([`examples/noveon-os.md`](../examples/noveon-os.md)):

| Seat | Job |
|---|---|
| Lead (Astra) | Sequence, packets, lease, merge |
| Builders (DarkHorse 1–3) | One overlapping surface each, bounded PR |
| Tools | Hostile / repro / tests |
| Investigate | Seals, scouts |
| Eyes | Discovery (scarce) |
| Independent grader | Semantic/source review |
| Sage | Advice only — no merge |
| Mr Process | Written law, not a third product grade |
| Coolify / Hermes | Specialized standby |

**Done** means: both independent reviews ACCEPT + Process GREEN + lead squash on the exact head. Not “the builder said it looks good.”

Keep engine work in its own workspace so app work does not interrupt it.

## Noveon App (`w6`) — product UI

**Job:** Customer-facing app, vault, and UI. Same git root for us, different merge owner.

Typical seats ([`examples/noveon-app.md`](../examples/noveon-app.md)):

| Seat | Job |
|---|---|
| Conductor | App-side lead |
| UI Builder | Presentation |
| Fullstack + Vault | Product API / persistence |
| Investigator / Tools | Repro |
| Independent Grader | App correctness |
| Mr. Process | Written law (may be a different occupant than Os) |
| Muse | Design; cwd may be `app/` |

Keep App separate so a UI packet does not wait behind an engine freeze, and an engine freeze does not block a vault fix. If app and engine are different repos, use different `--cwd` values.

## OverSeer (`w7`) — only cross-workspace talker

Os and App leads do not EMAIL each other. Only OverSeer may message **across** workspaces.

We run it as **Hermes**. A **pulse** is a **Hermes agent cron** in that pane. It is not a Herdr CLI command. Ask Hermes to create the cron (interval, which workspaces, what to do). Hermes wakes, looks, maybe EMAILS a lead, and sleeps.

OverSeer does not own PRs, does not review, and does not merge. A pulse is not a reason to invent work when the board is quiet.

**Ask Hermes to create a cron that, on each fire:**

1. Lists panes and `herdr agent get` for the watched workspaces.
2. Classifies each occupant: `working`, `idle`, `done` (sticky), `blocked`, or missing.

Then:

| Seen | Do |
|---|---|
| `working` | Leave it. If it looks stuck vs the packet budget, EMAIL that workspace’s **lead**, not the worker. |
| `idle`, no open packet | Nothing. Idle is allowed. |
| `idle` / `done`, unharvested receipt | EMAIL the **lead**: harvest this pane. Sticky `done` alone is not new work. |
| `blocked` | EMAIL the lead or human: inspect the dialog. Do not answer it. |
| Roll-call incomplete | EMAIL the lead: finish onboard ACKs. |
| Quiet (no due packets) | Stop. Do not invent tasks. |

Cross-workspace EMAIL goes to the **lead of that workspace**, not builder to builder.

If you skip OverSeer, each lead keeps their own wait. You lose one watchdog that can see Os and App.

## Noveon Misc (`w8`)

Scratch terminals and other checkouts. Keeps random cwd hopping off the Os and App tab bars.

## How to invent yours

1. What are you merging? (engine PR, app PR, docs, infra)
2. Who must not grade their own change?
3. Which streams must not share WIP? If two streams can land without each other, use two workspaces.

Name **roles**, not model brands:

- one **lead** (sequence + merge)
- **builders** (WIP=1 per overlapping path)
- **hostile/repro**
- **semantic/source**
- **process**
- optional **advice**
- optional **OverSeer** (only cross-workspace EMAIL; Hermes if you want crons)

Pick CLI **kinds** (grok, cursor, claude, codex, hermes, …) from what they do well, not from the tab label.

Do not copy a 12-tab Os roster for three humans and one bot. Start with:

`Lead | Builder | Reviewer | Process`

Add a seat when a real queue stays backlogged, not when the tab bar looks empty.
