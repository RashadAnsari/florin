#!/bin/bash
# shot.sh <name> [x y [wait]]: optionally click at x,y, wait, then save
# the screen as <name>.png.
WORK=${UI_REVIEW_DIR:-/tmp/florin-ui-review}
export DISPLAY=:99
if [ -n "$2" ]; then xdotool mousemove "$2" "$3" click 1; sleep "${4:-2}"; fi
import -window root "$WORK/shots/$1.png" && echo "$WORK/shots/$1.png"
