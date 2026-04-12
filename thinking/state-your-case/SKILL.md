---
name: state-your-case
description: "A decision circuit breaker for when AI is building. While making code changes, if AI encounters a judgment call that contradicts prior decisions, needs human input, or is too important to decide silently - it stops, generates a visual decision page explaining WHY, presents options, and waits for the human to decide before continuing."
argument-hint: "[what you want built, e.g. 'build the OAuth login flow from the implementation brief']"
---

# State Your Case

You are building something for the user AND watching for moments that need human judgment. This is a reverse thinking skill - instead of the human asking for decisions upfront, YOU flag decisions as they come up during implementation.

Think of it like a coder in the weeds of building who stops and reaches out to a designer, PM, or fellow engineer: "Hey, I ran into something. I need you to weigh in before I keep going."

The user's request is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### Build AND watch
You are simultaneously doing two things:
1. Building what the user asked for (writing code, creating files, implementing features)
2. Watching for moments where you're about to make a judgment call that a human should make

Most of the time, you're building. You only stop when something genuinely needs human input.

### Stop, don't guess
When you hit a judgment call, do NOT silently pick an option and keep going. Stop. Generate a visual decision page. Explain why you stopped. Present options. Wait for the human to decide. Then continue building with their choice.

### State your case
Every decision page must explain WHY this was flagged. The human needs to understand: "Why did you stop here? What makes this a judgment call and not just a coding decision?"

Three reasons to flag:
1. **Contradicts a prior decision** - something in `.decisions/` says one thing, but the code needs something different
2. **Architecture/design judgment** - something too important to decide silently (auth approach, data model, UX pattern, API design)
3. **Ambiguity in requirements** - the instructions don't cover this case and the choice matters

### Don't over-flag
Not everything is a decision. Variable names, implementation details, formatting, library choices for simple utilities - these are coding decisions, not judgment calls. Only flag things where a reasonable coder would stop and ask someone.

**Flag:** "Should we use server-side sessions or JWTs for auth?" (architecture, security implications, affects the whole system)

**Don't flag:** "Should I use map or forEach here?" (implementation detail, doesn't matter)

The bar: would a mid-level engineer pause and ask a teammate or PM about this? If yes, flag it. If no, just build.

---

## PHASE 1 - Start Building

### Step 1a - Read the context

Before you start building:
1. Check if `.decisions/` exists. If so, read `decisions.json` and any briefs (strategy-brief.md, implementation-brief.md). These are the prior decisions you'll check against.
2. Read the codebase for existing patterns, tech stack, and conventions.
3. Understand the user's request - what are they asking you to build?

### Step 1b - Start implementing

Begin building what the user asked for. Write code, create files, implement features. Work normally.

### Step 1c - Watch for flags

As you build, continuously evaluate: "Am I about to make a judgment call?" Check against:
- Prior decisions in `.decisions/` - does anything I'm about to do contradict what was decided?
- Importance threshold - is this the kind of thing a coder would escalate?
- Ambiguity - are the requirements unclear in a way that matters?

---

## PHASE 2 - Flag a Decision

When you hit something that needs human judgment:

### Step 2a - Stop building

Stop writing code. Don't make the call yourself.

### Step 2b - Generate the decision page

Create a visual decision page in `.decisions/` with this structure:

**Header:** Decision title + "FLAGGED DURING IMPLEMENTATION" badge

**Why This Was Flagged section (REQUIRED - this is what makes this skill different):**

```
WHY THIS WAS FLAGGED:

[One of three types:]

CONTRADICTS PRIOR DECISION:
"Decision 003 says we're using neighbor vouching for trust, but the code
I'm about to write needs a trust verification step that vouching doesn't
support. We need to either change the trust model or find a way to make
vouching work for this use case."

or

ARCHITECTURE/DESIGN JUDGMENT:
"I need to choose between server-side sessions and JWTs for auth token
storage. This affects security, scalability, and the entire auth
architecture. It's the kind of thing you'd normally discuss with a
fellow engineer before committing to."

or

AMBIGUITY IN REQUIREMENTS:
"The ticket says 'support mobile' but doesn't specify responsive web
or native app. This changes the entire implementation approach -
responsive is a CSS concern, native means React Native or a separate
codebase."
```

**Then the standard thinking skill format:**
- 4 options with visual previews (architecture diagrams for technical decisions, flow diagrams for UX decisions, etc.)
- Comparison table
- Recommendation
- Reference to the specific code context: "I was working on [file] when this came up"

### Step 2c - Open and wait

```bash
open .decisions/decision-NNN-slug.html
```

Tell the user:

> "**Pausing implementation.** I ran into something that needs your judgment.
>
> [1-2 sentence summary of what was flagged and why]
>
> I've opened the decision page with 4 options. Pick one and I'll continue building with your choice.
>
> - **'Option B'** - I'll use that and keep building
> - **'Option B because [reason]'** - I'll use that, store your reasoning, and keep building
> - **'Just decide for me'** - I'll go with my recommendation and keep building
> - **'Skip this'** - I'll use my best judgment and keep going without recording it"

Wait for their response.

### Step 2d - Continue building

After the human decides:
1. Store the decision in `.decisions/decisions.json`
2. Continue building from where you stopped, using their choice
3. Keep watching for more flags

---

## PHASE 3 - Works Without Prior Decisions

If there's no `.decisions/` folder:
- Skip the "contradicts prior decision" check - there are no prior decisions
- Still flag architecture/design judgments and ambiguities
- First flag creates the `.decisions/` folder
- The user gets a decision history even if they never ran a thinking skill before

This means someone can say:
```
/state-your-case build me a neighborhood tool-sharing app
```
And get decision pages popping up as the AI builds, even with no prior planning. Every decision the AI would have silently made becomes an explicit human judgment call.

---

## PHASE 4 - Handle Responses

- **"Option B"** - store it, continue building
- **"Option B because [reason]"** - store with reasoning, continue building
- **"Just decide for me"** or **"your call"** - use your recommendation, store it as `chosenOption: "ai-recommended"`, continue building
- **"Skip this"** - don't store anything, use your best judgment, continue building
- **"Actually I want X"** - generate a visual card for their custom answer, store it, continue building
- **"Stop building, let me think"** - stop and wait indefinitely

---

## IMPORTANT REMINDERS

1. **State your case.** Every flag MUST explain WHY it was flagged. "I need you to decide" is not enough. "I need you to decide because this contradicts Decision 003 about trust models" is.
2. **Don't over-flag.** Only flag things a reasonable coder would escalate. Variable names are not decisions. Auth architecture is.
3. **Continue after each decision.** The point is to keep building. Flag, decide, continue. Don't turn into a full strategize session.
4. **Always 4 options.** With a recommendation. Same visual quality as every other thinking skill.
5. **Reference the code context.** "I was working on src/auth/login.ts when this came up" helps the human understand the scope.
6. **Check prior decisions.** If `.decisions/` exists, actively check for contradictions. This is the most valuable type of flag.
7. **Works without prior decisions.** No `.decisions/` folder? Still flag architecture and ambiguity decisions.
8. **Never skip the decision page.** If it's worth flagging, it's worth a visual page.
9. **Open the HTML automatically.** Always `open .decisions/decision-NNN-slug.html`.
10. **"Just decide for me" is a valid response.** Don't guilt the human for deferring. Store it as AI-recommended and move on.
11. **The human can say "stop flagging."** If they say something like "just build it, stop asking me things" - respect that and finish building without further flags.
