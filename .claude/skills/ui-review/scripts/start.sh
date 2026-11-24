#!/bin/bash
# start.sh <en|nl> <light|dark> [width height]
# Starts the release build on a virtual display :99 with a copy of the demo
# folder, so clicks never change demo/. UI_REVIEW_YEAR opens another year. Run `make demo` and
# `flutter build linux --release` first.
set -e
LOC=${1:-en}; MODE=${2:-light}; W=${3:-1440}; H=${4:-900}
ROOT=$(git -C "$(dirname "$0")" rev-parse --show-toplevel)
WORK=${UI_REVIEW_DIR:-/tmp/florin-ui-review}
pkill -f bundle/florin || true; pkill -f "Xvfb :99" || true; sleep 1
rm -rf "$WORK/demo"; mkdir -p "$WORK/shots"; cp -r "$ROOT/demo" "$WORK/demo"
PREFS="$HOME/.local/share/me.ansarihamedani.florin"; mkdir -p "$PREFS"
# The year to open: UI_REVIEW_YEAR, or the demo's year.
YEAR=${UI_REVIEW_YEAR:-$(grep -oP "const _year = \\K[0-9]+" "$ROOT/tool/create_demo_database.dart")}
echo "{\"flutter.db_path\":\"$WORK/demo/florin.db\",\"flutter.fiscal_year\":$YEAR,\"flutter.app_locale\":\"$LOC\"}" > "$PREFS/shared_preferences.json"
# Dark mode: GTK reads the colour scheme from a GSettings keyfile.
KEYFILE="$HOME/.config/glib-2.0/settings/keyfile"; mkdir -p "$(dirname "$KEYFILE")"
THEME=Adwaita; [ "$MODE" = dark ] && THEME=Adwaita-dark
printf "[org/gnome/desktop/interface]\ncolor-scheme='prefer-%s'\ngtk-theme='%s'\n" "$MODE" "$THEME" > "$KEYFILE"
export GSETTINGS_BACKEND=keyfile DISPLAY=:99
Xvfb :99 -screen 0 "${W}x${H}x24" >/dev/null 2>&1 &
sleep 2
GDK_BACKEND=x11 "$ROOT/build/linux/x64/release/bundle/florin" >"$WORK/app.log" 2>&1 &
sleep 7
WIN=$(xdotool search --name Florin | tail -1)
xdotool windowmove "$WIN" 0 0 windowsize "$WIN" "$W" "$H"; sleep 2
echo "Florin is on :99 ($LOC, $MODE). Screenshots go to $WORK/shots."
