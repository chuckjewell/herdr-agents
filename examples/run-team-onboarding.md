# How to run team-onboarding

This is a **planning / air-traffic** job. Use a **strong** model (the same class you would pick for lead/ATC), not a cheap builder.

1. In Herdr, open a pane. Start that agent in the shell (`grok`, `claude`, `codex`, …).
2. Official Herdr skill already installed (`npx skills add herdrdev/herdr --skill herdr -g`). Team extras are in agent-behavior, not a herdr fork.
3. Paste (edit the kit path):

```
Read $HERDR_AGENTS_KIT/skills/team-onboarding/SKILL.md (or <kit>/skills/team-onboarding/SKILL.md) and run it.

You are doing first-time team standup: design session vs the kit baselines, write roster/skills, configure Herdr, ask me to start the lead CLI then the rest, onboard the lead like any seat, then have the lead onboard the team. Do not start CLIs for me. Do not merge.
```

4. Answer its design questions. When it asks, start the **lead** CLI in the lead tab, then the others.

New workspace later: same paste. Day-to-day swap: tell the **lead** to use agent-behavior Pane onboard, not this skill.
