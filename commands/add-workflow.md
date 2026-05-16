---
description: Add the solo-dev workflow to an existing directory (retrofit, no scaffolding new project)
---

Add workflow files to the current directory. Use this when you already have a project folder and want to bring it under the workflow without creating a new project from scratch.

**Argument (optional):** $ARGUMENTS — used as project name in CLAUDE.md if provided.

## Step 1 — Verify

Run from the directory you want to add the workflow to. Check:
- Current directory exists and is writable.
- It's a git repo (run `git rev-parse --is-inside-work-tree`). If not, ask: "Initialize git here? (y/n)" and run `git init` on confirmation.

## Step 2 — Gather minimal info

Ask only what's needed (not full /new-project interview):

1. "Project name in CLAUDE.md? (default: current folder name)"
2. "Tier? (Quick / Medium / Heavy)"
3. "Short description?"

## Step 3 — Check for collisions

Before creating any file, check for existing:
- `CLAUDE.md`, `PLAN.md`, `HANDOFF.md`, `DECISIONS.md`, `FAILURES.md`

For each existing file, ask:
> "<file> already exists. Skip / Overwrite / Backup-and-replace? (s/o/b)"

Default to skip if user gives no answer — never destroy existing content silently.

## Step 4 — Create files from templates

Look for templates in these locations (in order):
1. `~/projects/reference/claude-solo-dev-project-improvement-workflow/templates/`
2. `~/projects/reference/claude-solo-dev-workflow/workflow-package/templates/`

Copy from the first location that exists:
- `CLAUDE.md` → fill in name, tier, description
- `PLAN.md`, `HANDOFF.md`, `DECISIONS.md`, `FAILURES.md` as-is

If `src/` exists, also create `src/CLAUDE.md` from `src-CLAUDE.md` template (if available).
If `tests/` exists, also create `tests/CLAUDE.md` from `tests-CLAUDE.md` template (if available).

## Step 5 — Commit (if user wants)

Ask: "Stage and commit these new workflow files? (y/n)"

On yes:
```
git add CLAUDE.md PLAN.md HANDOFF.md DECISIONS.md FAILURES.md src/CLAUDE.md tests/CLAUDE.md
git commit -m "chore: add solo-dev workflow files via /add-workflow"
```

## Step 6 — Final summary and next step

```
Workflow added to: <cwd>
Tier: <tier>
Files created: <list>
Files skipped: <list>

Next: /improve to audit and improve the project, or /clarify to scope new work.
```

---

**Notes:**
- This command intentionally does NOT create a GitHub remote or tag.
- This command intentionally does NOT copy any slash commands into `.claude/commands/` — globals handle everything.
- If the directory is genuinely empty (no code, no files besides .git), suggest the user use `/new-project` instead so they get the full scaffold.
