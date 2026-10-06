#!/bin/bash
set -euo pipefail

theme_dir="$(cd -- "$(dirname -- "$0")" && pwd)"
action="${1:-serve}"
case "$action" in
  build|serve) ;;
  *) printf 'Usage: preview.command [build|serve]\n' >&2; exit 1 ;;
esac

export BUNDLE_GEMFILE="$theme_dir/Gemfile"
export BUNDLE_PATH="${BUNDLE_PATH:-$theme_dir/.preview/gems}"
if ! bundle check >/dev/null 2>&1; then
  bundle install
fi
mkdir -p "$theme_dir/.preview"
cd -- "$theme_dir/.preview"

if [[ "$action" == build ]]; then
  exec bundle exec jekyll build --strict_front_matter \
    --source "$theme_dir" --destination "$theme_dir/.preview/site" --baseurl ""
fi

printf 'Local preview: http://127.0.0.1:8767/\n'
# Wait for Jekyll's initial build before opening the browser.
(
  for ((attempt = 0; attempt < 120; attempt++)); do
    if curl --fail --silent --output /dev/null --max-time 1 http://127.0.0.1:8767/; then
      open -a Safari http://127.0.0.1:8767/ || printf 'Could not open Safari; use the preview URL above.\n' >&2
      exit 0
    fi
    sleep 0.5
  done
  printf 'Preview did not become ready in time; use the preview URL above.\n' >&2
) &
browser_wait_pid=$!
trap 'kill "$browser_wait_pid" 2>/dev/null || true' EXIT

bundle exec jekyll serve --strict_front_matter \
  --source "$theme_dir" --destination "$theme_dir/.preview/site" \
  --host 127.0.0.1 --port 8767 --baseurl ""
