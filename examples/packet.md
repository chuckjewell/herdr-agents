# EMAIL / packet skeleton

This is the organizing format: every dispatch and every FINAL looks like mail. Occupants load the rule from `skills/conduct` (Dispatch). This file is the fill-in template, not a second law.

```
FROM: lead — w1:pD
TO: tools — w1:p3
SUBJECT: Hostile seal PR1234 at exact head
product_licensed=false

PINS: HEAD=<40 hex> TREE=<40 hex> BASE=<40 hex> PR=1234
WT: .worktrees/foo (or main checkout, read-only)

DO: Run named tests only. Write artifacts/pr1234_seal.v1.md. Hash after final write. One callback to lead.
DON'T: merge, restamp, full suite, prompt other lanes, Git mutation.

RECEIPT: artifacts/pr1234_seal.v1.md
CALLBACK: herdr agent prompt <lead_pane> with path+sha256. No --wait.
BOUNDS: wall 20m.
```

Worker ACK before expensive work:

```
FULL_READ=yes PACKET_SHA256=<hash> MATCH
```

Worker FINAL:

```
VERDICT: ACCEPT_SCOPED | HOLD_WITH_EXACT_UNBLOCK | …
RECEIPT: artifacts/pr1234_seal.v1.md
RECEIPT_SHA256: <hash after last write>
```
