#!/bin/bash
# Auto preference observation — runs every other Sunday via launchd (macOS)
# or cron (Linux). Analyzes recent behavior patterns and updates the
# Learned Preferences section of CLAUDE.md.
#
# Setup:
#   1. Edit REPO below to point to your work-os directory.
#   2. Verify CLAUDE points to your Claude Code binary (check: which claude).
#   3. See auto/README.md for launchd / cron setup instructions.

set -euo pipefail

REPO="$HOME/path/to/your/work-os"   # ← edit this
CLAUDE="$HOME/.local/bin/claude"
LOG="$REPO/auto/logs/observe-$(date +%Y-%m-%d).log"

mkdir -p "$REPO/auto/logs"

# Only run if 13+ days have passed since the last observation
LAST_LOG=$(ls -t "$REPO/auto/logs/observe-"*.log 2>/dev/null | head -1)
if [[ -n "$LAST_LOG" ]]; then
  LAST_DATE=$(basename "$LAST_LOG" | sed 's/observe-//' | sed 's/.log//')
  DAYS_SINCE=$(( ( $(date +%s) - $(date -j -f "%Y-%m-%d" "$LAST_DATE" +%s 2>/dev/null || date -d "$LAST_DATE" +%s) ) / 86400 ))
  if [[ "$DAYS_SINCE" -lt 13 ]]; then
    echo "Skipping — last observation was $DAYS_SINCE days ago (need 13+)" >> "$LOG"
    exit 0
  fi
fi

echo "=== Preference Observation: $(date) ===" >> "$LOG"

cd "$REPO"
"$CLAUDE" -p "preference observation" \
  --allowedTools "Read,Write,Edit,Bash,Glob,Grep" \
  >> "$LOG" 2>&1

echo "=== Done: $(date) ===" >> "$LOG"

# Keep only the last 7 observation logs (~6 months)
ls -t "$REPO/auto/logs/observe-"*.log 2>/dev/null | tail -n +8 | xargs rm -f
