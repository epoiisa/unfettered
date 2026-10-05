# Unfettered

Unfettered is Epoiisa's reusable Jekyll theme for GitHub Pages, extracted from the [existing Epoiisa site design](https://epoiisa.github.io/). It provides a responsive content column, system light/dark colours, typography, breadcrumbs and optional navigation. Site content and branding stay in each consuming repository.

## Use

Add this to your site's `_config.yml`:

```yaml
remote_theme: epoiisa/unfettered@v0.1.0
plugins:
  - jekyll-remote-theme
```

Pages use `layout: default` in their front matter. Set each site's own `title`, `description`, `url` and `baseurl`. Optional navigation lives in the consuming site's `_data/navigation.yml`, with `title` and `url` entries; use `external: true` for external links.

Pin a release tag for a stable version, or use `epoiisa/unfettered@main` to follow development. A site fetches the theme when it builds; pushing theme changes does not itself rebuild consuming sites. Local theme files with matching paths override remote files.

## Development and versions

Run `bash preview.command build` to verify the example, or `bash preview.command serve` to preview it locally. Ruby and Bundler are required; dependencies and output remain ignored. After publishing a ref, `bash scripts/verify-remote.command v0.1.0` verifies a separate site that consumes only the public remote theme.

`VERSION` records the current semantic version, `CHANGELOG.md` describes releases, and signed `vX.Y.Z` tags identify published versions. The theme source is at the repository root. Agent instructions are private and ignored.
