# Solo-Dev Project Improvement Workflow

A Claude Code workflow for auditing and improving existing projects. Run `/improve` on any deployed project to get a structured health check, prioritized findings, and guided fixes.

## What it does

1. Checks for workflow files (CLAUDE.md, PLAN.md, etc.) — offers to add them if missing
2. Interviews you about what's bugging you
3. Audits code quality, tests, deps, docs, git hygiene, and workflow files
4. Runs deeper automated reviews (security, code quality, data correctness)
5. Presents prioritized findings (critical / important / nice-to-have)
6. Creates an improvement arc in PLAN.md
7. Executes fixes with your confirmation at each step
8. Logs the audit with a next-review date

## Commands

| Command | What it does |
|---|---|
| `/improve` | Full workflow: audit + plan + fix + track |
| `/improve audit-only` | Health check only, no fixes |
| `/improve [topic]` | Focus on a specific area |
| `/add-workflow` | Retrofit workflow files onto an existing project |

## Requirements

These plugins/skills are used by `/improve` for deeper reviews. Install them for full coverage — the workflow still runs without them, just skips those reviews.

- **compound-engineering plugin** — provides `/ce:review` (multi-reviewer code quality)
- **gstack** — provides `/qa` (browser testing) and `/security-review`

Install via Claude Code:
```
/plugin install github.com/EveryInc/compound-engineering-plugin
/plugin install github.com/garrytan/gstack
```

## Install

### Option A: Copy commands directly

```powershell
Copy-Item .\commands\improve.md $env:USERPROFILE\.claude\commands\improve.md
Copy-Item .\commands\add-workflow.md $env:USERPROFILE\.claude\commands\add-workflow.md
```

### Option B: Run the installer

```powershell
.\install.ps1        # install
.\install.ps1 -DryRun  # preview without changes
```

The installer backs up any existing files before overwriting.

## Templates

The `templates/` directory contains the workflow state files that `/add-workflow` deploys into projects:

- `CLAUDE.md` — project context and rules
- `PLAN.md` — current work arc + improvement history
- `HANDOFF.md` — session-to-session continuity
- `DECISIONS.md` — durable choices log
- `FAILURES.md` — what didn't work and why

## How it fits together

```
You run /improve on a project
    │
    ├─ Project has no workflow files?
    │   └─ /add-workflow adds them from templates/
    │
    ├─ Audit: manual + automated reviews
    │   ├─ /ce:review (code quality)
    │   ├─ /security-review (vulnerabilities)
    │   └─ data-science reviewer (if applicable)
    │
    ├─ Findings presented, you pick what to fix
    │
    ├─ Improvement arc written to PLAN.md
    │
    └─ Fixes executed with confirmation at each step
```

## Audit frequency

| Project state | Audit every |
|---|---|
| Active (commits in last 2 weeks) | 2-4 weeks |
| Stable (no commits in 30+ days) | 90 days |
| Just shipped (recent tag/milestone) | Right after shipping |
| New to you / inherited | Immediately |

## Origin

Built by Shawn Phillips for solo portfolio and consulting work. Runs on any project — data analysis, web apps, APIs, reports.

## License

MIT
