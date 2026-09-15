# Onboard a workspace

After seats exist, the **lead** onboards every occupant. A new process in a pane does not know the team until it reads the skills and ACKs its **role**.

Skills to load (path+sha256 in the packet; full-read ACK):

- `skills/herdr/SKILL.md` — drive Herdr
- `skills/agent-behavior/SKILL.md` — assign / harvest / wait
- `skills/conduct/SKILL.md` — EMAIL, WIP=1 (and `process` if that seat is Process)

Role comes from **tab label + roster + AGENTS.md**, not from which vendor is running. `Tools` stays Tools if Codex dies and Grok sits down.

## Lead packet (one per seat, or one roll-call)

EMAIL to each pane ID (not tab title). Do not prompt `working`. Template: [`examples/onboard-ack.md`](../examples/onboard-ack.md).

Ask them to:

1. Full-read the named skills; hash-ACK if you sent sha256s.
2. State **role** (from tab name / roster), pane ID, live agent name, kind.
3. ACK in EMAIL to the lead. Then idle until a real packet.

Harvest ACKs. Missing ACK = not onboarded. Do not assign product work until the roll-call is in.

## Swap the occupant (quota, crash, better kind)

Herdr panes are sockets. You can stop Codex and `herdr agent start … --kind grok --pane <same-id>` (pane must be back at a shell prompt; see the Herdr skill). The **role does not change**.

Then: **ask the lead to onboard that pane** the same way. The new occupant reads skills + tab/roster and EMAIL-ACKs the same role. No session reset of the rest of the team. No replay of charged work unless the lead sends a bounded recovery packet.

Stand-down of a *role* is different: that is conduct (artifacts already written stay; say what was touched).
