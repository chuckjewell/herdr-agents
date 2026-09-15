# Herdr skill vs upstream

`skills/herdr/SKILL.md` is [herdr `v0.9.0`](https://github.com/herdrdev/herdr/blob/v0.9.0/skills/herdr/SKILL.md) with a few short inserts. We do **not** restate wait-vs-turn, the 5s stall, “don’t blindly resubmit,” or “ask the user before answering blocked.” Those are already in upstream and the skill follows them.

## Inserts (why)

| Insert | Why |
|---|---|
| Tab titles are not agent targets | Occupants used “Sage” / “Astra” as IDs. |
| `done` stays after a CLI harvest | Pulses re-listed `finished-unseen` as if new. |
| `herdr agent get` before treating a seat as free | Ledger “idle” vs live `working`. |
| No second `agent start` on an occupied pane | Duplicate occupant on `agent_not_ready`. |
| Same `herdr` on `PATH` for child tools; no restart-to-fix | Poller used a different client; missing method ≠ kill the server. |

## Not in this skill (already in `conduct`)

Receipts, `TO:` vs delivery, stand-down vs artifacts, skill-adoption ACK, transport fallback. See [`operating-loop.md`](operating-loop.md) and [`skills/conduct/SKILL.md`](../skills/conduct/SKILL.md).

Occupants do not hot-reload this file. Send path+sha256; require full-read ACK.
