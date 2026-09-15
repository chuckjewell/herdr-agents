# Example roster — Product

This is one worked example, not a required clone. Workspace label: **Product**. Same git root as Engine for us. Different merge owner and WIP pool.

| Tab label | Suggested agent name | Kind we use | Job |
|---|---|---|---|
| Lead | `app_lead` | codex | Product-side lead |
| UI Builder | `ui` | claude | Presentation |
| Fullstack | `vault` | cursor | Product API / persistence |
| Tools | `app_tools` | cursor | Repro |
| Grader | `app_grade` | claude | App correctness |
| Process | `app_process` | grok | Written law (may be a different occupant than Engine) |
| Hermes | `app_hermes` | hermes | Odd jobs |
| Terminal | — | shell | Human / lead CLI |
| Design | `design` | muse | Design; cwd may be `app/` |

Keep this off the Engine tab bar so UI packets do not wait behind engine dual-review, and engine freezes do not block product work.

If the UI lives in another repo, set that tab’s `--cwd` there and give it its own `AGENTS.md` snippet.
