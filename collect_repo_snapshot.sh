#!/usr/bin/env bash
# Collect a full-repo activity snapshot for the daily repo summary workflow.
# Unlike collect_status.sh (which is scoped to YOU), this script captures
# commits from ALL authors across ALL remote branches in the window.
#
# Outputs to stdout a structured report the agent can feed to an LLM:
#   - Commits in the window (dedup'd by SHA) with author, date, subject, branches
#   - Per-commit diffstat summary
#   - Current list of all remote branches (for new-branch detection)
#   - Diff vs. previous branch snapshot (if any)
#
# Usage: ./collect_repo_snapshot.sh [since] [snapshot_dir]
#   since        — git date string, default "24 hours ago"
#   snapshot_dir — directory for storing branch-snapshot.txt,
#                  default "./repo-summaries"
#
# Setup: edit REPO below before first use.

set -euo pipefail

REPO="/path/to/your/main/git/repo"    # absolute path to the repo being summarized
SINCE="${1:-24 hours ago}"
SNAPSHOT_DIR="${2:-$(cd "$(dirname "$0")" && pwd)/repo-summaries}"
SNAPSHOT_FILE="$SNAPSHOT_DIR/.branch-snapshot.txt"
PREV_SNAPSHOT="$SNAPSHOT_DIR/.branch-snapshot.prev.txt"

mkdir -p "$SNAPSHOT_DIR"

cd "$REPO"
git fetch --all --prune --quiet 2>/dev/null

# ---------------------------------------------------------------------------
# 1. Metadata
# ---------------------------------------------------------------------------
echo "=== Snapshot metadata ==="
echo "Repo:      $REPO"
echo "Since:     $SINCE"
echo "Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo ""

# ---------------------------------------------------------------------------
# 2. Commits in window (dedup'd across branches)
# ---------------------------------------------------------------------------
echo "=== Commits in window (all authors, dedup'd by SHA) ==="
echo "Format: SHA | ISO-date | author | subject | decorations"
echo ""

git log --all --since="$SINCE" --no-merges \
  --format="%h|%aI|%an|%s|%D" \
  | sort -u

echo ""
echo "=== Diffstat summary (one block per commit) ==="
echo ""

git log --all --since="$SINCE" --no-merges \
  --format="----%n%h %an %aI%n%s" \
  --shortstat

# ---------------------------------------------------------------------------
# 3. Merge commits (kept separately; agent may attribute them to their
#    underlying update group rather than treat them as standalone updates)
# ---------------------------------------------------------------------------
echo ""
echo "=== Merge commits in window ==="
echo ""

git log --all --since="$SINCE" --merges \
  --format="%h|%aI|%an|%s|%D" \
  | sort -u || true

# ---------------------------------------------------------------------------
# 4. Branch snapshot & new-branch detection
# ---------------------------------------------------------------------------
if [ -f "$SNAPSHOT_FILE" ]; then
  cp "$SNAPSHOT_FILE" "$PREV_SNAPSHOT"
fi

git branch -r --format="%(refname:short)" \
  | grep -v 'HEAD' \
  | sort -u > "$SNAPSHOT_FILE"

TOTAL_BRANCHES=$(wc -l < "$SNAPSHOT_FILE" | tr -d ' ')

echo ""
echo "=== Branch snapshot ==="
echo "Total remote branches: $TOTAL_BRANCHES"
echo "Written to: $SNAPSHOT_FILE"
echo ""

if [ -f "$PREV_SNAPSHOT" ]; then
  NEW_BRANCHES=$(comm -23 "$SNAPSHOT_FILE" "$PREV_SNAPSHOT" || true)
  DELETED_BRANCHES=$(comm -13 "$SNAPSHOT_FILE" "$PREV_SNAPSHOT" || true)

  NEW_COUNT=$(printf "%s" "$NEW_BRANCHES" | grep -c . || true)
  DEL_COUNT=$(printf "%s" "$DELETED_BRANCHES" | grep -c . || true)

  echo "New branches since previous snapshot: $NEW_COUNT"
  if [ "$NEW_COUNT" -gt 0 ]; then
    printf "%s\n" "$NEW_BRANCHES" | sed 's/^/  + /'
  fi

  echo ""
  echo "Deleted branches since previous snapshot: $DEL_COUNT"
  if [ "$DEL_COUNT" -gt 0 ]; then
    printf "%s\n" "$DELETED_BRANCHES" | sed 's/^/  - /'
  fi
else
  echo "No previous snapshot found — this is the first run."
  echo "New-branch detection will start working on the next run."
fi

# ---------------------------------------------------------------------------
# 5. Force-push / history-rewrite detection (optional, best-effort)
#    Branches whose tip ref changed but with no new commits reachable in
#    the window are likely force-pushed.
# ---------------------------------------------------------------------------
echo ""
echo "=== Active branches in window ==="
echo "(branches that received at least one commit since '$SINCE')"
echo ""

git for-each-ref --format="%(refname:short)|%(committerdate:iso8601)" refs/remotes \
  | awk -F'|' -v since="$(date -u -v-24H +"%Y-%m-%d %H:%M:%S" 2>/dev/null || date -u -d '24 hours ago' +"%Y-%m-%d %H:%M:%S")" \
    '$2 >= since {print $1}' \
  | grep -v 'HEAD' \
  | sort -u
