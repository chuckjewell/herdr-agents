# Example roster — Noveon Os

This is one worked example, not a required clone. Workspace label: **Noveon Os**. Working directory: extract/engine checkout. One tab per seat. Kinds are what we use today.

| Tab label (cosmetic) | Suggested agent name | Kind we use | Job |
|---|---|---|---|
| Astra | `astra` | grok | Lead: packets, lease, squash |
| DarkHorse 1 | `dh1` | cursor | Builder |
| DarkHorse 2 | `dh2` | cursor | Builder |
| DarkHorse 3 | `dh3` | cursor | Builder |
| Tools | `tools` | cursor | Hostile / repro |
| Investigate | `investigate` | cursor | Seals, scouts |
| Eyes | `eyes` | grok | Discovery (scarce) |
| Grader | `grader` | grok | Independent semantic/source |
| Sage | `sage` | claude | Advice only |
| Mr Process | `process` | codex | Written-law closeout |
| Hermes | `hermes` | hermes | Architecture / odd jobs |
| Coolify | `coolify` | cursor | Specialized standby |

Build with [`docs/build-a-workspace.md`](../docs/build-a-workspace.md). Prompt by **pane ID or live name**, never by "Sage" as a tab string.

Merge object: engine PR. Dual ACCEPT + Process GREEN before lead squash.
