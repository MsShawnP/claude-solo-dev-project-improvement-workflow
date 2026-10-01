# claude-solo-dev-project-improvement-workflow — Current Work Plan

The current arc of work. Updated when the arc changes, not every
session. For session-by-session state, see HANDOFF.md.

---

## Goal

[One sentence — what "done" looks like for this arc.]

## Why this arc, why now

[One or two sentences. The reason matters when you come back in three
weeks and wonder why this was the priority.]

## Business question this arc answers

[One sentence. Direct connection to the project-level business question
in CLAUDE.md.]

## Tasks

Work in vertical slices — one section/feature end-to-end before moving
to the next. Visualizations get reviewed in their own slice, not
deferred to a polish phase.

- [ ] Specific, scoped, actionable
- [ ] Each one is a thing Claude Code could plausibly finish in one
      session
- [ ] If a task feels too big, break it down before adding it
- [x] Completed items stay struck or checked, so the trail is visible

## Out of scope for this arc

- Things explicitly NOT being done in this round
- Captures the decisions about what to defer
- Prevents scope creep mid-session

## Definition of done for this arc

- [ ] Specific, verifiable conditions
- [ ] Not "the prose is better" — "every section's executive summary
      has been reviewed and either approved or marked for domain
      insertion"
- [ ] When all of these are checked, the arc is done and a new PLAN.md
      arc gets defined

---

## Arc history

When an arc completes, archive its goal, completion date, and outcome
here. Then start a new arc above. Provides continuity without bloating
the active plan.

### [Date completed] — [Goal]
- Outcome: [what shipped or what was decided]
- Tag: [git tag if one was created]

---

## Improvement history

Track when this project was reviewed and improved via /improve.
Each entry records what was found, what was fixed, and when to
check again.

<!-- Entries are added by /improve — don't delete this section -->

### 2026-10-01 — Audit (health check only)
- **Findings:** 1 critical, 5 important, 3 nice-to-have
- **Top concerns:** install.ps1 (README Quick start, Option A) fails to parse on Windows PowerShell 5.1, the only PowerShell on this machine: the file is UTF-8 without a BOM and its em dashes (lines 21, 61, 86, 87) decode as cp1252 curly quotes that end strings early. /improve Step 3g names /ce:review (now compound-engineering:ce-code-review) and an uninstalled data-science-reviewer agent, so both deep reviews get silently skipped; the installed ~/.claude/commands/improve.md is the same file. /add-workflow copies from this repo's templates first, which are older than the claude-solo-dev-workflow/workflow-package copies (missing "work on main" and the read-all-five-state-files session start).
- **Other items:** /add-workflow Step 5 `git add` names src/CLAUDE.md and tests/CLAUDE.md, which these templates never create, so the commit fails with "pathspec did not match". Commits 3e94889 and d75f49e claim wrap/log credential redaction and a CLAUDE.md secret policy that live only in ignored files (.claude/, CLAUDE.md) on a PUBLIC repo. The repo had no PLAN/HANDOFF/DECISIONS/FAILURES files (this PLAN.md is new). Nice: README misdescribes installer backups and credits /security-review to gstack; no parse/smoke check for install.ps1; leftover merged branch claude/xenodochial-kepler-989878 and empty .claude/worktrees dir.
- **Rule-11 review:** install.ps1 PS 5.1 parse failure: kept as critical (reviewer 1 confirmed facts, reviewer 2 confirmed severity).
- **Verified OK:** All 13 tracked files read. gitleaks history scan (5 commits) found no leaks; pre-commit gitleaks hook installed; .gitignore covers .env, keys, credentials, secrets. No large files; no branches unmerged against origin/master (on master at 3e94889, 0 ahead/0 behind). commands/improve.md matches the installed copy and the sibling package; templates PLAN/DECISIONS/FAILURES/HANDOFF match the sibling apart from line endings. README covers what/how/stack. Tests: no suite; PS 5.1 parse smoke check on install.ps1 FAILED (3 errors), -DryRun failed the same way (0 passed, 1 failed). Skipped: `pre-commit run --all-files` and a real install.ps1 run (writes outside repo); no DB tests apply (ports 5432-5434, 15432-15433 clear). Deep reviews: security and code-quality done manually (/security-review had no pending branch changes; /ce:review no longer exists); no data-correctness review (repo computes no numbers). Step 2 interview skipped (batch rule 5).
- **Action taken:** Audit only — no fixes this session
- **Next review:** 2026-12-30
