# Work OS

A personal operating system and knowledge base that gives AI agent sessions
persistent context about your goals, projects, people, meetings, ideas,
and collaboration opportunities.

The system is maintained by AI agents running structured workflows (morning
briefing, evening update, weekly review) so that the habits that are worth
having become automatic rather than effortful.

## Setup

1. Replace all `[YOUR_NAME]`, `[YOUR_USERNAME]`, `[YOUR_COMPANY]`, and
   `[YOUR_MAIN_REPO]` placeholders across the repo with your real values.
2. Fill in `vision.md` with your north star and strategic pillars.
3. Fill in `okrs.md` with this quarter's objectives.
4. Add your key collaborators to `people/team-map.md`.
5. Edit `collect_status.sh` — set `REPO`, `AUTHOR`, and `GIT_NAME` to your
   own values (used by the morning/evening updates).
6. Edit `collect_repo_snapshot.sh` — set `REPO` (used by the daily repo
   summary workflow; captures activity from *all* authors, not just you).
7. Run `./collect_status.sh` and `./collect_repo_snapshot.sh` once each
   to verify both scripts work.

---

## Directory Layout

```
vision.md                 — North star, strategic pillars, relationship map, agent heuristics
okrs.md                   — Quarterly OKRs with key results
decisions.md              — Decision log: significant choices with alternatives + expected outcomes
hypotheses.md             — Hypothesis log: predictions and technical bets, reviewed when resolved
brag.md                   — Accomplishment tracker: impact-language wins for performance reviews
skills.md                 — Skill sprint tracker: one active sprint at a time
journal/YYYY-MM-DD.md     — Daily briefings + evening reflections
meetings/YYYY-MM-DD-*.md  — Meeting notes (transcript, takeaways, todos, ideas)
reading/queue.md          — Read-later list
reading/notes/*.md        — Processed notes on papers/articles/talks
inbox.md                  — Mid-day thought capture (timestamped, append-only)
ideas.md                  — Processed idea backlog
actions.md                — Cross-meeting action items tracker
reflections.md            — Personal reflections on career, field, strategy
progress/status.md        — Milestone tracker against your plan
index.md                  — High-level navigation guide
projects/*.md             — One page per project area
people/team-map.md        — All collaborators: area, focus + relationship warmth tracking
people/<username>.md      — Detailed pages for key collaborators
collaboration/
  opportunities.md        — Cross-project collaboration opportunities
  my-impact.md            — Your growth areas, impact plan, priorities
weekly/YYYY-WNN.md        — Weekly personal synthesis: OKRs, brag, skills, relationships
repo-summaries/YYYY-MM-DD.md — Daily full-repo intelligence reports (all authors)
repo-summaries/.branch-snapshot.txt — Rolling branch list for new-branch detection
```

---

## Agent Workflows

### Morning Update

**Trigger:** User says "morning update"

**Steps:**
1. Run `./collect_status.sh` to fetch all branches and get your commits
   since yesterday.
2. Read yesterday's journal entry (evening reflection) for continuity.
3. Read `vision.md` (decision heuristics), `okrs.md`, `progress/status.md`,
   and `actions.md` for context.
4. Read the **Relationship Warmth** section of `people/team-map.md`.
   For each Tier 1 contact: if today's date minus `Last Sync` exceeds
   their Expected Cadence, flag them in the briefing with a concrete
   suggested touchpoint (one specific sentence, not a generic "catch up").
5. Create `journal/YYYY-MM-DD.md` with these sections:
   - **Your Commits** — grouped by branch
   - **Team Activity That Matters to You** — filtered through vision.md
     heuristics. Three tiers: "Direct impact on OKRs" (must-read),
     "Worth knowing" (context), "New collaboration opportunities" (with
     concrete first step)
   - **Relationship Check** — any Tier 1/2 contacts overdue for sync,
     with one concrete suggested touchpoint each
   - **OKR Check-in** — table of OKRs with status and this week's target
   - **Draft Plan for Today** — linked to OKRs. Lead with **Top 3**:
     the three things that must happen today, ranked by OKR impact.
     Include open action items from `actions.md`.
   - **Inbox** — empty section for mid-day captures
   - **Evening Reflection** — empty section for evening agent

### Mid-Day Capture

**Trigger:** User says "capture: ..." or pastes a thought

**Steps:**
1. Append a timestamped entry to `inbox.md` under today's date header.
   Create the date header if it doesn't exist.
2. Auto-tag: `#idea`, `#action`, `#decision`, `#hypothesis`, `#meeting`,
   `#question`.
3. Do NOT process into other files — that's the evening agent's job.

### Meeting Note

**Trigger:** User says "meeting note: ..." or pastes a transcript

**Steps:**
1. Create `meetings/YYYY-MM-DD-slug.md` using the meeting template.
2. If user pasted a transcript, fill the Transcript section and extract:
   - **Takeaways** — key decisions and conclusions
   - **Things I Don't Understand** — assess against vision.md and OKRs.
     If worth learning, add to `reading/queue.md`.
   - **To-Do** — action items (processed to `actions.md` at evening)
   - **New Ideas** — processed to `ideas.md` at evening
   - **Decisions Made** — append to `decisions.md` immediately with the
     full format: decision, alternatives, reasoning, expected outcome,
     review date.
   - **Hypotheses** — any prediction or technical bet → append to
     `hypotheses.md` immediately.
   - **Impact on Plan** — flag which OKR or plan phase is affected
3. Update `Last Sync` date for each attendee in the Relationship Warmth
   table in `people/team-map.md`.
4. If user just gives a brief summary, create the file with what's provided
   and leave sections for later.

### Article / Paper / Reading

**Trigger:** User pastes a URL, article, or says "read this"

**Steps:**
1. Quick add: append to `reading/queue.md` with title, URL, date, and
   which OKR/vision pillar it relates to.
2. If user wants to discuss/process: create
   `reading/notes/YYYY-MM-DD-slug.md` with summary, key takeaways,
   relevance to work, and user's notes.
3. Move the item from queue to Done if previously queued.

### Evening Update

**Trigger:** User says "evening update"

**Steps:**
1. Run `./collect_status.sh` again for the full day's commits.
2. Read today's `journal/YYYY-MM-DD.md` (the morning briefing).
3. Read any `meetings/` files created today.
4. Read `inbox.md` entries for today.
5. Fill in the journal's **Work Log** with today's commits (flat list).
6. Process inbox entries by tag:
   - `#action` → append to `actions.md` Open table
   - `#idea` → append to `ideas.md`
   - `#decision` → append to `decisions.md` with full format
   - `#hypothesis` → append to `hypotheses.md` with full format
7. Process meeting to-dos and ideas the same way.
8. Process meeting "don't understand" items → `reading/queue.md` if
   worth learning.
9. **Update `brag.md`** — scan today's commits and meeting outcomes for
   accomplishments. Append under today's date in the current month section.
   Use impact language: "shipped X which unblocked Y" or "fixed Z which
   enables A to do B." If nothing significant happened today, skip.
10. Write the **Evening Reflection** in today's journal:
    - What got done vs. planned (compare to Top 3)
    - Blockers encountered
    - Key decisions made today
    - What's next tomorrow
11. Write the **Shutdown Checklist** at the bottom of today's journal:
    ```
    ## Shutdown Checklist
    - Inbox cleared: Y/N
    - Tomorrow's Top 3:
      1. [must-happen item 1]
      2. [must-happen item 2]
      3. [must-happen item 3]
    - Anyone blocked waiting on me: [name + what] or None
    - Tomorrow calendar check: [anything unusual]
    ```
12. Update `progress/status.md` — check current week milestones.

### Decision Log Entry

**Trigger:** User says "log decision: ..." or a decision is identified in
a meeting note or inbox capture.

**Steps:**
1. Append to `decisions.md` under "Open" with the full format:
   ```
   ## YYYY-MM-DD — [Decision title]
   **Decision:** What was decided
   **Alternatives considered:** What else was on the table
   **Reasoning:** Why this option over the alternatives
   **Expected outcome:** What you think will happen as a result
   **Review date:** ~3 months out, or at project end
   **Source:** Meeting name, solo thinking, etc.
   ```
2. If the decision reverses a previous decision, add a cross-reference.

### Hypothesis Log Entry

**Trigger:** User says "log hypothesis: ..." or a prediction is identified
in a meeting note or inbox capture.

**Steps:**
1. Append to `hypotheses.md` under "Open" with the full format:
   ```
   ### YYYY-MM-DD — [Hypothesis title]
   **Hypothesis:** I believe that X will happen
   **Why I believe this:** Reasoning or evidence
   **How to test:** What evidence would confirm or refute this
   **Expected timeline:** When will we know?
   **Status:** Open
   ```
2. During weekly review, scan for items whose timeline has passed and
   prompt the user to update the outcome.

### Brag Doc Update

**Trigger:** Automatically run during evening update. Or user says "update
brag doc."

**Steps:**
1. Scan today's commits, merged PRs, and meeting outcomes.
2. Extract accomplishments with impact framing:
   - Not "fixed bug in X" → "fixed X which was blocking Y from shipping"
   - Not "wrote 200 lines" → "shipped Y which the team can now build on"
   - Not "ran experiments" → "confirmed hypothesis Z, changing approach
     for OKR 2"
3. Append under today's date in `brag.md`, current month section.
4. Quarterly (before performance review): synthesize monthly entries into
   a 5-7 bullet quarter summary grouped by OKR.

### Skill Sprint

**Trigger:** User says "start skill sprint: [skill]" or weekly review
identifies a skill gap blocking current OKR progress.

**Steps:**
1. Check `skills.md` — if there is already an active sprint, do not start
   a new one. Ask user to finish or explicitly abandon the current one first.
2. Move the skill from Queued to Active Sprint and fill in the full block:
   ```
   ## Sprint N: [Skill Name] — YYYY-MM-DD to YYYY-MM-DD (2 weeks)
   **Why this skill:** Connection to OKR or vision pillar
   **Definition of done:** What "good enough" looks like for this sprint
   **Resources:** Docs/papers/codebases to use
   **Week 1 goal:** [what to cover / read]
   **Week 2 goal:** [what to build or apply]
   **Outcome:** (filled at sprint end)
   ```
3. At sprint end (during weekly review): fill the Outcome field, move block
   to Completed Sprints, and prompt user to start the next queued skill.

### Preference Observation (Auto, Bi-weekly)

**Trigger:** Runs automatically every other Sunday via `auto/observe.sh`.
No user input needed.

**Steps:**
1. Read all `journal/` entries from the past 14 days.
2. Read `decisions.md` entries from the past 14 days.
3. Read `actions.md` — note which items were completed vs. repeatedly
   carried over without progress.
4. Read `ideas.md` — note which types of ideas appear most frequently.
5. Read `inbox.md` — note what gets captured (tags, topics, time of day).
6. Synthesize: identify behavioral patterns or preferences not yet captured
   in the `## Learned Preferences` section of this file.
7. Append new findings to `## Learned Preferences` (date-stamped, one line
   each). Do NOT overwrite or remove existing entries.
8. Append a log entry to `auto/logs/observe-YYYY-MM-DD.log`:
   `[YYYY-MM-DD] observation | N new preferences added | summary`

**What to look for:**
- Task types that get done immediately vs. repeatedly deferred
- Decision patterns (what reasoning appears most often?)
- Which OKRs get the most attention vs. least
- Recurring blockers or friction points
- Topics that generate the most ideas
- Anything surprising that should change how the agent prioritizes

### Weekly Review (Friday)

**Trigger:** User says "weekly review"

**Steps:**
1. Run `./collect_status.sh` for the full week's commits.
2. Read all 5 journal entries from the week.
3. Read all meeting files from the week.
4. Read `okrs.md`, `progress/status.md`, `actions.md`, `ideas.md`.
5. Scan `hypotheses.md` for items whose timeline has passed. If any:
   prompt user to record the actual outcome and add to the Resolved table.
6. Scan `decisions.md` for items whose review date falls this month.
   If any: prompt user to assess whether the expected outcome came true.
7. Write `weekly/YYYY-WNN.md` with these sections:
   - **What I Shipped** — from journal work logs, impact-framed
   - **OKR Progress** — table with start/end of week status + delta
   - **Visibility Log** — what was made visible to others this week:
     - Merged PRs or deployed work
     - Outputs shared with collaborators (data, tools, docs)
     - Write-ups, Slack updates, or announcements posted
     - Demos or presentations given
     - Flag: if all empty, note "visibility gap this week"
   - **Meetings This Week** — one-line summaries
   - **Decisions Made** — brief list of decisions logged this week
   - **Hypotheses Updated** — any opened or resolved this week
   - **Brag Wins This Week** — pulled from `brag.md` for this week
   - **Ideas Generated** — items added to `ideas.md`
   - **Reading This Week** — items added or processed
   - **Action Items Status** — opened, completed, carried over, overdue
   - **Relationship Check** — for each Tier 1 contact: last sync, days
     since sync, overdue? Suggested next touchpoint if overdue.
   - **Skill Sprint Progress** — current sprint status and weekly goal
     completion
   - **Plan Drift Analysis** — plan targets vs. actual, assessment
   - **Next Week Plan** — carryover + Top 3 for Monday
   - **Reflection** — what went well, what didn't, one thing to change
8. Update `okrs.md` status fields.
9. Update `progress/status.md` with fresh assessment.
10. Update project pages: "Recent Direction" for areas that changed.
11. Update `people/team-map.md` if anyone's focus shifted.
12. Refresh `collaboration/opportunities.md` with fresh analysis.
13. Check `decisions.md` and `hypotheses.md` for items due for review.
14. Check `skills.md` — is the active sprint on track? If sprint ends
    this week, prompt for outcome and next sprint.

### Daily Repo Summary

**Trigger:** User says "daily repo summary" (or scheduled daily, e.g. 9am).

**Purpose:** A full-repo intelligence report. Unlike the morning update
(which is *you-centric*: your commits, team activity that matters to you),
this workflow is *repo-centric*: what happened across the whole repo in the
last 24 hours, clustered into logical units of work.

**Scope:** Single repository (the one configured in `collect_repo_snapshot.sh`).
Read-only — no local checkout or merge.

**Output:** `repo-summaries/YYYY-MM-DD.md`.

#### Steps

**1. Fetch and collect.**

Run `./collect_repo_snapshot.sh` — this fetches all remote branches,
produces the commit log for the window (default 24h, all authors, dedup'd
by SHA), writes the current branch list to
`repo-summaries/.branch-snapshot.txt`, and diffs against the previous
snapshot to flag new/deleted branches. The script also emits diffstat
summaries and a list of branches active in the window.

**2. Cluster into logical updates (two-stage LLM reasoning).**

*Stage 1 — Clustering.* Given the commits from step 1, group them into
**logical updates** — a single coherent unit of work a human would
describe as "one thing that happened." Use all of these signals together,
not any one alone:

- **Branch:** commits on the same feature branch are likely one update.
- **Author:** same author + related messages → likely one update.
- **Topic:** commit messages referencing the same module, feature, or
  bug (e.g. 10 commits mentioning the same solver → 1 update).
- **Time proximity:** bursts of commits from the same author in a short
  window.

A single commit can be its own update if it's unrelated to others.

Internally, the agent produces a JSON-like structure for each update
group: `{ title, commit_shas, primary_authors, primary_branches }`.

*Stage 2 — Rank and summarize.* Rank updates by importance. Prioritize
breaking changes, new features, critical bug fixes, infrastructure/config
changes, and security patches over routine refactors or chores.

- **Top N (default 10):** write exactly **2 sentences** each — what
  changed, and why it matters. Note the number of commits and author(s).
- **Remaining updates:** one bullet each in the format
  `- title (author, N commits) — one-line description`.

**3. Write `repo-summaries/YYYY-MM-DD.md`** in this structure:

```markdown
# Repo Summary — YYYY-MM-DD

**Period:** {start_time} → {end_time}
**Total commits:** {count} across **{update_count} logical updates**
**Active branches:** {active_count} ({new_count} new)

## New Branches
- `feature/xyz` — created by {author}, N commits. One-line purpose.

## Top Updates

### 1. {title} — `{branch}` ({authors}, N commits)
Two-sentence summary. What changed and why it matters.

### 2. {title} — `{branch}` ({author}, N commits)
Two-sentence summary.

...

## Other Updates

- {title} ({author}, N commits) — one-line description.
- ...
```

**4. Update project pages (daily, scoped).**

For each project area that saw **significant changes** (major features,
architecture changes, new contributors — not routine refactors or typo
fixes):

1. Read the corresponding page from `projects/`.
2. Update **only** the "Recent Direction" subsection with today's changes.
3. If a new person appeared as a contributor, add them to the
   "Active Contributors" table.
4. Do **not** rewrite Purpose, Architecture, or Connections.

If a person's focus visibly shifted, update their entry in
`people/team-map.md` and their person page if one exists.

**5. Append the "For You" section.**

Append `## For You` to today's `repo-summaries/YYYY-MM-DD.md`. This is
2-4 personalized, actionable collaboration suggestions for `[YOUR_NAME]`
based on:

- Today's repo activity (the summary above)
- Your recent work: `git log --all --author="[YOUR_USERNAME]" --since="7 days ago" --oneline`
- Known opportunities (`collaboration/opportunities.md`)
- Impact priorities (`collaboration/my-impact.md`)
- Team context (`people/team-map.md`)
- Decision heuristics (`vision.md`)
- Current OKRs (`okrs.md`)

Each suggestion names a specific person, explains the connection to your
work, and proposes a concrete first step. Format:

```markdown
## For You

Based on your recent work ({brief description}) and today's updates:

**{Action verb}: {Person}** — {Why this matters, what the connection is}.
{Concrete first step.}

**{Action verb}: {Observation}** — {What changed and why you should care}.
{Concrete first step.}
```

Guidelines:
- Be concrete: "Review X's PR on Y" not "consider exploring synergies."
- Only suggest things grounded in today's actual activity or recent git data.
- 2-4 suggestions. Quality over quantity.
- If nothing noteworthy connects to your work today, write a brief
  "No specific collaboration signals today" note instead of forcing it.

**6. Friday: append a Weekly Repo Review section.**

If today is Friday, after the daily steps above, append
`## Weekly Repo Review` to today's `repo-summaries/YYYY-MM-DD.md`.

Steps:

1. Read all daily summaries from this week (Mon-Fri) in `repo-summaries/`.
2. Read all project pages, `people/team-map.md`, `collaboration/opportunities.md`,
   `collaboration/my-impact.md`.
3. Deeper git analysis (run against the summarized repo):
   ```bash
   # Cross-directory contributors (people working across areas)
   git log --all --since="7 days ago" --format="%an" --name-only \
     | awk '/^[A-Z]/{author=$0; next}
            /\//{split($0,p,"/"); dirs[author][p[1]]++}
            END{for(a in dirs){n=0; for(d in dirs[a]) n++; if(n>2) print a": "n" top-level dirs"}}'
   # Stale branches (>2 weeks no commits)
   git for-each-ref --sort=committerdate refs/remotes \
     --format="%(committerdate:iso8601) %(refname:short)" \
     | awk -v cut="$(date -u -v-14d +%F 2>/dev/null || date -u -d '14 days ago' +%F)" '$1 < cut'
   ```
4. Write the Weekly Repo Review with these sections:
   ```markdown
   ## Weekly Repo Review — YYYY-WNN

   ### Week Summary
   3-5 bullets: major themes across the repo this week.

   ### Your Week (repo view)
   What you shipped — commits, PRs, measurable impact in repo terms.
   (The personal-synthesis view — OKR progress, brag wins, skill sprint —
   lives in the separate `weekly review` workflow.)

   ### Collaboration Opportunities
   3-5 specific, actionable opportunities with who / what / first step.

   ### Impact Advice
   - What to focus on next week for maximum impact
   - Emerging projects worth joining
   - Skills to develop
   - Things to deprioritize

   ### Wiki Updates Made
   List of wiki pages updated during this weekly refresh.
   ```
5. Full wiki refresh (weekly only):
   - Rewrite `collaboration/opportunities.md` with fresh analysis.
   - Update `collaboration/my-impact.md` with new strategic advice.
   - Re-run contributor analysis and update `people/team-map.md`.
   - Update all project pages' "Recent Direction" and "Active Contributors".
   - Update person pages for key collaborators whose work shifted.

**Coordination with the personal `weekly review` workflow (Friday):**

These two Friday workflows are complementary, not duplicative:

| Workflow | Output | Focus |
|----------|--------|-------|
| `daily repo summary` (Friday) | `repo-summaries/YYYY-MM-DD.md` with Weekly Repo Review | Repo-wide activity, cross-team opportunities, wiki refresh |
| `weekly review` | `weekly/YYYY-WNN.md` | You-centric synthesis: OKRs, brag wins, decisions due, hypotheses due, skill sprint, relationship check |

Run `daily repo summary` first on Friday, then `weekly review` — so the
personal review can reference the fresh wiki and weekly repo review.

#### Edge cases

- **Zero commits in window:** write the file anyway, noting
  "No activity in the last 24 hours." Continuity matters.
- **Fewer than N updates:** put all updates in "Top Updates" and skip
  "Other Updates."
- **Merge commits:** include them but attribute them to the underlying
  update group; do not treat a merge as its own update.
- **Cross-author collaboration:** if multiple authors contribute to the
  same logical update (same branch/topic), list all authors.
- **Force-pushed branches:** note if a branch's history was rewritten
  (ref changed without new commits reachable in the window).

#### Configuration

| Parameter | Default | Where |
|-----------|---------|-------|
| `REPO` | — (must set) | `collect_repo_snapshot.sh` |
| Lookback window | `24 hours ago` | arg 1 to `collect_repo_snapshot.sh` |
| Output dir | `repo-summaries/` | arg 2 to `collect_repo_snapshot.sh` |
| `TOP_N` | 10 | agent-side, in the prompt |

---

## Wiki Update Rules

### Daily (alongside morning update)
- Update only the **"Recent Direction"** section of affected project pages.
  Do not rewrite entire pages.
- If a person's focus visibly shifted, update their entry in `team-map.md`
  and their person page if one exists.

### Weekly (Friday)
- Rewrite `collaboration/opportunities.md` and `my-impact.md`.
- Synthesize the week across all journals and meetings.

---

## File Formats

### Project Page (`projects/*.md`)
```markdown
# <Project Area Name>

**Directories:** `dir1/`, `dir2/`, ...

## Purpose
What this project area does (2-3 sentences).

## Architecture
Key modules, entry points, how it connects to other areas.

## Active Contributors
| Person | Role/Focus | Recent Commits |
|--------|-----------|----------------|

## Recent Direction
What's actively being worked on right now. Updated weekly.

## Connections
How this area relates to other project areas.
```

### People Page (`people/<username>.md`)
```markdown
# <Full Name> (<username>)

**Primary area:** ...
**Expertise:** ...
**Expected sync cadence:** Weekly / Bi-weekly / Monthly
**Last meaningful sync:** YYYY-MM-DD
**Next suggested touchpoint:** [specific topic, not "catch up"]

## Current Work
What they're actively pushing on (updated weekly).

## History
Major past contributions.

## Collaboration Surface
Where your work overlaps. Concrete: "talk to [Name] about X."
```

### Meeting Note (`meetings/YYYY-MM-DD-slug.md`)
```markdown
# [Title]: [Topic]
**Date:** YYYY-MM-DD HH:MM | **Type:** 1:1 / group / standup
**Attendees:** You, ...

## Transcript
## Takeaways
## Things I Don't Understand → reading/queue.md
## To-Do → actions.md
## New Ideas → ideas.md
## Decisions Made → decisions.md
## Hypotheses → hypotheses.md
## Impact on Plan
```

### Weekly Review (`weekly/YYYY-WNN.md`)
```markdown
# Week in Review — YYYY-WNN

## What I Shipped
## OKR Progress
## Visibility Log
## Meetings This Week
## Decisions Made This Week
## Hypotheses Updated
## Brag Wins This Week
## Ideas Generated This Week
## Reading This Week
## Action Items Status
## Relationship Check
## Skill Sprint Progress
## Plan Drift Analysis
## Next Week Plan
## Reflection
```

---

## Rules

- Keep pages concise. Project pages: 100-200 lines max.
- Use data from git, not speculation. Cite commit counts and branch names.
- "Recent Direction" reflects the last 1-2 weeks, not deep history.
- Person pages focus on collaboration surface with you, not biography.
- Collaboration advice must be concrete: "talk to X about Y" not
  "consider exploring synergies."
- Always read `vision.md` before making recommendations.
- Morning briefings must be detailed and actionable. Each recommendation
  needs a concrete first step and OKR connection.
- **Decision log:** always include alternatives considered. A decision
  without alternatives is just a description.
- **Brag doc:** use impact language, not activity language.
  "Shipped X which enabled Y" not "worked on X."
- **Hypothesis log:** when marking an outcome, be honest about misses.
  Wrong predictions are more valuable for calibration than correct ones.
- **Relationship warmth:** flag once per week per overdue contact.
  One reminder is helpful; repeated reminders are noise.
- **Skill sprints:** one active sprint at a time. Do not start a new one
  before finishing or explicitly abandoning the current one.

---

## Learned Preferences

<!-- Auto-maintained by bi-weekly Preference Observation runs (auto/observe.sh). -->
<!-- Do not edit manually. Format: YYYY-MM-DD — [observed preference or pattern] -->
