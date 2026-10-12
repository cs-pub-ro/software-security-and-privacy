# Slides

The deck for this lecture, written in [Quarto](https://quarto.org/docs/presentations/) and rendered to [reveal.js](https://revealjs.com/).

* [`system-auditing-live.qmd`](system-auditing-live.qmd) — the source
* [`system-auditing-live.html`](system-auditing-live.html) — the rendered deck, published with the website

## Building

```console
make            # HTML, via reveal.js — what the website publishes
make pdf        # PDF, via beamer — published elsewhere
make clean
```

Quarto has to be installed; see [Get Started](https://quarto.org/docs/get-started/).
The PDF target also needs LaTeX; the easiest way to get it is:

```console
quarto install tinytex
```

Alternatively, open the rendered `.html` with `?print-pdf` appended to the URL and print to PDF from the browser — this preserves the reveal.js appearance.

## Publishing

The `.github/workflows/pages.yml` workflow renders every `slides/*.qmd` under `content/` before building the site, and `scripts/gen_pages.py` copies the resulting `.html` next to the lecture page.
Nothing has to be registered anywhere: a new deck in a `slides/` directory is picked up because it is there.

The rendered output is generated, so it is not committed; `.gitignore` covers it.
