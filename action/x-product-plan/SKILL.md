---
name: x-product-plan
description: "Experimental v2 of /product-plan. Same soul — a research-backed launch playbook covering everything outside the code (operations, partnerships, trust, supply seeding, go-to-market), every task tagged human/AI-assisted/automatable, with 'Product at This Phase' capability requirements per phase — plus: parallel research including launch post-mortems, the riskiest-assumption test from your strategy brief as literal Task #1, per-phase go/pivot/kill gates, dependency tags, and tripwire check-in tasks. Part of the Product Pipeline: use after /x-product-strategy, before /x-product-design."
argument-hint: "[describe your product or paste your strategy brief]"
---

# Product Plan X (v2)

You are generating a comprehensive, research-backed operational playbook for launching a product — everything OUTSIDE the code. Uber had to convince people to drive strangers around; Airbnb had to convince people to sleep in strangers' homes. Every product has a "big how" beyond the app: partnerships, trust-building, supply seeding, legal groundwork, community, go-to-market. That's this playbook.

The user's request is: **$ARGUMENTS**

**Core principles (inherited from v1):**
- NOT about how to code the app (that's /x-product-design). About everything else — plus what the product must be *capable of* at each phase.
- **"Product at This Phase"** box per phase: what form the product takes (a Google Form is a valid v1!), core capabilities needed, what can wait, and the transition trigger. As simple as possible for as long as possible.
- Research real launch stories — what Uber/Airbnb/relevant comparables actually did, not theory.
- Every task tagged 🧑 Human / 🤖 AI-Assisted / ⚡ Automatable, with priority and estimated effort.
- Plain English, specific to THIS product. "Post in 5 local Facebook groups for neighborhoods with new construction," not "build community."

**New principles (v2):**
1. **Validation before operations.** If the strategy brief names a riskiest assumption and cheapest test (x-product-strategy does), that test is **literally Task #1 of Phase 1** — before domain registration, before logo, before anything. The kill criteria go on the task card.
2. **Launch post-mortems are half the research.** For every "how they launched" search, a "why launches like this die" search: cold-start death spirals, trust breakdowns, regulatory surprises, channels that stopped working. Traps become ⚠ warnings on the tasks where they bite.
3. **Phase gates with go/pivot/kill.** Each phase ends with measurable criteria: proceed if X, pivot if Y (pivot named), kill/pause if Z. From research benchmarks, not invented numbers.
4. **Tripwires become tasks.** Strategy-brief tripwires convert into recurring check-in tasks placed where they're most likely to fire.
5. **Dependencies visible.** Tasks that block others say so.

## Reference file (read on demand)

Read `references/playbook-template.md` (this skill's directory) **right before generating the playbook HTML** — the full interactive template (clickable checkboxes + localStorage progress, research panel, phase overview + `.product-phase` callout boxes, task cards with effort tags) and the effort-tag/priority/specificity rules.

---

## PHASE 0 — Read Configuration & Strategy

1. `.decisions/profile.json` and `.decisions/sources.json` — adapt language; honor research preferences.
2. `.decisions/strategy-brief.md` — if present, the playbook is a direct execution plan for it: elevator pitch verbatim at the top; every decision as context. **Harvest the v2 sections when present:** "Riskiest Assumption & Cheapest Test" → Task #1 (see below); "Assumptions & Tripwires" → recurring check-in tasks; "Pre-Mortem" → ⚠ warnings on the relevant tasks; toss-up decisions → an early task that gathers the settling information.
3. No brief? Read `$ARGUMENTS`; if too vague, ask: what does it do and for whom, and what's the hardest non-technical challenge?

---

## PHASE 1 — Research Real Launch Stories (and Deaths)

Launch parallel research subagents (one message, multiple Agent calls), distinct angles:

- **Launch stories** — how 2-3 comparable products actually got first users/supply, first city tactics, cold-start solutions
- **Post-mortems** — comparable products that died or stalled: what killed them (supply churn, trust incident, CAC, regulation), "[industry] startup failed why"
- **Operational specifics** — partnership strategy, trust & safety operations, supply acquisition tactics, legal/launch checklist requirements for this product type
- **Numbers** — realistic conversion/retention/supply benchmarks for the category (these feed the phase gates)

Each agent returns `finding — source — URL` lists honoring sources.json. Fallback: 3-4 inline WebSearches minimally covering launch stories + post-mortems. Tell the user the key insight before building.

---

## PHASE 2 — Generate the Playbook

`mkdir -p .playbook`, read the template reference, then build:

**Phases:** 4-6, adapted to THIS product (marketplace: Foundation → Supply Seeding → Trust Infrastructure → Soft Launch → Growth → Sustainability; B2B: Foundation → Partnerships → Pilot → Sales Infrastructure → Scale; consumer: Foundation → Community Seeding → Launch & PR → Growth Loops → Retention). Each phase: **Phase Overview** (what/why/measurable success) + **Product at This Phase** box.

**Task #1 — the validation task (NEW).** When the brief carries a riskiest assumption: the first task of Phase 1 is running its cheapest test, with the kill criteria printed on the card and a gate immediately after it ("kill criteria met → stop; revisit strategy before spending another dollar"). If there's no brief, derive the riskiest assumption yourself from the research and do the same.

**Tasks:** 5-12 per phase: verb-first title · why it matters (research-grounded) · how (2-4 concrete steps) · effort tag · priority · estimated effort · **`blocked by` note for real dependencies** · **⚠ trap warnings** from post-mortem research on the tasks where they bite ("Nextdoor-style geo-gating killed early liquidity for X — seed one neighborhood to density before opening the next").

**Phase gates (NEW):** a visually distinct card ending each phase: *Measure* → *Proceed if* → *Pivot if* (pivot named) → *Kill/pause if*. Benchmarks from research; when research gave none, say the gate is a judgment call and name what to weigh.

**Tripwire check-ins (NEW):** each brief tripwire becomes a recurring task ("every 2 weeks: check [condition]; if fired, revisit decision N").

**Week One day-by-day (NEW):** a "Your First 7 Days" box before Phase 1 — Days 1-7, each with 1-3 concrete actions (Day 1 usually starts the riskiest-assumption test).

Write `.playbook/playbook.html`, open it.

---

## PHASE 3 — Present and Iterate

> "Your launch playbook is open — [N] phases, [N] tasks, everything from [first phase] to [last phase], each task tagged human/AI/automatable. It starts by *testing your riskiest assumption* ([assumption]) before you spend on anything else — kill criteria included. Between phases there are go/pivot/kill gates based on how [Company A] and [Company B]'s launches actually went — and died.
>
> Want me to: **dive deeper** into a phase · **add tasks** · **research a specific challenge** ('how do I actually get tool-lending insurance?') · **generate templates** (outreach scripts, partnership one-pagers)?"

Handle follow-ups by editing the playbook HTML in place and re-opening.

---

## EDGE CASES

No strategy brief → run standalone from `$ARGUMENTS` (derive the riskiest assumption from research). Existing `.playbook/` → read it, ask whether to regenerate or extend. Product is pre-idea ("should I even build this?") → point to /x-product-strategy first.

---

## IMPORTANT REMINDERS

1. **Task #1 is the validation test** whenever a riskiest assumption is known. A playbook that starts with logo design has failed.
2. **Post-mortem research is mandatory** — every playbook knows how launches like this die, and says so on the relevant tasks.
3. **Gates between phases** with go/pivot/kill from research benchmarks; tripwires from the brief become recurring tasks — never silently dropped.
4. **"Product at This Phase" in every phase** — as simple as possible for as long as possible; spreadsheets before software.
5. **Be specific to THIS product**; tag every task; mark real dependencies; estimates honest.
6. **Interactive HTML** per the template reference; open it automatically.
7. **Connect the pipeline:** /x-product-strategy before (it wrote the brief), /x-product-design after (it builds what "Product at This Phase" demands).
