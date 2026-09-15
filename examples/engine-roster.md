# Example roster — Engine

This is one worked example, not a required clone. Workspace label: **Engine**. Working directory: the engine/core checkout. One tab per seat.

| Tab label | Suggested agent name | Kind we use | Job |
|---|---|---|---|
| Lead | `lead` | grok | Packets, lease, squash |
| Builder 1 | `builder1` | cursor | Builder |
| Builder 2 | `builder2` | cursor | Builder |
| Builder 3 | `builder3` | cursor | Builder |
| Tools | `tools` | cursor | Hostile / repro |
| Investigate | `investigate` | cursor | Seals, scouts |
| Eyes | `eyes` | grok | Discovery (scarce) |
| Grader | `grader` | grok | Independent semantic/source |
| Advice | `advice` | claude | Advice only |
| Process | `process` | codex | Written-law closeout |
| Hermes | `hermes` | hermes | Odd jobs / OverSeer if combined |
| Standby | `standby` | cursor | Specialized standby |

Build with [`docs/build-a-workspace.md`](../docs/build-a-workspace.md). Prompt by **pane ID or live name**, never by the tab string.

Merge object: engine PR. Dual ACCEPT + Process GREEN before lead squash.
