#!/bin/bash
# Run Token Estimator (startup script) using full path; requires setup.sh to have been run.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_PYTHON="$SCRIPT_DIR/ai_content_editor_day1/.venv/bin/python3"
MAIN_SCRIPT="$SCRIPT_DIR/ai_content_editor_day1/src/token_estimator.py"
if [[ ! -x "$VENV_PYTHON" ]]; then
  echo "Error: Virtual env not found. Run: $SCRIPT_DIR/setup.sh"
  exit 1
fi
if [[ ! -f "$MAIN_SCRIPT" ]]; then
  echo "Error: Main script not found at $MAIN_SCRIPT. Run setup.sh first."
  exit 1
fi
exec "$VENV_PYTHON" "$MAIN_SCRIPT"
