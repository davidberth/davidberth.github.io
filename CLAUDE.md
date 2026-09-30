# Lixel — website

The public site at **lixel.io**. Jekyll-theme-chirpy on GitHub Pages, custom
domain via Google Workspace, push-to-deploy via GitHub Actions. Remote is
`davidberth/davidberth.github.io` — the name is historical and must stay
`<user>.github.io` to keep GitHub user-pages status; visitors only ever see
`lixel.io`.

**This repository is public** — the whole working tree, not just the rendered
site. Adding a file to `_config.yml`'s `exclude:` list keeps it off the *site*;
it does not keep it off the *internet*. Nothing confidential goes here: no
client names, no engagement terms, no unpublished research detail.

This repo is the *website only*. Identity, positioning, and company facts are
authored in `C:\db\lixel\brand` and copied in — see below.

## Sibling repos

| repo | what | relationship |
| --- | --- | --- |
| `C:\db\lixel\brand` | identity + company facts (private) | this repo consumes its `dist/` |
| `C:\db\lixel\operations` | the business record (private) | read for context, never copy text across |
| `C:\db\geo` | the platform (private) | source material for capability copy |
| `C:\db\dimming`, `C:\db\hadwigers` | project work | source material for posts |

Reading a sibling for context while drafting is expected. **Moving text across
is not** — anything sourced from `operations` needs a deliberate scrub, and
anything naming a client needs that client's consent.

## Brand assets are synced, not authored

Everything visual comes from `brand` and is **generated there**:

```powershell
.\tools\sync-brand.ps1              # defaults to ..\brand
.\tools\sync-brand.ps1 -BrandPath D:\somewhere\brand
```

Synced files carry a `GENERATED - DO NOT EDIT` header naming their source.
**Do not hand-edit them and do not hand-tune a favicon here.** Fix the model in
`brand/src/`, rebuild there, re-sync here. Raster sizes are laid out
natively per size in `brand` (a 16px icon is not a downscaled logo), which
is exactly why this repo does not generate them.

Synced files are **committed**, so GitHub Actions builds the site with no
sibling repo present and no image toolchain. A missing `brand` breaks
re-syncing only, never deploying.

Landing spots: `assets/img/favicons/` (icons), `assets/img/` (logo SVG),
`_sass/_lixel-tokens.scss` (color variables). Web-platform wiring — the
`<link>` tags in `_includes/favicons.html`, theme colors, any future
webmanifest — stays here; that is a web concern, not a brand one.

## Voice

Summarized from `brand/BRAND.md`, which is authoritative. Duplicated here
because site copy needs it constantly.

> **Lixel — light + pixel. Emergence from fundamental building blocks.**
> Real-time AI, computer vision, geospatial intelligence, and graph theory.

Poetic main line, descriptive subtitle. Body copy: technical-academic is fine,
first-person welcome, no management-speak. The mark makes the same argument
visually — an L of five pixel blocks, one of them lit.

The primary audience is a company stuck on a hard technical problem, looking
for credibility and a fast path to contact. Positioning detail, the audience
model, and what is off-limits live in `brand/BRAND.md` — private, and it
stays private.

## Site structure

Live nav, from `_tabs/` — the site has moved well past the original
About/Consulting/Writing/Contact sketch:

- **Research** — graph theory and computation; Four Color Theorem, Hadwiger's,
  partition and interface methods. Framed as upstream of Studio.
- **Consulting** — hard technical problems in applied AI, scientific computing,
  research engineering.
- **Learning** — advanced math and ML tutoring and mentoring, with explicit
  support for people who think and learn differently.
- **Studio** — owned software and creative work; The Dimming. Marked
  "in development".
- **Writing**, **Contact**, **About**.
- Chirpy's **Categories** / **Tags** remain, demoted to the end.

The home page is a custom `index.html`: hero, a Mission block, umbrella cards
for Research / Consulting / Learning, a Studio teaser, and recent writing.

Note that this framing is broader than the consulting-only wedge in
`brand/BRAND.md` — Learning in particular has no counterpart there. The
two should be reconciled; the site is the newer of the two.

Writing about a project should link outward to that project, not restate it.
Detail on The Dimming, the platform, or Hadwiger's belongs in those repos;
posts here are the public face of that work, subject to the posture in
`BRAND.md` (Hadwiger's: status only until the paper is out).

## Working on the site

- Theme is `jekyll-theme-chirpy`, pinned to 7.5.x in the `Gemfile`.
- `_tabs/` holds top-nav pages, `_posts/` holds writing, `_sass/` holds styles.
- `tools/` is in `_config.yml`'s `exclude:` list, so scripts there never ship.
- Deploy is push-to-`main` via GitHub Actions; there is no manual publish step,
  so a bad commit is live at `lixel.io` within a couple of minutes.

## Open work

- **`_includes/logo.svg` is outside the brand pipeline.** It is the sidebar
  lockup — the five-block mark plus an "ixel" wordmark in Bodoni MT — still
  hand-authored in Inkscape, with the same off-grid coordinates and mismatched
  stroke widths the favicon had before it was ported. It should become a
  generated lockup in `brand` so the mark has one definition. Until then,
  editing the mark in `brand` does **not** change what visitors see in the
  sidebar. **Hand-matched to brand's square geometry on 2026-09-30**: the five
  rects now use 40 x 40 blocks with one 6-unit gap, scaled to the lockup's
  existing mark height, with one stroke width, and the wordmark path is
  translated left by 13.1 so the foot-to-"ixel" gap is unchanged and the
  lockup stays centered at the same 160px. **Recolored by hand the same day**
  to match `brand`: the lit pixel is `#ffce1d` and the foot `#6e6e6e` (it was
  `#2b2b2b`, nearly invisible on the dark sidebar). In the dark theme a rule in
  `_sass/themes/_dark.scss` strokes the five blocks near-white at 0.95px, the
  same treatment as the slides' dark mark, because the lockup's inline black
  strokes vanish on the dark sidebar. What remains is the pipeline itself: the
  next change to the mark in `brand` will need this file edited by hand again
  until the lockup is generated there.
- **One gold, reconciled 2026-09-30 (David).** The site's accent was the bronze
  `#d4a574`, in the lockup and as the dark theme's `--link-color`, a different
  gold from the mark's `#ffce1d`. It is now `#ffce1d` in both places, and
  `brand/src/tokens.json` records it as `site.accent`. The LaTeX documents'
  blue is a separate question and still open.
- No webmanifest, despite 192/512 icons being synced and available.
- Positioning drift: `BRAND.md`'s wedge predates the current five-umbrella
  site framing and omits Learning entirely.
