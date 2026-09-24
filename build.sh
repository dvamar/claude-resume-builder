#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
BASE="${1:-resume}"          # html source base -> <BASE>.html
CONFIG="${2:-config.yaml}"   # theme config (config.yaml | config_light.yaml)
OUTBASE="${3:-$BASE}"        # output pdf base -> <OUTBASE>.pdf
THEMED="$DIR/.${BASE}_themed.html"

# Apply theme from the selected config
python3 "$DIR/apply_theme.py" "$BASE" "$CONFIG"

# Locate a Chrome/Chromium binary across macOS, Linux, and WSL (Windows Chrome).
CHROME=""
for candidate in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "$(command -v google-chrome-stable || true)" \
  "$(command -v google-chrome || true)" \
  "$(command -v chromium || true)" \
  "$(command -v chromium-browser || true)" \
  "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" \
  "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
  "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"; do
  if [ -n "$candidate" ] && [ -x "$candidate" ]; then
    CHROME="$candidate"
    break
  fi
done

if [ -z "$CHROME" ]; then
  echo "error: no Chrome/Chromium/Edge binary found for PDF generation" >&2
  exit 1
fi

# Windows browsers (under /mnt/c) need Windows-style paths for I/O.
IN="$THEMED"
OUT="$DIR/$OUTBASE.pdf"
if [[ "$CHROME" == /mnt/c/* ]]; then
  IN="$(wslpath -w "$THEMED")"
  OUT="$(wslpath -w "$DIR/$OUTBASE.pdf")"
fi

"$CHROME" \
  --headless \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf="$OUT" \
  "$IN"

# Clean up temp file
rm -f "$THEMED"

echo "Built: $DIR/$OUTBASE.pdf"
