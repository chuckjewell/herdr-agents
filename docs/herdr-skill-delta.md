# Herdr skill: upstream vs ours

Base: [herdrdev/herdr `v0.9.0` `skills/herdr/SKILL.md`](https://github.com/herdrdev/herdr/blob/v0.9.0/skills/herdr/SKILL.md) (sha256 `25a68bc3…`, ~12.6K).

Ours: `skills/herdr/SKILL.md` in this repo (and the copies under `~/.claude|grok|cursor/skills/herdr`). **Not** a byte-identical vendor file. We started from a 4614-byte rewrite that dropped setup examples, then **restored upstream as the body** and folded campaign scars back in.

Each extra below was added when it bit us. Some belong in this skill (multiplexer). Some are team OS that leaked here; they still live in the file until we split them.

## Already in upstream (do not treat as ours)

These look like “our rules” in transcripts. They shipped in v0.9.0:

- Wait tracks **lifecycle**, not an individual turn; 5s activity gate; `agent_prompt_stalled`
- Do not blindly resubmit after timeout/stall
- Inspect blocked UI; ask the user before answering
- Reads do not mark `done` seen; focus does
- `agent start` never creates layout
- Do not `server stop` / kill Herdr to fix a missing method

## Multiplexer scars (keep in this skill)

| What we added | Why it showed up |
|---|---|
| Tab titles are not targets | Occupants prompted “Sage” / “Astra” as if they were pane IDs. Upstream bans terminal IDs and kind labels, not tab labels. |
| `done` is sticky; CLI harvest does not clear it | Fleet pulses listed `finished-unseen` forever. A second harvest is not a new event. |
| Live `agent get` before prompt; do not prompt `working` | Dispatch to a seat that looked idle in a ledger but was mid-turn. WIP=1. |
| Do not start a duplicate on `agent_not_ready` | Second `agent start` on a blocked occupant. |
| Blocked: only an **explicit** authorized choice for that dialog | DCG / force-delete prompt. Upstream says ask the user; we forbade inferred Yes. |
| Timeout ≠ worker failure ≠ license to reset | Quota-killed Codex treated as “try again from zero.” |
| CLI exit 1/2 ≠ worker RESULT | JSON stderr vs a packet verdict. |
| Protocol mismatch: no server restart; same `herdr` on `PATH` for child tools | Status poller invoked a different client than the parent. Upstream already bans stop-to-upgrade; we named PATH/sync. |
| Parse IDs from JSON, not tab labels or sidebar | Same class as tab-title targeting. |

## Team OS (better in `conduct` / AGENTS snippet)

Still in the skill because that is where we were standing when they bit. A friend who only wants room setup can ignore these; a campaign lead should keep them somewhere.

| What we added | Why it showed up | Better home |
|---|---|---|
| Receipt path + sha256; hash after last write; one callback | “Done” with no file. `TO:` in a novel. | `docs/operating-loop.md`, `examples/packet.md` |
| `TO:` headers are not delivery | EMAIL-shaped paste with no `herdr agent prompt`. | same |
| Runtime `done` ≠ successful **packet** | Provider death / usage limit, no FINAL. Sticky-done (above) is the Herdr half. | `conduct` |
| Named fallback, not a resend loop | Process closeout replayed onto a quota-blocked seat. | `conduct` transport recovery |
| Stand-down retires a **role**, not artifacts | C01 reassigned; builder still had a worktree leftover. | `conduct` / AGENTS |
| Skill file edit ≠ hot-reload; path+hash ACK; no session reset | Foundation Herdr refresh packets. True, but not `pane split`. | AGENTS snippet |

## How to refresh from upstream later

1. Diff this file against the tagged upstream `SKILL.md`.
2. Keep the multiplexer table. Re-evaluate the team-OS table — prefer `conduct` if the skill is getting long.
3. Occupants do **not** pick up a file edit. Send path + sha256; require full-read ACK. Do not reset sessions.
