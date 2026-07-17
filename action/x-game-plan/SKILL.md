---
name: x-game-plan
description: "Experimental v2 of /game-plan. Same soul — a research-backed phased operational roadmap for any complex goal, every task tagged human/AI-assisted/automatable — plus: parallel research including failure stories, a day-by-day Week One, dependency tags on tasks, per-phase checkpoint gates with pivot criteria, and automatic conversion of your strategy brief's tripwires into recurring check-in tasks. Reads /whoiam and /research-sources config."
argument-hint: "[describe the goal or situation you need a plan for]"
---

# Game Plan X (v2)

You are generating a comprehensive, research-backed operational roadmap for achieving a complex goal — a job search, a legal situation, a life change, a marathon, an organizational transformation. This turns strategy into action: specific tasks, realistic timelines, and clarity about what the user must do personally vs. what they can get help with.

The user's goal is: **$ARGUMENTS**

**Core principles (inherited from v1):**
- Adapt everything — no fixed phases or categories; research the domain and find what matters for THIS goal.
- Research real stories — tactics from people who actually did it, not generic advice.
- Every task tagged 🧑 HUMAN / 🤖 AI-ASSISTED / ⚡ AUTOMATABLE, with priority and estimated effort.
- Be absurdly specific — "send 5 cold LinkedIn messages to engineering managers on your target list using the Phase 1 template," not "network."
- Each phase gets a "What This Looks Like" box: what you should have, be doing, can skip, and the trigger to move on.
- Plain English; first phase doable THIS WEEK.

**New principles (v2):**
1. **Failure stories are half the research.** For every "how people did it" search, run a "how people failed at it" search. The traps go into the plan as explicit warnings on the relevant tasks.
2. **The plan checks itself.** Each phase ends with a checkpoint gate: what to measure, what result means proceed, and what result means pivot (with the pivot named). Plans that only know how to go forward aren't plans.
3. **Tripwires become tasks.** If the strategy brief carries tripwires ("revisit decision 3 if X"), each becomes a recurring check-in task in the plan — strategy assumptions get monitored, not forgotten.
4. **Dependencies are visible.** Tasks that block other tasks say so; the critical path is identifiable.
5. **Week One is day-by-day.** The gap between "having a plan" and "starting" kills more plans than bad planning does. The first 7 days get a concrete daily schedule.

## Reference file (read on demand)

Read `references/playbook-template.md` (in this skill's directory) **right before generating the playbook HTML** — the interactive template (clickable checkboxes with localStorage progress, research panel, phase overviews, callout boxes, task cards with effort tags) plus effort-tag/priority/specificity rules live there. Adapt wording: header subtitle "[Goal] — Your complete game plan"; rename the "Product at This Phase" box to "What This Looks Like"; footer references /x-strategize and /x-shape.

---

## PHASE 0 — Read Configuration & Prior Thinking

1. `.decisions/profile.json` (/whoiam) — adapt language and analogies.
2. `.decisions/sources.json` (/research-sources) — honor in all research.
3. `.decisions/strategy-brief.md` (from /x-strategize or /strategize) — if found, the plan executes that strategy: use every decision as context, surface the elevator pitch at the top of the playbook, and **harvest the "Assumptions & Tripwires" and "Pre-Mortem" sections** — tripwires become recurring check-in tasks (see below), pre-mortem failure modes become warnings on the tasks where they'd bite.
4. `.decisions/decisions.json` — note any `confidence: "tossup"` decisions; the plan should include an early task that gathers the information that would settle them.

If no brief exists, read `$ARGUMENTS`; if too vague, ask: what does success look like, and what's the biggest obstacle?

---

## PHASE 1 — Research How People Actually Do (and Fail at) This

Launch parallel research subagents (one message, multiple Agent calls), each with a distinct angle:

- **Success stories** — "[goal] how to actually do it step by step", real accounts, realistic timelines
- **Failure stories** — "[goal] mistakes to avoid", "why I failed at [goal]", what people skip that they shouldn't, where motivation dies
- **Domain tactics & numbers** — current best approaches, realistic costs/durations, benchmarks ("how many applications per offer", "typical timeline for X")

Each agent returns `finding — source — URL` lists, honoring sources.json. Fallback: 3-4 inline WebSearches covering at minimum success + failure angles. Synthesize into actionable patterns (what people do first, what takes longest, what kills momentum) and tell the user the most surprising finding.

---

## PHASE 2 — Generate the Game Plan

`mkdir -p .playbook`, read the playbook template reference, then build:

**Phases:** 4-6, shaped by THIS goal (career: Clarity → Preparation → Outreach → Interview → Close; fitness: Baseline → Foundation → Build → Push → Maintain; etc.). Each phase gets: **Phase Overview** (what, why it matters grounded in research, measurable success) and **"What This Looks Like"** (have / doing / can-skip / move-on trigger).

**Tasks:** 5-12 per phase. Each: verb-first title · why it matters (research-grounded) · how to do it (2-4 concrete steps) · effort tag · priority · estimated effort · **NEW: `blocked by` note when it depends on another task** (reference the task by phase+name; keep it light — only real dependencies) · **NEW: ⚠ trap warnings** on tasks where failure-story research found a common mistake ("most people send generic messages here — that's why response rates are 2%; personalize the first line").

**NEW — Week One, day-by-day:** between the intro and Phase 1, a "Your First 7 Days" box: Day 1 through Day 7, each with 1-3 small concrete actions pulled from Phase 1's easiest high-momentum tasks. Someone should be able to start today without reading the rest.

**NEW — Checkpoint gates:** each phase ends with a visually distinct gate card: *Measure:* [the 1-2 numbers or facts to check] · *Proceed if:* [threshold] · *Pivot if:* [threshold + the named pivot: "fewer than 2 interviews from 40 applications → stop applying cold; switch to the referral-first track and revisit strategy decision 4"]. Gates come from research benchmarks, not invented numbers.

**NEW — Tripwire check-ins:** every tripwire from the strategy brief becomes a small recurring task ("every 2 weeks: check whether [condition]; if yes, revisit decision N before continuing"), placed in the phase where it's most likely to fire.

Write `.playbook/playbook.html`, open it.

---

## PHASE 3 — Present and Iterate

> "Your game plan is ready — [N] tasks across [N] phases, with checkpoint gates between phases and your first week planned day by day. Click any task to check it off; progress saves in your browser.
>
> Research note: based on how people actually did this — and the [N] most common ways they failed, which are flagged ⚠ on the tasks where they bite.
>
> Want me to: **dive deeper** into a phase · **add tasks** to an area · **research a specific challenge** · **generate templates** (scripts, checklists, prep docs)?"

Handle follow-ups by editing the playbook HTML in place and re-opening.

---

## IMPORTANT REMINDERS

1. **Adapt everything** — phases and categories come from the domain research, not a fixed list.
2. **Failure research is mandatory** — a plan without trap warnings is half a plan.
3. **Be absurdly specific** — every task actionable right now without asking "but how?"
4. **Tag every task**; mark real dependencies; keep the critical path visible.
5. **Gates between phases** — measurable proceed/pivot criteria from research benchmarks. Never invent thresholds; if research gave none, say the gate is a judgment call and name what to weigh.
6. **Week One is day-by-day**; the first phase is doable this week.
7. **Tripwires from the strategy brief become recurring tasks** — never silently drop them.
8. **Interactive HTML** with localStorage progress, per the template reference.
9. **Connect the pipeline:** /x-strategize (strategy) and /x-shape (detailed design) — and for products, /x-product-plan is the launch-specific sibling.
