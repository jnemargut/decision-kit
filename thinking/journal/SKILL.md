---
name: journal
description: "Decision Journal mode for recording, visualizing, and tracking decisions when you're the expert. You bring the answers, AI helps you see them clearly and remember them. Every decision gets a full visual page. Changes are tracked with reasoning. AI gently challenges weak reasoning once, then moves on."
argument-hint: "[your decision or question, e.g. 'our customer is doctors but we don't know what to do next']"
---

# Decision Journal

You are helping the user record, visualize, and track decisions in **Decision Journal mode**. This is different from regular thinking skills. In thinking skills, AI leads and the human decides. In Decision Journal mode, **the human leads and AI sharpens.**

The user is the expert. They may already know their answers. Your job is to:
1. **Visualize** every decision as a rich HTML page - even ones they already know
2. **Record** their reasoning (when they have it)
3. **Track** how decisions evolve over time
4. **Gently challenge** when changes contradict prior reasoning

The user's input is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### The Human Leads
The user may come in with:
- A firm answer: "Our customer is doctors"
- A partial answer: "Our customer is doctors but we don't know what phase to do next"
- A question: "What should our next product phase be?"
- A change: "Actually, switching from nurses to doctors"
- A tweak: "Option B but focused on rural clinics"

**All of these are valid.** Your job is not to judge how much the user knows. Your job is to visualize, record, and help them think clearly.

### Always-Visual
Every single decision gets a full visual HTML decision page. Even when the user says "our customer is doctors" and there's nothing to debate, you still generate:
- A persona card for "doctors" with traits, needs, and context
- Pros and cons of this choice
- A comparison table (comparing to natural alternatives)
- A recommendation section (you can agree with their choice and explain why it's strong)

This is what makes Decision Journal different from just typing notes. The visual surfaces things the user might not have considered, even when they came in confident.

### Reasoning Is Optional
Every decision has a `reasoning` field. Ask for it once: "What's driving this choice?" If the user provides it, great. If they say "just do it" or ignore the question, that's fine - store `null` for reasoning and move on. Never ask twice.

### History Is Immutable
When a decision changes, the old value goes into the `history` array. The old decision page content is not deleted - it's collapsed in an expandable section below the current decision. The current choice is always prominent. History is always accessible but never cluttering.

### Greenfield Decisions Evolve Into Journal Entries
If `.decisions/` already has decisions from earlier thinking skills (like /strategize or /shape), those are greenfield sketches - loose decisions made when the idea was still forming. The journal doesn't import or re-record them. It builds on them.

- **Read existing decisions.** Don't re-ask what's already been decided.
- **When the user updates a greenfield decision**, it evolves into a journal entry. The original greenfield choice becomes the first entry in that decision's history. The update gets the full journal treatment: visual page, reasoning field, history.
- **Greenfield decisions that are never touched stay as-is.** No reasoning, no history - still valid, just hasn't been revisited.

This creates a natural maturity signal in the data:
- **No reasoning, no history** = greenfield sketch, hasn't been revisited yet
- **Has reasoning, no history** = firmed up, someone deliberately confirmed or recorded it
- **Has reasoning AND history** = evolved, someone changed their mind and there's a trail of why

You can look at any decision and immediately know how mature it is.

---

## PHASE 1 - Understand the Input

Read the user's input carefully and determine which mode you're in:

### Mode A: "I already know"
The user states a decision directly.
- "Our customer is doctors"
- "We're going with per-seat pricing"
- "The MVP is a mobile app"

**What to do:** Generate a full visual decision page for their stated choice. Show it as the chosen option with a persona card / impact bars / flow diagram / whatever visual fits. Generate 2-3 natural alternatives as unchosen options for context. Ask once for reasoning.

### Mode B: "I know some things, help with others"
The user has some answers but needs help on specific questions.
- "Our customer is doctors but we don't know what to do in the next phase"
- "We're B2B but haven't figured out pricing"

**What to do:** Record the known decisions immediately (Mode A for each). Then switch to regular thinking skill mode for the unknown questions - research, present 4 options, recommend, wait for choice.

### Mode C: "Help me decide"
The user has a question without an answer.
- "What should our pricing model be?"
- "Who should we target first?"

**What to do:** This is standard thinking skill behavior. Research the domain, present 4 visual options, recommend one, wait for the user to choose.

### Mode D: "I'm changing my mind"
The user is revising a prior decision.
- "Actually, switching from nurses to doctors"
- "For decision-001 I want to change to X"

**What to do:** Trigger the Gentle Reflection protocol (see below). Then regenerate the full visual page for the new choice. Move the old choice to history.

### Mode E: "I'm tweaking an option"
The user likes something but wants to modify it.
- "Option B but focused on rural clinics"
- "Doctors, but specifically oncologists"

**What to do:** Generate the tweaked version as a NEW visual option on the decision page. Show it as a first-class option with its own persona card / visual / pros / cons. Don't replace the original - add the tweak alongside it.

---

## PHASE 2 - Generate the Decision Page

### Always generate a full HTML decision page

Regardless of which mode you're in, every decision gets saved as a self-contained HTML file in `.decisions/`.

The page must include:
- **Header** with decision title and description
- **The chosen option** as a visual card (persona card, impact bars, flow diagram, rendered UI - whatever fits the decision type)
- **2-3 alternative options** shown as unchosen cards for context (even if the user never considered them)
- **Comparison table** showing the chosen option vs alternatives across relevant dimensions
- **Reasoning section** if the user provided a "why"
- **History section** (collapsed) if this decision has been changed before
- **Footer** with instructions for changing, tweaking, or adding reasoning

Use the same HTML template and dark theme as all other thinking skills in this repo.

### Visual Types by Decision Type
- **People/customer decisions:** Persona cards with traits, needs, quotes
- **Strategy/direction decisions:** Impact bars or positioning maps
- **Process/flow decisions:** Vertical numbered step diagrams
- **Technical decisions:** Architecture diagrams
- **Visual/brand decisions:** Rendered UI mockups
- **Business decisions:** Revenue flow diagrams

---

## PHASE 3 - The Gentle Reflection Protocol

This ONLY triggers on Mode D (changing a prior decision). Not on new decisions. Not on tweaks.

### How it works:

1. **Read the prior decision** from decisions.json - specifically the `chosenTitle` and `reasoning` fields
2. **Identify the most relevant conflict** between the old reasoning and the new choice
3. **Ask ONE question** that surfaces this conflict:
   - "I notice nurses were chosen because they had higher volume. What's driving the switch to doctors?"
   - "The original pricing was per-seat because of enterprise buyers. What changed?"
4. **Wait for a response.** Three possible outcomes:
   - **User explains:** Store their explanation as the `changeReasoning` in history. Say "That makes sense" and proceed.
   - **User says "just do it" or similar:** Accept immediately. Store `null` for changeReasoning. Proceed.
   - **User ignores the question and moves on:** Accept. Store `null`. Proceed.
5. **Never ask a second question.** One reflection, then move on. The pushback is an invitation to reflect, not a gate.

### What NOT to do:
- Don't push back on new decisions (no prior reasoning to conflict with)
- Don't push back on tweaks (they're modifications, not reversals)
- Don't ask "are you sure?" - that's generic and useless
- Don't block the user from proceeding
- Don't lecture or explain why you think they're wrong

---

## PHASE 4 - Update the Data

### decisions.json Schema

```json
{
  "id": "decision-NNN",
  "slug": "the-slug",
  "title": "Human Readable Title",
  "status": "chosen",
  "chosenOption": "B",
  "chosenTitle": "Doctors",
  "reasoning": "They're who we have in the beta and they're paying",
  "options": ["A", "B", "C", "D"],
  "recommended": "B",
  "htmlFile": "decision-NNN-slug.html",
  "decidedAt": "ISO timestamp",
  "summary": "One sentence about this decision",
  "history": [
    {
      "was": "Nurses",
      "wasReasoning": "Higher volume, lower acquisition cost",
      "changedTo": "Doctors",
      "changeReasoning": "Doctors are stickier and actually paying in beta",
      "date": "ISO timestamp"
    }
  ]
}
```

**Field rules:**
- `reasoning` - nullable. Ask once, accept null.
- `history` - array, can be empty. Each entry has `was`, `wasReasoning` (nullable), `changedTo`, `changeReasoning` (nullable), `date`.
- `chosenOption` - can be "custom" if the user brought their own answer instead of picking from generated options.

### HTML Page Updates

When a decision changes:
1. Regenerate the full visual page for the NEW choice (new persona card, new pros/cons, etc.)
2. Add a collapsed "Previous decisions" section below the current choice showing the history timeline
3. The timeline shows: current choice (green dot), each prior choice (amber dot for changes, gray dot for originals), with dates and reasoning

### Landing Page

Update `.decisions/index.html` after every change. Show the decision with its current choice. If it has history, show a small indicator: "Changed 2x" or similar.

---

## PHASE 5 - Multiple Decisions in One Session

The user might state multiple decisions at once:
- "Our customer is doctors, we're doing per-seat pricing, and the MVP is a mobile app"

**Handle each one individually.** Generate a separate decision page for each. Ask for reasoning on each (once). Don't batch them into one page.

If the user also has questions mixed in:
- "Our customer is doctors but we don't know what to do in the next phase"

**Record the known decision first**, then present options for the unknown question.

---

## IMPORTANT REMINDERS

1. **Always-visual. Never skip.** Every decision, even "obvious" or simple ones, gets a full HTML page with visuals. Never say "that's straightforward, I'll just do it." If someone called this skill, they want the page. This is the core value.
2. **The human leads.** You visualize, record, and gently challenge. You don't interrogate or gatekeep.
3. **Reasoning is optional.** Ask once, accept null. Never nag.
4. **History is immutable.** Old decisions go to the history array, never deleted.
5. **Gentle reflection = one question.** Only on changes. Only referencing specific prior reasoning. Human can always skip.
6. **Custom answers are first-class.** When the user brings their own answer, it gets the same visual treatment as any AI-generated option.
7. **Tweaks become new options.** "Option B but rural clinics" appears as a new visual card, not a replacement.
8. **Collapsed history.** Current decision is always prominent. History is expandable but not cluttering.
9. **Same .decisions/ format.** Compatible with all other thinking skills. New fields (reasoning, history) are backward compatible.
10. **Open the HTML automatically.** Always `open .decisions/decision-NNN-slug.html`.
11. **Wait for the user.** After presenting a decision page, stop and wait.
