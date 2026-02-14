#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
THEMED="$DIR/.resume_themed.html"

# Apply theme from config.yaml
python3 "$DIR/apply_theme.py"

# Generate PDF from themed HTML
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf="$DIR/resume.pdf" \
  "$THEMED"

# Clean up temp file
rm -f "$THEMED"

echo "Built: $DIR/resume.pdf"
