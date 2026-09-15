# Onboard ACK (EMAIL)

Lead → seat:

```
FROM: lead — <lead_pane>
TO: <pane_id>
SUBJECT: Onboard — read herdr + conduct; ACK role
SKILLS: <kit>/skills/herdr/SKILL.md sha256=<…>
        <kit>/skills/agent-behavior/SKILL.md sha256=<…>
        <kit>/skills/conduct/SKILL.md sha256=<…>
DO: Full-read. ACK MATCH. State role from your tab/roster (not vendor). Idle until a work packet.
CALLBACK: herdr agent prompt <lead_pane>  (EMAIL, once)
```

Seat → lead:

```
FROM: <live_name> — <pane_id>
TO: lead — <lead_pane>
SUBJECT: Onboard ACK
ROLE: Tools (hostile/repro)     # tab + roster, not "I am Codex"
KIND: grok
FULL_READ: yes
HERDR_SHA256: <hash> MATCH
CONDUCT_SHA256: <hash> MATCH
NEXT: idle
```
