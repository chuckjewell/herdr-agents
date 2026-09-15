# Onboard a workspace

## Story

1. **Map roles.** An agent (or you) reads our catalog vs what this workgroup needs. Catalog: lead, builder, hostile/repro, semantic/source, process, advice, OverSeer — see [`workspaces.md`](workspaces.md) and [`examples/noveon-os.md`](../examples/noveon-os.md). Keep **our lead** unless they have a better concept. Drop seats you do not need. Do not invent a 12-tab Os copy for a three-seat job.
2. **Build the rooms.** Tabs named for those roles, one pane each, agent CLI in the shell ([`build-a-workspace.md`](build-a-workspace.md)). The lead tab is already labeled.
3. **Onboard the lead like any other seat.** Tell that pane to read herdr + agent-behavior + conduct (path+sha256), ACK **role from the tab**, EMAIL back. That *is* onboard. No extra leader ceremony.
4. **Tell the lead to onboard the team.** Same packet to every other pane. Harvest EMAIL ACKs. Then product work.

Skills (path+sha256; full-read ACK):

- `skills/herdr/SKILL.md`
- `skills/agent-behavior/SKILL.md`
- `skills/conduct/SKILL.md` (`process` only for the Process seat)

Role is **tab + roster + AGENTS.md**, not vendor. Template: [`examples/onboard-ack.md`](../examples/onboard-ack.md). Missing ACK = not onboarded.

## Swap (quota, crash)

Exit the old CLI. Run `grok` / `claude` / `codex` in that shell. Herdr recognizes the kind if the integration is installed. Ask the **lead** to onboard that pane again — same role. Do not reset the workspace.
