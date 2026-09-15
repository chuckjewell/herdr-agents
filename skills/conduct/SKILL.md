---
name: conduct
description: >
  Lane orchestration for dispatch, receipts, reviews, integration, and handoffs.
  Invoke on lane events and turn end.
---

# Conduct wire

Portable team loop for Herdr (or any visible multi-agent layout). Product-specific gates stay in the repo's `AGENTS.md`.

## Invariants

- One WIP per lane; one writer per overlapping surface. One pane per agent. No vendor nested subagents — Herdr cannot see their status; the parent looks ready and new EMAIL can queue on unfinished work.
- One finalizer (lead) at a time for the default branch.
- Dual independent review (semantic/source **and** hostile/repro) plus written Process before merge.
- Runtime `done` is not a receipt. Close a packet only on durable path + sha256 delivered to the requester. `TO:` headers are not delivery.
- Do not prompt `working` panes. Do not invent work on a quiet poll.
- A stand-down retires a role. It does not retract artifacts already written; say what was touched.
- Skill file edits do not update running occupants. Adoption is path+sha256 and a full-read ACK, not a session reset.

## Every lane event

1. Check live occupant: `herdr agent get <pane>` when `HERDR_ENV=1`.
2. Classify: RESULT (receipt exists), FAILURE (runtime death without FINAL), STATUS, QUESTION, duplicate.
3. One imperative next action if work remains. No ACK loop on a terminal result.
4. Keep a wake path for **completion and** abnormal termination. ACK ≠ later provider failure.
5. Harvest and close the old packet before a new orthogonal packet on that lane.

## Dispatch

Every assignment and every worker FINAL is **EMAIL-shaped**: `FROM` / `TO` (pane ID or live name, not tab title) / `SUBJECT`, then pins, bounded `DO`/`DONT`, receipt path, callback. One packet, one owner, one overlapping surface. Full skeleton: `$HERDR_AGENTS_KIT/examples/packet.md`.

Headers do not deliver. Send with `herdr agent prompt` (or an explicit paste if Herdr is down). Worker ACK is full-read + hash MATCH when a sha256 was given. Worker FINAL is `VERDICT` + receipt path + sha256 after the last write, once.

Before send: owner, paths, exact pins, mutation scope, acceptance, budget, receipt path, callback. Existing named lanes before new agents.

Do not add a new ask to a lane that just delivered unless the next packet is already queued and orthogonal.

## Onboard

Standup: `team-onboarding`. Day-to-day pane: `agent-behavior` Pane onboard. Template: `$HERDR_AGENTS_KIT/examples/onboard-ack.md`. Kit path: AGENTS.md `HERDR_AGENTS_KIT` or `.agents/herdr-agents.path`.

## Integration

Lead owns the merge lease: one PR, pinned base/head, bounded TTL. Workers do not self-merge, restamp, or widen the contract. Guarded squash uses `--match-head-commit` at the reviewed tip when the host supports it.

## Handoffs

Worker wire: `TO / VERDICT / PINS / CONTRACT / DO / DONT / NEXT`. Counts have denominator and grain; `unavailable` never invented `0`. Hash after the final write; one callback; stop.

A HOLD pauses dependents of that packet, not the whole campaign. Idle tabs, a finished batch, or "no PRs" are not completion evidence. If nothing lawful remains, report the exact blocker; do not manufacture tasks.

Transport recovery: reconcile existing artifacts; receipt-only closeout may use execution budget zero; no quota reset, no seal reopen, no blind resend.
