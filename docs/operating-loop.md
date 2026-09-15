# Packet and harvest notes

This page is a short cheat sheet for humans. The full story is [`conductor-loop.md`](conductor-loop.md).

Official herdr skill = multiplexer. `agent-behavior` = air traffic control (ATC) steps. `conduct` = EMAIL + two reviews + Process.

**EMAIL** = `FROM` / `TO` / `SUBJECT`, then the work. **WIP=1** = one active packet on a seat.

## Roles

Copy the **jobs**, not any one campaign’s nicknames.

| Role | May | Must not |
|---|---|---|
| Human | Outcomes, exceptions | — |
| Lead | Sequence, packets, merge | Grade their own code as independent |
| Builder | One overlapping surface, one PR | Merge, widen the packet |
| Semantic/source reviewer | Truth vs source | Implement the fix they just graded |
| Hostile/repro reviewer | Break it, exact pins | Same |
| Process | Written law / provenance | A third product grade |
| Advice | Bound opinion | Execute, merge, own the queue |

## Packet

A self-contained order. Template: [`examples/packet.md`](../examples/packet.md).

```
FROM / TO / SUBJECT
PINS: repo, branch, HEAD, BASE, paths
DO: one bounded outcome
DON'T: merge, extra surfaces, suite unless named
RECEIPT: durable path under artifacts/
CALLBACK: herdr agent prompt <lead>
BUDGET: wall clock; no --wait on the worker's callback
```

Worker:

1. Read the whole packet. If it gave a sha256, ACK MATCH before you execute.
2. Do only the DO.
3. Write the receipt. Hash **after** the last write.
4. Send **one** callback with path + sha256.
5. Stop.

A `TO:` line is not delivery. `herdr agent prompt` is. Desktop notifications are not.

## Harvest

When a pane looks finished:

1. `herdr agent get` before you assume it is free.
2. Read recent output **and** the receipt file.
3. Runtime `done` with no receipt is not done (quota, crash, abandoned turn).
4. Close the packet (accept, hold with exact unblock, or next successor).
5. Do not add a new ask on that lane unless the next packet is already queued and uses different files.

Herdr does not clear `done` when you CLI-read. A pulse that lists `finished-unseen` is a weak signal. Judge from receipts.

## One writer

- One packet per lane. One writer per overlapping path.
- Never prompt `working`.
- Never dispatch because “the tab looks idle” without `agent get`.
- Standing down a **role** does not erase files already written. Say what was touched.

## Two reviews and Process

For anything that can land on the default branch:

1. Independent semantic/source review at exact HEAD/BASE.
2. Independent hostile/repro review (different occupant).
3. Process: pins match, receipts exist, law followed — not “I also like the code.”
4. Lead: squash `--match-head-commit <exact>` then fast-forward the default branch.

Code the lead wrote is still builder work. The lead cannot be both independent reviewers.

## Numbers

Every count needs a **denominator** and a **grain**. If you did not measure, write `unavailable`, never `0`.

## Holds

`HOLD_WITH_EXACT_UNBLOCK`: name the missing evidence, the owner, and what would change the decision. A worker HOLD or a code comment is not a new gate unless the governing decision says so.

## Skill refresh

Editing `SKILL.md` does not update running occupants. Send path + sha256. Require a full-read ACK. Do not reset the session or replay charged work.

## Optional ledger

Long campaigns can use a small state machine (we use `tools/lane_watch.py` in our extract repo). Until then, a markdown table of packets is enough. A spreadsheet is not live Herdr state.

A **pulse** is a Hermes agent cron on OverSeer. Ask Hermes to create it. It reads status and EMAILS leads. It does nothing when the board is quiet. Details: [`workspaces.md`](workspaces.md) (OverSeer).

## If a provider dies mid-packet

Do not reset the seat and replay the expensive run. Reconcile files you already have. A named alternate may finish a receipt-only closeout with no new execution. Repeated transport failure: one named fallback, not a resend loop.
