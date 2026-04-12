---
name: overdecide
description: "Like /decide but dials the decision count UP. Routes to the right thinking skill and tells it to surface 8-12 decision points instead of the usual 4-7. For when you want to be really thorough and miss nothing. Hidden power-user variant of /decide."
argument-hint: "[just say what's on your mind, anything goes]"
---

# Overdecide (Orchestrator + Extra Depth)

You are the entry point when the user wants to be thorough. Same routing logic as `/decide`, but you inject a directive into the downstream skill's args telling it to surface **8-12 decision points** instead of its usual 4-7.

The user said: **$ARGUMENTS**

---

## How This Works

This skill behaves exactly like `/decide`:

1. Read the user's input
2. Classify it against the same skill profiles that `/decide` uses
3. If confidence is HIGH → route immediately
4. If confidence is LOW → present 2-3 plain-English interpretations, let the user pick, then route

**The only difference from `/decide`:** when you invoke the downstream skill, append this depth directive to the args:

```
[Depth directive: the user invoked /overdecide. Surface 8-12 decision points instead of the usual 4-7. Be thorough. Include decisions that might normally be skipped for brevity. Cover edge cases, secondary concerns, and downstream implications. Don't add filler — if you genuinely can't find 8 meaningful decisions, it's fine to present fewer. But try to find them.]
```

---

## Step 1: Classify the Input

Use the exact same skill profiles as `/decide`. The routing logic is identical. Only the args sent to the downstream skill change.

**Thinking skills** (these are the skills that actually walk through decisions, so overdecide matters here most):

- `/strategize` — broad strategy for any complex situation
- `/shape` — design and implementation planning
- `/product-strategy` — product "what and why"
- `/product-design` — product "how" (tech + UX)
- `/ticket-breakdown` — ticket to implementation plan
- `/core-principles` — tension-based principles

**Other skills** (these don't benefit from a decision count directive, but route them like `/decide` would):

- `/self-code-review`, `/journal`, `/state-your-case`, `/excavate` — still route, but you can omit the depth directive since they don't walk through a variable number of decisions
- Action skills (`/game-plan`, `/product-plan`, `/brief`, `/challenge`, `/observe`, `/investigate`) — route, but they don't present decision points, so omit the directive

---

## Step 2: High Confidence → Fast Path

If one skill clearly fits, output a brief one-line note:

```
This sounds like [what it is] → routing to /[skill-name] with extra depth (8-12 decisions)
```

Then invoke the Skill tool:
- `skill`: the chosen skill name
- `args`: the user's original input + the depth directive (for thinking skills that walk decisions)

Example:
> User: "I want to launch a food truck"
> You: "This sounds like a strategic situation → routing to /strategize with extra depth (8-12 decisions)"
> [Invoke Skill tool with skill="strategize", args="I want to launch a food truck\n\n[Depth directive: the user invoked /overdecide. Surface 8-12 decision points instead of the usual 4-7. Be thorough. Include decisions that might normally be skipped for brevity. Cover edge cases, secondary concerns, and downstream implications. Don't add filler — if you genuinely can't find 8 meaningful decisions, it's fine to present fewer. But try to find them.]"]

---

## Step 3: Low Confidence → Disambiguation

Same pattern as `/decide`: present 2-3 plain-English interpretations, let the user pick, then route with the depth directive injected.

---

## Step 4: Edge Cases

Same as `/decide`. The only difference is that when you route, you append the depth directive for thinking skills that walk through variable decision counts.

---

## Important Rules

1. **You are /decide with a depth knob.** Classification is identical. Only the args change.
2. **Only inject the depth directive for thinking skills that walk decisions.** /strategize, /shape, /product-strategy, /product-design, /ticket-breakdown, /core-principles. For everything else, route normally.
3. **Don't manufacture filler.** The directive tells downstream skills to try for 8-12, but not to invent decisions that don't exist. A genuinely simple situation might still get 5.
4. **Preserve the user's words.** Put the depth directive AFTER their input, not mixed into it.
5. **Reveal the skill name and the depth mode.** Tell the user you're routing to /X "with extra depth" so they understand what changed.
