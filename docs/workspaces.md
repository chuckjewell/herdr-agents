# Workspaces as workgroups

A Herdr **workspace** is not a git worktree and not a "project" in the IDE sense. It is a **workgroup**: a set of named seats that share a cwd (usually one git checkout) and a job.

We run several workspaces against the **same** extract checkout. They differ by *who is allowed to touch what* and *what "done" means*.

## Noveon Os (`w1`) — engine / correctness factory

**Job:** Move the extraction engine. Typed, licensed, honest. Dual review before merge.

Typical seats (see [`examples/noveon-os.md`](../examples/noveon-os.md)):

| Seat | Job |
|---|---|
| Lead (Astra) | Sequence, packets, lease, guarded merge |
| Builders (DarkHorse 1–3) | One overlapping surface each, bounded PR |
| Tools | Hostile / repro / tests |
| Investigate | Seals, scouts, source-bound checks |
| Eyes | Discovery / unknown shapes (scarce) |
| Independent grader | Semantic/source class walk |
| Sage | Advice only — no merge, no execution authority |
| Mr Process | Written law / provenance, **not** a third product grade |
| Coolify / Hermes | Specialized standby (UI mock, architecture) |

**Done** means: dual independent ACCEPT (semantic + hostile) + Process GREEN + lead squash on exact head. Not "the builder said LGTM."

**Why a whole workspace:** engine work is high-stakes and parallel. Mixing it with app chrome in the same tab bar trains everyone to interrupt the wrong lane.

## Noveon App (`w6`) — product / UI / vault

**Job:** The customer-facing app, vault, and UI. Same git root for us (monorepo-ish), different *consumer*.

Typical seats ([`examples/noveon-app.md`](../examples/noveon-app.md)):

| Seat | Job |
|---|---|
| Conductor | App-side lead |
| UI Builder | Presentation |
| Fullstack + Vault | Persistence / product API |
| Investigator / Tools | Repro |
| Independent Grader | App correctness |
| Mr. Process | Written law again (can be a different occupant than Os) |
| Muse | Design-only cwd when needed |

**Why split from Os:** a UI packet must not steal the engine lead's attention, and an engine freeze must not block a vault fix. Same repo, **different WIP pools and merge owners**.

If your app and engine are actually different repos, give them different `--cwd` values. Our App workspace mostly still sits on the extract checkout because that is where `AGENTS.md` and the skills live; one tab (`Muse`) points at `app/`.

## OverSeer (`w7`) — only cross-workspace talker

Os and App leads do **not** EMAIL each other. The only seat allowed to communicate **across workspaces** is OverSeer.

We run it as **Hermes** because Hermes can schedule agent crons: poll other lanes/leads, nudge a stuck roll-call, remind Os to harvest. It does not own PRs, does not dual-review, does not merge. A pulse is a reminder, not a license to invent work when the board is quiet.

If you skip OverSeer, each lead keeps their own bounded wait. You lose a single watchdog that can see Os *and* App.

## Noveon Misc (`w8`) — junk drawer with a lid

Scratch terminals, other checkouts (`unified-build`, `herdr-telegram`), a Leader tab. Useful so random cwd hopping does not contaminate Os/App tab bars.

## How to invent yours

Ask three questions:

1. **What is the merge object?** (engine PR vs app PR vs docs vs infra)
2. **Who is not allowed to grade their own change?** (need an independent seat)
3. **What must never share WIP?** (if two streams can land without each other, they are two workspaces)

Then name **roles**, not people-models:

- one **lead** (sequence + merge)
- **builders** (WIP=1 per overlapping path)
- **hostile/repro** (break it)
- **semantic/source** (is it true)
- **process** (was the law followed)
- optional **advice** (scarce, no authority)
- optional **metronome / OverSeer** (only cross-workspace EMAIL; Hermes if you want crons)

Pick agent **kinds** (grok, cursor, claude, codex, hermes, …) from demonstrated fit, not from the tab label. Labels do not prove quality. We often put a strong reasoner on source review and a cheaper capable model on deterministic ops.

Do not clone our 12-tab Os roster if you have three humans and one bot. Start with:

`Lead | Builder | Reviewer | Process`

Add a seat when a **qualified queue** is persistently backlogged, not when a tab bar looks empty.
