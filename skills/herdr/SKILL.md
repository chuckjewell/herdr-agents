---
name: herdr
description: Control Herdr only when the user explicitly names it or requests Herdr pane, workspace, terminal or agent inspection/control. Requires HERDR_ENV=1; not generic delegation.
---

# Herdr

PRECHECK: `test "${HERDR_ENV:-}" = 1`; failure → no inspection/control of another focused session.
SYNTAX: installed binary is authority. `herdr --help`, relevant group help only. Never bare `herdr` (TUI attach); never probe mutating nested commands with missing arguments (defaults can execute).

## Identity and state

- TARGET: `--current`, exact pane ID or unique live agent name. Never UI focus/sidebar position. Parse returned opaque IDs, don't predict them.
- DISCOVER: `herdr pane current --current`; `herdr agent list/get`; topology groups when needed.
- LAYERS: pane=raw terminal/process; agent=recognized occupant/lifecycle; tab/workspace=layout. Agent names aren't terminal IDs or kind labels.
- NAMES: `[a-z][a-z0-9_-]{0,31}`, live-unique; follow current occupant, cleared on exit/release/replacement.
- STATES: idle=ready+seen; done=same readiness, unseen completion; reads don't mark seen, focus does. blocked=recognized approval/question UI; unknown ≠ complete.
- MOVE: new workspace-qualified pane ID from `.result.move_result.pane.pane_id`; previous ID survives only inherited caller context. Closed IDs not reused.

## Existing agents first

`herdr agent prompt <id> '<bounded task>'` submits input; `--wait --timeout <ms>` waits for settled idle/done/blocked (no redundant `--until`). Obey host wait limits.

- Wait tracks lifecycle, not your packet. Already-working turn may satisfy wait; verify task-specific ACK/output.
- Nonworking prompt needs observed transition within 5s or agent_prompt_stalled. Inspect before deciding follow-up; no blind retry.
- Wait timeout/failure: inspect get + bounded recent output before further input; timeout is neither worker failure nor permission to resend/reset.
- blocked rejects prompt: inspect get/read; answer only within existing explicit authorization for that exact dialog choice, otherwise ask user. No inferred permission or unauthorized model-dialog answers/resets.
- `herdr agent wait <id>` uses settled defaults; `--until blocked` only for that explicit condition.
- Keys: agent send-keys validates logical keys; use only for authorized UI control. Pane commands only when raw terminal control is intentional.
- Handoff: durable artifact-backed tasks name receipt + actual completion transport upfront. TO headers alone don't deliver.

## Create only within authorization

No new workspace/tab/worktree/cwd unless requested. For authorized new agent/command pane: inspect caller layout; wide→right, tall/narrow→down; avoid repeated tiny splits.

`herdr pane split --current --direction right --cwd "$PWD" --no-focus`

Read `.result.pane.pane_id`. Agent start needs an existing available interactive shell with no foreground process; never creates layout. `herdr agent start <name> --kind <requested-kind> --pane <returned-id> [-- <native-args>]`. Installed group help lists kinds.

Start returns after detected ready; default 30s. agent_not_ready may leave a named blocked occupant: inspect/read, wait for readiness; don't start duplicates.

Ordinary command: pane run → pane wait-output with literal --match or --regex and explicit timeout → pane read. wait-output checks retained output immediately; match alone may be stale. No-timeout waits indefinite.

## Read/output safety

- visible=current viewport; recent=rendered scrollback; recent-unwrapped=joined wraps, preferred logs; detection=bottom state buffer. `--format ansi` only when styling is evidence.
- More --lines cannot recover alternate-screen history. After one failed recovery, request complete artifact/path; read directly. Don't repeatedly scrape missing output.
- Preserve focus with --no-focus. Never close layouts/sessions you didn't create unless explicitly asked.
- Never stop server unless user explicitly intends stopping it and its pane processes. Never kill main Herdr process; experiments use authorized isolated test sessions.
- Server errors: JSON stderr/exit1; syntax errors: exit2. Distinguish command failure from worker result.
- Protocol mismatch: do not follow a server-restart suggestion that would stop pane processes. Use an already-available compatible client when verified; otherwise report the exact transport blocker. Propagate the same compatible client through PATH to child tools such as Lane Watch, not just direct calls. Verify the child's runtime-sync result; an unavailable sync is not a current lane-state check.
