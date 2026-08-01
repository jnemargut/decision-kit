# Skills reference

Every skill in Decision Kit, what it does, and when to reach for it.

New here? Start with the [README](../README.md) and just run `/decide`. It picks
the right skill for you. This page is for when you want to go direct.

---

### `/decide` - The entry point to everything

Don't know which skill to use? Don't care. Just say what's on your mind. The orchestrator reads your intent, picks the right skill, and takes you there.

```
/decide help me figure out this sleep app idea
```

### `/decide` variants

Three power-user siblings to `/decide`. They route the same way; only the directive passed to the downstream thinking skill changes:

- **`/overdecide [topic]`**: surfaces 8-12 decisions instead of the usual 4-7. For when you want to be thorough.
- **`/underdecide [topic]`**: surfaces only 2-3 decisions. For when you just want the highest-stakes calls made and the rest defaulted.
- **`/autodecide [topic]`**: auto-picks the recommended option for every decision. Pauses once at the end with a batch-review page so you can override before the action skill runs. Same research, same options, same recommendations; just skip the per-decision pause.

They chain with each other (`/overdecide /autodecide [topic]` = thorough + auto-pick) and also work as inline modifiers on any thinking skill (`/strategize /autodecide [topic]`).

### Thinking Skills

These do the thinking for you. Context gathering, option generation, visual comparisons, tradeoff analysis. Then they stop and wait for your judgment.

| Skill | What it does | When to use it |
|-------|-------------|----------------|
| `/strategize` | Strategy for any complex situation | You have a goal and need to figure out the right approach |
| `/shape` | Design and implementation planning | You know *what*, now figure out *how* |
| `/product-strategy` | Product "what and why" - problem, users, positioning, business model | You're about to build a product |
| `/product-design` | Product "how" - framework, database, visual direction, UX flows | You know what to build, now make the tech and design calls |
| `/visual-design` | Aesthetic polish for any HTML or SVG. Pick a tradition, tune composition/color/type/mood/flourish | You have an existing artifact that looks generic and you want it to feel like *something* |
| `/design-system` | Generate a unique design system through a four-step designer workshop - archetype, sliders, references, tension | You want a full system (palette, type pairing, icons, showcase) that doesn't look like another shadcn default |
| `/ticket-breakdown` | Ticket to implementation plan - scope, approach, testing, PR plan | You have a ticket and want to think before coding |
| `/self-code-review` | Review your own code before the PR | You've written code and want to catch issues before a teammate sees it |
| `/excavate` | Surface decisions hidden in an existing codebase | You inherited a project or want to audit what's already decided |
| `/journal` | Record and track decisions you've already made | You're past exploration and want to document what you know |
| `/state-your-case` | Decision circuit breaker during AI implementation | You want AI to build but flag judgment calls for you |
| `/core-principles` | Derive "X over Y" tension-based principles | You want to articulate the beliefs guiding your strategy |

### Action Skills

These execute on your judgment. They read what you decided and produce deliverables. No questions asked.

| Skill | What it does | When to use it |
|-------|-------------|----------------|
| `/game-plan` | Phased operational roadmap with tasks | After any thinking skill - you need a concrete plan |
| `/product-plan` | Launch playbook - operations, partnerships, go-to-market | After `/product-strategy` - everything beyond writing code |
| `/brief` | Shareable one-page HTML summary | You want to send someone a clean summary of what was decided |
| `/challenge` | Gently challenge your decisions - contradictions, gaps, stale choices | You want a sanity check before a big milestone |

### Configuration Skills

These shape how thinking skills behave. Run them first.

| Skill | What it does |
|-------|-------------|
| `/whoiam` | Tell the system who you are so decisions are framed in your language |
| `/research-sources` | Configure which sources you trust for context gathering |
| `/hook-init` | Connect decisions to an external service for sync and privacy controls |

---

## The X tier — xtra thinking, xtra usage

Nine core skills have an `x-` version. Same soul, same flow, same `.decisions/` format — the dial is just turned up. X skills research in parallel with subagents (including a mandatory pass on *failure stories*), put an honest confidence level on every recommendation (`STRONG PICK` / `LEAN` / `TOSS-UP` — a toss-up gets called a toss-up), argue **against** their own pick on every page, tag every decision as a one-way or two-way door, and record assumptions with tripwires so `/x-challenge` can later check them against reality.

The `x` means **xtra**: better output, noticeably more token usage. Pick per run — `/strategize` when you want the quick pass, `/x-strategize` when the decision deserves the spend.

| X skill | Everything in the original, plus |
|---------|----------------------------------|
| `/x-decide` | Routes to the X tier where it exists, originals otherwise. Passes `/autodecide`, `/overdecide`, `/underdecide`, and `3 takes` through |
| `/x-strategize` | Parallel adversarial research, confidence levels, case-against-my-pick, tripwires + pre-mortem in the brief |
| `/x-shape` | Constraints ledger with a **running cost/time tally** across decisions — flags a busted budget *before* you lock the choice, offers trade-backs |
| `/x-product-strategy` | Multi-angle sweep (competitors / numbers / user complaints / graveyard), **permission to say "don't build this"**, riskiest-assumption + cheapest-test + kill criteria in the brief |
| `/x-product-design` | A **Living Preview** — one composite mockup of your product that absorbs every choice as you make it — plus `tokens.css`/`tokens.json` export |
| `/x-product-plan` | Launch post-mortem research, the riskiest-assumption test as literal Task #1, go/pivot/kill gates between phases |
| `/x-game-plan` | Failure-story research with ⚠ trap warnings on tasks, a day-by-day Week One, dependency tags, checkpoint gates, strategy tripwires → recurring check-in tasks |
| `/x-visual-design` | Previews built from *your* artifact's real content, **Three Takes mode** (`3 takes` → three complete styled variants in parallel, pick one), eyes-on screenshot critique, side-by-side compare page |
| `/x-challenge` | Understands the X metadata: patrols your tripwires against current reality (with fresh web research), re-tests toss-ups, revisits your overrides honestly in both directions, and red-teams its own challenges before showing them |

The tiers compound: an `/x-strategize` brief carries assumptions and tripwires that `/x-game-plan` turns into recurring check-in tasks and `/x-challenge` later verifies against the real world. X skills read `/whoiam` and `/research-sources` config, and support all `/decide` variant modifiers inline.

Shared templates for the X tier live in `shared/x-templates/` and are synced into each skill with `scripts/sync-x-templates.sh` (same convention as `shared/design-dna`): skills ship self-contained, so edit the shared file, then sync.

---

> **Want more detail on any skill?** Expand the section below for full descriptions with code examples, usage flows, and what each skill checks or produces.

<details>
<summary><h3>Full skill details (click to expand)</h3></summary>

---

#### `/strategize` - Strategy for anything

The general-purpose thinking skill. Works for any complex situation: product strategy, business launches, life decisions, anything with real stakes.

```
/strategize my partner and I are launching a food truck
```
It identifies the 4-7 decisions that matter most, gathers context for each one, and presents visual options. You judge. It stores your decisions and generates a strategy brief.

**Example decisions it might present:** Target market, pricing strategy, location model, brand identity, competitive positioning.

---

#### `/shape` - Design and implementation planning for anything

Takes a goal or strategy and walks through the detailed implementation decisions: architecture, visual design, user flows, information structure.

```
/shape how should we structure our community workshop series?
```
Reads any prior strategy decisions, then presents implementation choices with visual previews, layouts, flow diagrams, structural options.

---

#### `/product-strategy` - The "what and why" for products

Validates the idea before you build. Problem definition, target users, market positioning, business model, and success metrics.

```
/product-strategy A tool-sharing app for neighbors
```
Gathers context about the market and landscape, then walks you through the strategic decisions that define what the product is and why it matters.

---

#### `/product-design` - The "how" for products

Technical and UX decisions. Frontend framework, database, visual direction, navigation patterns, user flows, component design.

```
/product-design the v1 tool-sharing app we planned
```
If you've run `/product-strategy` first, it reads your strategy brief and uses it to inform every design option. It won't re-ask who your users are. It already knows.

Picks *which* visual direction to use (10 aesthetic traditions). When you want to go deeper on the aesthetic (stroke weight, color nuance, signature flourish, per-artifact re-skinning), hand off to `/visual-design` on any HTML or SVG artifact you've produced.

---

#### `/visual-design` - Polish any HTML or SVG artifact

Post-step aesthetic thinking. You already have an artifact (a brief from `/strategize`, a playbook from `/game-plan`, a one-pager from `/brief`, an icon from somewhere) and it looks generic. `/visual-design` walks through the aesthetic decisions and rewrites it.

```
/visual-design                                  # auto-detects recent HTML/SVG
/visual-design .decisions/strategy-brief.html   # explicit target
/visual-design icons/download.svg               # SVG icon mode
```

**What it does:**
- Picks from **30 aesthetic traditions** (Editorial, Swiss, Neo-Brutalist, Warm Minimal, Cyberpunk Neon, Neon Terminal, Kraft Paper, Art Deco, 22 more) — every tradition has a unique typographic voice, enforced by the shared design DNA
- **HTML mode (6 steps):** tradition → composition (CSS-only layout art direction) → color → type → mood → signature flourish
- **SVG mode (3 steps):** tradition → stroke weight → color treatment (faithful / mono / accent / duotone)
- Enforces the **banned-defaults list** (no Inter-everywhere, no indigo gradients, no timid palettes) and ends every run with a **render-and-critique gate** — the skill screenshots its own output and fixes what it sees before showing you
- Writes `<name>.styled.html` or `<name>.styled.svg` alongside the original (non-destructive)
- Saves `.visual-design/tokens.json` at the project root. Next run in the same project surfaces your saved aesthetic as suggestion #1

The difference between this and `/product-design`: `/product-design` picks *which* direction at a system level. `/visual-design` goes deep on *how* for a specific artifact. Which vs. how.

#### `/design-system` - Generate a unique design system

A four-step designer workshop — archetype cards, adjective sliders, reference triage, signature tension — that generates a complete system: semantic palette, curated Google Fonts pairing, ~20 novel SVG icons, and an applied showcase, bundled framework-agnostic in `design/` for any downstream generator.

**Amplification rules keep it honest:** every generated choice must trace to a workshop signal, the tension must produce one visible rule-breaking move, and slider extremes override the archetype's comfortable defaults. Outputs pass the same banned-defaults list and critique gate as `/visual-design`.

Both design skills read their shared rules from `shared/design-dna/` — the banned-defaults list, characterful font pool, composition signatures, and critique gate live there once and sync into each skill's `references/` via `scripts/sync-dna.sh` (CI-checkable with `--check`).

---

#### `/ticket-breakdown` - From ticket to implementation plan

Takes a ticket (or any task description), reads the codebase for context, and surfaces the implementation decisions: scope, approach, testing strategy, PR plan, and risks.

```
/ticket-breakdown Add OAuth2 login with Google and GitHub providers.
Should work with our existing user table. Mobile web needs to work.
```
Reads the project, finds your tech stack, existing patterns, relevant files, then presents implementation decisions grounded in YOUR codebase.

**The Adaptive Five decisions:**
- **Scope & Boundaries** - what's in, what's out, what's ambiguous
- **Approach** - how to build it, which patterns, which files
- **Testing Strategy** - what to test, what kind, edge cases
- **PR Plan** - one PR or stacked, what order, smallest shippable piece
- **Risks & Gotchas** - what could break, dependencies, rollback

---

#### `/self-code-review` - Review your own code before the PR

Reads the diff, the codebase, and any prior implementation decisions, then surfaces what you should be thinking about before opening the PR.

```
/self-code-review
```
Or focus it:
```
/self-code-review just the auth changes
```
Produces visual assessment pages for each dimension, each rated green, amber, or red.

**What it checks:** Scope Drift, Architecture Fit, Testing Adequacy, Complexity & Readability, PR Readiness.

**The engineering flow:**
```
/ticket-breakdown PROJ-1234           # decide how to implement
# ... write the code ...
/self-code-review                     # check your work
# ... open the PR for peer review ...
```

---

#### `/excavate` - Codebase decision archaeology

Reads your code and surfaces the decisions nobody wrote down: framework choices, auth patterns, error handling philosophy, UX decisions, even business model signals.

```
/excavate
```
Scans in 4 layers: surface (configs, dependencies), structural (routes, models, middleware), patterns (error handling, testing, state management), and meaning (UX decisions, business model signals). Re-run after changes and it only shows what's new or what drifted.

---

#### `/journal` - Decision journal for brownfield

You bring the answers, AI visualizes and records them. For when you already know things and want to document decisions with reasoning and change tracking.

```
/journal our target user ended up being suburban homeowners, not urban renters
```
AI generates a full visual decision page even though you already know the answer. If this changes a prior decision, it asks one reflection question, then stores both the old and new decision with your reasoning.

---

#### `/state-your-case` - Decision circuit breaker during implementation

Runs WHILE AI is building. When AI encounters a judgment call (something that contradicts a prior decision, needs human input, or is too important to decide silently) it stops, presents options, and waits.

```
/state-your-case build the OAuth login flow from the implementation brief
```
AI builds. When it hits something that needs judgment, it pauses, generates a decision page explaining WHY it stopped, and waits for you to judge. Then continues.

---

#### `/core-principles` - Derive tension-based principles

Surfaces real tensions in your idea, where user needs, business needs, and doing right by the world pull in different directions, and helps you take a stance. Produces principles in "X over Y" format.

```
/core-principles a neighborhood tool-sharing app
```

---

#### `/game-plan` - Operational roadmap from any strategy

Takes your decisions and generates a phased operational roadmap with specific tasks, timelines, and priorities.

```
/strategize thinking about launching a food truck
# ... make your decisions ...
/game-plan
```

---

#### `/product-plan` - Launch playbook for products

Launch roadmap: operations, partnerships, trust-building, supply acquisition, go-to-market execution. Everything beyond writing code.

```
/product-strategy A tool-sharing app for neighbors
# ... make your strategy decisions ...
/product-plan
```

---

#### `/brief` - Shareable one-pager from any decisions

Generates a polished, self-contained HTML one-pager you can share with anyone.

```
/brief
```

---

#### `/challenge` - Hold up a mirror to your decisions

Reads all your decisions and gently challenges them. Surfaces contradictions, flags missing reasoning, identifies untested assumptions, highlights stale decisions.

```
/challenge
```
Or focus it:
```
/challenge are there contradictions with our pricing model?
```

---

#### `/whoiam` - Tell the system who you are

Takes 15 seconds. You tell it your role and how familiar you are with the topic. It saves a profile that adapts language, analogies, and comparison dimensions across every thinking skill.

```
/whoiam I'm a teacher looking into investing for retirement
```

---

#### `/research-sources` - Configure your source trust

5 quick decisions about where information comes from: domain, source types, trusted voices, domain allowlist/blocklist, recency.

```
/research-sources I'm exploring how to price a SaaS product
```

---

#### `/hook-init` - Connect decisions to an external service

Walks through provider selection, project identity, visibility defaults, auto-sync preferences, and credentials. Installs hook scripts from the provider's hook package.

```
/hook-init
```

</details>
