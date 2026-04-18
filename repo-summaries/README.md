# Repo Summaries

Daily intelligence reports for the repository configured in
`../collect_repo_snapshot.sh`.

Unlike `journal/` (which is you-centric — *your* commits, *your* meetings,
*your* Top 3), files in this directory capture the **full-repo view**:
what every author on every branch shipped in the last 24 hours, clustered
into logical units of work.

## Files

- `YYYY-MM-DD.md` — one file per day. Structure:
  - Period metadata + commit/branch counts
  - `## New Branches` — branches created since last run
  - `## Top Updates` — top N ranked logical updates, two sentences each
  - `## Other Updates` — remaining updates as one-line bullets
  - `## For You` — 2-4 personalized collaboration suggestions
  - `## Weekly Repo Review` (Fridays only) — repo-wide weekly synthesis

- `.branch-snapshot.txt` — current remote branch list. Used to detect
  new branches on the next run. Auto-maintained; do not edit manually.

- `.branch-snapshot.prev.txt` — previous run's snapshot, kept for the diff.

## Generation

See the `Daily Repo Summary` workflow in `../CLAUDE.md`.

Triggered by saying "daily repo summary" in Claude Code, or on a cron
(default 9am daily).

## Relationship to other workflows

| Workflow | Output | Focus |
|----------|--------|-------|
| `morning update` | `journal/YYYY-MM-DD.md` | You: your commits, team activity filtered through your vision, your Top 3 |
| `daily repo summary` | `repo-summaries/YYYY-MM-DD.md` | Repo: clustered view of *everyone's* work + For You suggestions |
| `weekly review` | `weekly/YYYY-WNN.md` | You weekly: OKRs, brag, skills, hypotheses, decisions, relationships |
| `daily repo summary` (Friday) | appends `## Weekly Repo Review` to that day's file | Repo weekly: themes, collaboration opportunities, full wiki refresh |

The two Friday workflows are complementary. Run `daily repo summary` first,
then `weekly review` — so the personal review can reference a fresh wiki.
