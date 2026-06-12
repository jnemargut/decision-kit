---
name: design-system
description: Generate a unique AI-driven design system through a guided designer workshop. Walks the user through archetype selection, adjective sliders, reference triage, and signature tension — then generates novel SVG icons, a curated Google Fonts pairing, a semantic palette, and an applied showcase HTML + framework-agnostic bundle that any generator (Claude Code, v0, Lovable) can adopt. Every generated choice must trace to a workshop signal (amplification rules), nothing on the banned-defaults list ships, and the showcase passes a render-and-critique gate. Produces 'design/' folder with showcase.html, tokens.json, tokens.css, icons/, and claude.md. Use when the user wants a unique design system (colors, components, typography, icons) generated through discovery — not another shadcn-looking default. Triggers on 'design system', 'brand identity', 'make it unique', 'curated typography', 'not generic', 'design DNA'.
---

# Design System Skill

You help a user produce a fully unique, AI-generated design system through a four-step designer workshop. Output is a polished applied showcase HTML plus a framework-agnostic bundle that any downstream generator (Claude Code, v0, Lovable, Subframe, etc.) can adopt in one line.

**Your users are Taste-Aspiring Builders** — developers with design sensibility who know they lack a formal taste framework. They self-selected for thinking skills. They want craft, not a quiz. Teach the framework while capturing their taste.

## Core Principles

- **Feels like craft, not a personality quiz.** Every step is visual, rich, and teaches something.
- **All four discovery signals inform generation.** No wasted steps — enforced by the Amplification Rules below.
- **Nothing ships broken.** Edge cases deferred to `glyph-spec.md` / claude.md instructions rather than shipped as low-quality output.
- **Nothing banned ships.** Every output passes `references/banned-defaults.md` and the critique gate in `references/critique-gate.md`.
- **Framework-agnostic output.** No Tailwind config, no framework-specific files. Universal core only.
- **Pure prompt.** No external APIs, no Node scripts, no MCP. Everything generated inline. (The critique gate uses headless Chrome when available, with a documented no-tooling fallback.)

The skill ships with shared design DNA in `references/` (synced from the repo's `shared/design-dna/` — edit there, not here): `banned-defaults.md`, `font-pool.md`, `composition-signatures.md`, `critique-gate.md`.

## Amplification Rules — make the signals bite

The workshop's four signals are this skill's moat — and unenforced, they compress into the generic middle: every run drifts toward the same safe serif-plus-neutral-sans system regardless of input. These rules apply to every generation phase (5a–5c, 6).

1. **Every choice traces to a named signal.** Each generated decision (brand hue, accent, display face, body face, icon flourish, motion feel) must cite which signal produced it: the archetype, a specific slider position, a specific reference's DNA, or the tension. A choice you can't trace is a default wearing a costume — regenerate it. (The brand-design test: "if a brand can't connect its visual decisions back to its archetype, the archetype isn't real.")
2. **The tension must produce one visible rule-breaking move.** Not a saturation nudge — a move a careful designer would notice and question: a clashing accent earned by "warm but feral," a brutalist input field inside an elegant system for "luxury but honest," a hand-drawn icon terminal in a geometric set for "modern but handmade." Name the move in the showcase. A system with no rule-break has averaged its tension away.
3. **Slider extremes force non-obvious picks.** A slider at ≤15 or ≥85 is the user shouting. It must override the archetype's comfortable tendency, not season it — Playful at 8 with Ruler primary means the Ruler system gets genuinely playful moves, not a Ruler system with one rounded corner.
4. **Reference DNA outranks the archetype table.** When the synthesized reference DNA conflicts with the archetype's tendency (e.g., all three references are serif-driven but the archetype suggests geometric sans), the references win — the user showed you their taste; the table is only a prior.
5. **Different inputs must produce visibly different outputs.** Before finalizing, ask: if this run's archetype, sliders, or tension had been meaningfully different, would this system look different? If the honest answer is no, the signals didn't bite — find where they were laundered out and regenerate that piece.

---

## Phase 0 — Check for Context

Before anything, check if the current working directory has existing context that should shape the run:

- `.decisions/strategy-brief.md` — product strategy from `/product-strategy`
- `.decisions/decisions.json` — any prior design decisions
- `package.json` or framework configs — what stack is the user on

If a strategy brief exists, read it. Use the project name, target user, and elevator pitch to make every decision page feel grounded in what the user is actually building. If no context, that's fine — proceed on fresh footing.

Create a workspace for this run: `.design-decisions/` (separate from any existing `.decisions/` to avoid collision). This holds the four workshop decision pages.

## Phase 1 — Workshop Step 1: Archetype Selection

Present the 12 Jungian archetypes as an illustrated card deck. Each card: **signature sigil (geometric mark), archetype name, essence in quotation marks, 2-3 example brands that embody it.** User picks primary (70%) + secondary (30%).

The 12 archetypes with their sigils and essences (use these verbatim):

| Sigil | Name | Essence | Example Brands |
|-------|------|---------|----------------|
| ◈ | Creator | "Make something that didn't exist." | Apple · Lego · Adobe |
| ▲ | Hero | "Rise to the challenge, prove worth." | Nike · FedEx · Duracell |
| ◯ | Sage | "Tell the truth, earn trust." | NYT · Google · BBC |
| ➤ | Explorer | "Keep moving, find the edge." | REI · Jeep · North Face |
| ✕ | Outlaw | "Break what should be broken." | Harley · Virgin · Diesel |
| ✦ | Magician | "Transform what is into what could be." | Disney · Tesla · Dyson |
| ☺ | Jester | "Lightness is a form of truth." | MailChimp · Old Spice · Ben & Jerry's |
| ❖ | Ruler | "Set the standard. Hold the frame." | Rolex · Mercedes · American Express |
| ♥ | Caregiver | "Take care of what matters." | Johnson's · Volvo · TOMS |
| ❋ | Lover | "Make it beautiful. Make them feel." | Chanel · Häagen-Dazs · Godiva |
| ○ | Innocent | "See it clean. Start fresh." | Dove · Coca-Cola · Innocent Drinks |
| ▢ | Everyman | "Welcome as you are." | Target · IKEA · Home Depot |

### Step 1 Output

Render a self-contained HTML decision page at `.design-decisions/step-1-archetype.html` with the 12 cards in a grid. Open it. Ask the user: *"Which archetype leads (70%)? Which supports (30%)? Name both — e.g., 'Creator primary, Magician secondary.'"*

Wait for the response. Store as `{ primary: "Creator", secondary: "Magician", primarySigil: "◈", secondarySigil: "✦" }`.

Card rendering structure:
```html
<article class="arch-card [picked if chosen]">
  <div class="sigil">[sigil]</div>
  <h3 class="name">[name]</h3>
  <p class="essence">"[essence quote]"</p>
  <p class="examples">[brand 1] · [brand 2] · [brand 3]</p>
</article>
```

Style the cards to feel substantial — warm neutral background, generous padding, serif display for the name, italic for the essence quote. Not pill-shaped. Not a quiz.

## Phase 2 — Workshop Step 2: Adjective Axes

Present 5-6 bipolar adjective sliders. User places their product on each axis. Produces a multi-dimensional style fingerprint.

The axes (use these six):
1. **Playful ←→ Serious**
2. **Warm ←→ Cool**
3. **Classic ←→ Modern**
4. **Quiet ←→ Loud**
5. **Organic ←→ Geometric**
6. **Restrained ←→ Expressive**

Render a decision page at `.design-decisions/step-2-adjectives.html` showing each axis as a labeled track with a draggable-looking dot. Ask the user to specify positions in one message — e.g., *"Playful 35, Warm 20, Classic 70, Quiet 45, Organic 30, Restrained 55"* where the number is position from left (0) to right (100).

Store as `{ playfulSerious: 35, warmCool: 20, classicModern: 70, quietLoud: 45, organicGeometric: 30, restrainedExpressive: 55 }`.

If the user gives qualitative answers ("very warm, somewhat modern"), translate to approximate numeric positions and confirm.

## Phase 3 — Workshop Step 3: Reference Triage

Ask for 3 references from **unrelated industries** (this is deliberate — forces taste expression beyond competitors). Format: URL + one sentence on why.

Prompt: *"Share 3 products you love from different industries. For each: the URL + one sentence on what draws you to it. Example: `linear.app — the motion feels like thought`."*

For each reference:
1. Attempt to WebFetch the URL — extract dominant palette, font families, layout density, mood signals
2. Combine fetched data with the user's why-sentence
3. If fetch fails, fall back to product name + why-sentence + Claude's own recall

Synthesize the 3 references into a **shared DNA object**:
```json
{
  "sharedHueFamily": "warm earth with deep accent",
  "sharedTypographyTrait": "serif-driven, low-contrast",
  "sharedRhythm": "generous whitespace, asymmetric",
  "sharedMood": "quiet confidence, old-world digital",
  "userWhyThemes": ["clarity", "restraint", "character"]
}
```

Render a decision page at `.design-decisions/step-3-references.html` showing each reference with its extracted DNA and the synthesized intersection. Open it.

Wait for user confirmation — they can accept, adjust references, or modify the synthesis. Store the final DNA object.

## Phase 4 — Workshop Step 4: Signature Tension

Final discovery step: declare a tension in the form **"X but Y"** where both sides are genuinely good. This prevents generic-middle outputs.

Prompt: *"What's the tension your product lives in? Both sides should be good. 'Warm but formal.' 'Modern but handmade.' 'Confident but welcoming.' Your turn."*

Show the user the four previous signals (archetype pair, adjective fingerprint, reference DNA) and 3-4 suggested tensions inferred from them. But accept anything they write — even if it contradicts the suggestions, that contradiction is informative.

Render at `.design-decisions/step-4-tension.html`. Store as `{ tension: "warm but formal", leadSide: "warm", quietSide: "formal" }`.

## Phase 5 — Asset Generation

Now produce the design system assets. Do these in order — each informs the next.

### 5a. Palette (Multi-Signal Semantic Construction)

Build a full semantic palette using ALL four discovery signals:
- **Archetype → brand hue family.** (Creator: rich saturated. Caregiver: warm muted. Magician: deep violet/purple. Hero: high-contrast bold. Sage: low-saturation blue/green. Outlaw: desaturated black/red. etc.)
- **Adjectives → saturation curve + contrast range.** (playfulSerious > 50 → desaturated; warmCool < 50 → shift hues toward red/orange; classicModern > 60 → compressed scale.)
- **References → accent hue DNA.** Sample the shared hue family from reference synthesis.
- **Tension → pop locations.** The "lead side" gets louder saturation in one semantic slot (usually accent or danger); the "quiet side" keeps everything else restrained.

**Palette structure rule: one dominant family + one sharp accent.** Dominant colors with sharp accents outperform timid, evenly-distributed palettes — never ship five semantic colors at equal visual weight. The brand family carries the system; the accent cuts through it; everything else recedes into the neutral ramp. And per `references/banned-defaults.md`: no unconsidered indigo/violet defaults (`#6366f1`, `#8b5cf6` and friends), no purple-on-white gradient moves unless a signal genuinely produced them.

Record a one-line trace for brand and accent (Amplification Rule 1), e.g. `brand: deep moss — Sage primary + references' shared earth DNA · accent: signal red — "calm but urgent" lead side`. These traces ship in tokens.json under `rationale` and render in the showcase DNA tab.

Output structure (save as `design/tokens.json` in W3C Design Tokens format):

```json
{
  "$schema": "https://design-tokens.org/schema.json",
  "color": {
    "neutral": {
      "50": { "value": "#..." }, "100": { "value": "#..." }, "200": { "value": "#..." },
      "300": { "value": "#..." }, "400": { "value": "#..." }, "500": { "value": "#..." },
      "600": { "value": "#..." }, "700": { "value": "#..." }, "800": { "value": "#..." },
      "900": { "value": "#..." }
    },
    "brand": { "value": "#..." },
    "accent": { "value": "#..." },
    "semantic": {
      "success": { "value": "#..." },
      "warning": { "value": "#..." },
      "danger":  { "value": "#..." },
      "info":    { "value": "#..." }
    },
    "surface": {
      "bg":       { "value": "{color.neutral.50}" },
      "card":     { "value": "#ffffff" },
      "elevated": { "value": "#ffffff" }
    }
  },
  "typography": { /* see 5c */ },
  "space":   { "1": "4px", "2": "8px", "3": "12px", "4": "16px", "5": "24px", "6": "32px", "7": "48px", "8": "64px", "9": "96px" },
  "radius":  { "sm": "4px", "md": "8px", "lg": "12px", "xl": "20px" },
  "shadow":  { /* L1-L4 */ }
}
```

Validate: body text color (typically neutral.700) against surface.bg must pass WCAG AA (contrast ≥ 4.5:1). Adjust if it doesn't.

Also generate `design/tokens.css` as plain CSS custom properties derived from the same source — this is the universal adapter:

```css
:root {
  --color-neutral-50: #...;
  --color-neutral-900: #...;
  --color-brand: #...;
  --color-accent: #...;
  --color-success: #...;
  /* etc. */
  --space-1: 4px;
  /* etc. */
  --font-display: "...";
  --font-body: "...";
}
```

### 5b. Icons (Spec + Anchor + Two-Pass Review)

**Pass 1 — Derive style spec from discovery:**
- stroke weight (1.5px default; adjust +/-1 based on restrainedExpressive)
- corner radius (sharp if geometric dominant, soft if organic)
- grid size (20×20 or 24×24)
- fill treatment (outline-only for quiet + classic; filled for loud + modern)
- terminal style (flat caps for geometric, rounded for organic)
- signature flourish (informed by the primary archetype's sigil — e.g., Creator's ◈ → diamond motif in compositions; Magician's ✦ → star terminators)

**Pass 2 — Generate the anchor icon (typically "home") with maximum care** following the spec. This is the style reference.

**Pass 3 — Generate the icon set (~20 icons)** using the spec + anchor as paired reference:
home, search, plus, settings, user, bell, close, check, menu, arrow-right, arrow-left, arrow-up, arrow-down, chevron-down, heart, star, edit, trash, download, upload, filter, grid-view, list-view, calendar

Generate each as a complete SVG with consistent viewBox (0 0 24 24), named descriptively.

**Pass 4 — Review & regenerate outliers.** Look across the 20 icons. For each icon, ask: does it share stroke, radius, terminal style, and overall visual DNA with the anchor? Identify ≤3 outliers. Regenerate them matching the anchor more tightly.

Save each as an individual file: `design/icons/home.svg`, `design/icons/search.svg`, etc.

### 5c. Typography (Curated Google Fonts Pairing)

**Pick a real, production-quality typography pairing from Google Fonts driven by the discovery signals. Two fonts: one display, one body. Both must already exist on Google Fonts — never invent a font.**

**Step 1 — Use the archetype's type tendency as the starting filter.**

Each archetype has a documented type personality (see `archetypes.md`). These are **priors, not menus** — Amplification Rule 4 lets reference DNA override them, and `references/font-pool.md` holds the full supply with pairing notes. Banned faces (`references/banned-defaults.md`: Inter, Roboto, Arial, Open Sans, Lato, Montserrat, Poppins as display; Inter as default body) never appear, in any role the user didn't explicitly request.

- Creator → distinctive display (Fraunces, Bricolage Grotesque, Gloock, Young Serif); characterful body (Karla, Plus Jakarta Sans, Source Serif 4)
- Hero → strong-weight display (Archivo Black, Bebas Neue, Anton, Oswald); sturdy body (Libre Franklin, Saira, Hanken Grotesk)
- Sage → editorial serif or engineered sans (Source Serif 4, Newsreader, Literata, IBM Plex Sans); body (Hanken Grotesk, Lora, IBM Plex Sans)
- Explorer → textural grotesque (Space Grotesk, Familjen Grotesk, Outfit, Bricolage Grotesque); body (Figtree, Public Sans, Alegreya Sans)
- Outlaw → brutalist/condensed (Anton, Bowlby One, Archivo Black, Syne); body (Space Grotesk, Libre Franklin) with mono accents (JetBrains Mono, Space Mono)
- Magician → elegant or otherworldly display (Cormorant Garamond, Marcellus, Playfair Display, Unbounded); body (Sora, DM Sans, Spectral)
- Jester → bouncy display (Bricolage Grotesque, Quicksand, Baloo 2); body (Nunito, Plus Jakarta Sans); hand-drawn accent (Caveat, Patrick Hand)
- Ruler → classical serif (EB Garamond, Bodoni Moda, Cormorant Garamond, Marcellus); refined body (Manrope, Alegreya Sans, Lora)
- Caregiver → warm serif or rounded sans (Petrona, Vollkorn, Quicksand); soft body (Mulish, Karla, Nunito)
- Lover → expressive serif (Cormorant Garamond, Crimson Pro, Italiana, Bodoni Moda); elegant body (Lora, Crimson Pro, Alegreya Sans)
- Innocent → clean friendly display (Quicksand, Young Serif, Karla); body (Mulish, Figtree, Karla)
- Everyman → honest workhorse (Source Sans 3, Public Sans, Hanken Grotesk, Chivo); body from the same family or Figtree

**Cross-project uniqueness:** before locking the display face, check sibling memory (`.visual-design/tokens.json`, any prior `design/tokens.json` in adjacent projects you can see). If the same display face was already this user's last system, pick the next-best candidate — two of the user's projects shouldn't share a voice by default.

**Step 2 — Apply the adjective sliders to narrow.**
- `warmCool` < 50 → push toward serifs and warmer humanist sans; > 50 → cooler grotesque/geometric sans
- `classicModern` < 50 → traditional / Garalde / classical proportions; > 50 → contemporary / Modernist / variable
- `organicGeometric` < 50 → humanist / hand-derived; > 50 → geometric / constructed
- `restrainedExpressive` > 60 → distinctive display with character (italic axis, variable opsz); < 40 → workhorse, neutral body

**Step 3 — Use reference DNA + tension to make the final pick.**
- If references share a typography trait (e.g., "all serif-driven, low-contrast"), honor it
- The signature tension determines whether display + body **contrast** (different families/voices, e.g., "warm but formal" → expressive serif + crisp neutral sans) or **harmonize** (same superfamily, e.g., "modern but handmade" → Hanken Grotesk + Caveat-as-accent)

**Step 4 — Output the pairing decision.**

```json
{
  "display": {
    "family": "Fraunces",
    "weights": [400, 600, 700, 800],
    "axes": "opsz,wght — variable",
    "fallback": "Georgia, serif"
  },
  "body": {
    "family": "Karla",
    "weights": [400, 500, 600, 700],
    "axes": "wght — variable",
    "fallback": "system-ui, sans-serif"
  },
  "googleFontsUrl": "https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700;9..144,800&family=Karla:wght@400;500;600;700&display=swap",
  "rationale": "Fraunces (display) carries the Creator archetype's character through its variable opsz axis — bigger sizes, more flair [trace: Creator primary]. Karla (body) is warm and grounded without going soft [trace: Warm 20 + references' humanist DNA]. The pair contrasts deliberately — the rule-breaking warmth inside a formal frame [trace: tension 'warm but formal']."
}
```

Add typography tokens to `tokens.json`:

```json
"typography": {
  "display": {
    "family":   { "value": "Fraunces" },
    "fallback": { "value": "Georgia, serif" }
  },
  "body": {
    "family":   { "value": "Karla" },
    "fallback": { "value": "system-ui, sans-serif" }
  },
  "googleFontsUrl": { "value": "https://fonts.googleapis.com/css2?..." },
  "scale": {
    "xs":      { "value": "12px" },
    "sm":      { "value": "14px" },
    "base":    { "value": "16px" },
    "lg":      { "value": "20px" },
    "xl":      { "value": "28px" },
    "display": { "value": "44px" }
  }
}
```

And add to `tokens.css`:

```css
:root {
  --font-display: "Fraunces", Georgia, serif;
  --font-body: "Karla", system-ui, sans-serif;
}
```

Critically: **never generate SVG glyphs, never invent fonts, never produce a fake "novel typeface."** Real Google Fonts only. The "AI" part is the curation — picking the right two fonts from thousands of options based on the user's discovery signals. That's the value.

## Phase 6 — Showcase HTML (Three Layers)

Assemble `design/showcase.html` as a self-contained file with three layers:

### Layer 1: Fixed Skeleton

The outer frame is stable across runs. Structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Design System — [Project Name]</title>
  <style>
    /* Inlined tokens.css */
    :root { /* color, space, radius, shadow, typography tokens */ }
    /* Base reset */
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: var(--font-body); color: var(--color-neutral-900); background: var(--color-surface-bg); }
    /* Layout */
    .frame { max-width: 1200px; margin: 0 auto; padding: 2rem; }
    .tabs { display: flex; gap: 8px; border-bottom: 1px solid var(--color-neutral-200); }
    .tab { padding: 12px 20px; font-weight: 600; cursor: pointer; }
    .tab.active { border-bottom: 2px solid var(--color-brand); color: var(--color-brand); }
    /* etc. */
  </style>
</head>
<body>
  <header class="frame">
    <h1 style="font-family: var(--font-display);">[Project Name]</h1>
    <p>[Tension: "X but Y"] · [Primary archetype] · [Secondary archetype]</p>
  </header>
  <div class="tabs frame">
    <button class="tab active" data-tab="dna">DNA</button>
    <button class="tab" data-tab="applied">Applied</button>
  </div>
  <main class="frame" id="tab-dna">[LAYER 2 CONTENT]</main>
  <main class="frame hidden" id="tab-applied">[LAYER 3 CONTENT]</main>
  <footer class="frame">
    <h2>Hand to Claude Code</h2>
    <p>Run this in your project: <code>use the design system in design/</code></p>
  </footer>
  <script>
    // Minimal tab switcher
    document.querySelectorAll('.tab').forEach(t => t.addEventListener('click', e => {
      document.querySelectorAll('.tab').forEach(x => x.classList.remove('active'));
      document.querySelectorAll('main').forEach(x => x.classList.add('hidden'));
      e.target.classList.add('active');
      document.getElementById('tab-' + e.target.dataset.tab).classList.remove('hidden');
    }));
  </script>
</body>
</html>
```

### Layer 2: DNA Tab (Token-Injected)

Templated sections. For each, render from the generated tokens:

- **Palette**: every neutral step + semantic colors rendered as swatches with hex labels and contrast badges (against body text color)
- **Typography**: specimens using the chosen Google Fonts (loaded via `<link>` in `<head>`). Show display font name + sample at large/medium/small ("Aa Bb Cc 123"), body font name + a paragraph sample, and a 30-second pairing rationale ("why these two together"). Compare side-by-side so the relationship is visible.
- **Icons**: grid of all ~20 icons at 24px and 48px, labeled by name
- **Declared Tension**: the "X but Y" presented as a quote with both sides styled — the lead side bolder, the quiet side restrained — plus the named **rule-breaking move** it produced (Amplification Rule 2) with a one-line pointer to where it shows up in the Applied tab
- **Why it looks this way**: the signal→choice trace table (Amplification Rule 1) — one row per major decision (brand, accent, display, body, icon flourish, motion), each citing the archetype, slider, reference, or tension that produced it. This is the tab that teaches; a user should leave able to defend every choice

### Layer 3: Applied Tab (AI-Composed)

Claude writes this fresh, informed by all discovery signals and generated assets. Produce:

- **Hero section** — a product landing hero using the display font (real Google Font via `<link>`) and brand/accent colors. Realistic copy matching the archetype and tension (not "Lorem ipsum").
- **Card** — a product card using card surface, icons, typography
- **Form** — an input field + button + helper text demonstrating interactive states
- **Nav** — a horizontal nav with brand mark (display font), 3-4 nav items (body font), and a CTA button

Each section should visibly reflect the archetype + tension. A Creator-led "warm but formal" system and a Magician-led "modern but handmade" system should produce visibly different Applied tabs.

**Compose, don't template:** pick a composition signature from `references/composition-signatures.md` for the Applied tab's hero/section structure, informed by archetype + tension (Hero/Outlaw → poster or broken-grid; Sage → marginalia or editorial-spread; Ruler → monolith; Everyman → bento...). Two systems should differ in bones, not just paint. The rule-breaking move from Amplification Rule 2 must be visible somewhere in this tab.

Validate: all body text passes contrast. No Lorem ipsum. No broken tokens.

## Phase 7 — Generate claude.md

Write `design/claude.md` with five sections (see `claude-md-template.md` in the skill directory for the full template). The five sections:

1. **Framework Adaptation** — detection logic + per-framework adapter patterns (Tailwind, styled-components, Svelte, Vue, CSS Modules, SCSS, plain CSS).
2. **Using Icons** — inline import vs. SVG sprite patterns. Never swap in external icon libraries.
3. **Using Typography** — load the Google Fonts via `<link>` (URL is in `tokens.json`). Use `var(--font-display)` for headlines and `var(--font-body)` for body. The pairing was curated for this brand — don't substitute.
4. **Component Patterns** — buttons, cards, inputs, nav composed from tokens.
5. **Tension & Voice** — the declared tension and how to apply it (lead side amplified in marketing moments; quiet side restrained in daily-use surfaces).

Fill in placeholders with actual values from the generated system: project name, archetype pair, tension, chosen Google Fonts, real palette values for component pattern examples.

## Phase 8 — Write Bundle + Open Showcase

Write all files to `design/`:

```
design/
├── showcase.html
├── tokens.json           # includes typography.display.family + body.family + googleFontsUrl
├── tokens.css            # includes --font-display + --font-body
├── claude.md             # 5 sections, including "Using Typography"
└── icons/
    ├── home.svg, search.svg, plus.svg, settings.svg, user.svg, bell.svg, close.svg,
    ├── check.svg, menu.svg, arrow-right.svg, arrow-left.svg, arrow-up.svg, arrow-down.svg,
    ├── chevron-down.svg, heart.svg, star.svg, edit.svg, trash.svg, download.svg, upload.svg,
    └── filter.svg, grid-view.svg, list-view.svg, calendar.svg
```

No `fonts/` directory. No `glyph-spec.md`. Typography ships as Google Fonts references inside `tokens.json` and `tokens.css` — the user (or downstream Claude Code) just adds the `<link>` to their HTML and references `var(--font-display)` / `var(--font-body)`.

**Run the critique gate before opening anything.** Follow `references/critique-gate.md` against `design/showcase.html`: deterministic checks (ban scan, contrast from tokens, font-delivery), then render via headless Chrome and answer the binary rubric against the screenshot — including question 8 (would this be mistaken for the user's previous system?) when sibling memory exists. Fix failures, maximum two loops, keep what the gate found for the final message. No renderer available → run the CSS self-review fallback; never skip the gate silently.

Then open the showcase in the browser:
```bash
open design/showcase.html
```

## Phase 9 — Final Message

Tell the user:

> "Your design system is ready. I've opened `design/showcase.html` — take a look at both tabs.
>
> - **DNA tab** — palette, your curated typography pairing, icons, and your declared tension
> - **Applied tab** — the system rendered into real UI sections
>
> To build your product on top of this, hand to Claude Code with:
> `use the design system in design/`
>
> The `claude.md` in the folder tells Claude Code how to adapt these tokens to whatever framework you're using.
>
> Want to regenerate anything? Tell me which piece (palette, icons, typography pairing, showcase) and I'll redo just that one."

---

## Handling User Changes

**"Regenerate icons"** — keep palette, typography, tokens; rerun Phase 5b with any new style spec adjustments.

**"I don't love the palette"** — rerun Phase 5a with user guidance ("more restrained", "warmer accent", "less orange"), then re-render tokens.json, tokens.css, and the DNA tab of showcase.html.

**"The fonts don't fit"** — rerun Phase 5c with user guidance ("more editorial", "less serif", "show me alternatives"). Output 2-3 candidate pairings with rationale and let the user pick. Re-render tokens.json, tokens.css, and the typography section of the DNA tab.

**"The tension should be 'X but Z' instead"** — update the tension, re-run the Applied tab of showcase.html, update section 5 of claude.md.

**"Start over"** — remove `.design-decisions/` and `design/`, restart from Phase 1.

## Quality Gates

Before opening the showcase, verify:
1. All body text passes WCAG AA contrast (≥ 4.5:1) against its surface
2. Every font-size in the showcase corresponds to a typography scale step in tokens.json
3. Every color, spacing, radius in the showcase references a token (no ad-hoc values)
4. Icons share consistent stroke, radius, and terminal treatment (visual review)
5. No `Lorem ipsum` or `Card 1` placeholder text in the Applied tab — use realistic copy for the project domain
6. claude.md references the actual tension, not a placeholder
7. The chosen Google Fonts actually exist (use only fonts confirmed to be on fonts.google.com — verify via `https://fonts.google.com/specimen/[Font+Name]` mental check; if uncertain, default to a known-good pairing for the archetype)
8. The Google Fonts URL in tokens.json is well-formed and includes both display and body family at appropriate weights
9. Nothing from `references/banned-defaults.md` appears in tokens or showcase (run the grep self-check: banned faces outside fallback tails, banned accent hexes)
10. Every major choice has a signal trace, and the tension's rule-breaking move is named and visible (Amplification Rules 1–2)
11. The critique gate (Phase 8) ran and its findings are reported

If any check fails, regenerate the failing piece.

## What NOT To Do

- Don't use Tailwind config output — we committed to framework-agnostic
- Don't use external icon libraries (Lucide, Phosphor) — breaks the "novel icons" claim
- Don't skip the two-pass icon review — outliers kill consistency
- **Don't generate SVG glyphs for fonts. Don't invent fonts. Don't write a "glyph-spec.md".** The skill produces a curated Google Fonts pairing — real production fonts only.
- Don't write Lorem ipsum — use realistic copy informed by the archetype
- Don't hide the framework. The archetype cards, the tension, the typography rationale — all of these teach. The user leaves with a vocabulary, not just an artifact
- Don't reach for banned defaults (`references/banned-defaults.md`) — Inter-everywhere, indigo gradients, timid evenly-spread palettes, the fixed shadcn-shaped template. If a choice can't be traced to a signal, it doesn't ship
- Don't average the tension away. A system that splits every difference belongs to nobody — the generic middle is the failure mode this skill exists to prevent
