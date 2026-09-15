# Onboard ACK (EMAIL)

Same packet for the **lead** and for every other seat. Human (or setup agent) → lead first; then lead → team.

```
FROM: <you> — <your_pane>
TO: <pane_id>
SUBJECT: Onboard — read herdr + conduct; ACK role
SKILLS: official herdr (npx skills add herdrdev/herdr --skill herdr -g)
        <kit>/skills/agent-behavior/SKILL.md sha256=<…>   # includes Herdr extras
        <kit>/skills/conduct/SKILL.md sha256=<…>
DO: Full-read. ACK MATCH. Role = your tab + roster (not vendor). Idle until a work packet.
CALLBACK: herdr agent prompt <requester_pane>  (EMAIL, once)
```

After the lead ACKs, send them one more EMAIL: onboard every other pane in this workspace the same way; harvest ACKs; then idle.

Seat → requester:

```
FROM: <live_name> — <pane_id>
TO: <requester>
SUBJECT: Onboard ACK
ROLE: Lead   # or Tools / Builder 1 / … — tab + roster, not "I am Codex"
KIND: grok
FULL_READ: yes
HERDR_SHA256: <hash> MATCH
CONDUCT_SHA256: <hash> MATCH
NEXT: idle
```
