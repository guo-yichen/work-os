#!/usr/bin/env bash
# Fetch all remote branches and print your commits since a given time.
# Usage: ./collect_status.sh [since]
#   since: git date string, default "today 00:00"
#
# Setup: edit the three variables below before first use.

set -euo pipefail

REPO="/path/to/your/main/git/repo"   # absolute path to your main git repo
AUTHOR="your-git-username"            # your git author name (as it appears in git log)
SINCE="${1:-today 00:00}"

cd "$REPO"
git fetch --all --quiet 2>/dev/null

echo "=== Commits by $AUTHOR since '$SINCE' ==="
echo ""

git log --all \
  --author="$AUTHOR" \
  --since="$SINCE" \
  --format="%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %s %C(green)(%D)%C(reset)" \
  --date=short \
  --no-merges

echo ""
echo "=== Branches with recent activity ==="
echo ""

git log --all \
  --author="$AUTHOR" \
  --since="$SINCE" \
  --format="%D" \
  --no-merges \
  | tr ',' '\n' \
  | sed 's/^ *//' \
  | grep -v '^$' \
  | grep -v 'HEAD' \
  | sort -u
