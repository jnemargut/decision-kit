---
name: excavate
description: "Codebase decision archaeology. Reads an existing codebase and surfaces the invisible decisions encoded in it — from tech stack choices down to approach-level patterns like memory allocation strategies, rendering pipelines, and collision detection. Adapts to any domain (game engines, web apps, CLI tools, embedded systems). Shows evidence, you confirm what's right and correct what's not. Re-run after changes to catch drift."
argument-hint: "[optional: path, focus area, or both — e.g. 'find the UX decisions' or 'just the auth subsystem' or '/path/to/project focus on error handling']"
---

# Excavate

Every codebase is full of decisions nobody wrote down. You are reading a codebase and surfacing them — not just the obvious framework choices, but the approach-level decisions that make the codebase tick: how it handles errors, why it uses fixed-point math instead of floats, what collision detection strategy it chose, how it serializes state. You show the evidence, the human confirms what's right and corrects what's not.

This is a reverse thinking skill. Instead of generating options for the human to choose from, you're extracting what was ALREADY chosen and asking the human to verify it.

The user's input is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### Extract, don't invent
You are reading what's IN the code, not brainstorming what COULD be there. Every finding must be grounded in specific files, patterns, or configurations. If you can't point to evidence, don't surface it.

### Show your work
Every finding includes evidence: the specific files, line numbers, and code patterns that led to it. The human should never have to take your word for it. Trust is earned by showing proof.

### Decisions, not observations
"This project uses React" is an observation. "This project chose React with App Router over Pages Router" is a decision. Surface decisions — choices where an alternative existed and something was picked.

### The "tell a new teammate" test
The right granularity is: would a senior engineer onboarding a new teammate mention this? "We use BSP rendering" — yes. "Visplanes are pooled in a fixed array to avoid allocation during rendering" — yes. "TICRATE is 35 because of VGA 70Hz mode" — yes. "MAXVISPLANES = 128" — no, that's tuning you'd adjust, not rethink. Surface architecture-level AND approach-level decisions. Skip pure tuning constants unless they encode a real tradeoff.

### Adapt to the domain
Don't apply web-app heuristics to a game engine or embedded-system heuristics to a Rails app. Detect what KIND of codebase you're looking at and generate appropriate decision categories. A game engine has rendering, collision, AI, audio decisions. A web app has auth, API design, state management, caching decisions. The categories come from the code, not a predetermined checklist.

### Target density: ~1 decision per KLOC
Aim for roughly 1 decision per thousand lines of code as a baseline. A 2k-line CLI tool gets ~4-6 findings. A 30k-line game engine gets ~25-35. A 100k-line SaaS gets ~40 (capped — more than 40 is overwhelming). Scale to the codebase's actual complexity.

---

## PHASE 1 — Determine Mode

Check if `.decisions/decisions.json` exists.

### Mode A: First Run (no .decisions/ or empty)
Full excavation. Scan everything, surface all findings.

### Mode B: Re-run (existing .decisions/)
Delta mode. Read the existing decisions. Scan the codebase. Surface only:
1. **New findings** — decisions in code that aren't in decisions.json
2. **Drifted findings** — recorded decisions that no longer match the code

Tell the user which mode you're in:

**First run:**
> "No decisions recorded yet. I'll do a full excavation of the codebase."

**Re-run:**
> "I see [N] recorded decisions. I'll scan for new decisions and check if any recorded ones have drifted."

---

## PHASE 1.5 — Parse Focus Lens

Read `$ARGUMENTS` for focus signals that narrow the excavation scope.

**Full scan (default):** No focus signal detected → scan all categories, all layers, all subsystems.
- `/excavate`
- `/excavate the codebase at /path/to/project`

**Focused scan:** User specified what to look for → constrain which categories are generated and which layers are probed.
- `/excavate find the UX and product decisions` → only UX + business/product categories. Skip pure technical findings.
- `/excavate just the rendering subsystem` → only probe files in the rendering subsystem.
- `/excavate focus on error handling and testing patterns` → only pattern-layer categories related to error handling and testing.
- `/excavate what auth decisions are in here` → only auth-related categories across all layers.

**How to detect focus:**
- Look for phrases: "find the", "just the", "focus on", "only look at", "what ___ decisions", "show me the"
- Extract the focus topic(s) from the natural language
- Set a focus filter that constrains Phase 2 (which categories to generate) and Phase 3 (which layers/subsystems to probe)

**Narrate the focus:**
> "Focusing on UX and product decisions only. I'll skip pure technical findings."

or:
> "Focusing on the rendering subsystem. I'll probe all decision layers but only within rendering-related files."

If the focus is too narrow to find meaningful decisions, say so:
> "I only found 2 decisions matching that focus. Want me to widen the lens?"

---

## PHASE 2 — Domain Detection & Subsystem Mapping

Before the phased dig, understand what you're looking at. If a focus lens is active, use it to constrain which categories and subsystems you generate.

### Step 2a — Detect the Domain

Read the top-level structure (configs, dependencies, directory layout) and classify the codebase:

- **Game engine:** rendering pipeline, physics, audio, input, AI subsystems
- **Web application:** routes, models, middleware, auth, frontend components
- **CLI tool:** argument parsing, command structure, output formatting
- **Mobile app:** screens, navigation, state, native APIs
- **Systems/embedded:** hardware abstraction, interrupts, memory-mapped I/O
- **Library/SDK:** public API surface, internal implementation, documentation
- **Data pipeline:** ingestion, transformation, storage, scheduling

**Narrate:**
> "This looks like a [domain] — I'll look for [domain-appropriate decision categories]."

### Step 2b — Map Subsystems

Identify the subsystems in the codebase using structural + semantic detection:

1. **Structural hints:** File prefixes (r_*.c, p_*.c), directory structure (src/auth/, app/api/), naming patterns
2. **Semantic validation:** Read headers/imports to understand real boundaries. Who imports who? Which files talk to each other?
3. **Split junk drawers:** If a prefix/directory contains unrelated things (e.g., DOOM's m_*.c has fixed-point math, menus, AND random numbers), split them into separate logical subsystems
4. **Merge related files:** If multiple prefixes/directories form one pipeline (e.g., r_bsp.c + r_segs.c + r_plane.c + r_draw.c = the rendering pipeline), group them

**Narrate:**
> "I see [N] subsystems: [list with file counts and line counts]"

### Step 2c — Generate Domain-Appropriate Categories

Based on the detected domain and mapped subsystems, generate the decision categories to look for. Examples:

**Game engine categories:** Rendering approach, spatial partitioning, physics/collision, AI/behavior, audio mixing, input handling, serialization/save, content loading, memory strategy, game loop/timing, networking model, entity system

**Web app categories:** Framework choice, database/ORM, auth approach, API design, state management, error handling, testing strategy, deployment, caching, component patterns, data validation

**CLI tool categories:** Argument parsing, command structure, output formatting, configuration, error handling, dependency management

Don't use a fixed list. Generate categories that match THIS codebase's subsystems and domain.

---

## PHASE 3 — The Phased Dig

Scan the codebase in 4 layers. Each layer informs the next. Narrate progress as you go.

### Scan Strategy: Headers First, Then Targeted Deep Reads

For each layer:
1. **Read all headers/interfaces first** — .h files, type definitions, index files, public API surfaces. These are short (50-100 lines typically) and information-dense: structs, enums, function signatures, #defines. They reveal the architectural skeleton cheaply.
2. **Identify interesting headers** — which ones contain complex types, state machines, unusual patterns, or design decisions?
3. **Deep-read the implementation files** for interesting headers — read the .c/.ts/.py files that implement what the header defined. This is where approach-level decisions live.
4. **Proportional depth per subsystem** — bigger subsystems (more files, more lines) get more files read. A 12-file rendering subsystem gets 6-8 files read. A 2-file sound subsystem gets both read.

### Layer 1: Surface Scan

Read configs, dependency manifests, directory structure, README, deployment configs.

**Narrate:**
> Layer 1: Surface scan...
> Reading configs, dependencies, directory structure
> Found: [framework], [language], [deployment target]

### Layer 2: Structural Scan

Read the architectural skeleton using domain-appropriate categories:

**For any domain:** Entry points, data models, public APIs, module boundaries
**For game engines:** Rendering pipeline, physics/collision files, AI files, audio files, networking
**For web apps:** Route handlers, database schema, auth middleware, API layer, component structure
**For CLI tools:** Command definitions, argument parsing, output handlers

Read headers first across all subsystems, then deep-read 1-3 implementation files per subsystem based on what the headers reveal.

**Narrate:**
> Layer 2: Structural scan...
> Reading [subsystem] headers and key implementation files
> Found: [decisions found — 1-3 per subsystem]

### Layer 3: Pattern Scan

Read how the code behaves — approach-level decisions within each subsystem:

- Error handling philosophy — crash vs recover, logging vs swallowing, error types
- Data flow patterns — how state moves through the system, caching, synchronization
- Algorithm choices — spatial partitioning, search strategies, sorting, hashing
- Memory patterns — allocation strategies, pooling, ownership, lifecycle
- Concurrency patterns — threading model, async approach, synchronization primitives
- Testing approach — what's tested, how, coverage patterns

Deep-read 2-4 implementation files per major subsystem, focusing on files where Layer 2 headers revealed interesting patterns.

**Narrate:**
> Layer 3: Pattern scan...
> Analyzing [subsystem] internals — error handling, algorithms, memory patterns
> Found: [approach-level decisions]

### Layer 4: Meaning Scan

Infer higher-level decisions from the code using domain-appropriate lenses:

**For any domain:** Code organization philosophy, naming conventions with semantic meaning, cross-cutting concerns
**For game engines:** Game design constraints encoded in code (player limits, tick rates, level structure)
**For web apps:** UX decisions (navigation, onboarding), business model signals (roles, pricing tiers, feature flags)
**For CLI tools:** User experience decisions (output format, interactivity, progressive disclosure)

**Narrate:**
> Layer 4: Meaning scan...
> Inferring higher-level decisions from code patterns
> Found/Maybe: [higher-level decisions with lower confidence]

**After all layers:**
> Done. Found [N] decisions across [M] layers. Opening triage page...

---

## PHASE 4 — Generate the Triage Page

Create a triage page at `.decisions/excavate-triage.html` and open it in the browser.

### Triage Page Structure

The page uses the **Layered Dig Report** layout — findings grouped by the 4 scan layers:

### Each finding has:
1. **Confidence dot** — green (●) high, amber (◐) medium, gray (○) low
2. **Decision title** — what was decided, stated as a choice
3. **Reason label** — one line explaining HOW the skill knows (first level of progressive disclosure)
4. **Expandable evidence** (click to reveal):
   - **"Why this looks like a decision"** — 2-3 sentences explaining what was found and why it seems deliberate
   - **Evidence** — actual code snippet with file path and line number
   - **"Same pattern in:"** — list of other files showing the same pattern
5. **Action buttons** — Confirm / Review / Reject

### Confidence Assignment Rules

**High confidence (green ●):**
- Explicitly declared in a config file or dependency manifest
- A framework or library that requires deliberate installation
- A pattern found in 80%+ of relevant files

**Medium confidence (amber ◐):**
- A consistent pattern that could be deliberate OR accidental
- Something inferred from data models or naming conventions
- A design pattern with plausible alternative interpretations

**Low confidence (gray ○):**
- Inferred from indirect signals (route structure → UX pattern)
- Business decisions guessed from technical artifacts
- Anything where the "why" is highly speculative

### Delta Mode Triage Page

When re-running (Mode B), the triage page has two sections:

**Drifted from recorded** (shown first, red DRIFT badges):
- Shows what was recorded vs what's in the code now
- Format: "Recorded: REST only. Found: REST + new GraphQL endpoint"
- Actions: Update (record the new reality) / Dismiss (keep the recorded version)

**New findings** (shown second, blue NEW badges):
- Same format as first-run findings
- Actions: Confirm / Review / Reject

Summary header: "9 decisions unchanged. 3 new + 2 drifted:"

---

## PHASE 5 — Guided Triage Conversation

After opening the triage page, prompt the user for batch triage:

> "I've opened the triage page with [N] findings across [M] layers. Take a look, then tell me:
>
> `Confirm 1-6, review 7 and 9, reject 11`
>
> Or go one at a time. You can also say `confirm all green` to batch-confirm high-confidence findings.
>
> After triage, you can also say:
> - `dig deeper` — I'll probe all subsystems for more decisions
> - `dig deeper into [subsystem]` — I'll focus on one area
> - `go exhaustive` — I'll find everything, down to tuning-level decisions"

### Handle Responses

**Batch triage:** "Confirm 1-6, review 7 and 9, reject 11"
1. Store confirmed findings as decisions in `.decisions/decisions.json` with `source: "excavated"` and `status: "chosen"`
2. Generate a standard decision HTML page for each confirmed finding
3. Discard rejected findings
4. Queue reviewed findings for deep review (Phase 6)

**"Confirm all green"** or **"confirm all high confidence":**
1. Batch-confirm all green-dot findings
2. Present remaining amber/gray findings for individual triage

**"Go one at a time":**
1. Present each finding sequentially with its evidence
2. Wait for confirm/review/reject on each

**Custom corrections:** "The freemium one is wrong — it's actually usage-based pricing"
1. Store as a decision with `chosenTitle` reflecting the correction
2. Store their reasoning
3. Set `source: "excavated"` and mark as corrected

### Dig Deeper (Post-Triage)

**"Dig deeper":**
1. Re-scan all subsystems, reading MORE implementation files per subsystem
2. Look for approach-level decisions missed in the first pass
3. Present new findings in a supplementary triage page
4. Already-confirmed decisions are not re-presented

**"Dig deeper into [subsystem]":**
1. Read ALL files in that subsystem (headers and implementation)
2. Look for every approach-level decision within it
3. Present subsystem-specific findings

**"Go exhaustive":**
1. Read all files in the codebase
2. Drop the granularity filter — include tuning-level decisions with tradeoffs
3. Present everything found, labeled by level (architecture / approach / tuning)

---

## PHASE 6 — Deep Review

For each finding the user marked "Review," present a full journal-style decision page:

1. **Generate a decision HTML page** with the same dark-theme format as other thinking skills
2. The page shows:
   - The finding as the primary option (what the code suggests)
   - 2-3 alternative interpretations as unchosen options
   - A comparison table
   - The full evidence dossier
3. **Open the page** in the browser
4. **Ask the user:**

> "**[Finding title]**
> I see [evidence summary]. Was this a deliberate decision?
>
> - **'Yes'** or **'Confirm'** — record it as a decision
> - **'Yes because [reason]'** — record with your reasoning
> - **'No, it's actually [X]'** — I'll record your correction
> - **'Skip'** — move on without recording"

5. Store the decision and move to the next review item

### After all reviews are complete:

> "All [N] findings processed:
> - [X] confirmed
> - [Y] reviewed and recorded
> - [Z] corrected
> - [W] rejected
>
> Your `.decisions/` now has [total] verified decisions with `source: "excavated"`.
> Run `/challenge` to question them, or `/journal` to evolve them over time.
>
> Want to dig deeper? Say `dig deeper` or `dig deeper into [subsystem]`."

---

## PHASE 7 — Store Decisions

### decisions.json Format

Each excavated decision is stored in the standard format with additional fields:

```json
{
  "id": "decision-NNN",
  "slug": "the-slug",
  "title": "Human Readable Decision Title",
  "category": "technical|pattern|ux|business",
  "status": "chosen",
  "chosenOption": "A",
  "chosenTitle": "What the code shows",
  "reasoning": "User's reasoning if they provided it, otherwise null",
  "options": ["A"],
  "recommended": "A",
  "htmlFile": "decision-NNN-slug.html",
  "decidedAt": "ISO timestamp",
  "summary": "One sentence about this decision",
  "source": "excavated",
  "confidence": "high|medium|low",
  "evidence": {
    "files": ["app/api/users/route.ts:23", "app/api/books/route.ts:31"],
    "pattern": "try/catch blocks returning generic 500 responses",
    "layer": "patterns",
    "subsystem": "api"
  },
  "history": []
}
```

**New fields specific to excavate:**
- `source: "excavated"` — tells downstream skills this came from code analysis, not deliberation
- `confidence: "high|medium|low"` — the confidence level at extraction time
- `evidence` — structured evidence data (files, pattern description, which layer found it, which subsystem)

### Landing Page

Generate or update `.decisions/index.html` showing all decisions including excavated ones. Excavated decisions should show a small "excavated" tag alongside their category badge.

---

## IMPORTANT REMINDERS

1. **Evidence is everything.** Never surface a finding without pointing to specific files and code. The user should be able to verify every claim by opening the file.
2. **Decisions, not observations.** "Uses TypeScript" is an observation. "Chose TypeScript with strict mode enabled" is a decision. Always frame findings as choices.
3. **~1 decision per KLOC.** Scale findings to the codebase. A 2k CLI gets 4-6. A 30k game engine gets 25-35. Don't force findings that aren't there, but don't stop at the surface when there's more to find.
4. **Detect the domain, adapt categories.** A game engine needs collision/AI/audio categories, not auth/state-management. Read the code and figure out what kinds of decisions THIS codebase contains.
5. **Map subsystems, probe inside them.** Don't just find "BSP rendering." Find the 5 decisions inside the renderer: visplane pooling, column drawing, colormap lighting, clip tracking, validcount traversal.
6. **Headers first, then targeted reads.** Headers/interfaces reveal architecture cheaply. Deep-read implementation files selectively where headers look interesting.
7. **Proportional depth.** Bigger subsystems get more files read and more decisions extracted. A 12-file rendering pipeline deserves 6-8 files read. A 2-file sound system gets both.
8. **The "tell a teammate" test.** If a senior engineer would mention it during onboarding, it's a decision. If they wouldn't, it's tuning.
9. **Narrate the dig.** As each layer completes, tell the user what you found. Build anticipation.
10. **Confidence is honest.** Green means explicit in config. Amber means consistent pattern. Gray means inference.
11. **Batch confirm is fast.** "Confirm all green" should work. Don't make users click through 15 obvious findings.
12. **Dig deeper is available.** After triage, offer to probe deeper into specific subsystems or go exhaustive.
13. **Delta mode catches drift.** Re-runs show "Recorded: REST. Found: REST + GraphQL" — the most valuable insight.
14. **Source metadata enables downstream.** `source: "excavated"` lets /challenge and /state-your-case adapt their behavior.
15. **Open the triage page automatically.** Always `open .decisions/excavate-triage.html`.
16. **Wait for the user.** After opening the triage page, stop and wait for their triage response.
17. **Respect the focus lens.** If the user said "find the UX decisions," don't report technical stack findings. If they said "just the auth subsystem," stay in that subsystem. A focused excavation should feel focused, not like a full scan with filtering.
