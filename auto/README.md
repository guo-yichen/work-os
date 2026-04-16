# Auto Scheduling

Shell scripts that run Work OS workflows automatically on a schedule,
so you never have to manually trigger "morning update" or "evening update."

## Scripts

| Script | Workflow | Suggested Schedule |
|--------|----------|--------------------|
| `morning.sh` | Morning Update | Daily, 08:30 |
| `evening.sh` | Evening Update | Daily, 21:00 |
| `weekly.sh` | Weekly Review | Every Friday, 17:00 |
| `observe.sh` | Preference Observation | Every other Sunday, 21:00 |

## Setup

### Step 1 — Edit all four scripts

In each script, change the `REPO` line to your actual path:
```bash
REPO="$HOME/path/to/your/work-os"   # ← change this
```

Also verify the `CLAUDE` path points to your Claude Code binary:
```bash
which claude   # prints the path — use this in the CLAUDE= line
```

### Step 2 — Make scripts executable

```bash
chmod +x auto/morning.sh auto/evening.sh auto/weekly.sh auto/observe.sh
```

### Step 3a — macOS: create launchd plists

Create `~/Library/LaunchAgents/work-os.morning.plist`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>work-os.morning</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>/YOUR/PATH/TO/work-os/auto/morning.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>8</integer>
    <key>Minute</key>
    <integer>30</integer>
  </dict>
  <key>StandardOutPath</key>
  <string>/tmp/work-os-morning.log</string>
  <key>StandardErrorPath</key>
  <string>/tmp/work-os-morning-err.log</string>
</dict>
</plist>
```

Repeat for `work-os.evening.plist` (Hour: 21), `work-os.weekly.plist`
(add `<key>Weekday</key><integer>5</integer>` for Friday), and
`work-os.observe.plist` (Hour: 21, Weekday: 0 for Sunday).

Load each plist:
```bash
launchctl load ~/Library/LaunchAgents/work-os.morning.plist
launchctl load ~/Library/LaunchAgents/work-os.evening.plist
launchctl load ~/Library/LaunchAgents/work-os.weekly.plist
launchctl load ~/Library/LaunchAgents/work-os.observe.plist
```

### Step 3b — Linux: use cron

```bash
crontab -e
```

Add:
```
30 8  * * *   /bin/bash /path/to/work-os/auto/morning.sh
0  21 * * *   /bin/bash /path/to/work-os/auto/evening.sh
0  17 * * 5   /bin/bash /path/to/work-os/auto/weekly.sh
0  21 * * 0   /bin/bash /path/to/work-os/auto/observe.sh
```

## Logs

All runs are logged to `auto/logs/`. Log files are automatically pruned
(morning/evening: last 30 days; weekly: last 13 weeks; observe: last 7 runs).

The `logs/` directory is gitignored — logs stay local.

## How It Works

Each script calls `claude -p "[workflow trigger]"` in non-interactive
(headless) mode. Claude Code reads `CLAUDE.md`, runs the appropriate
workflow, and writes results to the repo files. No human input needed.

The `observe.sh` script additionally checks the date of the last observation
log before running, so it self-throttles to at most once per 13 days even
if triggered more frequently.
