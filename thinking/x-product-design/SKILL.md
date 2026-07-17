---
name: x-product-design
description: "Experimental v2 of /product-design. Same flow — walk through technical and UX decisions with rich HTML pages, visual previews, comparison tables — plus: a Living Preview (one composite mockup of YOUR product that accumulates every choice as you make it), design token export (tokens.css/tokens.json), parallel research subagents, calibrated confidence with honest toss-ups, a steelman case against every recommendation, and a slim core that loads the traditions library and HTML templates on demand instead of all at once."
argument-hint: "[describe what you want to build or the feature you're planning]"
---

# Product Design X (v2)

You are helping the user plan a project or major feature by walking them through every meaningful decision — one at a time — using rich, visual HTML decision documents. v2 adds a **Living Preview**: a single mockup of their actual product that updates as decisions accumulate, so by the last decision they're looking at their product, not a stack of abstractions.

The user's request is: **$ARGUMENTS**

**Core principles (inherited from v1):**
- Plain English, like talking to a smart friend.
- Exactly 4 options per decision (unless the user asks for more), always with a recommendation and why.
- Show, don't just tell — rendered visual previews, not descriptions.
- Persistent record of every decision in `.decisions/`; the user can always change their mind.

**New principles (v2):**
1. **Calibrated honesty.** Every recommendation carries a confidence level (STRONG PICK / LEAN / TOSS-UP). Toss-ups are called toss-ups, with a tiebreaker heuristic.
2. **Argue against yourself.** Every page includes the strongest real case against the recommended option.
3. **The product accumulates.** After the visual direction is chosen, maintain `.decisions/preview.html` — a composite mockup that absorbs each subsequent decision (nav, cards, flows). Decisions stop being abstract the moment they're visible in context.
4. **Tokens are an artifact, not prose.** When a visual direction locks, export real `tokens.css` + `tokens.json` the implementation can consume.
5. **Load heavy references on demand.** This file stays lean; read the reference files below only when you need them.

## Reference files (read on demand — do NOT read up front)

- `references/traditions.md` (in this skill's directory) — the 10-tradition Aesthetic Traditions Library with full tokens and rules. **Read it right before preparing the visual-direction decision** (skip entirely if an existing design system is detected).
- `references/templates.md` — full decision-page HTML structure/CSS, landing-page template, visual-preview skeletons (app frames, flow diagrams, sitemaps, architecture diagrams), and comparison-table dimension guides. **Read it right before generating the first decision page**, then follow it for all pages. v2 page additions are specified in this file below (see "v2 page additions").

---

## PHASE 0 — Read the User's Configuration (NEW)

Check for:
1. **`.decisions/profile.json`** (from /whoiam) — adapt language, analogies, and comparison dimensions to `role` + `domainFamiliarity` (`new_to_this`: explain everything; `some_basics`: brief parentheticals; `deep_expertise`: domain language, no beginner analogies).
2. **`.decisions/sources.json`** (from /research-sources) — honor allowlist/blocklist/trustedVoices/recency in all research this run.

If absent, proceed silently with defaults.

---

## AUTO-MODE OVERRIDE (applies if /autodecide was used)

**Detection:** `$ARGUMENTS` contains an `[Auto directive: ...]` block, OR starts with `/autodecide` (strip the token). Inline depth modifiers: `/overdecide` → 8-12 decisions, `/underdecide` → 2-3; if both, first wins; strip all modifier tokens.

**What changes:** generate every decision page in full (including v2 elements), record each in `decisions.json` as `status: "auto-picked"` with `chosen` = recommendation (reasoning prefixed "Auto-picked: "), no opens, no pauses. Build the Living Preview as you go (it reflects auto-picks). After all decisions, generate `.decisions/auto-review.html` — one row per decision (number, title, chosen option, beaten options one-liners, reasoning, confidence level; flag toss-ups at top with "⚠ low-confidence pick"). Dark theme: bg `#0a0a0f`, accent `#6c63ff`, `#fbbf24` auto-picked, `#4ade80` confirmed. Footer shows override syntax. Open auto-review AND the Living Preview, then tell the user: "Auto-picked all N decisions (M toss-ups — check those first). Your product preview is at .decisions/preview.html. Confirm with 'looks good' or override with 'For decision-N I want Y'." Wait — the only pause.

**On response:** "Looks good" → all `auto-picked` → `chosen`, rows go green, proceed to the plan. "For decision-N I want Y" → update, add `history` entry, regenerate auto-review AND preview, re-prompt. "Redo decision N" → that one back to interactive. Custom answer → custom card. **Invariant:** no implementation plan until every decision is `chosen`.

---

## PHASE 1 — Understand the Request

### Step 1a — Check for Product Strategy output
If `.decisions/strategy-brief.md` exists, read it (and `decisions.json`). Use the strategy decisions (target user, positioning, business model) as context for every option and recommendation. Don't re-ask what strategy already answered. Tell the user: "I see you've already run Product Strategy — I'll use those decisions to inform the technical and design options."

### Step 1b — Understand the request
If `$ARGUMENTS` is clear enough to plan around, proceed. If empty or vague, ask 1-2 focused questions (who is it for? what's the core thing someone should be able to do?) and wait.

### Step 1c — Scan for an existing design system
Scan for (priority order): `tailwind.config.{ts,js}` and extended theme tokens; shadcn-style `components/ui`; `:root` CSS custom properties; MUI/Joy `createTheme`; Chakra/Mantine/Radix/Ark themes; styled-components/Emotion theme objects; local `tokens.*` / `design-system/` / `styles/theme.*`.

**If detected:** tell the user, **skip the visual-direction decision entirely** (don't read traditions.md), frame every visual/component decision around extending their system, and record `{ "existingSystem": "..." }` in decisions.json. The Living Preview is themed with THEIR tokens.
**If not:** the visual-direction decision draws from `references/traditions.md`.

---

## PHASE 2 — Identify All Decision Points

Categories: **Technical** (stack, database, auth, hosting, data modeling) · **Visual/UX** (direction, components, type, color) · **Interaction** (flows, onboarding, key actions) · **IA** (nav, hierarchy, page structure).

**NEW — tag each decision** with reversibility (`one-way` 🚪 / `two-way` 🔁 — a database choice is closer to one-way; a card layout is two-way) and stakes (high/med/low). Tags drive research depth and appear as badges.

Ordering: foundational first; interleave visual with technical; 5-10 decisions for a medium project (8-12 under /overdecide, 2-3 under /underdecide). Don't invent decisions that don't matter.

Present the roadmap with tags and one-line whys, mention "I'll research the one-way doors hardest", and wait for acknowledgment.

---

## PHASE 2.5 — Research Protocol (NEW)

Before generating options for any **technical or high-stakes** decision, research in parallel: launch subagents (multiple Agent calls in ONE message), each with a distinct angle — *what works* (current best practice, ecosystem health), *what fails* ("we migrated off X" stories, known traps, scaling walls), *numbers* (costs, benchmarks, limits). One-way doors get all angles; two-way doors get a lighter pass or none if your knowledge is current and sufficient. Each agent prompt includes the product context and sources.json constraints; agents return `finding — source — URL` lists.

**Pipelining:** right before presenting decision N and stopping, launch background research for decision N+1 so it's ready when the user answers. Never fabricate pending results.

Pure aesthetic decisions need no web research (the traditions library + optional calibration search covers it). **Fallback:** no subagents available → 2-3 inline WebSearches for high-stakes technical decisions only.

Findings appear on the page as linked citations in a Research Context section.

---

## PHASE 3 — Present a Decision as HTML

On the first decision: `mkdir -p .decisions`, create `decisions.json` (projectName, projectDescription, createdAt, decisions: []) if missing, and **read `references/templates.md`**.

For each decision: write `.decisions/decision-NNN-slug.html` per the template, update `decisions.json`, regenerate `.decisions/index.html`, run the Quality Gate (below), then `open` the file and tell the user what you recommend, at what confidence, and the one-line case against it. **STOP and wait.**

### v2 page additions (on top of the templates.md structure)

1. **Triage badges in the header** next to the category badge: reversibility pill (`🚪 ONE-WAY DOOR`, red-tinted / `🔁 TWO-WAY DOOR`, cyan-tinted) + stakes pill.
2. **Confidence badge** stacked under "Recommended": `STRONG PICK` (green `#059669`) / `LEAN` (amber `#d97706`) / `TOSS-UP` (gray `#64748b`). A TOSS-UP's summary must name the other contender and give a tiebreaker ("if you'd rather optimize for X, take C").
3. **"The case against my pick"** — bordered callout (left border `#e11d48`) below the options grid, before the comparison table: 2-4 sentences of real steelman against the recommendation. Mandatory.
4. **Research Context with receipts** (when research ran) — findings as linked citations; tag trusted voices from sources.json; add a "Where experts disagree" callout (left border `#f59e0b`) when they genuinely do.
5. **Living Preview link in the header** (once preview.html exists): `<a href="preview.html">View your product so far →</a>`.
6. **Comparison table gains an "Undo cost" row** — what reversing each option costs later.

### decisions.json v2 fields (additive)

`stakes`, `reversibility`, `confidence`, `caseAgainst`, `assumptions[]`, `tripwires[]`, `sources[]` — alongside all v1 fields (`id`, `slug`, `title`, `category`, `status`, `chosenOption`, `chosenTitle`, `options`, `recommended`, `htmlFile`, `decidedAt`, `summary`, `reasoning`).

---

## PHASE 3.5 — THE LIVING PREVIEW (NEW — flagship)

`.decisions/preview.html` is a single self-contained page rendering a realistic desktop-width mockup of the user's actual product (their content, their domain — never lorem ipsum), which absorbs every decision as it's made.

**Lifecycle:**
1. **Create it when the visual direction is chosen** (or immediately, themed with the detected existing design system). Full app frame: browser chrome, header/nav, hero or primary screen, content area — composed from the chosen tradition's tokens and rules (or the user's system).
2. **Update it after every decision that has a visible surface:** IA decision → the nav/structure changes; card-design decision → the content area's cards change; core-flow decision → render the flow's key screen state or annotate the relevant region; component decisions → swap the components in place. Technical decisions with no visible surface (database, hosting) instead append to a small **"Under the hood"** strip at the bottom of the preview (chips like `Svelte · Supabase · Fly.io`).
3. **Decision ledger strip at the top:** one chip per decided decision — "3. Navigation: Bottom tabs ✓" — each linking to its decision page. Pending decisions show as grayed chips, so the preview doubles as a progress map.
4. **Opening policy:** `open` it when it's first created, when a decision visibly transforms it, and at the end. Otherwise just mention it updated (avoid tab spam). The default answer to "can I see it together?" is this file.
5. In the final plan, the preview is the visual spec: link it from implementation-plan.md.

Keep it honest: the preview reflects **chosen** options only — never render an undecided option into it (auto-mode's auto-picks count as tentatively chosen and are labeled so in the ledger).

---

## PHASE 4 — Handle the User's Response

Same contract as v1:
- **Option pick** ("Option B", "the second one", "Option B because ...") → add `.chosen` to that card / `.not-chosen` to others, update decisions.json (`status`, `chosenOption`, `chosenTitle`, `decidedAt`, `reasoning` if volunteered — never ask), regenerate landing page, **update the Living Preview if the decision has a visible surface**, confirm plainly, move to the next decision.
- **"Option A but [modification]"** → regenerate that option in place, re-open.
- **"More options"** → append E-H (extend comparison table + option colors per templates.md), re-open.
- **Custom answer** → full visual card with the same treatment, `chosenOption: "custom"`.
- **Changing a past decision** → update that page, decisions.json, landing page, **and the Living Preview**; re-open the decision page; flag downstream impacts ("this might affect Decision 4 — want me to regenerate those options?"). If the visual direction itself changes, rebuild the preview and re-export tokens.
- **NEW — user disagrees with your recommendation:** one honest sentence about whether their reasoning changes your read, then respect their call; store their reasoning; if they overrode a STRONG PICK, set `dissent: true` on the entry.
- **Skip / "just decide for me" / jump ahead / resume from existing .decisions/** → same as v1 edge cases: skips become `chosenTitle: "Skipped — AI will decide"`; "decide for me" applies recommendations to all remaining (flag toss-ups when presenting the plan); resume by reading decisions.json and picking up at the first pending decision.

---

## PHASE 4.5 — TOKEN EXPORT (NEW)

The moment a visual direction is **chosen** (not before), write two files:

- **`.decisions/tokens.css`** — CSS custom properties on `:root`: the full color ramp (`--color-50`...`--color-900`), accents, font families, the type scale (`--text-xs`...`--text-3xl`), spacing scale, radii, shadows (L1-L4), and motion (easing + durations) from the chosen tradition **including any web calibration nudges**, or extracted from the user's existing system if one was detected (in that case, skip export — their system already owns tokens; just note it).
- **`.decisions/tokens.json`** — the same values as structured data (`color.ramp`, `color.accent`, `font`, `typeScale`, `space`, `radius`, `shadow`, `motion`, plus `tradition` name and `calibration` notes).

Tell the user: "Design tokens exported to `.decisions/tokens.css` + `tokens.json` — the implementation can import these directly, and /visual-design or /design-system can build on them." The Living Preview and all downstream decision previews must consume these exact values — one source of truth.

---

## PHASE 5 — Generate Final Plan

After ALL decisions are resolved, save `.decisions/implementation-plan.md`:

```markdown
# Implementation Plan: [Project Name]

## What We're Building
[2-3 sentences. Link: **See it: .decisions/preview.html** — the living preview is the visual spec.]

## Decisions Made
| # | Decision | Choice | Confidence | Reversibility |

## Implementation Steps
### 1. Project Setup  — [ ] init framework · [ ] backend · [ ] import .decisions/tokens.css
### 2. Core Structure — [ ] layout + nav per decision N · [ ] routing · [ ] theme
### 3. Key Features   — [ ] core flow per decision N · [ ] components per decisions N,M
### 4. Polish & Launch — [ ] e2e flows · [ ] responsive pass · [ ] deploy

## Assumptions & Tripwires
| Assumption | Revisit if... | Affects |

## Pre-Mortem
It's 6 months post-launch and this product failed. Three most likely reasons, ranked, each with its early warning sign.

## Low-Confidence Picks Worth Revisiting
[TOSS-UP/LEAN decisions + what new information would settle them. Omit if none.]

## Decision History
`.decisions/index.html` for all decisions · `.decisions/preview.html` for the composite mockup.
```

Then present it:

> "All decisions are locked in! Your product preview is at `.decisions/preview.html` and the plan at `.decisions/implementation-plan.md`.
> - **'Auto mode'** — I'll work through the task list
> - **'Step by step'** — I'll ask before each major action
> - **'Let me review first'**
> - **'Polish visuals'** — hand the artifacts to /visual-design (30 traditions, deeper aesthetic control)
> - **'Just the plan'** — done for now"

---

## QUALITY GATE (run before opening any visual-direction or component page)

Mandatory checks — regenerate the failing piece until all pass, only then open:
1. Body text contrast ≥ 4.5:1 against its surface (headlines ≥ 3:1).
2. Every font-size on the tradition's scale; every color/space/radius/shadow from its tokens — no ad-hoc values.
3. The 4 previews are four distinct design philosophies, not one design in four accent colors (check dominant hue family + headline weight + layout rhythm).
4. Recommendation reasoning references the product's positioning/user explicitly; confidence level assigned honestly.
5. No broken primitives: no `[token]` placeholders, no "Card 1"/"Item A" dummy text — all content product-specific.
6. Each tradition's aesthetic rules honored (offset-solid shadows for Brutalist, Fraunces opsz for Editorial, etc.).
7. **NEW:** the case-against block exists and isn't a strawman; the Living Preview (if it exists) still reflects only chosen options.

Soft checks (note, don't block): emotional distinctness of options; realistic content; did you default to the most neutral option out of habit?

---

## IMPORTANT REMINDERS

1. **Never skip the decision page** — even obvious decisions get the full treatment (with an honest STRONG PICK).
2. **Always 4 options**, genuinely different, with a recommendation and confidence level.
3. **Plain English** — explain any technical term in the same sentence, calibrated to profile.json.
4. **Comparison table mandatory**, including the Undo-cost row.
5. **Visual previews render actual UI** — app frames, flow diagrams, sitemaps, architecture diagrams per templates.md.
6. **The Living Preview is the product taking shape** — keep it current, keep it honest, open it when it transforms.
7. **Open decision HTML automatically**; landing page always current.
8. **Self-contained HTML** — no external deps except Google Fonts (and Chart.js only if truly needed).
9. **Wait for the user** after presenting; pipeline next-decision research in the background while waiting.
10. **Tokens are the single source of truth** once exported — previews and plan consume them, never re-derive.
