# Unfettered

Unfettered is a lightweight Jekyll theme for GitHub Pages. It provides a responsive content column, system light/dark colours, typography, breadcrumbs and optional navigation.

The [live demo](https://epoiisa.github.io/unfettered/) builds from this repository’s `main` branch.

## Use

Add this to your site’s `_config.yml`:

```yaml
remote_theme: epoiisa/unfettered@v0.1.0
plugins:
  - jekyll-remote-theme
```

Pin a release tag for a stable version, or use `epoiisa/unfettered@main` to follow development.

Pages use `layout: default` in their front matter. Set your site’s `title`, `description`, `url` and `baseurl`. Optional navigation lives in your site’s `_data/navigation.yml`, with `title` and `url` entries; use `external: true` for external links.

## Development

Ruby and Bundler are required.

Run `bash preview.command build` to build the example site, or `bash preview.command serve` to preview it locally.
