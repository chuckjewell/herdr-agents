# Workspaces (workgroups)

This page is for humans who are choosing seats. A Herdr **workspace** is a workgroup: named seats that share a working directory (usually one git checkout) and a job. It is not a git worktree.

We run several workspaces against the **same** git checkout. They differ by who may touch what, and what “done” means.

## Engine workspace

**Job:** Move the extraction engine. Dual independent review before merge.

Typical seats ([`examples/engine-roster.md`](../examples/engine-roster.md)):

| Seat | Job |
|---|---|
| Lead | Sequence, packets, lease, merge |
| Builders | One overlapping surface each, bounded PR |
| Tools | Hostile / repro / tests |
| Investigate | Seals, scouts |
| Eyes | Discovery (scarce) |
| Independent grader | Semantic/source review |
| Advice | Advice only — no merge |
| Mr Process | Written law, not a third product grade |
| Standby / Hermes | Specialized standby |

**Done** means: both independent reviews ACCEPT + Process GREEN + lead squash on the exact head. Not “the builder said it looks good.”

Keep engine work in its own workspace so app work does not interrupt it.

## Product workspace

**Job:** Customer-facing app, vault, and UI. Same git root for us, different merge owner.

Typical seats ([`examples/product-roster.md`](../examples/product-roster.md)):

| Seat | Job |
|---|---|
| Lead | Product-side lead |
| UI Builder | Presentation |
| Fullstack + Vault | Product API / persistence |
| Investigator / Tools | Repro |
| Independent Grader | App correctness |
| Process | Written law (may be a different occupant than Engine) |
| Design | Design; cwd may be `app/` |

Keep Product separate so a UI packet does not wait behind an engine freeze, and an engine freeze does not block a vault fix. If app and engine are different repos, use different `--cwd` values.

## OverSeer — only cross-workspace talker

Engine and Product leads do not EMAIL each other. Only OverSeer may message **across** workspaces.

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

If you skip OverSeer, each lead keeps their own wait. You lose one watchdog that can see Engine and Product.

## Scratch workspace

Scratch terminals and other checkouts. Keeps random cwd hopping off the Engine and Product tab bars.

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

Do not copy a 12-tab Engine roster for three humans and one bot. Start with:

`Lead | Builder | Reviewer | Process`

Add a seat when a real queue stays backlogged, not when the tab bar looks empty.
