---
layout: default
title: Examples
permalink: /examples/
---

# Examples

Unfettered uses a responsive content column, a system font and a consistent spacing rhythm. Colours follow your device's light or dark appearance.

## Text and lists

Use **bold text** for emphasis, *italics* for a change of voice, and `inline code` for short technical references. [Links use a blue accent]({{ '/' | relative_url }}).

- A short list item.
- A longer item that can wrap naturally on smaller screens, with spacing that keeps each item easy to follow.
- An item with **emphasis** and `code`.

### Nested lists

- [A linked parent item]({{ '/examples/nested/' | relative_url }})
  - A child item.
    1. An ordered grandchild.
    2. Another ordered grandchild.
  - Another child item.
- A plain-text parent item.
  1. An ordered child.
  2. **An emphasised child.**
     - An unordered grandchild.

### Lists with paragraphs

- A list item with two paragraphs.

  This second paragraph retains normal paragraph spacing.

- Another list item.

1. Choose a published theme version.
2. Build your site.
3. Review the resulting pages.

### A smaller heading

Paragraphs and headings share the same spacing system, with extra space before a new section.

> A blockquote uses muted text and a simple border. It can contain multiple paragraphs.
>
> This second paragraph demonstrates the spacing within a quote.

## Tables

| Element | Behaviour |
| --- | --- |
| Content column | Adapts to the available width |
| Colours | Follow the system appearance |
| Navigation | Uses each site's own links |
| Breadcrumbs | Follow the page hierarchy |

## Code

```yaml
remote_theme: epoiisa/unfettered@v0.1.0
plugins:
  - jekyll-remote-theme
```

---

## Nested pages

Visit the [nested page]({{ '/examples/nested/' | relative_url }}) to see linked ancestors in the breadcrumbs.
