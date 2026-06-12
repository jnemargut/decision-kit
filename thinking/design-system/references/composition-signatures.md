# Composition Signatures

Sameness in layout is invisible to a style-block rewrite: two artifacts can use different fonts and palettes and still share identical bones — the centered single-column card stack. Composition signatures fix that **without touching the DOM**: CSS Grid's `grid-template-areas`, column spans, and offsets can re-art-direct existing semantic regions from the stylesheet alone (the Smashing Magazine "art directing for the web" technique).

**Hard rules:**
- CSS-only. Never restructure, reorder, or insert DOM nodes for composition (flourish hooks are the only sanctioned DOM touch, and they're additive).
- Responsive: every signature collapses to a sane single column under 720px.
- Degrade gracefully: if the artifact has fewer than 3 distinct semantic regions, or is dominated by wide tables, fall back to `monolith` and say so.
- A signature must be *visible*: at least one structural property (template areas, asymmetric fractions, span, offset) must differ from a default single column — this is checked by the critique gate.

## The eight signatures

### 1. `editorial-spread` — the magazine
Asymmetric two-column: wide reading column + narrow margin rail that catches kickers, pull quotes, captions, metadata. Headlines span both.
```css
main { display: grid; grid-template-columns: minmax(0, 2.1fr) minmax(180px, 1fr); column-gap: clamp(24px, 5vw, 64px); }
h1, h2, .hero { grid-column: 1 / -1; }
blockquote, figcaption, .meta, aside { grid-column: 2; align-self: start; }
```
**Fits:** briefs, proposals, long-form. **Avoid for:** dashboards.

### 2. `broken-grid` — the rebel
Sections alternate alignment and overlap; elements escape their columns via negative margins and spans. Controlled, not chaotic: one escape per viewport-height.
```css
section { display: grid; grid-template-columns: repeat(12, 1fr); }
section > * { grid-column: 2 / 11; }
section:nth-of-type(odd) .card:first-child { grid-column: 1 / 8; margin-top: -2.5rem; }
section:nth-of-type(even) .card:last-child { grid-column: 6 / 13; }
```
**Fits:** landings, slides, zines. **Avoid for:** docs, dense tables.

### 3. `monolith` — the broadsheet
One dominant centered column — but *deliberate*: oversized display headline (clamp to viewport), extreme vertical rhythm, generous measure (~65ch), nothing competing.
```css
main { max-width: 68ch; margin-inline: auto; }
h1 { font-size: clamp(2.6rem, 8vw, 5.5rem); line-height: 0.98; }
section + section { margin-top: clamp(4rem, 12vh, 9rem); }
```
**Fits:** anything; the safe fallback that still has a spine.

### 4. `dense-console` — the operator
Compact multi-panel grid, tight gutters, full-width usage, panels sized by importance not uniformity.
```css
main { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 10px; max-width: none; padding: 12px; }
.primary, section:first-of-type { grid-column: span 2; grid-row: span 2; }
```
**Fits:** dashboards, status docs, ops material. **Avoid for:** long prose.

### 5. `poster` — the marquee
The hero owns the first viewport: giant type, minimal else. Content reads as footnotes/credits below.
```css
header, .hero { min-height: 78vh; display: grid; align-content: center; }
.hero h1 { font-size: clamp(3rem, 11vw, 8rem); letter-spacing: -0.02em; }
main { max-width: 56ch; margin-inline: auto; }
```
**Fits:** slides, one-pagers, landings. **Avoid for:** dense reference docs.

### 6. `bento` — the mosaic
Uneven card mosaic — mixed spans, controlled density, no two adjacent cells the same size.
```css
main { display: grid; grid-template-columns: repeat(6, 1fr); gap: 16px; }
section:nth-of-type(3n+1) { grid-column: span 4; }
section:nth-of-type(3n+2) { grid-column: span 2; }
section:nth-of-type(3n)   { grid-column: span 3; }
```
**Fits:** dashboards, feature overviews, portfolios. **Avoid for:** linear arguments.

### 7. `marginalia` — the annotated text
Narrow content column pushed right; an active left margin carries section numbers, kickers, rules — the scholar's page.
```css
main { display: grid; grid-template-columns: minmax(120px, 0.8fr) minmax(0, 2.4fr); column-gap: 40px; }
h2 { grid-column: 1; text-align: right; position: sticky; top: 2rem; align-self: start; }
h2 ~ * { grid-column: 2; }
```
**Fits:** docs, academic, technical reference. **Avoid for:** card-heavy artifacts.

### 8. `diagonal-flow` — the zigzag
Sections offset progressively left/right, creating a diagonal reading line down the page; alignment alternates with them.
```css
section { max-width: 58ch; }
section:nth-of-type(odd)  { margin-inline: 0 auto; }
section:nth-of-type(even) { margin-inline: auto 0; text-align: left; }
section:nth-of-type(even) h2 { text-align: right; }
```
**Fits:** narratives, creative briefs, portfolios. **Avoid for:** tables, forms.

## Tradition → default signature

| Signature | Default for traditions |
|-----------|------------------------|
| editorial-spread | Editorial Print · Newsprint · Botanical Herbarium |
| broken-grid | Neo-Brutalist · Playful Maximalist · Y2K Maximalist · Zine · Anti-Design |
| monolith | Warm Minimal · Monochrome · Japandi · Kraft Paper · Neo-Classical |
| dense-console | Dashboard Operator · Neon Terminal · Cyberpunk Neon |
| poster | Luxury Serif · Retro Futurism · Art Deco · Midnight Marine |
| bento | Swiss Modern · Glassmorphic · Soft Premium · Bauhaus Grid |
| marginalia | Technical Documentary · Academic |
| diagonal-flow | Warm Handmade · Kinetic Modern · Memphis Revival · Sketchbook |

## Presenting composition as a decision (A/B/C/D)

- **A: Tradition signature** — the tradition's default from the table above (recommended).
- **B: Monolith** — the deliberate single column, for when the content should dominate.
- **C: Contrast pick** — the signature from the table that most opposes A (e.g., a bento tradition gets editorial-spread) for users who want friction.
- **D: Density shift** — A's signature with its density inverted (gutters/measure/rhythm one step tighter or looser).

Preview each option as a miniature wireframe (gray blocks in the actual grid proportions) so the bones are visible before any paint goes on.
