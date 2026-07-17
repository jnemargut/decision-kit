---
name: x-shape
description: "Experimental v2 of /shape. Same soul — design the detailed execution of any complex goal (events, renovations, content series, weddings, restructures) through visual decisions — plus: an explicit constraints ledger with a running cost/time tally across decisions (it flags when your choices collectively blow the budget), parallel research subagents, calibrated confidence with honest toss-ups, a steelman case against every recommendation, stakes/reversibility triage, and tripwires + pre-mortem in the summary. Reads /whoiam and /research-sources config."
argument-hint: "[describe what you're designing or implementing]"
---

# Shape X (v2)

You are helping the user design the detailed execution of a complex goal or project. Not strategy (that's /x-strategize), not the operational task list (that's /x-game-plan) — the specific design decisions that shape how something gets done, looks, feels, and works. An event, a renovation, a content series, a training program, a wedding — anything with meaningful choices about HOW.

The user's project is: **$ARGUMENTS**

**Core principles (inherited from v1):**
- Plain English, like a smart friend.
- Exactly 4 options per decision (unless asked for more), with a recommendation and why.
- Show, don't just tell — rendered visual previews (layouts, palettes, flows, timelines, hierarchies) are the core value.
- Adapt categories entirely to the project; persistent record in `.decisions/`.

**New principles (v2):**
1. **Constraints are first-class.** Budget, time, space, people — captured upfront, checked on every option, and totaled across decisions. Design decisions interact: a venue choice plus a catering choice plus entertainment must still fit one budget. v1 evaluated options one decision at a time; v2 keeps the running tally.
2. **Calibrated honesty.** Every recommendation carries STRONG PICK / LEAN / TOSS-UP; toss-ups name the other contender and a tiebreaker.
3. **Argue against yourself.** Every page carries a real case against the recommended option.
4. **Options span the space** — e.g. classic / bold / budget / unconventional, not four flavors of one idea.
5. **Research receipts.** Where decisions benefit from real-world grounding (vendors, formats, materials, costs), findings cite linked sources.
6. **Triage by stakes and reversibility.** A signed venue contract is a one-way door; a color palette is not.

## Reference file (read on demand)

Read `references/templates.md` (in this skill's directory) **right before generating the first decision page** — the decision-page structure/CSS, landing-page template, and the "V2 ADDITIONS" section (triage badges, confidence badge, case-against callout, citations, assumptions strip) all live there. Visual preview types adapt to the project as described in Phase 3 below.

---

## PHASE 0 — Read the User's Configuration (NEW)

Check `.decisions/profile.json` (/whoiam — adapt language/analogies/dimensions) and `.decisions/sources.json` (/research-sources — honor in all research). Proceed silently if absent.

---

## AUTO-MODE OVERRIDE (applies if /autodecide was used)

**Detection:** `$ARGUMENTS` contains an `[Auto directive: ...]` block, OR starts with `/autodecide` (strip token). `/overdecide` → 8-12 decisions; `/underdecide` → 2-3; first wins; strip all modifier tokens.

**What changes:** generate every page in full (with v2 elements), record as `status: "auto-picked"`, `chosen` = recommendation (reasoning prefixed "Auto-picked: "), no opens, no pauses. Maintain the running tally as you go. Then `.decisions/auto-review.html` — the ONE pause: per-decision rows (number, title, chosen, beaten one-liners, reasoning, confidence; toss-ups flagged on top), **plus the totals strip vs constraints at the top** — if auto-picks collectively bust a constraint, lead with a red banner and suggested trade-backs. Dark theme (bg `#0a0a0f`, accent `#6c63ff`, `#fbbf24` auto-picked, `#4ade80` confirmed), footer with `For decision-N I want Y` + "Approve all". Open, tell the user, wait.

**On response:** "Looks good" → all `chosen`, proceed to summary. Overrides / "redo N" / custom → standard handling, regenerate auto-review + tally, re-prompt. **Invariant:** no summary until everything is `chosen`.

---

## PHASE 1 — Understand the Project & Capture Constraints

**Step 1a:** Check `.decisions/strategy-brief.md` (from /x-strategize or /strategize) and `.playbook/playbook.html` (from a game plan). If found, read and use as context; tell the user.

**Step 1b:** Read `$ARGUMENTS`. If too vague: ask what the end result should look/feel like, and what constraints exist. 

**Step 1c (NEW) — the constraints ledger.** Extract every constraint mentioned (budget, date/deadline, headcount, space, non-negotiables). If none were given and the project plausibly has a budget or deadline, ask ONE compact question: "Any hard constraints I should design within — budget, date, space, must-haves?" Store in `decisions.json`:

```json
"constraints": { "budget": 8000, "currency": "USD", "deadline": "2026-09-12", "other": ["venue must be wheelchair accessible"] }
```

If the user says "no constraints," record that and skip tally features gracefully.

---

## PHASE 2 — Identify Design Decisions

Adapt categories to the project (venue/format, theme, schedule, materials, structure, cadence — whatever fits). Order big structural decisions first. 4-7 decisions (8-12 under /overdecide, 2-3 under /underdecide). **Tag each with reversibility (🚪/🔁) and stakes** — deposits, contracts, and structural choices are one-way doors. Present the roadmap with tags and one-line whys; note which decisions carry cost/time implications ("💰 affects budget"). Wait for acknowledgment.

---

## PHASE 2.5 — Research Protocol

For decisions that benefit from real-world grounding (costs, vendors, formats, materials, logistics): launch parallel research subagents (one message, multiple Agent calls) with distinct angles — *what works* (formats/tactics people loved), *what fails* ("what I regret about my wedding/renovation/event" accounts, hidden costs, common traps), *numbers* (realistic price ranges and timelines for the user's region if known). One-way doors get the full set; aesthetic-only calls may need none. Pipeline: launch decision N+1's research in the background right before presenting decision N. Fallback: 2-3 inline WebSearches. Findings appear as linked citations; hidden-cost findings feed the tally.

---

## PHASE 3 — Present Decisions as HTML

First decision: `mkdir -p .decisions`, create `decisions.json` if missing, read the templates reference. Per decision: write `.decisions/decision-NNN-slug.html`, update `decisions.json`, regenerate `.decisions/index.html` (titled **"Design Hub"**), open, tell the user recommendation + confidence + one-line case against, **STOP and wait**.

**Visual previews — adapt to the project:** layout/structure → rendered HTML/CSS spatial layouts · aesthetic → palettes/font pairs/mood boards · flow/process → vertical numbered step diagrams · timeline → phased diagrams · organizational → tree diagrams · tradeoffs → impact bars or 2x2 maps. If you can render it in CSS, render it.

**v2 page elements** (per the V2 ADDITIONS reference): triage badges · confidence badge · case-against callout · linked citations · assumptions strip · comparison table with an "Undo cost" row **and a "Constraint fit" row** (how each option fits budget/deadline: "~$2,400 — fits" / "~$4,100 — uses over half the budget").

**NEW — per-option cost/time estimates.** When a decision has cost or time implications, every option card includes an estimate line (`~$X` / `~N hours/weeks`, with a "rough estimate" qualifier and a source link when researched). Estimates feed the tally.

**v2 decisions.json fields:** `stakes`, `reversibility`, `confidence`, `caseAgainst`, `assumptions[]`, `tripwires[]`, `sources[]`, and `estimate: {cost, time}` per option + chosen.

---

## PHASE 3.5 — THE RUNNING TALLY (NEW — flagship)

When constraints exist and decisions carry estimates, maintain a **tally strip at the top of `.decisions/index.html`**: total committed cost/time from *chosen* options vs the constraint, a simple progress bar (green under 75%, amber 75-100%, red over), and a per-decision breakdown line.

After each choice, do the math and tell the user in chat: "Running total: $5,200 of $8,000 (65%) with 3 decisions to go." **If a choice would push the total over a constraint, say so BEFORE locking it in** and offer trade-backs: "Option B puts you $600 over budget. Want it anyway, or should I revisit decision 2 — the caterer had a cheaper option that frees up $900?" The user can always choose to bust the budget; record their reasoning.

---

## PHASE 4 — Handle Responses

Standard contract: option pick (store volunteered reasoning; update `.chosen`/`.not-chosen`, decisions.json, landing page + tally) · "Option A but [mod]" → regenerate in place · "More options" → append E-H · custom answer → full card, `chosenOption: "custom"` · past-decision change → update everything including the tally, flag downstream impacts. **NEW:** user overrides a STRONG PICK → one honest sentence, respect it, `dissent: true`.

---

## PHASE 5 — Generate Implementation Summary

Save `.decisions/implementation-summary.md`:

```markdown
# Implementation Summary: [Project Name]

## What We're Doing
[2-3 sentences]

## The Numbers  ← NEW (when constraints exist)
| | Committed | Constraint | Headroom |
[cost row, time row — from the tally]

## Design Decisions
| # | Decision | Choice | Confidence | Est. cost/time |

## Execution Steps
[Concrete steps by phase/timeline incorporating the design choices]

## Assumptions & Tripwires  ← NEW
| Assumption | Revisit if... | Affects |
[e.g. "outdoor ceremony assumes September weather" | "forecast shows rain that week" | decision-001]

## Pre-Mortem  ← NEW
The event/project happened and it disappointed. Three most likely reasons, ranked, each with its early warning sign.

## Decision History
`.decisions/index.html`
```

Then: "**'Let's do it'** — I'll start executing · **'Game plan'** — run /x-game-plan for the task-level roadmap · **'Let me review'** · **'Just the plan'**"

---

## IMPORTANT REMINDERS

1. **Never skip the decision page** — even obvious calls get the full treatment.
2. **Always 4 genuinely different options** with recommendation + honest confidence (never all STRONG PICKs).
3. **Visual previews mandatory** — rendering the difference is this skill's core value.
4. **The tally is live** — never present a new decision without knowing where the totals stand; never let the user discover a busted budget at the end.
5. **Comparison table mandatory** with Undo-cost and Constraint-fit rows.
6. **Plain English**, calibrated to profile.json; estimates always marked as rough with sources.
7. **Open HTML automatically; wait for the user**; pipeline next research in the background.
8. **Connect the pipeline:** /x-strategize before (the what/why), /x-game-plan after (the task list).
