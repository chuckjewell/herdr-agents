---
name: agent-behavior
description: Agent operating conventions, day-to-day pane onboard (swap/new occupant EMAIL ACK), and reusable workflow learning. Apply during coding and multi-agent delivery. Not the first-time team standup (use team-onboarding).
---

# Agent operations

Three jobs in this file — do not mix them:

- **Herdr extras** — scars on top of the official herdr skill (always on).
- **Pane onboard** — day-to-day: new occupant or swap in an existing seat. Not first-time team standup (`team-onboarding`).
- **Conductor loop** — **normal** lead behavior after the team exists: assign, harvest, wait, merge. Not an onboarding walk.

AUTH: current system/developer/user instructions and project authority control scope.
Skills supply method, not additional permission. Existing named lanes before new agents.

Herdr control: load the **official** skill (`npx skills add herdrdev/herdr --skill herdr -g`). Do not fork it. Team extras below so that skill stays upgradable.

## Herdr extras

Official wait/stall/blocked/server rules stand. These are campaign scars:

- Agent targets: pane ID or live name — **not tab titles**.
- `done` stays `done` after a CLI harvest; a later pulse listing that pane is not a new event.
- `herdr agent get` before treating a seat as free; do not prompt `working`.
- Do not start a second agent in an occupied pane or name.
- Same `herdr` on `PATH` for child tools; a missing method is not permission to restart the server (kills panes). Unavailable runtime-sync is not a live lane check.

## Local work

- DOCS: no unsolicited documentation or comments/types on untouched code. Explain non-obvious changed logic only.
- NAV: use available project index for symbol/caller/impact queries; refresh after relevant changes when writes are allowed. Immutable review → exact git objects, no index mutation. Literal search → native fast search. Missing tooling ≠ setup project.
- ROAM: discover installed syntax as needed; retrieve/context/uses/preflight/impact/diff cover normal work. No mandatory full tour, health scan or generic command catalog per task.
- ID: when using MCP Agent Mail, register explicit stable `{identity}-{client}[-instance]`; no random replacement identities.

## Pane onboard (day-to-day)

Not the first-time workspace standup (`team-onboarding`). Use this after a **new occupant** in an existing seat: swap, crash, first CLI in a pane the user just started.

EMAIL that pane (`$HERDR_AGENTS_KIT/examples/onboard-ack.md`): **official herdr** + **this skill** path+sha256; ACK **role from tab/roster**, not vendor. Harvest ACK before product packets. Do not prompt `working`. Same two skills for the lead and for every other seat.

Swap: user exits the old CLI, starts the new one in that shell, asks the **lead** to onboard that pane. Same role. No team reset.

## Conductor loop (day-to-day lead, not onboard)

TRIGGER=authorized asynchronous team work. Dispatch is not completion.

1. ASSIGN: one owner/overlapping surface; explicit objective, pins, allowed writes, acceptance, budget, receipt and actual completion transport. Prevent duplicate work. Announce any authorized hidden delegation; don't substitute it for visible lanes.
2. START: verify new-task ACK/activity. Generic running is insufficient. Runtime proves lifecycle; packet proves assignment. Reconcile conflicts before new shared-state action.
3. CALLBACK: direct conductor prompt, tracked completion wait, or verified wake callback. Successful ACK proves start, not delivery of a later provider/runtime failure. Wake coverage must include completion and abnormal termination, not just a worker-authored FINAL. EMAIL headers/desktop notifications are not delivery. Worker seals receipt then sends final identifier/hash once; delivery failure → recorded failure + one named fallback, no retry loop.
4. HARVEST: receipt → accept/repair/review/exact hold/next packet. Close prior debt before new assignment; never append hidden scope. No redundant ACK conversation. Read unchanged evidence once using exact-pin receipt cursor.
5. SCHEDULE: independent work parallel; shared writes serialized. Reserve capacity for review/integration. Ready PRs must not drown behind discovery. Builder can take orthogonal work after releasing candidate custody.
6. WAIT: event-driven; don't spend model turns rediscovering unchanged state. Without verified completion-and-failure wake support, keep the authorized delivery task active with bounded runtime waits and obey communication limits. A quiet status check is not a persistent watcher. Timeout alone triggers no new worker ask or regrade.
7. MERGE: within authorization, exact-pin checks → guarded merge → local/remote reconciliation → recoverable cleanup → queue recompute/next lawful dispatch. Blocked step → exact owner/unblock; no authority expansion.
8. HANDOFF: a packet HOLD pauses only its dependents, not the campaign. Check live lanes/terminal receipts, open PRs through cleanup, and the user's agreed plan/punchlist—not just already-selected packets—before declaring the queue exhausted. Reconcile a relevant backlog row against current evidence, then route its next useful action; stale rows are not automatic build authority and this check does not authorize a new census. Classify blockers by operation: a forbidden protected write does not forbid an otherwise authorized read-only design, dependency check or independent review. Such preparation must resolve a concrete unfinished requirement; do not repeat completed preparation or manufacture tasks to fill lanes. Attach an owner and exact next action or genuine authority/dependency blocker to remaining work; idle agents, a finished batch and zero PRs are not completion evidence. A worker's HOLD or code comment alone does not establish a new approval requirement; verify the governing decision without waiving it. Ask missing decisions while other permitted work proceeds. If the user stops, stop; if the agreed remaining work has no lawful next action, report the exact blockers and request direction. Do not invent work or a watcher. While work is in flight, retain a verified completion-and-failure wake path or bounded wait; ACK is not completion. Terminal runtime without FINAL → reconcile existing children/artifacts before a named transport recovery. Resume never resets quotas, replays charged execution or reopens a seal. Completed execution may receive receipt-only recovery with execution budget zero. Repeated transport failure → qualified fallback or exact external blocker, not blind resends.

## Evidence and continuity

- PACKETS: minimal sufficient context; details in canonical receipts/logs. Verdict/pins/scope/count-grain/blockers/next in relay. No full-history fork without need and authorization.
- REVIEW: batch coherent repairs; successor delta + affected controls, unchanged-code carry explicit. No historical run relabelled exact-tip. Failed setup retained, not product failure; no synthetic control relabelled source proof.
- CUSTODY: final write → hash → cite → freeze. Corrections/new members → separate correction/index. Never edit a cited manifest to add its correction.
- SKILL UPDATE: file edit ≠ worker adoption. When new instructions matter, send exact path/hash, require full read + hash ACK; don't reset agents or assume hot reload.
- CONTEXT: compact current pins/owners/queue/decisions/receipts, not history. Rollover only via supported authorized mechanism at safe boundary; no token threshold authorizes reset. Preserve active workers/callbacks.
- USAGE: separate cached/uncached when diagnosing costs. Provider routing only within user preferences and review independence. Goal creation requires explicit request; token budget only if explicitly requested.

## Learning

Read relevant existing workflow memory when available. Record reusable causal lessons after meaningful work; prefer updating existing entries. No diary/count dump or unsolicited new docs. Deduplicate; retain roughly 20–30 high-value lessons, not an accumulating rule for every incident.
