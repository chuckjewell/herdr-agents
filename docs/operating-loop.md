# Operating loop

Layout is cheap. **Coordination** is the product.

## Roles (portable)

| Role | Authority | Ban |
|---|---|---|
| Human (strategy) | Outcomes, doctrine, exceptions | — |
| Lead | Sequence, packets, integration lease, guarded merge | Grading their own code as "independent" |
| Builder | One overlapping surface, one PR | Merge, restamp, widening the packet |
| Semantic/source reviewer | Truth vs source | Implementing the fix they just graded |
| Hostile/repro reviewer | Break it, exact pins | Same |
| Process | Written law / provenance | Third product grade, invented gates |
| Advice | Bound opinion | Execution, merge, queue authority |

Labels (`Sage`, `Astra`, `DarkHorse`) are ours. Copy the **authorities**, not the names.

## Packet

Dispatch is a **self-contained order**, not a vibe:

```
FROM / TO / SUBJECT
PINS: repo, branch, HEAD, BASE, paths
DO: one bounded outcome
DON'T: merge, extra surfaces, suite unless named
RECEIPT: durable path under artifacts/
CALLBACK: how the lead learns (herdr agent prompt lead …)
BUDGET: wall clock / no --wait on the worker's callback
```

See [`examples/packet.md`](../examples/packet.md).

The worker:

1. Full-read + **hash ACK** before execute (if the packet gave a sha256).
2. Does only the DO.
3. Writes the receipt, **hashes after the final write**.
4. Sends **one** callback with path + sha256.
5. Stops. No novel, no extra PR.

A `TO:` header is not delivery. `herdr agent prompt` (or a paste block if Herdr is down) is delivery. Desktop notifications are not.

## Harvest

Lead (or a named alternate) on `done` / pulse:

1. **Live `herdr agent get`** before assuming the seat is free.
2. Read recent-unwrapped output **and** the receipt file.
3. Runtime `done` without a receipt = not done (provider death, quota, abandoned turn).
4. Close the packet (accept / hold with exact unblock / next successor).
5. Do **not** add a new ask to the lane that just delivered unless the next packet is already queued and orthogonal.

Sticky `done`: Herdr does not clear it when you CLI-read. A pulse that lists `finished-unseen` is a **weak** signal. Judge from receipts.

## WIP and dirty trees

- One active packet per lane; one writer per overlapping path.
- Never prompt `working`.
- Never dispatch to a pane "because the tab is idle" without `agent get`.
- A stand-down retires a **role**. It does not retract artifacts already written. If stood down mid-work, say exactly what was touched.

## Dual review + Process

For anything that can land on the default branch:

1. Independent **semantic/source** review at exact HEAD/BASE.
2. Independent **hostile/repro** review (different occupant).
3. **Process**: pins match, receipts exist, law followed — not "I also think the code is good."
4. Lead: guarded squash `--match-head-commit <exact>` then ff-only default branch.

Lead-authored code is still builder work. The lead cannot supply both independent grades of their own diff.

## Counts

Every number has a **denominator and grain**. Missing measurement is `unavailable`, never `0`.

## Holds

`HOLD_WITH_EXACT_UNBLOCK`: name the missing evidence, owner, and the condition that changes the decision. A worker HOLD or a code comment does not create a new approval gate by itself — cite the governing decision.

## Skill refresh

Editing `SKILL.md` does not update running occupants. When it matters:

- Send path + sha256.
- Require full-read ACK.
- Do **not** reset the session, change model, or replay charged work.

## Optional ledger

Long campaigns benefit from a tiny state machine (we use `tools/lane_watch.py` in the extract repo): `dispatch` / `respond` / `set staged_idle` / `poll`. Until you have that, a markdown table of packets is enough. Do not pretend a spreadsheet is live Herdr state.

A 15-minute "pulse" (OverSeer) is a **reminder to the lead**, not a license to invent work when `quiet=true`.

## Transport recovery

If a worker hits a provider quota or dies without FINAL: do not reset the seat and replay the expensive run. Reconcile existing artifacts. A named alternate may finish a **receipt-only** closeout with execution budget zero. Repeated transport failure → one named fallback, not a resend loop.
