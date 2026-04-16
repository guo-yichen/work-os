#!/bin/bash
# Auto morning update — runs daily at a scheduled time via launchd (macOS)
# or cron (Linux). Executes the Morning Update workflow defined in CLAUDE.md.
#
# Setup:
#   1. Edit REPO below to point to your work-os directory.
#   2. Verify CLAUDE points to your Claude Code binary (check: which claude).
#   3. See auto/README.md for launchd / cron setup instructions.

set -euo pipefail

REPO="$HOME/path/to/your/work-os"   # ← edit this
CLAUDE="$HOME/.local/bin/claude"
LOG="$REPO/auto/logs/morning-$(date +%Y-%m-%d).log"

mkdir -p "$REPO/auto/logs"
echo "=== Morning Update: $(date) ===" >> "$LOG"

cd "$REPO"
"$CLAUDE" -p "morning update" \
  --allowedTools "Read,Write,Edit,Bash,Glob,Grep" \
  >> "$LOG" 2>&1

echo "=== Done: $(date) ===" >> "$LOG"

# Keep only the last 30 log files
ls -t "$REPO/auto/logs/morning-"*.log 2>/dev/null | tail -n +31 | xargs rm -f
