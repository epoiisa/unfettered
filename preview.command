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
    --source "$theme_dir" --destination "$theme_dir/.preview/site"
fi

printf 'Local preview: http://127.0.0.1:8767/\n'
exec bundle exec jekyll serve --strict_front_matter \
  --source "$theme_dir" --destination "$theme_dir/.preview/site" \
  --host 127.0.0.1 --port 8767
