# Work OS

Personal knowledge base and operating system.
Maintained by AI agents (morning/evening daily + weekly) to track
projects, people, goals, meetings, ideas, and collaboration opportunities.

See `README.md` for setup instructions and `CLAUDE.md` for agent workflows.

---

## Personal Operating System

- [Vision](vision.md) — north star, strategic pillars, relationship map, agent heuristics
- [OKRs](okrs.md) — quarterly objectives and key results
- [Journal](journal/) — daily briefings + evening reflections
- [Meetings](meetings/) — meeting notes with transcripts, takeaways, action items
- [Inbox](inbox.md) — mid-day thought capture (timestamped, append-only)
- [Ideas](ideas.md) — processed idea backlog
- [Actions](actions.md) — cross-meeting action items tracker
- [Decisions](decisions.md) — decision log: significant choices with alternatives + review dates
- [Hypotheses](hypotheses.md) — hypothesis log: predictions reviewed when timelines pass
- [Brag](brag.md) — accomplishment tracker for performance reviews
- [Skills](skills.md) — skill sprint tracker: one active sprint at a time
- [Reading](reading/queue.md) — reading queue + processed notes
- [Reflections](reflections.md) — personal reflections on career, field, strategy
- [Progress](progress/status.md) — milestone tracker

## Projects

- [Project pages](projects/) — one page per project area

## People

- [Team Map](people/team-map.md) — all collaborators with areas, focus, and relationship warmth
- [Individual pages](people/) — detailed pages for key collaborators

## Collaboration

- [Opportunities](collaboration/opportunities.md) — cross-project integration points
- [My Impact Plan](collaboration/my-impact.md) — growth areas, priorities, strategic advice

## Weekly Reviews

Archived in [weekly/](weekly/) as `YYYY-WNN.md`.

## Repo Summaries

Daily full-repo intelligence reports in [repo-summaries/](repo-summaries/)
as `YYYY-MM-DD.md`. Clusters the day's commits across all authors and
branches into logical updates, then ends with a personalized "For You"
section. See [repo-summaries/README.md](repo-summaries/README.md).

---

## How This Works

- **Morning:** Say "morning update." Agent reads your commits, team activity,
  and open actions. Produces today's briefing with Top 3 tasks and any
  overdue relationship check-ins.
- **Daily 9am:** `daily repo summary` runs (or trigger manually). Clusters
  the last 24h of commits across *all* authors into logical updates,
  updates affected project pages, and ends with a personalized For You.
- **During day:** "capture: ..." appends a tagged note to inbox. After
  meetings, paste transcript and agent creates a structured meeting file
  and extracts actions, decisions, ideas, and hypotheses.
- **Evening:** Say "evening update." Agent fills work log, processes inbox,
  updates brag doc, writes reflection, sets tomorrow's Top 3.
- **Friday:** Say "weekly review." Agent synthesizes the week: OKR progress,
  visibility log, relationship check, hypothesis and decision review,
  skill sprint status. The Friday `daily repo summary` also appends a
  Weekly Repo Review with org-wide themes.
