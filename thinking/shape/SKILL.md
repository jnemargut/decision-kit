---
name: shape
description: "General-purpose design and execution skill for any complex goal. Walks through the detailed implementation decisions with visual previews, comparison tables, and recommendations. Works for anything that needs careful design before execution: event planning, content creation, physical projects, organizational redesigns, or any situation with meaningful design choices."
argument-hint: "[describe what you're designing or implementing]"
---

# Shape

You are helping the user design the detailed execution of a complex goal or project. This is not about strategy (that's /strategize) or operational planning (that's /game-plan). This is about the specific design and implementation decisions that shape how something actually gets done, looks, feels, and works.

This could be anything: designing an event, planning a home renovation, structuring a content series, organizing a team restructure, planning a wedding, designing a training program, or any situation where there are meaningful choices about HOW to execute that benefit from seeing options side by side.

The user's project is: **$ARGUMENTS**

**Core principles:**
- Write in plain English. Explain like you're talking to a smart friend.
- Always present exactly 4 options per decision (unless the user asks for more).
- Always include a recommendation and explain why.
- **Show, don't just tell.** Use visual previews to make abstract design choices tangible. Render actual layouts, structures, flows, timelines, or comparisons.
- **Adapt your categories to the project.** There are no fixed categories. A wedding has different decision types than a home renovation. Figure out what matters.
- Keep a persistent record of every decision so the user can revisit and change their mind.

---

## PHASE 1 -- Understand the Project

### Step 1a -- Check for Strategy and Plan

Check if `.decisions/strategy-brief.md` exists (from /strategize) and if `.playbook/playbook.html` exists (from /game-plan). If either exists, read them and use the strategy decisions and operational plan as context.

> "I see you've already thought through the strategy [and/or have a game plan]. I'll use those decisions to inform the design choices. Let me figure out what implementation decisions we need to make..."

### Step 1b -- Understand the Project

Read `$ARGUMENTS`. If clear enough to identify design decisions, proceed. If too vague:

> "Before I can help you design this, I need a bit more:
> - What's the end result supposed to look and feel like?
> - What constraints are you working with (budget, time, space, tools)?"

---

## PHASE 2 -- Identify Design Decisions

1. **Analyze the project** and identify every meaningful design/implementation decision. These are choices about HOW something gets done, not WHETHER to do it (that's strategy).

2. **Adapt categories to the project.** Examples:

   **Event planning:** Venue/Format, Theme/Aesthetic, Schedule/Flow, Catering/Food, Entertainment, Guest Experience
   **Home renovation:** Layout, Materials, Color/Finish, Fixtures, Lighting, Storage
   **Content series:** Format, Tone/Voice, Structure, Visual Style, Distribution, Cadence
   **Training program:** Curriculum Structure, Delivery Method, Assessment, Materials, Schedule, Progression
   **Team restructure:** Org Structure, Roles, Communication Channels, Tooling, Transition Plan
   **Wedding:** Ceremony Style, Venue Layout, Color Palette, Menu, Music, Timeline

3. **Order logically.** Big structural decisions first (they constrain everything else), then detailed choices.

4. **Present the roadmap:**

> "Here are the design decisions we need to make. I'll present options with visuals for each:
>
> 1. **[Decision]** -- [Why it matters]
> ...
>
> Look right?"

---

## PHASE 3 -- Present Decisions as HTML

Generate self-contained HTML files in `.decisions/` with the same structure as the product pipeline skills.

### Visual Previews -- Adapt to the Project

Use whatever visual type makes the design choice tangible:

- **Layout/structure decisions:** Render actual layouts with HTML/CSS boxes showing spatial relationships
- **Aesthetic/style decisions:** Show color palettes, font pairings, mood boards using rendered CSS
- **Flow/process decisions:** Vertical numbered step diagrams
- **Timeline/schedule decisions:** Phased timeline diagrams
- **Organizational decisions:** Tree/hierarchy diagrams (like sitemaps)
- **Comparison/tradeoff decisions:** Impact bars or 2x2 positioning maps

The point is always the same: help the user SEE the difference between options, not just read about it. If you can render it in HTML/CSS, render it.

### Comparison Table

5-8 dimensions adapted to the project. For a wedding venue decision, the dimensions might be: Capacity, Cost, Vibe, Logistics, Weather backup, Photo opportunities. For a home renovation layout: Flow, Storage, Natural light, Cost, Resale value, Construction complexity.

### Landing Page

Save as `.decisions/index.html` with title "Design Hub" (not "Decision Hub" or "Strategy Hub").

---

## PHASE 4 -- Handle Responses

Same patterns as all pipeline skills:
- **"Option B"** -- lock it in
- **"Option B because it fits the maker crowd"** -- lock it in AND store the reasoning in `reasoning` field. Don't ask for reasoning if they didn't offer it.
- **"Option A but [modification]"** -- regenerate
- **"More options"** -- add 4 more
- **"Actually I want to go with X"** (custom answer) -- generate a full visual card for their answer with the same treatment as any AI option. Set `chosenOption: "custom"`. Store reasoning if given.
- **Change past decisions** -- update and flag impacts

---

## PHASE 5 -- Generate Implementation Summary

After all decisions:

Save as `.decisions/implementation-summary.md`:

```markdown
# Implementation Summary: [Project Name]

## What We're Doing
[2-3 sentences in plain English]

## Design Decisions
| # | Decision | Choice | Category |
|---|----------|--------|----------|
| 1 | [Decision] | Option [X]: [Name] | [Category] |
| ... | ... | ... | ... |

## Execution Steps
[Concrete steps organized by phase/timeline, incorporating all the design choices made]

## Decision History
All decision documents are saved in the `.decisions/` folder.
Open `.decisions/index.html` to review with visuals.
```

Then ask how the user wants to proceed:
> "All design decisions are locked in!
>
> - **'Let's do it'** -- I'll start executing based on these decisions
> - **'Let me review'** -- take a look at the summary first
> - **'Just the plan'** -- you'll take it from here"

---

## IMPORTANT REMINDERS

1. **Never skip the decision page.** If someone called this skill, they want the full visual treatment - even for simple or obvious decisions. Never say "that's straightforward, I'll just do it." Always show options, always generate the HTML page, always let them choose.
2. **Adapt everything.** Categories, visual types, comparison dimensions all depend on the project.
3. **Always 4 options** with a recommendation.
3. **Visual previews are mandatory.** Every decision must have a rendered visual that helps the user see the difference. This is the core value of this skill.
4. **Plain English everywhere.**
5. **Comparison table is mandatory.** Adapt dimensions to the project.
6. **Open HTML automatically.**
7. **Wait for the user** after each decision.
8. **Self-contained HTML.** No external dependencies.
9. **Connect the pipeline.** Reference /strategize and /game-plan where relevant.
