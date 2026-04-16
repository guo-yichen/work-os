# Work OS

A personal operating system for knowledge workers. AI agents maintain it
daily so that the habits worth having become automatic rather than effortful.

## What This Is

Most people have good intentions about journaling, meeting notes, tracking
decisions, and building skills — but the habits don't stick because the
maintenance cost is too high. This system offloads that cost to AI agents.

You talk. The agents write, organize, and surface what matters.

## Core Workflows

| Trigger | What happens |
|---------|-------------|
| `"morning update"` | Agent reads your git commits, team activity, and open actions. Produces a prioritized daily briefing with Top 3 tasks and any overdue relationship check-ins. |
| `"capture: [thought]"` | Appends a tagged note to inbox for later processing. Zero friction. |
| `"meeting note: ..."` or paste transcript | Agent structures the meeting, extracts actions, decisions, ideas, and hypotheses, and files them to the right places. |
| `"evening update"` | Agent fills your work log, processes the inbox, updates the brag doc, writes a reflection, and sets tomorrow's Top 3. |
| `"weekly review"` (Fridays) | Agent synthesizes the week: OKR progress, visibility log, relationship check, hypothesis review, decision review, skill sprint status. |

## What Gets Tracked Automatically

- **Actions** — cross-meeting task list linked to OKRs
- **Decisions** — significant choices with alternatives considered and a review date, so you can check your predictions later
- **Hypotheses** — technical and strategic bets, reviewed when the timeline passes
- **Brag doc** — accomplishment log in impact language, ready for performance reviews
- **Relationship warmth** — morning agent flags when a key collaborator is overdue for a sync
- **Skill sprints** — structured 2-week learning blocks, one at a time
- **Visibility** — weekly log of what you shipped, shared, or presented

## Setup (15 minutes)

### Step 1 — Fill in your content

1. **Fill in `vision.md`** — your 3-month north star, strategic pillars,
   and the decision heuristics you want the agent to apply.

2. **Fill in `okrs.md`** — this quarter's objectives with measurable
   key results.

3. **Add your team to `people/team-map.md`** — the Relationship Warmth
   section (Tier 1/2) is what the morning agent reads.

4. **Edit `collect_status.sh`** — set these three variables (used for
   local/manual runs only):
   ```bash
   REPO="/path/to/your/main/git/repo"
   AUTHOR="your-git-username"
   GIT_NAME="Your Name"
   ```

### Step 2 — Choose your automation mode

**Option A: Claude Code Desktop Scheduled Tasks (recommended)**

No local setup needed. Workflows run as remote cloud agents on a schedule.

1. Push this repo to GitHub.
2. Open [claude.ai/code/scheduled](https://claude.ai/code/scheduled) and
   create 4 triggers pointing at your repo:

   | Name | Prompt | Cron (UTC) | Local time (PT) |
   |------|--------|------------|-----------------|
   | morning update | `morning update` | `30 15 * * *` | 8:30 AM daily |
   | evening update | `evening update` | `0 4 * * *` | 9:00 PM daily |
   | weekly review | `weekly review` | `0 0 * * 6` | Fri 5:00 PM |
   | preference observation | `preference observation` | `0 4 * * 1` | Sun 9:00 PM (bi-weekly, self-throttles) |

3. Done — no cron, no launchd, no local scripts.

**Option B: Manual triggers**

Open the repo in Claude Code and say the trigger phrase anytime:
- `"morning update"` — generates today's briefing
- `"evening update"` — processes inbox, updates brag doc, sets tomorrow's Top 3
- `"weekly review"` — synthesizes the week (run on Fridays)
- `"preference observation"` — analyzes patterns, updates Learned Preferences

## File Structure

```
vision.md          Your north star, pillars, relationship map, decision heuristics
okrs.md            Quarterly OKRs
decisions.md       Decision log — significant choices with alternatives + review dates
hypotheses.md      Hypothesis log — predictions reviewed when timelines pass
brag.md            Accomplishment tracker for performance reviews
skills.md          Skill sprint tracker
actions.md         Cross-meeting action items
ideas.md           Idea backlog (Active / Backlog / Archived)
inbox.md           Mid-day captures (append-only, processed at evening)
reflections.md     Career and strategy reflections
progress/          Milestone tracker
journal/           Daily briefings + evening reflections
meetings/          Structured meeting notes
reading/           Queue + processed notes
people/            Team map + individual collaborator pages
collaboration/     Opportunities + impact plan
weekly/            Weekly reviews
projects/          One page per project area
```

## Philosophy

**Habits fail because of friction, not intention.** This system keeps the
friction close to zero: you provide raw input (a thought, a transcript, a
URL), the agent structures it. You approve or edit. The habit runs itself.

**Decisions and predictions deserve a paper trail.** Most people make
dozens of significant decisions per quarter and can't remember why. This
system logs them with alternatives considered and a review date. Looking
back at your predictions — right and wrong — is one of the fastest ways
to improve your judgment.

**Visibility is a skill, not a personality trait.** The weekly visibility
log makes it explicit: did anything you shipped reach someone else this
week? A flag of "visibility gap" is a prompt, not a judgment.

**Relationships require proactive maintenance.** The warmth tracking is not
about managing people — it's about not accidentally letting important
collaborations go cold through inattention.
