---
name: conduct
description: >
  Lane orchestration for dispatch, receipts, reviews, integration, and handoffs.
  Invoke on lane events and turn end.
---

# Conduct wire

Portable team loop for Herdr (or any visible multi-agent layout). Product-specific gates stay in the repo's `AGENTS.md`.

## Invariants

- One WIP per lane; one writer per overlapping surface.
- One finalizer (lead) at a time for the default branch.
- Dual independent review (semantic/source **and** hostile/repro) plus written Process before merge.
- Runtime `done` is not a receipt. Close a packet only on durable path + sha256 delivered to the requester.
- Do not prompt `working` panes. Do not invent work on a quiet poll.

## Every lane event

1. Check live occupant: `herdr agent get <pane>` when `HERDR_ENV=1`.
2. Classify: RESULT (receipt exists), FAILURE (runtime death without FINAL), STATUS, QUESTION, duplicate.
3. One imperative next action if work remains. No ACK loop on a terminal result.
4. Keep a wake path for **completion and** abnormal termination. ACK ≠ later provider failure.
5. Harvest and close the old packet before a new orthogonal packet on that lane.

## Dispatch

Before send: owner, paths, exact pins, mutation scope, acceptance, budget, receipt path, callback. Self-contained packet (`examples/packet.md` in herdr-agents). Existing named lanes before new agents.

Do not add a new ask to a lane that just delivered unless the next packet is already queued and orthogonal.

## Integration

Lead owns the merge lease: one PR, pinned base/head, bounded TTL. Workers do not self-merge, restamp, or widen the contract. Guarded squash uses `--match-head-commit` at the reviewed tip when the host supports it.

## Handoffs

Worker wire: `TO / VERDICT / PINS / CONTRACT / DO / DONT / NEXT`. Counts have denominator and grain; `unavailable` never invented `0`. Hash after the final write; one callback; stop.

A HOLD pauses dependents of that packet, not the whole campaign. Idle tabs, a finished batch, or "no PRs" are not completion evidence. If nothing lawful remains, report the exact blocker; do not manufacture tasks.

Transport recovery: reconcile existing artifacts; receipt-only closeout may use execution budget zero; no quota reset, no seal reopen, no blind resend.
