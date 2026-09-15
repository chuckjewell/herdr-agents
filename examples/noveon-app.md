# Example roster — Noveon App

This is one worked example, not a required clone. Workspace label: **Noveon App**. Same git root as Os for us. Different merge owner and WIP pool.

| Tab label | Suggested agent name | Kind we use | Job |
|---|---|---|---|
| Conductor | `app_lead` | codex | App-side lead |
| UI Builder | `ui` | claude | Presentation |
| Fullstack + Vault | `vault` | cursor | Product API / persistence |
| Investigator / Tools | `app_tools` | cursor | Repro |
| Independent Grader | `app_grade` | claude | App correctness |
| Mr. Process | `app_process` | grok | Written law (may be a different occupant than Os) |
| Hermes | `app_hermes` | hermes | Odd jobs |
| Terminal | — | shell | Human / lead CLI |
| Muse | `muse` | muse | Design; cwd may be `app/` |

Why it is not a tab on Os: UI packets must not sit behind engine dual-review, and engine freezes must not block vault work.

If your UI lives in another repo, set that tab's `--cwd` there and give it its own `AGENTS.md` snippet.
