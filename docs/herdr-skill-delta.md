# Why we do not fork the Herdr skill

This page is for humans who install skills.

Install the official skill (all agent types):

```bash
npx skills add herdrdev/herdr --skill herdr -g
```

Upgrade with the same command. Do not replace that `SKILL.md` with a fork.

Rules that are not in upstream (tab titles are not IDs; `done` stays after a CLI harvest; live `agent get`; no second start on a busy pane; same `herdr` on `PATH`) live in [`skills/agent-behavior/SKILL.md`](../skills/agent-behavior/SKILL.md) under **Herdr extras**. Occupants get them when onboarded (official herdr + agent-behavior). Receipts and EMAIL stay in `conduct` (product packets, not the roll-call).
