---
name: game-plan
description: "General-purpose planning skill that creates a research-backed operational roadmap for any complex goal. Career transitions, legal battles, major life changes, organizational challenges, or anything where you need a concrete phased plan with specific tasks. Each task tagged as requiring you personally, AI assistance, or fully automatable."
argument-hint: "[describe the goal or situation you need a plan for]"
---

# Game Plan

You are generating a comprehensive, research-backed operational roadmap for achieving a complex goal. This could be anything: landing a new job, navigating a legal situation, executing a major life change, leading an organizational transformation, training for a marathon, or any situation where "figure it out as you go" isn't good enough.

This is the plan that turns a strategy into action. Specific tasks, realistic timelines, and a clear sense of what you need to do yourself vs. what you can get help with.

The user's goal is: **$ARGUMENTS**

**Core principles:**
- **Adapt everything to the situation.** There are no fixed phases or task categories. A career transition plan looks nothing like a legal strategy plan. Research the domain and figure out what phases and tasks actually matter.
- **Research real stories.** Search for how people actually achieved similar goals. Real tactics from real people, not generic advice.
- Every task gets tagged: HUMAN (requires you personally), AI-ASSISTED (you + AI together), or AUTOMATABLE (software/AI can handle it).
- Write in plain English. This should feel like advice from a friend who's been through it.
- **Be absurdly specific.** "Send 5 cold LinkedIn messages to engineering managers at companies on your target list using the template in Phase 1" not "network with people."
- **Include a "What This Looks Like" section in each phase** describing what you should have, be doing, or be capable of at that stage. This is the equivalent of "Product at This Phase" but for any goal.

---

## PHASE 1 -- Understand the Goal

### Step 1a -- Check for Strategy Brief

Check if `.decisions/strategy-brief.md` exists. If it does, the user has already run `/strategize`. Read it and use every decision as context for the plan.

> "I found your strategy brief from /strategize. I'll build the game plan around your decisions. Let me research how people actually execute on this..."

### Step 1b -- Understand the Goal

If there's no strategy brief, read `$ARGUMENTS`. If clear enough, proceed. If too vague, ask:

> "Before I can build a game plan, I need to understand the goal:
> - What does success look like?
> - What's the biggest obstacle?"

---

## PHASE 2 -- Research How People Actually Do This

Before generating anything, research the domain:

1. **Search for real execution stories:** "[goal] how to actually do it step by step," "[goal] timeline realistic," "[goal] mistakes to avoid"
2. **Search for domain-specific tactics:** "[goal] best approach 2025 2026," "[goal] checklist complete guide"
3. **Synthesize into actionable patterns:** What do people do first? What takes longest? What do people skip that they shouldn't?
4. **Tell the user** what you found

---

## PHASE 3 -- Generate the Game Plan

Generate a self-contained HTML playbook and open it in the browser.

### Step 3a -- Determine the Phases

Organize into 4-6 phases based on what THIS goal actually requires. There are no fixed phases. Examples:

**Career transition:** Clarity (what do I want), Preparation (skills, resume, portfolio), Outreach (networking, applications), Interview (prep, practice, execution), Close (negotiation, decision)

**Legal challenge:** Assessment (understand the situation), Counsel (find representation), Preparation (evidence, documentation), Action (filings, proceedings), Resolution (settlement, outcome)

**Fitness goal:** Baseline (where am I now), Foundation (habits, equipment, schedule), Build (progressive training), Push (intensity phase), Maintain (sustainability)

**Organizational change:** Discovery (current state), Alignment (stakeholders), Design (new approach), Pilot (small test), Scale (full rollout)

### Step 3b -- Phase Overview

Each phase gets an overview box with:
- What you're trying to accomplish in plain English
- Why this phase matters (grounded in research)
- What success looks like with specific measurable outcomes

### Step 3c -- "What This Looks Like" Section

Each phase gets a callout box describing what your situation should look like at this stage:
- What you should have (documents, connections, capabilities, assets)
- What you should be doing (daily/weekly activities)
- What you can skip for now (with gray X marks)
- When to move on (the trigger for the next phase)

### Step 3d -- Generate Tasks

For each phase, 5-12 specific tasks with:
- **Title** (verb first)
- **Why it matters** (grounded in research or the strategy)
- **How to do it** (2-4 specific, actionable steps)
- **Effort tag:** HUMAN, AI-ASSISTED, or AUTOMATABLE
- **Priority:** Critical, Important, or Nice-to-have
- **Estimated effort**

### Step 3e -- Write and Open the HTML

Save to `.playbook/playbook.html` using the same interactive HTML template as the product plan skill (with clickable checkboxes, progress tracking via localStorage, research panel, phase overviews, "What This Looks Like" boxes, and tagged tasks).

The header subtitle should say "[Goal] -- Your complete game plan" (not "Your complete launch roadmap").

The footer should reference `/strategize` (strategy) and `/shape` (detailed execution).

Open in browser: `open .playbook/playbook.html`

### Step 3f -- Elevator Pitch at Top

If a strategy brief exists with an elevator pitch, display it at the top of the playbook. If not, synthesize a brief description of the goal from the user's input.

---

## PHASE 4 -- Present and Iterate

> "Your game plan is ready -- [N] tasks across [N] phases. Click any task to check it off, progress is saved in your browser.
>
> Want me to:
> - **Dive deeper** into any specific phase?
> - **Add more tasks** to a particular area?
> - **Research a specific challenge** (e.g. 'how do I actually cold-message hiring managers?')
> - **Generate templates** (email scripts, checklists, prep documents)?"

---

## IMPORTANT REMINDERS

1. **Adapt everything.** No fixed phases or categories. Research the domain and figure out what matters.
2. **Research real stories.** Every playbook includes research on how people actually achieved similar goals.
3. **Be absurdly specific.** Every task should be actionable right now without asking "but how?"
4. **Tag every task.** Human, AI-Assisted, or Automatable.
5. **Include "What This Looks Like" per phase.** Shows what your situation should look like at each stage.
6. **Phase overviews with success criteria.** Every phase describes what you're doing, why, and what done looks like.
7. **Interactive HTML.** Clickable checkboxes that persist via localStorage.
8. **First phase should be doable THIS WEEK.** Quick wins early to build momentum.
9. **Connect the pipeline.** Reference /strategize and /shape.
