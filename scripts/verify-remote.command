#!/bin/bash
set -euo pipefail

theme_dir="$(cd -- "$(dirname -- "$0")/.." && pwd)"
theme_ref="${1:-v0.1.0}"
if [[ ! "$theme_ref" =~ ^[a-zA-Z0-9._-]+$ ]]; then
  printf 'Use a tag, branch, or commit ref.\n' >&2
  exit 1
fi
export BUNDLE_GEMFILE="$theme_dir/Gemfile"
export BUNDLE_PATH="${BUNDLE_PATH:-$theme_dir/.preview/gems}"
bundle check >/dev/null

fixture_dir="$(mktemp -d "${TMPDIR:-/tmp}/unfettered-consumer.XXXXXX")"
trap 'rm -rf -- "$fixture_dir"' EXIT
mkdir -p "$fixture_dir/source/_data" "$fixture_dir/source/child"
cat > "$fixture_dir/source/_config.yml" <<YAML
title: Consumer Test
description: Independent remote-theme fixture.
url: https://example.invalid
baseurl: /consumer
remote_theme: epoiisa/unfettered@$theme_ref
plugins:
  - jekyll-remote-theme
YAML
cat > "$fixture_dir/source/_data/navigation.yml" <<'YAML'
- title: Home
  url: /
- title: Child
  url: /child/
YAML
cat > "$fixture_dir/source/index.md" <<'MARKDOWN'
---
layout: default
title: Home
permalink: /
---
# Consumer Home
MARKDOWN
cat > "$fixture_dir/source/child/index.md" <<'MARKDOWN'
---
layout: default
title: Child
permalink: /child/
---
# Consumer Child
MARKDOWN
cd -- "$fixture_dir"
bundle exec jekyll build --strict_front_matter \
  --source "$fixture_dir/source" --destination "$fixture_dir/site"
bundle exec ruby - "$fixture_dir/site" <<'RUBY'
root = ARGV.fetch(0)
home = File.read(File.join(root, "index.html"))
child = File.read(File.join(root, "child/index.html"))
raise "Consumer branding was not retained" unless home.include?("Home • Consumer Test")
raise "Theme stylesheet did not arrive" unless File.file?(File.join(root, "assets/css/style.css"))
raise "Project stylesheet prefix is missing" unless home.include?("/consumer/assets/css/style.css")
raise "Theme layout or local navigation is missing" unless home.include?("Skip to content") && home.include?("/consumer/child/")
raise "Nested breadcrumb is missing" unless child.include?('aria-current="page">Child</span>') && child.include?("/consumer/")
raise "Theme example leaked into consumer" if home.include?("A lightweight Jekyll theme by Epoiisa")
raise "Private or development files leaked" unless Dir.glob(File.join(root, "**/*"), File::FNM_DOTMATCH).select { |path| File.file?(path) }.map { |path| path.delete_prefix(root + "/") }.sort == ["assets/css/style.css", "child/index.html", "index.html"]
puts "Remote theme verified: layout, CSS, site-owned navigation, branding, baseurl, nested breadcrumbs and output isolation."
RUBY
