# Decision Log

Significant decisions with alternatives considered, reasoning, and expected
outcomes. Reviewed quarterly to check predictions against reality.

A decision without alternatives considered is just a description. Always
record what else was on the table.

## Open (awaiting review)

<!-- New entries go here. Agent adds them during meeting notes and evening
     update processing. Use the Decision Log Entry workflow in CLAUDE.md. -->

---

<!-- Example entry — delete when you have real decisions:

## YYYY-MM-DD — Migrate from REST to GraphQL for internal APIs

**Decision:** Adopt GraphQL for all new internal API endpoints. Existing
REST endpoints remain as-is until migrated.

**Alternatives considered:**
- Keep REST with better OpenAPI documentation (rejected: doesn't solve
  the N+1 query problem that's causing mobile client slowdowns)
- gRPC (rejected: too much client-side complexity; teams would need new
  tooling; GraphQL gives similar performance wins with less migration cost)
- Hybrid: REST for external, GraphQL for internal only (chosen path)

**Reasoning:** Mobile team (Carol's team) reported 3x over-fetching on
the dashboard endpoints. GraphQL resolves this without changing the
external API contract. Alice confirmed the ML training pipeline only
uses internal APIs, so they'd benefit immediately.

**Expected outcome:** Mobile dashboard load time drops below 2s (from
current 5s) within 4 weeks of migration. Internal API calls decrease
by ~60%.

**Review date:** YYYY-MM-DD (3 months out)
**Source:** Architecture review meeting YYYY-MM-DD

-->

---

## Completed (reviewed)

| Decision | Date | Expected Outcome | Actual Outcome | Accurate? |
|----------|------|-----------------|----------------|-----------|
| (none yet) | — | — | — | — |
