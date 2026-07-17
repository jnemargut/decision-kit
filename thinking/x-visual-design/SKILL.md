---
name: x-visual-design
description: "Experimental v2 of /visual-design. Re-skin any existing HTML artifact or SVG with a chosen aesthetic — same 6-step flow (tradition, composition, color, type, mood, flourish) for HTML, 3-step for SVG, same banned-defaults list and critique gate — plus: previews rendered from YOUR artifact's actual content instead of generic samples, a Three Takes mode ('3 takes' spawns parallel agents that each produce a complete styled variant to pick from), an eyes-on critique gate that screenshots and visually inspects the result, and a side-by-side compare page. Use AFTER producing an artifact that looks visually generic."
---

# Visual Design X (v2)

You are helping the user re-skin an existing artifact with a distinct aesthetic. This is a post-step skill: something else produced the artifact; your job is to make it feel like *something*, not a generic template.

**What's new in v2 (applies throughout the flow below):**

1. **Artifact-native previews.** At every A/B/C/D step (Composition, Color, Type, Mood — and Stroke/Color in SVG mode), option previews are built from the *user's actual artifact*: its real headline, its real first section or hero, its real table/card content — with the candidate tokens applied. Never generic sample text like "Realistic headline" when the artifact's own words are available. The user should be choosing between four versions of *their thing*, not four abstract swatches. (Step 1's type-forward tradition tiles stay as-is — one word in each tradition's voice is the right form there.)
2. **Three Takes mode.** If the user's invocation contains `3 takes`, `three takes`, or `--takes` (or they ask for it at any point): skip the step-by-step flow. Score traditions as in Phase 3, take the top 3 matches, and spawn **3 parallel subagents** (one Agent call each, all in one message). Each agent receives: the artifact path + analysis, ONE assigned tradition, and instructions to run the full pipeline solo — resolve tokens (tradition defaults for composition/color/type/mood + its best-fit flourish), generate the stylesheet honoring `references/banned-defaults.md`, and write `<name>.take-N-<tradition-slug>.html`. When all three return, run the critique gate on each, build a picker page `.decisions/visual-design/takes.html` (three iframe columns, tradition names + one-line rationale, "Reply 1, 2, or 3 — or 'refine 2' to enter the step-by-step flow starting from take 2's choices"), open it, and wait. On pick: promote that take to `<name>.styled.html`, write tokens.json, delete the other takes (mention it). On "refine N": enter the normal flow at Step 2 with take N's tradition locked.
3. **Eyes-on critique gate.** When the critique gate (Phase 5) renders a screenshot, **Read the screenshot image and judge it with your own eyes** against the rubric — don't reason only from the CSS. What looks broken beats what should work.
4. **Compare page.** The final output includes `.decisions/visual-design/compare.html` — original and styled side by side in two iframes with a labeled header — so "before vs after" is one file.
5. **Calibrated recommendation.** The recommended tradition/option comes with a confidence read: when it's a genuine toss-up between two traditions, say so and name the condition that decides it ("Editorial if this brief is mostly read; Swiss if it's mostly scanned").
6. **Profile awareness.** If `.decisions/profile.json` exists (from /whoiam), calibrate option descriptions to the user's role — a designer gets type talk, a non-designer gets feel-and-audience talk.

The skill supports two modes based on the input file:
- **HTML mode** (`.html` input) — 6-step flow: **Tradition → Composition → Color → Type → Mood → Signature Flourish**. Rewrites the `<style>` block, including CSS-only layout art direction.
- **SVG mode** (`.svg` input) — 3-step flow: **Tradition → Stroke → Color**. Rewrites stroke/fill attributes on paths. For icons, logos, and illustrations.

The skill ships with shared design DNA in `references/` (synced from the repo's `shared/design-dna/` — edit there, not here):
- `references/banned-defaults.md` — the "never do" list every output must pass
- `references/font-pool.md` — the characterful font supply and uniqueness rules
- `references/composition-signatures.md` — eight CSS-only layout signatures
- `references/critique-gate.md` — the render-and-critique gate run before any output ships
- `references/traditions.md` + `references/flourishes.md` — the libraries (formerly inline)

The user invokes `/visual-design [optional path to .html or .svg]`. Original is preserved; a new `<name>.styled.html` or `<name>.styled.svg` is written alongside, and `.visual-design/tokens.json` captures the decisions for reuse in the project.

**Core principles:**
- Write in plain English. Talk like a designer who cares, not a form-builder.
- Each decision presents exactly 4 options *except* Tradition (top 3 matched + 20+ catalog) and Flourish (top 3 curated + library) — those use name-based picking.
- Always include a recommendation.
- Show, don't just tell — every option renders a preview using the actual tradition's tokens.
- Nothing banned ships. Every output passes the checks in `references/banned-defaults.md` and the critique gate in `references/critique-gate.md` before the user sees it.
- The skill's job ends when the styled file and `tokens.json` are on disk, the critique gate has passed, and the result is opened for the user.

---

## AUTO-MODE OVERRIDE (applies if /autodecide was used)

**Detection:** Auto-mode applies if EITHER:

- `$ARGUMENTS` contains a `[Auto directive: ...]` block (injected by the `/autodecide` orchestrator), OR
- `$ARGUMENTS` starts with `/autodecide` (direct invocation modifier — the user typed `/visual-design /autodecide [path]`)

In the second case, strip `/autodecide` from the args before treating the rest as the path/argument for the skill. Note: visual-design has a fixed decision count per mode (6 for HTML, 3 for SVG), so depth modifiers (`/overdecide`, `/underdecide`) don't apply here — strip them if present and ignore.

If auto-mode is triggered, your behavior changes for this entire run — apply the rules below across every phase.

**What changes:**

1. **Per-decision pauses are skipped.** For each aesthetic decision in your flow (HTML mode: Tradition → Composition → Color → Type → Mood → Flourish; SVG mode: Tradition → Stroke → Color): generate the full HTML decision page exactly as normal — option previews using the actual tradition's tokens, recommendation, comparison. Save it. Record the decision in `.decisions/decisions.json` (or your equivalent decision log) with `status: "auto-picked"` and `chosen` set to the recommended option (capture the recommendation reasoning in the `reasoning` field, prefixed with "Auto-picked: "). Do NOT `open` the file. Do NOT pause. Immediately proceed to the next decision.

2. **Generate `.decisions/auto-review.html` after all aesthetic decisions are picked.** This is the ONE pause point in auto mode. A single page listing every auto-picked aesthetic decision in a scannable layout. For each row, show: decision number, decision title (e.g. "Tradition", "Color"), the chosen option (label + summary or token preview), the other options as one-line summaries, and the AI's reasoning. Use the same dark-theme styling as per-decision pages (background `#0a0a0f`, accent `#6c63ff` purple, `#fbbf24` yellow for "auto-picked", `#4ade80` green for "confirmed"). Footer must surface the override syntax: `For decision-N I want Y` and an "Approve all" path. Open it with `open .decisions/auto-review.html`.

3. **Tell the user.** Output: "Auto-picked all N aesthetic decisions. Review at .decisions/auto-review.html. Confirm with 'looks good' or override with 'For decision-N I want Y'."

4. **Wait for the user's response.** This is the only pause in auto mode.

**On user response:**

- **"Looks good" / "Confirm" / "Approved" / similar** → Transition every `auto-picked` decision to `status: "chosen"`. Update the auto-review page rows to the green "confirmed" state. Then proceed to the styled-file generation step normally — apply all chosen tokens, write `<name>.styled.html` or `<name>.styled.svg` and `tokens.json`, and open the result.
- **"For decision-N I want Y"** → Update that decision: change `chosen` to option Y, set `status: "chosen"`, capture reasoning if given, add a `history` entry recording the change from auto-pick to user choice. Regenerate `auto-review.html`. Re-prompt for confirmation of the remaining auto-picks. Repeat until the user confirms.
- **"Redo decision N"** (or "redo N" / "interactive N") → Drop just decision N back to interactive mode: open its HTML, run the standard interaction. After they pick, return to the auto-review pause for the rest.
- **Custom answer** → Standard custom-answer handling: generate a custom option card (or use the user's named tradition/color/etc.), regenerate auto-review.

**Note on Tradition and Flourish:** these decisions don't follow the strict 4-option pattern (they use top-3-matched + catalog/library). In auto mode, auto-pick the **top match** (the highest-ranked recommendation) for each. The user can still override to any catalog item via the standard syntax.

**Note on depth directives:** visual-design has a fixed decision count per mode (6 for HTML, 3 for SVG), so any `[Depth directive: ...]` from `/overdecide` or `/underdecide` does not apply here — auto-mode runs the standard count.

**Schema:** `auto-picked` is a third valid value for the `status` field, alongside `pending` and `chosen`. The styled file must not be written until every aesthetic decision has transitioned from `auto-picked` to `chosen`.

**Critical invariant:** Do NOT write the styled file (`.styled.html`/`.styled.svg`) or `tokens.json` until every decision has transitioned from `auto-picked` to `chosen`. The batch-review pause is the gate.

---

## PHASE 1 — Invocation

### Step 1a — Parse the argument + detect mode

The user invokes `/visual-design [path]` where `[path]` is optional.

**If a path is provided:**
- Verify the file exists.
- Branch on extension:
  - `.html` → set `MODE = "html"`, `TARGET = path`, proceed to Phase 2.
  - `.svg` → set `MODE = "svg"`, `TARGET = path`, proceed to Phase 2.
  - `.png` / `.jpg` / `.jpeg` / `.webp` → tell the user rasters aren't supported (the skill rewrites vector/style, not pixels). Suggest they convert to SVG or provide an HTML wrapper. Stop.
  - Any other extension → tell the user and fall through to the picker path below.

**If no path is provided:**
- Glob for recent styleable artifacts in priority order:
  1. `.decisions/*.html` (most common — decision-kit outputs)
  2. `*.{html,svg}` in cwd
  3. `**/*.{html,svg}` up to 2 levels deep (excluding `node_modules`, `dist`, `.git`)
- Sort results by modification time (newest first).
- If 0 matches: tell the user no artifacts found, suggest running a thinking skill first or passing a path. Stop.
- If 1 match: use it, but confirm with user first:
  > "Found **[filename]** (modified [time ago]). Re-skin this one? Reply `yes` or pass a different path."
- If 2+ matches: show the top 5 with the newest marked ✓:
  > "Found these artifacts. Which one do you want to re-skin?
  >   1. ✓ strategy-brief.html   (2 min ago)
  >   2. icon-download.svg        (1 hr ago)
  >   3. proposal.html            (yesterday)
  > Reply with a number, a filename, or paste a different path."

Once confirmed, set `MODE` from the extension. Wait for confirmation before proceeding.

### Step 1b — Check for project memory

Once `TARGET` is set, check for `.visual-design/tokens.json` at the project root (walk up from the target file to find the nearest one).

- **If present:** parse it. Note the previous tradition + flourish. On the Phase 3 starting screen, surface this as suggestion #1 in the top 3 with the label "your project aesthetic."
- **If absent:** normal flow — skill will create the `.visual-design/` directory later.

### Step 1c — Create `.decisions/` working directory for this run

Create `.decisions/visual-design/` at the project root. Per-step decision pages for this invocation go here.

**HTML mode output:**
- `01-tradition.html`
- `02-composition.html`
- `03-color.html`
- `04-type.html`
- `05-mood.html`
- `06-flourish.html`
- `index.html` (run summary)

**SVG mode output:**
- `01-tradition.html`
- `02-stroke.html`
- `03-color.html`
- `index.html` (run summary)

These let the user revisit their aesthetic decisions later.

---

## PHASE 2 — Artifact Analysis

Analysis branches on `MODE`.

### Phase 2 — HTML mode

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
  "mode": "html",
  "type": "brief",
  "wordCount": 2400,
  "headings": { "h1": 1, "h2": 6, "h3": 3 },
  "hasTables": true,
  "hasCode": false,
  "selectors": [".page", ".option", ".footer", ".research", "h1.title", ".deck", "..."]
}
```

### Phase 2 — SVG mode

Read the target SVG file. Extract:

1. **ViewBox and dimensions** — `viewBox`, `width`, `height` attributes on the root `<svg>` element.
2. **Shape inventory** — count of `<path>`, `<circle>`, `<rect>`, `<line>`, `<polygon>`, `<polyline>`, `<ellipse>`. Note which primitives dominate.
3. **Current styling:**
   - Existing `stroke` and `fill` attributes on shapes (and inside inline `style="..."`)
   - Existing `stroke-width` values
   - Any embedded `<style>` tag inside the SVG
   - Any `<defs>` (gradients, filters, patterns) that will need to be updated or preserved
4. **Color count** — how many distinct colors are used? (1 = single-color, 2-3 = duotone/limited, 4+ = multi-color illustration)
5. **Infer asset type** — one of:
   - `icon` — small viewBox (≤64), 1-2 colors, outline-style (no fill or single fill)
   - `logo` — small-medium viewBox, branded colors, mixed stroke/fill
   - `illustration` — larger viewBox, 4+ colors, complex shapes
   - `glyph` — path-only, single color, no stroke (text-like)

Example:

```json
{
  "target": "icons/download.svg",
  "mode": "svg",
  "type": "icon",
  "viewBox": "0 0 24 24",
  "shapes": { "path": 3, "circle": 0, "rect": 0 },
  "colorCount": 1,
  "currentStroke": "currentColor",
  "currentFill": "none",
  "currentStrokeWidth": "2"
}
```

**Warn the user** if `type === "illustration"` and they've picked a tradition with single-color rules — multi-color illustrations may lose detail when flattened to a tradition's palette.

---

## PHASE 3 — Tradition Selection (Decision 1)

This is the first and biggest decision. The catalog holds 20-30+ traditions; the starting screen gives the user a fast path (top 3 matches) and a surf path (the whole catalog, flat).

### Step 3a — Score the traditions for this artifact

For each tradition in the library (see AESTHETIC TRADITIONS LIBRARY below), compute a fit score from the artifact type:

| Artifact type | Tradition affinities (highest fit first) |
|---------------|------------------------------------------|
| `brief` (HTML) | Editorial Print, Warm Minimal, Academic, Newsprint, Japandi, Neo-Classical, Botanical Herbarium, Swiss Modern |
| `landing` (HTML) | Neo-Brutalist, Kinetic Modern, Glassmorphic, Playful Maximalist, Y2K Maximalist, Memphis Revival, Retro Futurism, Swiss Modern |
| `doc` (HTML) | Technical Documentary, Swiss Modern, Monochrome, Academic, Dashboard Operator, Newsprint |
| `proposal` (HTML) | Editorial Print, Neo-Classical, Swiss Modern, Warm Minimal, Luxury Serif, Midnight Marine, Art Deco |
| `dashboard` (HTML) | Swiss Modern, Technical Documentary, Dashboard Operator, Kinetic Modern, Monochrome, Neon Terminal |
| `slide` (HTML) | Editorial Print, Neo-Brutalist, Luxury Serif, Kinetic Modern, Art Deco, Bauhaus Grid, Zine |
| `icon` (SVG) | Swiss Modern, Monochrome, Neo-Brutalist, Technical Documentary, Neon Terminal, Cyberpunk Neon, Dashboard Operator, Bauhaus Grid |
| `logo` (SVG) | Swiss Modern, Neo-Brutalist, Art Deco, Luxury Serif, Bauhaus Grid, Retro Futurism, Monochrome |
| `illustration` (SVG) | Warm Handmade, Sketchbook, Botanical Herbarium, Editorial Print, Memphis Revival, Kraft Paper, Playful Maximalist |
| `glyph` (SVG) | Monochrome, Swiss Modern, Neo-Brutalist, Art Deco, Luxury Serif, Academic |

**SVG-incompatible traditions** (warn user if they pick one for an SVG):
- **Glassmorphic** — requires backdrop-filter + layered translucency, meaningless on single-shape icons
- **Playful Maximalist** — gradients-as-default need careful per-shape handling, best for illustrations only
- **Anti-Design** — clashing-font premise doesn't apply to vectors without text

If the user picks one of these in SVG mode, offer a gentle "are you sure? here's what will change" note rather than blocking. The tradition will still resolve (color palette at least).

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

Once locked: set `TRADITION` in state, proceed to Step 3d.

### Step 3d — Calibrate with current references (optional but recommended)

Traditions are a stable grammar. The web has current examples. Combining the two gives you a library that never ages.

After `TRADITION` locks (and before presenting the Color/Type steps), fire 1-2 `WebSearch` queries targeting current real-world examples of this tradition. Good patterns:

- `"<tradition name> web design 2026 examples"`
- `"<tradition name> <artifact type> current trends"` (e.g., "editorial landing page current trends", "neo-brutalist SaaS site 2026")
- For SVG mode: `"<tradition> icon set current"` or `"<tradition> icons 2026"`

From the results, extract 1-3 concrete calibration signals:

- **Shifted accent hue** — is the current wave of this tradition trending warmer/cooler/more saturated? Capture 1-2 specific hex values from the examples.
- **Updated font weight or pairing** — did current examples swap the library's default for something fresher (e.g., Fraunces variable axis set to 144 instead of 96, or paired with Inter Tight instead of Inter)?
- **Trending treatment** — a new signature move the tradition is doing right now (e.g., current Editorial Print examples using big italic pull quotes; current Neo-Brutalist adding subtle grain behind offset shadows).

Store these as `CALIBRATION` in state alongside `TRADITION`. They'll show up in downstream decisions as a "2026 current" variant.

**Skip this step if:**
- Web is unavailable (offline, tool error)
- User said `use library defaults` or `skip calibration` at any prior step
- The tradition is intentionally era-specific and shouldn't track trends (Art Deco, Academic, Neon Terminal — these are stable by definition)

Don't let this step add more than ~5 seconds of latency. One search, extract, move on. If the search returns nothing useful, skip silently — the library defaults are still fine.

---

## PHASE 4 — Remaining Steps

The flow branches on `MODE`:
- **HTML mode** → 5 remaining steps (Composition, Color, Type, Mood, Signature Flourish), all A/B/C/D
- **SVG mode** → 2 remaining steps (Stroke, Color), all A/B/C/D

---

## PHASE 4 (HTML mode) — Steps 2-6

All five of these steps use the **A/B/C/D pattern** (standard thinking-skill convention). Each step:
1. Generates a decision HTML page with 4 options
2. Opens it in the browser
3. Waits for a letter-based response

**v2 — artifact-native previews at every step.** Wherever the step descriptions below say to render a preview (mini wireframe, mini-frame, styled headline + body, CTA + card + divider), source the content from the artifact analyzed in Phase 2: its actual h1 text, its actual first paragraph or hero copy, an actual card/table snippet, in the artifact's actual region proportions. Composition wireframes use gray blocks in the proportions of the *artifact's* semantic regions; Color/Type/Mood previews show a cropped slice of the *artifact* under each variant. Generic placeholder copy is a bug.

### Step 2 — Composition

The bones decision — load `references/composition-signatures.md`. Sameness in layout survives any re-paint; this step is where the artifact stops being the default centered column. Everything here is **CSS-only**: grid-template-areas, spans, offsets on the artifact's *existing* semantic regions. Never restructure the DOM.

Given `TRADITION` and the artifact analysis from Phase 2, offer 4 options:

- **Option A: Tradition signature** — the tradition's default signature from the library table (recommended).
- **Option B: Monolith** — the deliberate single column: oversized display headline, extreme vertical rhythm. For when content should dominate.
- **Option C: Contrast pick** — the signature that most opposes A, for users who want friction.
- **Option D: Density shift** — A's signature with density inverted (gutters, measure, rhythm one step tighter or looser).

Render each option as a miniature wireframe — gray blocks in the actual grid proportions of that signature, using the tradition's bg/ink — so the user sees the bones before any paint.

**Fitness guard:** if the artifact has fewer than 3 distinct semantic regions, or is dominated by wide tables (`dashboard`/`doc` with heavy tables), grey out signatures the library marks as unfit and note why. If nothing but monolith fits, say so and pre-pick B.

Write `.decisions/visual-design/02-composition.html`. Open. Wait.

### Step 3 — Color

Given `TRADITION` (and optionally `CALIBRATION` from Step 3d), offer 4 color variants:

- **Option A: Faithful** — the tradition's default ramp + accent as specified by the library.
- **Option B: 2026 current** (when `CALIBRATION` has color signal) — the tradition's ramp with the calibration's shifted accent hue applied. Label this option explicitly: "Pulled from current [tradition] examples on the web." *Fall back to "Warmer" (shift accents toward wood/brick/amber) if no calibration was gathered.*
- **Option C: Cooler** — shift accents toward cooler hues (navy, forest, slate). Always available.
- **Option D: Higher contrast** — pump the contrast between text and background one step. Always available.

Render each option as a mini-frame with the tradition's structure (browser chrome, header, hero headline, CTA button) using the shifted palette. Write `.decisions/visual-design/03-color.html`. Open. Wait.

### Step 4 — Type

Given `TRADITION` + `COLOR` (and optionally `CALIBRATION`), offer 4 type treatments:

- **Option A: Tradition default** — the headline + body pair specified by the tradition (recommended when no calibration).
- **Option B: 2026 current** (when `CALIBRATION` has type signal) — updated font weight / pairing pulled from current examples of this tradition. Label: "Pulled from current [tradition] examples on the web." *Fall back to "Bigger headlines" (same fonts, one scale step up on h1/h2) if no calibration.*
- **Option C: Alternate pair** — the tradition's alternate typeface suggestion (e.g., for Editorial, swap Fraunces display for Source Serif display).
- **Option D: Mono everything** — replace body with a monospace stack (good for technical feel).

All four options must clear `references/banned-defaults.md` — no banned face may be offered, including in Option D's mono stack (use the tradition's own mono from `references/font-pool.md`).

Each preview shows a styled headline + two lines of body text at realistic sizes. Write `.decisions/visual-design/04-type.html`, open, wait.

### Step 5 — Mood

Given prior choices, offer 4 mood combos (shape × shadow bundled):

- **Option A: Sharp + flat** — tight radius, no shadows
- **Option B: Sharp + elevated** — tight radius, strong shadows
- **Option C: Soft + flat** — generous radius, no shadows
- **Option D: Soft + elevated** — generous radius, soft shadows

Each preview shows a CTA button + a card + a divider to demonstrate the combo. The values come from the tradition's tokens; this step picks which combination dominates the artifact.

### Step 6 — Signature Flourish

Given prior choices, load the flourish candidates from the tradition's picks in `references/flourishes.md`.

- **Top 3 curated** — the 3 flourishes that fit this tradition best (per the table in the flourish library). Surface with the label "✦ fits [tradition] best."
- **Full library below** — all 8-10 flourishes available. Browse flat.

This is the novel step — the anti-generic move. Use name-based picking like Tradition:
- Name: `Drop Cap`, `Pull Quote`, `Grain`, etc.
- `A` / `B` / `C` hits the top 3 tiles
- `none` / `skip` is a valid choice (no flourish)

Each flourish preview renders the flourish rendered inside a small paragraph using the chosen tradition.

Write `.decisions/visual-design/06-flourish.html`. Open. Wait.

---

## PHASE 4 (SVG mode) — Steps 2-3

Two remaining steps after Tradition. Both use A/B/C/D.

### Step 2 — Stroke Weight

Pull the tradition's default stroke weight preference and offer 4 options calibrated around it. For a tradition whose rule specifies "1.5px stroke" (Swiss), the range might be 1 / 1.5 / 2 / 3. For Neo-Brutalist, 2 / 3 / 4 / 6.

General pattern:

- **Option A: Thin** — hairline, precise. Good for dense icon sets and reading-context icons.
- **Option B: Regular** — the tradition's default stroke width (recommended).
- **Option C: Bold** — stepped up one level, more presence.
- **Option D: Very Bold** — aggressive, chunky. Sets the icon apart. Default for Neo-Brutalist, Y2K, Anti-Design.

Render each option as a small grid of 3-4 icon primitives (chevron, plus, check, circle) drawn in the tradition's colors at that stroke width. User sees how each weight reads at typical icon size.

Also apply the tradition's stroke-linecap and stroke-linejoin preference:
- Most traditions → `round` for linecap + linejoin
- Swiss Modern, Bauhaus, Monochrome, Technical, Dashboard → `square` / `miter`
- Neo-Brutalist → `square` + thick miter join
- Neon Terminal, Cyberpunk → `square` with glow filter

Write `.decisions/visual-design/02-stroke.html`. Open. Wait.

### Step 3 — Color

Given `TRADITION` + `STROKE`, offer 4 color treatments:

- **Option A: Faithful palette** — apply the tradition's accent color as stroke/fill (e.g., Editorial's `#9a3412` brick, Cyberpunk's `#ff006e` neon).
- **Option B: Monochrome** — single color, typically the tradition's ink (e.g., Editorial's `#1f1611`, Swiss's `#0f172a`). Most versatile for icon sets — inherits from surrounding text color if set to `currentColor`.
- **Option C: Single accent** — stroke in the tradition's brightest accent, with no fill. Best for call-to-action icons.
- **Option D: Duotone** — two colors on different paths/shapes. Stroke in accent, fill in a secondary tone. Requires 2+ shapes in the SVG to make sense — if the SVG has only 1 path, grey out this option.

Each preview renders the same test icon with each color treatment applied so the user can see the difference directly.

**Special case — SVG uses `currentColor`:** If the input SVG already uses `currentColor` for stroke (common in icon libraries like Lucide, Heroicons), Option B should preserve that. Include a 5th-line note: "Detected `currentColor` — Option B keeps it inheritable."

Write `.decisions/visual-design/03-color.html`. Open. Wait.

---

## PHASE 5 — Rewrite & Output

Branches on `MODE`.

**HTML mode** — Steps 5a–5e below (existing flow).
**SVG mode** — Steps 5s-a through 5s-d (new, after the HTML section).

---

### Phase 5 (HTML mode)

Once all 6 decisions are locked, you have:

- `TRADITION` — tokens + aesthetic rules
- `COMPOSITION` — the layout signature + density variant
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
    "composition": "editorial-spread",
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
   - Preserve the DOM and its semantics — composition changes come from CSS, never restructuring
4. Apply the chosen composition signature's CSS (from `references/composition-signatures.md`) to the artifact's semantic regions — grid-template-areas, spans, offsets — including its under-720px single-column collapse
5. Append the flourish CSS
6. Responsive breakpoints mirror the original where the signature doesn't supersede them (never lose the artifact's mobile usability)
7. Run the self-check from `references/banned-defaults.md` against the stylesheet before writing it — banned faces and hexes must not survive into the output

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

### Step 5e — Run the critique gate

Before the user sees anything, run the gate in `references/critique-gate.md` against the styled file: deterministic checks (ban scan, contrast, composition proof, font delivery), then render via headless Chrome (or available browser tooling) and **Read the screenshot image — judge it with your own eyes** against the binary rubric (what looks broken beats what should work: overlapping text, invisible glass effects, flourishes that didn't manifest, a composition that collapsed). Fall back to the CSS self-review variant only if no renderer exists. Fix failures, maximum two loops. Keep what the gate found for the report.

### Step 5f — Build compare page, open + report

Write `.decisions/visual-design/compare.html`: a full-viewport page with a slim labeled header ("Original ↔ [Tradition]") and two side-by-side iframes loading the original and the styled file (use relative or absolute `file://`-safe paths; each iframe pane `width:50%; height:calc(100vh - 40px); border:0` with a 1px divider). Then:

```bash
open .decisions/visual-design/compare.html
```

(Opening the compare page replaces opening the two files separately — one tab, both versions.)

Report:
> "Re-skinned! The compare page is open — original on the left, **[basename].styled.html** on the right.
>
> Applied **[Tradition]** with **[Composition]** and **[Flourish]**. Decisions saved to `.visual-design/tokens.json` — next run in this project will surface this aesthetic as suggestion #1.
>
> [One short paragraph: what the critique gate checked, caught, and fixed — one sentence if everything passed.]
>
> Reply:
> - `love it` → nothing to do, done
> - `redo` → rerun the flow from scratch
> - `change [tradition|composition|color|type|mood|flourish]` → rerun just that step
> - `different flourish` → return to step 6
> - `more contrast` / `warmer` / etc → I'll interpret and adjust"

---

### Phase 5 (SVG mode)

Once all 3 decisions are locked, you have:

- `TRADITION` — aesthetic rules (stroke-linecap, linejoin, filter needs)
- `STROKE` — stroke-width value
- `COLOR` — resolved stroke + fill values (faithful / mono / accent / duotone)

### Step 5s-a — Resolve SVG attributes

Derive the exact attribute values to apply to each shape:

```json
{
  "mode": "svg",
  "tradition": "Editorial Print",
  "variant": { "stroke": "regular", "color": "monochrome" },
  "svg": {
    "strokeWidth": "1.5",
    "stroke": "#1f1611",
    "fill": "none",
    "strokeLinecap": "round",
    "strokeLinejoin": "round",
    "filter": null
  },
  "rootAttributes": {
    "width": "24",
    "height": "24",
    "viewBox": "0 0 24 24",
    "fill": "none",
    "stroke": "currentColor",
    "stroke-width": "1.5",
    "stroke-linecap": "round",
    "stroke-linejoin": "round"
  }
}
```

For traditions with a signature filter (Cyberpunk Neon, Neon Terminal), generate an SVG `<filter>` element to embed under `<defs>`. Example for Neon Terminal's phosphor glow:

```xml
<defs>
  <filter id="vd-glow" x="-50%" y="-50%" width="200%" height="200%">
    <feGaussianBlur stdDeviation="1.5" result="blur"/>
    <feMerge>
      <feMergeNode in="blur"/>
      <feMergeNode in="SourceGraphic"/>
    </feMerge>
  </filter>
</defs>
```

Then apply `filter="url(#vd-glow)"` to grouped shapes.

### Step 5s-b — Rewrite the SVG

The strategy: **hoist common attributes to the root `<svg>` element**, then **remove redundant per-shape attributes**. This keeps the output clean and makes the SVG easy to re-theme later.

1. **Set root attributes** on `<svg>` itself:
   - `stroke`, `fill`, `stroke-width`, `stroke-linecap`, `stroke-linejoin`
   - Keep existing `viewBox`, `width`, `height`
   - Preserve `xmlns`

2. **Strip old styling** from every shape (`<path>`, `<circle>`, etc.):
   - Remove `style="..."` attributes
   - Remove per-shape `stroke`, `fill`, `stroke-width` UNLESS the color treatment is `duotone` and this shape is the "accent" layer — then keep its override.

3. **Duotone handling**:
   - For multi-shape SVGs with duotone: the first half of shapes (or all "filled" shapes) get `fill="var(--accent)"` + `stroke="none"`; the second half get `stroke="var(--ink)"` + `fill="none"`. Tune per SVG inspection.
   - Single-path SVGs can't express duotone — fall back to accent.

4. **Filter injection** (if tradition requires one):
   - Add `<defs>` with the filter after `<svg>` opening
   - Add `filter="url(#vd-glow)"` to either the root `<g>` wrapper OR individual shapes

5. **Add a CSS comment header** inside `<svg>` as a text annotation for discoverability:
   ```xml
   <!-- /visual-design · Editorial Print · 1.5px · monochrome -->
   ```

6. **Preserve everything else** untouched — `<title>`, `<desc>`, `<metadata>`, comments, id attributes, aria attributes.

### Step 5s-c — Write output files

1. Write the rewritten SVG to `<original-basename>.styled.svg` in the same directory as the original.
2. Write tokens to `.visual-design/tokens.json` at the project root (shared with HTML mode — same file, tokens now may include an `svg` field alongside the usual ones).
3. Write run metadata to `.visual-design/run.json` (target, mode, decisions, timestamp).
4. Add `.visual-design/` to `.gitignore` if missing.

### Step 5s-d — Critique gate + open + report

Run the lightweight SVG variant of `references/critique-gate.md` first: ban scan on any embedded style, then render the styled SVG (headless Chrome screenshots SVG files directly) and check — strokes legible at 24px? duotone layers distinct? filter (if any) visible without blowing out shapes? Fix and re-check once, then open both files side by side (browsers render SVGs directly):
```bash
open <original>
open <original-basename>.styled.svg
```

Report:
> "Re-skinned! **[basename].styled.svg** is open alongside the original.
>
> Applied **[Tradition]** at **[Stroke]px** in **[Color treatment]**. Decisions saved to `.visual-design/tokens.json`.
>
> Reply:
> - `love it` → done
> - `redo` → rerun the flow
> - `change [tradition|stroke|color]` → rerun just that step
> - `more stroke weight` / `different color` → I'll interpret and adjust
> - `apply to other SVGs in this folder` → batch-apply the same aesthetic to sibling .svg files"

**Batch mode (bonus):** if the user invokes `/visual-design` again in the same project and another `.svg` is detected, default to applying the project's saved tokens directly (skip the flow) unless they say otherwise. This makes consistent icon sets trivial.

---

## RESPONSE PARSING — How Users Pick

The six steps don't all have 4 options, so input parsing varies per step:

### Steps 2, 3, 4, 5 (Composition, Color, Type, Mood) — standard A/B/C/D
- Exactly 4 options each. Respond like any thinking skill.
- Accept: `Option A`, `A`, `the first one`, `Option B because [reason]`, `Option A but [modification]`, `more options`.

### Steps 1 and 6 (Tradition, Flourish) — name-based picking
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
- `skip` — at step 6, valid meaning "no flourish." At other steps, use recommended.

Match input against (a) letter regex `^([A-Za-z])\b` at steps 2-5, (b) shortcut keywords, (c) fuzzy name match at steps 1 and 6. Show numbered candidates when ambiguous.

---

## AESTHETIC TRADITIONS LIBRARY

The 30-tradition library lives in **`references/traditions.md`** — load it when you reach Phase 3 (Tradition selection) and again at Phase 5 (rewrite). Each entry provides tokens (color ramp, type stack, spacing, radius, shadow, motion), aesthetic rules, flourish picks, and a default **composition signature**.

Two library-wide guarantees (do not violate when adding or editing traditions):
- **No two traditions share a display face.** Body and mono faces may repeat at most twice across the catalog.
- **Nothing in the library uses a banned default** — see `references/banned-defaults.md`.


## SIGNATURE FLOURISH LIBRARY

The ten flourish types (CSS + insertion hooks + tradition fit) live in **`references/flourishes.md`** — load it at Step 6 (Flourish) and at Phase 5 when applying the chosen flourish.

---

## HTML DECISION PAGE TEMPLATE

Each step generates a decision HTML file. Use a consistent shell with per-step variations.

### Shell skeleton (applies to all 6 step pages)

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
  <div class="eyebrow">Step [N] of 6 · [StepName]</div>
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

### Steps 2/3/4/5 (Composition/Color/Type/Mood) — structure

- 4 option cards, 2×2 grid. Each card has:
  - Letter badge (A/B/C/D)
  - Short title ("Faithful", "Warmer", "Higher contrast", etc.)
  - Visual preview rendered with the variant's tokens
  - 1-line description
- Recommended badge on one card (usually A or the tradition-default).
- Footer: "Reply with `Option A`, `A`, or `Option A but [modification]`."

### Step 6 (Flourish) — structure

- Section A: "✦ Fits [Tradition] best" — 3 curated flourish tiles. Each tile renders the flourish *applied to the tradition*, with the flourish name labeled.
- Section B: "Full library" — all ~10 flourishes as smaller tiles, flat grid.
- Include a "None" tile at the end of both sections for users who want no flourish.
- Footer: "Reply with a flourish name (e.g., `Drop Cap`) or `none`."

### Run summary page (`index.html`)

Mirror the decision-hub style used elsewhere in the decision-kit (serif display, mono kickers, warm paper bg). Shows:
- The 6 locked choices
- The final resolved aesthetic summary
- Links to each decision page
- Links to the original + styled artifact

---

## EDGE CASES

**Target file has no `<style>` block:** Inject one inside `<head>` with the full resolved stylesheet. All selectors still match.

**Target file uses external CSS (`<link rel="stylesheet">`):** Convert to inline — fetch the external CSS, rewrite selectors, inline into the `.styled.html`. If external CSS is unreachable (remote, 404), tell the user and skip the file.

**Target file is HTML with embedded `<script>`:** Preserve all scripts. The skill only touches styles and minimal DOM for flourish hooks.

**Target file is already a `.styled.html` / `.styled.svg`:** Ask if the user wants to re-skin it (changing aesthetic) or start over (forgetting the prior aesthetic). If re-skin: use the existing styled file as the source, write a new `<name>.styled.*` overwriting prior styled version, update tokens.json.

**Target file is a PNG/JPG raster:** The skill can't re-style pixels. Tell the user: "I can't restyle raster images — this skill rewrites vector/style. If this is an icon, see if you have the source SVG. If it's a photo, it's out of scope."

**SVG is a multi-color illustration (4+ colors):** Warn the user before Phase 4 starts: "This looks like a multi-color illustration. If you pick a tradition with a single-color rule (most), colors will flatten. Traditions built for illustrations: Warm Handmade, Sketchbook, Botanical Herbarium, Editorial Print. Continue anyway?"

**SVG has `<defs>` with gradients/patterns:** Preserve them. The rewrite only touches stroke/fill on rendered shapes, not referenced `url(#foo)` paint servers — unless the chosen tradition explicitly replaces them (e.g., Y2K Maximalist overriding gradients with its own chrome gradient).

**SVG uses `currentColor`:** Honor it. Monochrome color treatment (Option B in SVG Step 3) should preserve `currentColor` so the icon inherits from its context. Note this on the decision page.

**SVG has only one path:** Grey out the Duotone color option (D) since it needs 2+ shapes.

**Tradition not found (typo):** Show 3 closest matches numbered, ask which.

**User says `redo` after the output:** Delete the `.styled.*` file, re-run from Phase 1 with the same target.

**User says `change [step]`:** Jump to that step's decision page, re-run from there. Downstream choices stay unless they conflict.

**No artifact type detected confidently:** Use `brief` (HTML) or `icon` (SVG) as the fallback for type inference.

---

## IMPORTANT REMINDERS

1. **Never skip a decision step.** The user invoked `/visual-design` because they want to *think through* the aesthetic. Fast ≠ skipped. Each step gets its own HTML page with options.
2. **Always open the file after writing.** `open .decisions/visual-design/0N-<step>.html`. User needs to see what you've generated.
3. **Wait for the user at every step.** Don't proceed until they've picked.
4. **Preserve the original.** Never overwrite the target. Always write `.styled.html` alongside.
5. **Plain English.** Option descriptions talk about feel and audience, not tokens. Save the JSON for the tokens file.
6. **Tokens.json is sacred.** It's what makes the skill compound across artifacts. Write it every run. Respect existing ones as suggestion #1.
7. **Flourish is the hero step.** Step 6 is what separates generic from characterful. Don't treat it as a throwaway.
8. **Fuzzy match is friendly.** Accept typos, partial names, abbreviations (`brutal` → Neo-Brutalist). If truly ambiguous, show numbered candidates.
9. **Respect existing aesthetic.** If the target artifact already uses a well-known tradition (detect by font family hints), suggest that tradition as match #1.
10. **Add to `.gitignore`.** First time `.visual-design/` is created in a project, append a line to `.gitignore` (create if missing).
11. **Nothing banned ships.** Run the `references/banned-defaults.md` self-check on every stylesheet you write. Banned faces and hexes surviving into output is a bug, not a style choice.
12. **The gate is not optional.** Every run ends with the `references/critique-gate.md` pass — render, LOOK at the screenshot with your own eyes, fix — before the user sees the result. If no renderer exists, the CSS self-review fallback still runs. Never fix a gate failure by deleting the distinctive move.
13. **Previews show THEIR artifact (v2).** Every step-2-onward preview is built from the target artifact's real content and regions. If a preview could belong to any project, regenerate it.
14. **Three Takes is a first-class path (v2).** `3 takes` / `--takes` at any point switches to the parallel-variants flow. It's the right default suggestion when the user seems unsure what aesthetic they want, or says "just show me options."
15. **Banned-defaults and the gate bind Three Takes agents too.** Each take passes the same checks as the step-by-step flow — parallelism is not an excuse for sloppiness.
