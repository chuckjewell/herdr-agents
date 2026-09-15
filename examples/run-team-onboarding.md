# How to run team-onboarding

This is a **planning / air traffic control (ATC)** job. Use a **strong** model (the same class you would pick for lead/ATC), not a cheap builder.

It is **not one paste and done.** You will talk to it several times. That is the design.

**Team makeup is a conversation.** It should ask what kind of project this is, **propose a starter roster** (and an extra seat/skill if it helps — e.g. UI tester + `dev-browser` on a web app), equip seats at kit quality or better, and check the roster against **our loop**. If the team cannot dual-review / Process / WIP=1, it should **propose loop changes** (`conduct` / AGENTS) and get your yes. Do not let it create Herdr tabs until you explicitly say the team is **ready to build**.

1. In Herdr, open a pane. Start that agent in the shell (`grok`, `claude`, `codex`, …).
2. Official Herdr skill already installed (`npx skills add herdrdev/herdr --skill herdr -g`). Team extras are in agent-behavior, not a herdr fork.
3. Paste (edit the kit path):

```
Read $HERDR_AGENTS_KIT/skills/team-onboarding/SKILL.md (or <kit>/skills/team-onboarding/SKILL.md) and run it.

You are doing first-time team standup: design session vs the kit baselines, write roster/skills, configure Herdr, ask me to start the lead CLI then the rest. Onboard the lead with official herdr + agent-behavior (EMAIL role ACK). Then have the lead onboard every other pane with those same two skills. Do not start CLIs for me. Do not merge. After each gate, wait for me; when I reply, continue from the last unfinished step.
```

4. Work the roster with it until you are comfortable. Say the team is **ready to build** before it creates Herdr tabs.
5. When it asks, start the **lead** CLI in the lead tab. Tell it the pane is live. It onboards the lead.
6. When it asks, start the other CLIs. Tell it those panes are live. It tells the lead to onboard them.

**If it stops mid-walk** (layout done, then idle; or context compact), paste:

```
Continue team-onboarding from the last unfinished step. Do not restart the design session unless the roster changed.
```

Name the step if you know it (`continue from step 5 — other panes are live`).

New workspace later: same first paste. Day-to-day swap: tell the **lead** to use agent-behavior Pane onboard, not this skill.
