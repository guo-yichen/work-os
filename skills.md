# Skill Development

Structured skill sprints with explicit goals and outcomes. One active sprint
at a time. Finish or explicitly abandon before starting a new one.

A sprint converts "I should learn X" into "I am learning X, done by Y date,
measurable by Z."

---

## Active Sprint

*None currently. Start one: "start skill sprint: [skill name]"*

---

## Queued (to start next)

<!-- Add skills here as you identify gaps. Prioritize by OKR impact.
     Format: skill name, why it matters, suggested resources. -->

### [Skill Name]
**Why:** [Connection to OKR or vision pillar]
**Definition of done:** [What "good enough" looks like]
**Resources:** [Docs, papers, courses, codebases]

---

## Backlog

<!-- Skills worth learning eventually but not this quarter. -->

- [Skill] — [one sentence on why, when it becomes relevant]

---

## Completed Sprints

| Sprint | Skill | Period | Outcome |
|--------|-------|--------|---------|
| (none yet) | — | — | — |

---

## Sprint Template

```
## Sprint N: [Skill Name] — YYYY-MM-DD to YYYY-MM-DD
**Why this skill:** Connection to OKR or vision pillar
**Definition of done:** What "good enough" looks like
**Resources:**
- [resource 1]
- [resource 2]
**Week 1 goal:** [what to cover / read]
**Week 2 goal:** [what to build or apply]
**Outcome:** (filled at sprint end — what you can now do, and what changed)
```

---

<!-- Example completed sprint for reference:

## Sprint 1: GraphQL fundamentals — 2026-04-01 to 2026-04-14
**Why this skill:** OKR 1 requires migrating internal APIs to GraphQL.
Can't design the schema without understanding resolver patterns and N+1.
**Definition of done:** Can write a schema with nested resolvers, understand
DataLoader for batching, and review a PR for common GraphQL anti-patterns.
**Resources:**
- GraphQL official docs (Schemas and Types, Queries and Mutations)
- "Production Ready GraphQL" (book, first 4 chapters)
- Existing codebase: Alice's ML service GraphQL endpoint
**Week 1 goal:** Read docs + first 4 chapters. Write a toy schema.
**Week 2 goal:** Implement the first real internal endpoint using GraphQL.
**Outcome:** Shipped the user preferences endpoint in GraphQL. Caught a
classic N+1 in code review that would have caused 50x DB load. Now
comfortable reading and writing GraphQL schemas.

-->
