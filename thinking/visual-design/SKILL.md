---
name: visual-design
description: Re-skin any existing HTML artifact with a chosen aesthetic. Post-step aesthetic thinking — walks through 5 decisions (tradition, color, type, mood, signature flourish) and produces a side-by-side beautified HTML + tokens.json sidecar. Use AFTER producing an HTML artifact from another thinking skill (strategize, game-plan, better-proposal, launch-playbook, product-design) that looks visually generic, or any time you want to re-style an HTML file without rewriting its structure.
---

# Visual Design

You are helping the user re-skin an existing HTML artifact with a distinct aesthetic. This is a post-step skill: something else produced the HTML; your job is to make it feel like *something*, not a generic template.

The user invokes `/visual-design [optional path to .html]`. You walk them through five quick decisions — **Tradition → Color → Type → Mood → Signature Flourish** — then rewrite the artifact's `<style>` block with the resolved aesthetic. Original is preserved; a new `<name>.styled.html` is written alongside, and `.visual-design/tokens.json` captures the decisions for reuse in the project.

**Core principles:**
- Write in plain English. Talk like a designer who cares, not a form-builder.
- Each decision presents exactly 4 options *except* Tradition (top 3 matched + 20+ catalog) and Flourish (top 3 curated + library) — those use name-based picking.
- Always include a recommendation.
- Show, don't just tell — every option renders a preview using the actual tradition's tokens.
- The skill's job ends when `<name>.styled.html` and `tokens.json` are on disk and opened for the user.

---

## PHASE 1 — Invocation

### Step 1a — Parse the argument

The user invokes `/visual-design [path]` where `[path]` is optional.

**If a path is provided:**
- Verify the file exists and ends in `.html`.
- If valid, set `TARGET = the path`, proceed to Phase 2.
- If invalid (not found, not HTML), tell the user and fall through to the picker path below.

**If no path is provided:**
- Glob for recent HTML artifacts in priority order:
  1. `.decisions/*.html` (most common — decision-kit outputs)
  2. `*.html` in cwd
  3. `**/*.html` up to 2 levels deep (excluding `node_modules`, `dist`, `.git`)
- Sort results by modification time (newest first).
- If 0 matches: tell the user no HTML artifacts found, suggest running a thinking skill first or passing a path. Stop.
- If 1 match: use it, but confirm with user first:
  > "Found **[filename]** (modified [time ago]). Re-skin this one? Reply `yes` or pass a different path."
- If 2+ matches: show the top 5 with the newest marked ✓:
  > "Found these HTML artifacts. Which one do you want to re-skin?
  >   1. ✓ strategy-brief.html   (2 min ago)
  >   2. proposal.html            (1 hr ago)
  >   3. launch-plan.html         (yesterday)
  > Reply with a number, a filename, or paste a different path."

Wait for the user to confirm the target before proceeding.

### Step 1b — Check for project memory

Once `TARGET` is set, check for `.visual-design/tokens.json` at the project root (walk up from the target file to find the nearest one).

- **If present:** parse it. Note the previous tradition + flourish. On the Phase 3 starting screen, surface this as suggestion #1 in the top 3 with the label "your project aesthetic."
- **If absent:** normal flow — skill will create the `.visual-design/` directory later.

### Step 1c — Create `.decisions/` working directory for this run

Create `.decisions/visual-design/` at the project root. This is where per-step HTML decision pages for this invocation go:
- `01-tradition.html`
- `02-color.html`
- `03-type.html`
- `04-mood.html`
- `05-flourish.html`
- `index.html` (run summary)

These let the user revisit their aesthetic decisions later.

---

## PHASE 2 — Artifact Analysis

Read the target HTML file. Extract:

1. **Structural selectors** — every class and ID used on elements. Note the semantic regions (`header`, `footer`, `nav`, `main`, `section`, etc.).
2. **Current style block** — the contents of `<style>...</style>` if present. Note what tokens it already defines (e.g., `:root { --ink: ... }`).
3. **Artifact type hints:**
   - Word count (rough estimate from stripped body text)
   - Heading structure (h1-h6 count)
   - Presence of tables, lists, code blocks, forms
   - Inline font stacks used
4. **Infer artifact type** — one of:
   - `brief` — word-heavy, 1-3 headings, long prose paragraphs
   - `landing` — short hero text, multiple sections, CTAs
   - `doc` — many headings, tables, code blocks
   - `proposal` — mixed — hero + sections + tables + CTAs
   - `dashboard` — low text, many small cards
   - `slide` / `one-pager` — small body, large display text

Keep this as a data structure you reference throughout the run. Example:

```json
{
  "target": ".decisions/strategy-brief.html",
  "type": "brief",
  "wordCount": 2400,
  "headings": { "h1": 1, "h2": 6, "h3": 3 },
  "hasTables": true,
  "hasCode": false,
  "selectors": [".page", ".option", ".footer", ".research", "h1.title", ".deck", "..."]
}
```

---

## PHASE 3 — Tradition Selection (Decision 1)

This is the first and biggest decision. The catalog holds 20-30+ traditions; the starting screen gives the user a fast path (top 3 matches) and a surf path (the whole catalog, flat).

### Step 3a — Score the traditions for this artifact

For each tradition in the library (see AESTHETIC TRADITIONS LIBRARY below), compute a fit score from the artifact type:

| Artifact type | Tradition affinities (highest fit first) |
|---------------|------------------------------------------|
| `brief` | Editorial Print, Warm Minimal, Academic, Newsprint, Swiss Modern |
| `landing` | Neo-Brutalist, Kinetic Modern, Glassmorphic, Playful Maximalist, Swiss Modern |
| `doc` | Technical Documentary, Swiss Modern, Monochrome, Academic |
| `proposal` | Editorial Print, Neo-Classical, Swiss Modern, Warm Minimal |
| `dashboard` | Swiss Modern, Technical Documentary, Kinetic Modern, Monochrome |
| `slide` | Editorial Print, Neo-Brutalist, Luxury Serif, Kinetic Modern |

Top 3 scores become the featured matches. If project memory exists, slot the previous tradition as suggestion #1 regardless of score (with the "your project aesthetic" label).

### Step 3b — Render the tradition decision page

Write `.decisions/visual-design/01-tradition.html` following the HTML TEMPLATE REFERENCE below. The page has two sections:

1. **Matched for your artifact** (3 large tiles, rendered with each tradition's real tokens — type-forward thumbnail style, see below)
2. **Browse all** (flat grid of remaining traditions, ~48px tiles)

Each tile renders the tradition's name using the tradition's **own headline font**, **primary text color**, and **base background**. This is the "type-forward thumbnail" pattern — one word in the tradition's voice. Readable at small sizes, conveys feel instantly.

Open the file with `open .decisions/visual-design/01-tradition.html` and wait for the user's response.

### Step 3c — Handle the user's pick

User's response shapes:
- Name: `Editorial`, `Editorial Print`, `warm minimal`, `Swiss`, `neo-brutal` → fuzzy-match the library (case-insensitive, partial prefix match).
- Shortcut: `top pick` / `first` / `best match` / `A` / `B` / `C` → resolves to the 1st, 2nd, or 3rd matched tile.
- `recommended` → resolves to the highest-scored tradition (usually match #1).
- `more` / `more options` → expand the Browse All grid (if you showed a partial subset initially).
- `surprise me` / `skill's pick` → pick the highest-scored tradition, move on.

If input is ambiguous (multiple traditions match), list the candidates numbered:
> "Could be: 1) Editorial Print, 2) Academic (editorial typeface), 3) Neo-Classical. Reply with a number or a more specific name."

Once locked: set `TRADITION` in state, proceed to Step 2 (Color).

---

## PHASE 4 — Steps 2-5 of the Flow

All four of these steps use the **A/B/C/D pattern** (standard thinking-skill convention). Each step:
1. Generates a decision HTML page with 4 options
2. Opens it in the browser
3. Waits for a letter-based response

### Step 2 — Color

Given `TRADITION`, offer 4 color variants that stay within the tradition's ramp but shift emphasis:

- **Option A: Faithful** — the tradition's default ramp + accent as specified
- **Option B: Warmer** — shift accents toward warmer hues (wood, brick, amber)
- **Option C: Cooler** — shift accents toward cooler hues (navy, forest, slate)
- **Option D: Higher contrast** — pump the contrast between text and background one step

Render each option as a mini-frame with the tradition's structure (browser chrome, header, hero headline, CTA button) using the shifted palette. Write `.decisions/visual-design/02-color.html`. Open. Wait.

### Step 3 — Type

Given `TRADITION` + `COLOR`, offer 4 type treatments:

- **Option A: Tradition default** — the headline + body pair specified by the tradition (recommended)
- **Option B: Bigger headlines** — same fonts, one scale step larger on h1/h2
- **Option C: Alternate pair** — the tradition's alternate typeface suggestion (e.g., for Editorial, swap Fraunces display for Source Serif display)
- **Option D: Mono everything** — replace body with a monospace stack (good for technical feel)

Each preview shows a styled headline + two lines of body text at realistic sizes. Write, open, wait.

### Step 4 — Mood

Given prior choices, offer 4 mood combos (shape × shadow bundled):

- **Option A: Sharp + flat** — tight radius, no shadows
- **Option B: Sharp + elevated** — tight radius, strong shadows
- **Option C: Soft + flat** — generous radius, no shadows
- **Option D: Soft + elevated** — generous radius, soft shadows

Each preview shows a CTA button + a card + a divider to demonstrate the combo. The values come from the tradition's tokens; this step picks which combination dominates the artifact.

### Step 5 — Signature Flourish

Given prior choices, load the flourish candidates from the tradition's entry in the SIGNATURE FLOURISH LIBRARY.

- **Top 3 curated** — the 3 flourishes that fit this tradition best (per the table in the flourish library). Surface with the label "✦ fits [tradition] best."
- **Full library below** — all 8-10 flourishes available. Browse flat.

This is the novel step — the anti-generic move. Use name-based picking like Tradition:
- Name: `Drop Cap`, `Pull Quote`, `Grain`, etc.
- `A` / `B` / `C` hits the top 3 tiles
- `none` / `skip` is a valid choice (no flourish)

Each flourish preview renders the flourish rendered inside a small paragraph using the chosen tradition.

Write `.decisions/visual-design/05-flourish.html`. Open. Wait.

---

## PHASE 5 — Rewrite & Output

Once all 5 decisions are locked, you have:

- `TRADITION` — tokens + aesthetic rules
- `COLOR` — palette shift applied to ramp
- `TYPE` — headline + body pair + scale
- `MOOD` — shape + shadow combo
- `FLOURISH` — the signature element to add

### Step 5a — Resolve final tokens

Combine everything into a single tokens object:

```json
{
  "tradition": "Editorial Print",
  "variant": {
    "color": "faithful",
    "type": "tradition-default",
    "mood": "sharp-flat",
    "flourish": "drop-cap"
  },
  "tokens": {
    "color": {
      "ramp": ["#fdf6e3", "#f5ecd0", "#e7d7b8", "...", "#1f1611"],
      "accent": "#9a3412",
      "ink": "#1f1611",
      "bg": "#fdf6e3"
    },
    "type": {
      "headline": { "family": "'Iowan Old Style', Georgia, serif", "weights": [400, 600, 700] },
      "body": { "family": "'Source Serif 4', Georgia, serif", "weights": [400, 600] },
      "mono": { "family": "'JetBrains Mono', ui-monospace, monospace" },
      "scale": [12, 14, 18, 22, 32, 52]
    },
    "spacing": [4, 8, 12, 16, 24, 32, 48, 72, 104],
    "radius": [2, 4, 6, 10],
    "shadow": { "l1": "...", "l2": "...", "l3": "...", "l4": "..." },
    "motion": { "ease": "cubic-bezier(.2,.8,.2,1)", "duration": [140, 240, 400] }
  },
  "rules": [
    "Always use Iowan Old Style display at larger sizes.",
    "Italics are expressive tools for kickers and captions.",
    "No gradients — solid warm paper + ink.",
    "..."
  ],
  "flourish": {
    "type": "drop-cap",
    "css": ".drop { float: left; font-family: var(--headline); font-size: 3.5em; line-height: 0.85; padding: 0.1em 0.1em 0 0; color: var(--accent); }",
    "htmlHook": "add <span class=\"drop\">[first letter]</span> to the first paragraph after each h1"
  }
}
```

### Step 5b — Generate the new `<style>` block

Using the artifact's selectors (from Phase 2) and the resolved tokens, compose a complete CSS stylesheet:

1. Add Google Fonts `<link>` if needed (check the tradition's type stack)
2. Add `:root { --... }` with the resolved tokens
3. For each selector in the artifact, write rules that:
   - Apply tradition's aesthetic rules (e.g., offset-solid shadows for Neo-Brutalist, italic kickers for Editorial)
   - Use the resolved tokens for color, spacing, radius, type
   - Preserve layout structure (grid/flex patterns, widths, etc.) — only aesthetic properties change
4. Append the flourish CSS
5. Responsive breakpoints mirror the original (preserve the artifact's mobile behavior)

### Step 5c — Write output files

1. Copy the original artifact HTML structure (body, semantics) into a new file named `<original-name-without-ext>.styled.html` in the same directory as the original.
2. Replace its `<style>...</style>` block with the freshly generated CSS.
3. If `FLOURISH.htmlHook` specifies DOM insertions (e.g., drop caps, pull quotes), apply them minimally — just enough to manifest the flourish.
4. Ensure the `<head>` has the needed Google Fonts `<link>` tags.

### Step 5d — Write tokens sidecar

Write the resolved tokens object (from Step 5a) to `.visual-design/tokens.json` at the project root. Also write `.visual-design/run.json` with the invocation metadata (timestamp, target file, all 5 decisions).

If `.gitignore` exists and doesn't include `.visual-design/`, append a line:
```
# visual-design skill state
.visual-design/
```

### Step 5e — Open + report

Open both files side by side (so user can compare):
```bash
open <original>
open <original-basename>.styled.html
```

Report:
> "Re-skinned! **[basename].styled.html** is open alongside the original.
>
> Applied **[Tradition]** with **[Flourish]**. Decisions saved to `.visual-design/tokens.json` — next run in this project will surface this aesthetic as suggestion #1.
>
> Reply:
> - `love it` → nothing to do, done
> - `redo` → rerun the flow from scratch
> - `change [tradition|color|type|mood|flourish]` → rerun just that step
> - `different flourish` → return to step 5
> - `more contrast` / `warmer` / etc → I'll interpret and adjust"

---

## RESPONSE PARSING — How Users Pick

The five steps don't all have 4 options, so input parsing varies per step:

### Steps 2, 3, 4 (Color, Type, Mood) — standard A/B/C/D
- Exactly 4 options each. Respond like any thinking skill.
- Accept: `Option A`, `A`, `the first one`, `Option B because [reason]`, `Option A but [modification]`, `more options`.

### Steps 1 and 5 (Tradition, Flourish) — name-based picking
- 10-30+ options, letters don't scale. Pick by name.
- **Primary:** `Editorial`, `Warm Minimal`, `Neo-Brutalist`, `Drop Cap`, `Rule Line`, etc.
- **Fuzzy:** case-insensitive, partial prefix match (`brutal` → Neo-Brutalist, `warm` → Warm Minimal).
- **Top-3 shortcuts:** `A` / `B` / `C` hit the top 3 tiles. Also: `top pick`, `first`, `best match`.
- **Disambiguate:** if input matches >1 tradition, echo candidates numbered, ask for a pick.
- **Recommended:** the highest-scored tradition earns a ★. User can say `recommended` to pick it.

### Catalog-wide commands (any step)
- `more` / `more options` — expand visible set.
- `surprise me` / `skill's pick` — take the highest-scored option, move on.
- `back` / `previous` — step back without rerunning.
- `skip` — at step 5, valid meaning "no flourish." At other steps, use recommended.

Match input against (a) letter regex `^([A-Za-z])\b` at steps 2-4, (b) shortcut keywords, (c) fuzzy name match at steps 1 and 5. Show numbered candidates when ambiguous.

---

## AESTHETIC TRADITIONS LIBRARY

12 starter traditions, grouped by feel. Each entry provides the tokens and aesthetic rules needed to render previews AND to generate the final rewrite.

**Feel groups** (used only for internal organization — all traditions render in the flat grid):
- **Structural:** Swiss Modern, Technical Documentary, Monochrome, Newsprint, Academic
- **Warm:** Editorial Print, Warm Minimal, Warm Handmade
- **Expressive:** Neo-Brutalist, Playful Maximalist, Y2K Maximalist
- **Quiet:** Soft Premium, Neo-Classical
- **Raw:** Neon Terminal, Zine
- **Kinetic:** Kinetic Modern, Glassmorphic, Luxury Serif

Below are the 12 seed traditions. Add more over time by appending new entries in the same format.

---

### 1. Swiss Modern

**Feel:** Clean, confident, functional. Zero decoration. Information dense but never cramped. Typography does the heavy lifting.

**Color ramp:** `#fafafa` · `#f4f4f5` · `#e4e4e7` · `#d4d4d8` · `#a1a1aa` · `#71717a` · `#52525b` · `#3f3f46` · `#27272a` · `#0f172a`
**Accents:** primary `#6366f1` · pressed `#4f46e5` · success `#22c55e` · danger `#ef4444`

**Type:**
- Headline: `"Inter Tight"` 700, letter-spacing -0.02em
- Body: `Inter` 400, line-height 1.55
- Mono: `"JetBrains Mono"` 400
- Scale: 12 · 14 · 16 · 20 · 28 · 40
- Google Fonts: `Inter+Tight:wght@500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 4 · 6 · 10 · 16
**Shadow:** L1 `0 1px 2px rgba(15,23,42,.06)` · L2 `0 2px 8px rgba(15,23,42,.08)` · L3 `0 8px 24px rgba(15,23,42,.10)` · L4 `0 16px 40px rgba(15,23,42,.12)`
**Motion:** `cubic-bezier(.16,1,.3,1)` · 120 / 200 / 320ms

**Rules:**
- No gradients. Solid color + whitespace.
- Shadows only on elevated surfaces.
- Headlines tight (-0.02 to -0.03em); body neutral.
- No rounded corners above 16px.
- Icons: 1.5px stroke, match body color.

**Flourish picks:** Kicker · Rule Line · Small-Caps Label

---

### 2. Editorial Print

**Feel:** Warm, literary, intentional. Print publication translated to screen. Rewards reading. Restrained color — when it shows up, it means something.

**Color ramp:** `#fdf6e3` · `#f5ecd0` · `#e7d7b8` · `#d4af7a` · `#b07a4a` · `#9a3412` · `#7c2d12` · `#44342a` · `#2a1f18` · `#1f1611`
**Accents:** brick `#9a3412` · success `#357266` · danger `#b91c1c`

**Type:**
- Headline: `Fraunces` 600 with `opsz` 96-144, letter-spacing -0.02em
- Body: `"Source Serif 4"` 400, line-height 1.7
- Mono: `"JetBrains Mono"` 400
- Scale: 12 · 14 · 18 · 22 · 32 · 52
- Google Fonts: `Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Source+Serif+4:ital,opsz,wght@0,8..60,400;0,8..60,600;1,8..60,400&family=JetBrains+Mono`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 104
**Radius:** 2 · 4 · 6 · 10
**Shadow:** L1 `0 1px 2px rgba(31,22,17,.08)` · L2 `0 2px 6px rgba(31,22,17,.10)` · L3 `0 4px 12px rgba(31,22,17,.12)` · L4 `0 8px 20px rgba(31,22,17,.15)`
**Motion:** `cubic-bezier(.2,.8,.2,1)` · 140 / 240 / 400ms

**Rules:**
- Always use Fraunces `opsz` axis — bigger opsz for bigger sizes.
- Italics are expressive tools, especially for kickers and captions.
- No gradients. Solid warm paper + ink.
- Dividers hairline or dotted, never thick.
- Use pull-quotes with generous margins when space allows.
- Drop caps welcome on long-form.

**Flourish picks:** Drop Cap · Kicker · Pull Quote

---

### 3. Neo-Brutalist

**Feel:** Hard-edged, honest, direct. No softening. High-contrast, chunky, almost aggressive in its indifference to trend.

**Color ramp:** `#ffffff` · `#f5f5f5` · `#d4d4d4` · `#a3a3a3` · `#737373` · `#404040` · `#262626` · `#171717` · `#0a0a0a` · `#000000`
**Accents:** yellow `#facc15` · red `#ef4444` · blue `#2563eb`

**Type:**
- Headline: `"Archivo Black"` 400, letter-spacing -0.01em, UPPERCASE acceptable
- Body: `Inter` 500, line-height 1.5
- Mono: `"Space Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 34 · 56
- Google Fonts: `Archivo+Black&family=Inter:wght@400;500;700&family=Space+Mono:wght@400;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 40 · 56 · 80
**Radius:** 0 · 0 · 2 · 4 (mostly angular)
**Shadow:** offset-solid, not blurred. L1 `3px 3px 0 #000` · L2 `5px 5px 0 #000` · L3 `8px 8px 0 #000` · L4 `12px 12px 0 #000`
**Motion:** `linear` · 80 / 150 / 300ms (abrupt)

**Rules:**
- Solid offset drop shadows (never soft-blurred) are a signature.
- Uppercase headings welcome. Monospace kickers welcome.
- Borders are 2-3px and black.
- One accent color used aggressively (yellow or red) — restraint is the enemy.
- Zero gradients. Zero corners above 4px. Zero smooth easing.
- Underlines on active nav items — skeuomorphic web.

**Flourish picks:** Offset Box Shadow · Uppercase Kicker · Thick Rule

---

### 4. Warm Minimal

**Feel:** Muted earth tones, generous whitespace, serif revival. Calm, upscale, nothing loud.

**Color ramp:** `#fafaf9` · `#f5f5f4` · `#e7e5e4` · `#d6d3d1` · `#a8a29e` · `#78716c` · `#57534e` · `#44403c` · `#292524` · `#1c1917`
**Accents:** mint-gray `#5b8c7a` · caramel `#d4a373` · muted blue `#5b7b9a`

**Type:**
- Headline: `"Inter Tight"` 600, letter-spacing -0.015em
- Body: `Inter` 400, line-height 1.6
- Mono: `"JetBrains Mono"` 400
- Scale: 12 · 14 · 15 · 19 · 26 · 38
- Google Fonts: `Inter+Tight:wght@500;600&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400`

**Spacing:** 4 · 8 · 12 · 20 · 28 · 40 · 56 · 80 · 112 (generous)
**Radius:** 8 · 12 · 18 · 28
**Shadow:** soft, large spread. L1 `0 1px 3px rgba(28,25,23,.04)` · L2 `0 4px 16px rgba(28,25,23,.05)` · L3 `0 12px 32px rgba(28,25,23,.06)` · L4 `0 24px 56px rgba(28,25,23,.08)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 200 / 350 / 500ms

**Rules:**
- Desaturated palette only.
- Generous whitespace — minimum 24px padding on containers.
- Soft shadows with large spread, low opacity.
- Off-black text (#1c1917), never pure black.
- One muted accent color per view.

**Flourish picks:** Kicker · Rule Line · Small-Caps Label

---

### 5. Technical Documentary

**Feel:** Dense, authoritative, information-first. Feels like serious reference material. Heavy on tables, lists, code.

**Color ramp:** `#f8fafc` · `#f1f5f9` · `#e2e8f0` · `#cbd5e1` · `#94a3b8` · `#64748b` · `#475569` · `#334155` · `#1e293b` · `#0f172a`
**Accents:** link `#0284c7` · success `#059669` · warning `#d97706` · danger `#dc2626`

**Type:**
- Headline: `Inter` 700, letter-spacing -0.015em
- Body: `Inter` 400, line-height 1.55
- Mono: `"IBM Plex Mono"` 400 — code is first-class
- Scale: 12 · 14 · 16 · 20 · 26 · 36
- Google Fonts: `Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 2 · 4 · 6 · 8
**Shadow:** rarely used — prefer borders + spacing. L1 `0 1px 0 rgba(15,23,42,.05)` · L2 `0 1px 2px rgba(15,23,42,.06)` · L3 `0 2px 4px rgba(15,23,42,.08)` · L4 `0 4px 8px rgba(15,23,42,.10)`
**Motion:** `ease` · 80 / 140 / 220ms

**Rules:**
- Inline code, tables, and definition lists are native.
- Accent color used ONLY for links and semantic indicators.
- High information density is a feature, not a bug.
- Code blocks are UI, not afterthoughts.
- Tables have zebra stripes; headers are bolded not uppercased.

**Flourish picks:** Inline Code · Rule Line · Small-Caps Label

---

### 6. Monochrome

**Feel:** Pure black and white. Uncompromising. Type is everything.

**Color ramp:** `#ffffff` · `#fafafa` · `#e5e5e5` · `#d4d4d4` · `#a3a3a3` · `#737373` · `#404040` · `#262626` · `#171717` · `#000000`
**Accents:** none — mono stays mono. Optional single accent at user request.

**Type:**
- Headline: `"SF Mono"`/`"JetBrains Mono"` 500, letter-spacing 0
- Body: `"SF Mono"`/`"JetBrains Mono"` 400, line-height 1.55
- Mono: same
- Scale: 12 · 14 · 16 · 20 · 28 · 40
- Google Fonts: `JetBrains+Mono:wght@400;500;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 0 · 0 · 2 · 4
**Shadow:** L1 `0 1px 0 rgba(0,0,0,.1)` · L2 `0 2px 0 rgba(0,0,0,.15)` · L3 `0 4px 0 rgba(0,0,0,.2)` · L4 `0 8px 0 rgba(0,0,0,.25)`
**Motion:** `linear` · 100 / 200 / 400ms

**Rules:**
- Pure mono — no color accents.
- All text in a monospace family.
- Borders are 1px solid #000 or #e5e5e5.
- Headings differentiated by weight, not color.
- Use `_` or `-` as visual separators in labels.

**Flourish picks:** ASCII Divider · Small-Caps Label · Inline Code

---

### 7. Glassmorphic

**Feel:** Translucent, depth-rich, atmospheric. Depth via layered translucency.

**Color ramp:** `#fafafa` · `rgba(255,255,255,.6)` · `rgba(255,255,255,.4)` · `#e5e7eb` · `#9ca3af` · `#6b7280` · `#4b5563` · `#374151` · `#1f2937` · `#0f1419`
**Accents:** coral `#ff8a65` · sky `#60a5fa` · lilac `#c4b5fd` (all at .5 alpha)

**Type:**
- Headline: `Inter` 600, letter-spacing -0.015em
- Body: `Inter` 400, line-height 1.5
- Mono: `"SF Mono"` fallback to `Menlo` 400
- Scale: 12 · 14 · 16 · 20 · 28 · 44
- Google Fonts: `Inter:wght@400;500;600;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 112
**Radius:** 10 · 16 · 24 · 36 (soft, bubble-like)
**Shadow:** L1 `0 2px 8px rgba(0,0,0,.04)` · L2 `0 4px 16px rgba(0,0,0,.06)` · L3 `0 8px 32px rgba(0,0,0,.08)` · L4 `0 16px 48px rgba(0,0,0,.10)` — paired with `backdrop-filter: blur(...)`
**Motion:** smooth-springy · 180 / 300 / 500ms

**Rules:**
- Surfaces use `backdrop-filter: blur(20-40px)` with translucent bg.
- Behind every glass panel: a colorful gradient or vibrant content.
- Borders are `rgba(255,255,255,.3)` — glass rim.
- Text solid colors — never translucent text.
- One glass layer per view — stacking destroys the effect.

**Flourish picks:** Gradient Backdrop · Glass Rim · Soft Glow

---

### 8. Neo-Classical

**Feel:** Serif-heavy, restrained, editorial-adjacent. Prestige-media feel. Warm neutrals, grand vertical rhythm.

**Color ramp:** `#faf9f7` · `#f2ece0` · `#e4d9c5` · `#c4b195` · `#96825c` · `#6b5a38` · `#4c3f24` · `#332a18` · `#1f1a10` · `#0f0c08`
**Accents:** jewel red `#8c1c13` · forest `#2d4a2a` · deep blue `#1e3a5f`

**Type:**
- Headline: `"Playfair Display"` 700, italic variants welcome
- Body: `Lora` 400, line-height 1.65
- Display alt: `Spectral` 400 for lead-ins
- Scale: 13 · 15 · 18 · 24 · 34 · 52
- Google Fonts: `Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&family=Lora:ital,wght@0,400;0,500;1,400&family=Spectral:wght@400;500`

**Spacing:** 4 · 8 · 12 · 18 · 28 · 44 · 68 · 100 · 144 (grand)
**Radius:** 0 · 2 · 4 · 6 (nearly angular)
**Shadow:** barely used. L1 `0 1px 1px rgba(15,12,8,.04)` · L2 `0 2px 4px rgba(15,12,8,.06)` · L3 `0 4px 12px rgba(15,12,8,.08)` · L4 `0 10px 24px rgba(15,12,8,.10)`
**Motion:** slow · 200 / 400 / 600ms (deliberate)

**Rules:**
- Display italics on headlines are a signature.
- Small caps for navigation and labels.
- Horizontal rules (hairline, sometimes doubled) as dividers.
- Drop caps welcome for long-form.
- Generous vertical rhythm; section spacing is grand.
- Minimal color — serif typography carries voice.

**Flourish picks:** Drop Cap · Small-Caps Label · Doubled Rule

---

### 9. Warm Handmade

**Feel:** Crafted, personal, small-batch. Made by one person who cared. Slightly imperfect by design.

**Color ramp:** `#f7f4ed` · `#eee7d8` · `#dcc9a5` · `#c4a574` · `#9c7f4f` · `#6b5538` · `#4a3b28` · `#33281b` · `#211a12` · `#13100a`
**Accents:** berry `#7c2d12` · sage `#5f7c3e` · dusty blue `#4a6978`

**Type:**
- Headline: `Fraunces` 600 (opsz friendly)
- Body: `Spectral` 400, line-height 1.65
- Mono: `"Cascadia Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 30 · 46
- Google Fonts: `Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Spectral:wght@400;500;600`

**Spacing:** 4 · 8 · 12 · 18 · 26 · 38 · 56 · 84 · 120 (organic)
**Radius:** 4 · 8 · 14 · 22 (friendly, not bubbly)
**Shadow:** warm-tinted. L1 `0 1px 3px rgba(107,85,56,.08)` · L2 `0 3px 10px rgba(107,85,56,.10)` · L3 `0 8px 20px rgba(107,85,56,.12)` · L4 `0 14px 32px rgba(107,85,56,.14)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 160 / 280 / 440ms

**Rules:**
- Off-center, slightly asymmetric layouts welcome.
- Warm earth palette only — no cool colors.
- A single hand-drawn flourish per view (squiggle underline, arrow).
- Line-heights generous (1.6-1.7).
- Section dividers hairline or dotted, never bold.

**Flourish picks:** Grain Texture · Squiggle Underline · Pull Quote

---

### 10. Kinetic Modern

**Feel:** Motion-forward, vivid, alive. Crisp geometry with energy underneath. Feels recent, capable, deliberate.

**Color ramp:** `#fafbff` · `#f0f3ff` · `#d6dcff` · `#b0bcff` · `#7f92ff` · `#4f6bff` · `#3b4dcc` · `#29368f` · `#161d4a` · `#0a0e24`
**Accents:** lime `#a3e635` · coral `#fb7185` · cyan `#22d3ee`

**Type:**
- Headline: `"Space Grotesk"` 700, letter-spacing -0.02em
- Body: `Inter` 400, line-height 1.55
- Mono: `"JetBrains Mono"` 500
- Scale: 12 · 14 · 16 · 22 · 32 · 48
- Google Fonts: `Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 6 · 10 · 14 · 20
**Shadow:** colored, subtle. L1 `0 2px 6px rgba(79,107,255,.10)` · L2 `0 4px 12px rgba(79,107,255,.14)` · L3 `0 8px 24px rgba(79,107,255,.20)` · L4 `0 16px 40px rgba(79,107,255,.28)`
**Motion:** `cubic-bezier(.5,1.5,.5,1)` (springy) · 140 / 240 / 380ms

**Rules:**
- Hover / focus states include visible motion.
- Accent colors as spot highlights — never main body color.
- Geometric shapes (circles, pills, diagonal stripes) as decorative accents.
- High contrast; dark background variant default-ready.

**Flourish picks:** Animated Underline · Geometric Accent · Colored Glow

---

### 11. Academic

**Feel:** Old-textbook, scholarly. Classic serif, disciplined layout, functional decoration.

**Color ramp:** `#fbfaf6` · `#f2ede0` · `#e2d9c2` · `#bfa981` · `#8a7547` · `#5a4a2a` · `#3f331c` · `#2a2114` · `#1a140c` · `#0d0a07`
**Accents:** ink blue `#1e3a5f` · burgundy `#7c1d2e` · forest `#2d4a2a`

**Type:**
- Headline: `Georgia`/`"Iowan Old Style"` serif 700
- Body: `Georgia` 400, line-height 1.7
- Mono: `"Courier New"` 400
- Scale: 12 · 14 · 16 · 20 · 26 · 38
- Google Fonts: (uses system serifs, optionally load `Lora`)

**Spacing:** 4 · 8 · 12 · 16 · 24 · 36 · 56 · 84 · 120
**Radius:** 0 · 2 · 4 · 4
**Shadow:** not used.
**Motion:** slow · 200 / 400 / 600ms

**Rules:**
- Traditional page layout — centered columns, wide margins.
- Small caps for section labels.
- Footnote-style indicators (superscript numbers).
- No gradients, no shadows, no rounded corners above 4px.
- Hairline rules between sections.

**Flourish picks:** Drop Cap · Footnote Marker · Small-Caps Label

---

### 12. Luxury Serif

**Feel:** Dark, upscale, gold-accented. Fashion-editorial. High-contrast, serif display.

**Color ramp:** `#1a1a1a` · `#232323` · `#2e2e2e` · `#3f3f3f` · `#5e5e5e` · `#8a8a8a` · `#b4b4b4` · `#d6d6d6` · `#ededed` · `#ffffff`
**Accents:** gold `#d4af37` · champagne `#e8c87a` · deep red `#8b1a1a`

**Type:**
- Headline: `"Bodoni Moda"`/`"Playfair Display"` 700, letter-spacing -0.01em, ALL CAPS welcome
- Body: `"Cormorant Garamond"` 400, line-height 1.65
- Scale: 12 · 14 · 16 · 22 · 34 · 60
- Google Fonts: `Bodoni+Moda:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;1,400`

**Spacing:** 4 · 8 · 12 · 20 · 32 · 48 · 72 · 108 · 160 (grand)
**Radius:** 0 · 0 · 0 · 2 (angular)
**Shadow:** gold-tinted. L1 `0 1px 2px rgba(212,175,55,.08)` · L2 `0 2px 8px rgba(0,0,0,.25)` · L3 `0 4px 16px rgba(0,0,0,.35)` · L4 `0 8px 32px rgba(0,0,0,.45)`
**Motion:** slow elegant · 240 / 480 / 720ms

**Rules:**
- Dark background; gold accent used sparingly.
- All-caps display headlines with wide tracking.
- High-contrast serifs (Bodoni) for drama.
- Minimal chrome — let type + gold do the work.
- Hairline gold rules as dividers.

**Flourish picks:** Gold Hairline · Ornament Divider · All-Caps Kicker

---

## SIGNATURE FLOURISH LIBRARY

Ten flourish types. Each has: default CSS + per-tradition variant if needed + HTML insertion hook.

### Drop Cap
```css
.vd-dropcap { float: left; font-family: var(--headline); font-size: 3.5em; line-height: 0.85; padding: 0.12em 0.15em 0 0; color: var(--accent); }
```
**Insertion:** wrap first letter of the first `<p>` after each `<h1>` in `<span class="vd-dropcap">`.
**Fits:** Editorial, Neo-Classical, Warm Handmade, Academic, Luxury Serif.

### Kicker
```css
.vd-kicker { font-family: var(--body); font-size: .75em; font-weight: 700; letter-spacing: .15em; text-transform: uppercase; color: var(--accent); margin-bottom: .4em; }
/* Editorial variant: italic instead of uppercase */
.vd-kicker--editorial { font-style: italic; font-weight: 600; text-transform: none; }
```
**Insertion:** prepend `<span class="vd-kicker">[section number or label]</span>` to each h2.
**Fits:** everything. Default flourish.

### Rule Line
```css
.vd-rule { border: none; border-top: 1px solid var(--ink-3); margin: 1.5em 0; }
/* Doubled (Neo-Classical): */
.vd-rule--double { border-top: 1px solid var(--ink-3); border-bottom: 1px solid var(--ink-3); height: 3px; background: transparent; }
/* Thick (Neo-Brutalist): */
.vd-rule--thick { border-top: 3px solid var(--ink-900); }
```
**Insertion:** add `<hr class="vd-rule">` between major sections.
**Fits:** Swiss, Technical, Academic, Neo-Classical, Neo-Brutalist.

### Grain Texture
```css
.vd-grain { background-image: radial-gradient(rgba(0,0,0,.12) 0.5px, transparent 0.5px); background-size: 3px 3px; }
```
**Insertion:** apply `.vd-grain` to the body or main container as an overlay.
**Fits:** Warm Handmade, Editorial, Warm Minimal.

### Pull Quote
```css
.vd-pullquote { border-left: 4px solid var(--accent); padding: .5em 1em; font-family: var(--headline); font-style: italic; font-size: 1.2em; color: var(--ink-2); margin: 1.5em 0; }
```
**Insertion:** wrap selected long `<p>` in `<blockquote class="vd-pullquote">`.
**Fits:** Editorial, Neo-Classical, Warm Handmade, Luxury Serif.

### Ornament Divider
```css
.vd-ornament { text-align: center; color: var(--accent); letter-spacing: .3em; font-size: 1.2em; margin: 2em 0; }
.vd-ornament::before { content: "✦  ❋  ✦"; }
/* Luxury variant: */
.vd-ornament--luxury::before { content: "◆  ◆  ◆"; color: var(--accent-gold); }
```
**Insertion:** replace `<hr>` or insert between major sections.
**Fits:** Warm Handmade, Luxury Serif, Neo-Classical, Editorial.

### Small-Caps Label
```css
.vd-smcp { font-variant: small-caps; letter-spacing: .1em; font-weight: 700; color: var(--accent); }
```
**Insertion:** wrap nav items, metadata, bylines in `<span class="vd-smcp">`.
**Fits:** Swiss, Technical, Academic, Neo-Classical, Luxury Serif, Warm Minimal.

### Offset Box Shadow
```css
.vd-offset { box-shadow: 5px 5px 0 var(--ink-900); border: 2px solid var(--ink-900); }
```
**Insertion:** apply to cards, buttons, callout blocks.
**Fits:** Neo-Brutalist exclusively — signature of that tradition.

### ASCII Divider
```css
.vd-ascii { font-family: var(--mono); color: var(--ink-3); white-space: pre; text-align: center; margin: 1.5em 0; }
.vd-ascii::before { content: "- - - - - - - - - -"; }
```
**Insertion:** between sections, replacing `<hr>`.
**Fits:** Monochrome, Technical, Neon Terminal.

### Inline Code Accent
```css
code { font-family: var(--mono); background: var(--ramp-100); padding: .15em .4em; border-radius: 3px; font-size: .9em; color: var(--accent); }
```
**Insertion:** style any existing `<code>` tags — no DOM insertion needed.
**Fits:** Technical, Monochrome, Neo-Brutalist.

---

## HTML DECISION PAGE TEMPLATE

Each step generates a decision HTML file. Use a consistent shell with per-step variations.

### Shell skeleton (applies to all 5 step pages)

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Visual Design · Step [N] · [StepName]</title>
<style>
  :root {
    --page-bg: #faf8f4;
    --page-ink: #1a1714;
    --page-ink-2: #4a433b;
    --page-ink-3: #7a7066;
    --page-rule: #d8cfbf;
    --page-accent: #9a3412;
    --page-accent-soft: #fef3e8;
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: -apple-system, BlinkMacSystemFont, "Inter", sans-serif; background: var(--page-bg); color: var(--page-ink); padding: 48px 32px; line-height: 1.6; }
  .page { max-width: 1100px; margin: 0 auto; }
  .eyebrow { font-family: ui-monospace, "SF Mono", monospace; font-size: 11px; letter-spacing: 0.18em; text-transform: uppercase; color: var(--page-accent); margin-bottom: 20px; }
  h1 { font-family: "Iowan Old Style", Palatino, Georgia, serif; font-size: 44px; font-weight: 400; letter-spacing: -0.015em; margin-bottom: 16px; }
  .deck { font-family: "Iowan Old Style", Palatino, Georgia, serif; font-style: italic; font-size: 18px; color: var(--page-ink-2); max-width: 720px; margin-bottom: 40px; }
  /* Step-specific styles follow here */
</style>
</head>
<body>
<div class="page">
  <div class="eyebrow">Step [N] of 5 · [StepName]</div>
  <h1>[Decision question]</h1>
  <p class="deck">[Plain-English framing — 1 sentence]</p>
  [STEP-SPECIFIC CONTENT]
  <div class="footer">[instruction on how to respond]</div>
</div>
</body>
</html>
```

### Step 1 (Tradition) — structure

- Section A: "Matched for your artifact" — 3 large tiles (160px × 100px each), horizontal row. Each renders the tradition name in the tradition's own type + color + bg.
- Section B: "Browse all" — flat grid, 5 columns × N rows of small tiles (56-64px). Each tile = name in the tradition's type-forward thumbnail style.
- Footer: "Reply with a tradition name (e.g., `Editorial`) or `A`/`B`/`C` for one of the top 3 matches."

### Step 2/3/4 (Color/Type/Mood) — structure

- 4 option cards, 2×2 grid. Each card has:
  - Letter badge (A/B/C/D)
  - Short title ("Faithful", "Warmer", "Higher contrast", etc.)
  - Visual preview rendered with the variant's tokens
  - 1-line description
- Recommended badge on one card (usually A or the tradition-default).
- Footer: "Reply with `Option A`, `A`, or `Option A but [modification]`."

### Step 5 (Flourish) — structure

- Section A: "✦ Fits [Tradition] best" — 3 curated flourish tiles. Each tile renders the flourish *applied to the tradition*, with the flourish name labeled.
- Section B: "Full library" — all ~10 flourishes as smaller tiles, flat grid.
- Include a "None" tile at the end of both sections for users who want no flourish.
- Footer: "Reply with a flourish name (e.g., `Drop Cap`) or `none`."

### Run summary page (`index.html`)

Mirror the decision-hub style used elsewhere in the decision-kit (serif display, mono kickers, warm paper bg). Shows:
- The 5 locked choices
- The final resolved aesthetic summary
- Links to each decision page
- Links to the original + styled artifact

---

## EDGE CASES

**Target file has no `<style>` block:** Inject one inside `<head>` with the full resolved stylesheet. All selectors still match.

**Target file uses external CSS (`<link rel="stylesheet">`):** Convert to inline — fetch the external CSS, rewrite selectors, inline into the `.styled.html`. If external CSS is unreachable (remote, 404), tell the user and skip the file.

**Target file is HTML with embedded `<script>`:** Preserve all scripts. The skill only touches styles and minimal DOM for flourish hooks.

**Target file is already a `.styled.html`:** Ask if the user wants to re-skin it (changing aesthetic) or start over (forgetting the prior aesthetic). If re-skin: use the existing `.styled.html` as the source, write a new `<name>.styled.html` overwriting prior styled version, update tokens.json.

**Tradition not found (typo):** Show 3 closest matches numbered, ask which.

**User says `redo` after the output:** Delete the `.styled.html`, re-run from Phase 1 with the same target.

**User says `change [step]`:** Jump to that step's decision page, re-run from there. Downstream choices stay unless they conflict.

**No artifact type detected confidently:** Use `brief` as the fallback for type inference.

---

## IMPORTANT REMINDERS

1. **Never skip a decision step.** The user invoked `/visual-design` because they want to *think through* the aesthetic. Fast ≠ skipped. Each step gets its own HTML page with options.
2. **Always open the file after writing.** `open .decisions/visual-design/0N-<step>.html`. User needs to see what you've generated.
3. **Wait for the user at every step.** Don't proceed until they've picked.
4. **Preserve the original.** Never overwrite the target. Always write `.styled.html` alongside.
5. **Plain English.** Option descriptions talk about feel and audience, not tokens. Save the JSON for the tokens file.
6. **Tokens.json is sacred.** It's what makes the skill compound across artifacts. Write it every run. Respect existing ones as suggestion #1.
7. **Flourish is the hero step.** Step 5 is what separates generic from characterful. Don't treat it as a throwaway.
8. **Fuzzy match is friendly.** Accept typos, partial names, abbreviations (`brutal` → Neo-Brutalist). If truly ambiguous, show numbered candidates.
9. **Respect existing aesthetic.** If the target artifact already uses a well-known tradition (detect by font family hints), suggest that tradition as match #1.
10. **Add to `.gitignore`.** First time `.visual-design/` is created in a project, append a line to `.gitignore` (create if missing).
