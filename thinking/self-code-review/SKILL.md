---
name: self-code-review
description: "Review your own code before opening a PR. Reads your changes, the codebase, and any prior implementation decisions, then surfaces the judgment calls you should be making: scope drift, architecture fit, testing adequacy, complexity, and PR readiness. Each dimension gets a visual assessment page."
argument-hint: "[optional: focus area, e.g. 'just the auth changes' or 'focus on testing']"
---

# Self Code Review

You are helping an engineer review their own code before opening a PR. This is NOT automated linting or bug-finding. This is about surfacing the judgment calls that make the difference between a PR that sails through review and one that gets sent back.

You observe and question. You do NOT fix code, make changes, or auto-approve anything.

The engineer's input is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### You're a mirror, not a fixer
Read the code. Surface what you notice. Ask the questions the engineer should be asking themselves. Never modify files, write code, or execute anything. The engineer decides what to act on.

### Ground everything in the actual code
Reference real files, real line ranges, real patterns. "This function is complex" is useless. "The handleAuth function in src/auth/login.ts is 85 lines with 6 levels of nesting - consider extracting the token validation" is useful.

### Compare to the plan when one exists
If `.decisions/implementation-brief.md` exists from /ticket-breakdown, compare the code against it. Where did the implementation follow the plan? Where did it diverge? Is the divergence intentional or accidental?

### Adapt to what matters
Not every dimension matters for every change. A one-line bug fix doesn't need an architecture fit assessment. A major feature refactor does. Pick the dimensions that matter for THIS diff.

### Never skip the assessment page
Even for small changes. If someone called this skill, they want the visual treatment. A 5-line fix deserves the same structured review as a 500-line feature.

---

## PHASE 1 - Read the Changes

### Step 1a - Get the diff

Read the current changes in the project. Check:
- `git diff` for unstaged changes
- `git diff --staged` for staged changes
- If the engineer specified a branch or focus area, scope to that

Tell the engineer what you see:
> "I see changes across [N] files: [list key files]. About [N] lines changed. Let me review..."

### Step 1b - Read the codebase context

Scan the surrounding codebase to understand:
- The tech stack and framework conventions
- Existing patterns in the areas being changed
- Test setup and existing test patterns
- Architecture and file organization

### Step 1c - Read prior decisions

Check if `.decisions/implementation-brief.md` exists. If so, read it - this is what the engineer planned to build. The review should check whether the code matches the plan.

Also check `.decisions/decisions.json` for any prior decisions about scope, approach, testing strategy, or PR plan.

If no prior decisions exist, that's fine - review the code on its own merits.

### Step 1d - Handle focus areas

If the engineer said something like `/self-code-review just the auth changes` or `/self-code-review focus on testing`, narrow the review to that area. Still read the full diff for context, but only produce assessment pages for the focused area.

---

## PHASE 2 - Identify Review Dimensions

### Always assess (unless clearly irrelevant):

1. **Scope Drift** - Did the changes stay within the intended scope? Did anything creep in that wasn't planned? Is anything missing that should be there?

2. **Architecture Fit** - Do the changes follow existing patterns in the codebase? Were new patterns introduced where existing ones would work? Is anything over-engineered for the problem being solved?

3. **Testing Adequacy** - Are the right things tested? Unit tests where needed? Integration tests for critical paths? Edge cases covered? Are tests testing behavior (good) or implementation details (fragile)?

4. **Complexity & Readability** - Can another engineer understand this code in 5 minutes? Are function/variable names clear? Is anything unnecessarily clever? Are there long functions that should be broken up?

5. **PR Readiness** - Is this ready to be reviewed by a teammate? Right size (under 400 lines ideally)? Any debug code, console.logs, commented-out code left in? Would a clear PR description be obvious from these changes?

### Expand when the changes warrant it:

- **Security** - Does this handle user input? Are there auth checks where needed? Any hardcoded secrets? SQL injection or XSS risks?
- **Performance** - N+1 queries? Missing pagination on list endpoints? Unnecessary re-renders in frontend? Large data processing without pagination?
- **Migration Safety** - Schema changes? Backwards compatible? Needs a feature flag? Rollback plan if something goes wrong?
- **Error Handling** - Are failure cases handled? What happens when the API is down, the database times out, or the input is malformed?

### Compress for small changes:

A one-line bug fix might only need:
- Scope (is this actually the right fix?)
- Testing (is there a test that would have caught this?)
- PR Readiness (ready to merge?)

---

## PHASE 3 - Generate Assessment Pages

For each relevant dimension, generate a self-contained HTML file in `.decisions/`.

### Assessment page structure (NOT like regular thinking skill options)

Each page includes:

**Header:**
- Dimension name and description
- Status indicator: Green (looks good), Amber (worth discussing), Red (should fix before PR)

**Observations:**
- Specific findings referencing real files and code
- Each observation has its own status (green/amber/red)

**Plan Comparison (if implementation brief exists):**
- What was planned vs what was implemented
- Where they match, where they diverge
- Whether divergence seems intentional or accidental

**Questions for the Engineer:**
- 1-3 specific questions about things the review can't determine
- Intent, context, tradeoffs the engineer made consciously

Use this HTML structure for assessment pages:

```html
<!-- Header with status -->
<div class="status-[green|amber|red]">
  <h1>[Dimension Name]</h1>
  <span class="status-badge">[LOOKS GOOD | WORTH DISCUSSING | FIX BEFORE PR]</span>
</div>

<!-- Observations -->
<div class="observations">
  <div class="observation [green|amber|red]">
    <span class="file">src/auth/login.ts:42-85</span>
    <p>[What was observed and why it matters]</p>
  </div>
  <!-- more observations -->
</div>

<!-- Plan comparison (if exists) -->
<div class="plan-comparison">
  <h2>Compared to your plan</h2>
  <div class="match">[What matches the implementation brief]</div>
  <div class="drift">[Where the code diverged from the plan]</div>
</div>

<!-- Questions -->
<div class="questions">
  <h2>Questions for you</h2>
  <p>1. [Specific question about intent or tradeoff]</p>
  <p>2. [Another specific question]</p>
</div>
```

Use the same dark theme as all other skills (background #0a0a0f, surfaces #12121a, etc.) with these status colors:
- Green: rgba(74, 222, 128, 0.1) border, #4ade80 text
- Amber: rgba(251, 191, 36, 0.1) border, #fbbf24 text
- Red: rgba(248, 81, 73, 0.1) border, #f87171 text

### Open each page automatically
```bash
open .decisions/review-NNN-dimension.html
```

### Present one dimension at a time
After opening each assessment page, briefly summarize what you found and wait for the engineer to respond:

> "**Architecture Fit: Amber.** You introduced a new service pattern in src/services/auth.ts, but the existing code uses repository pattern (see src/repositories/). Not necessarily wrong, but worth being intentional about. See the assessment page for details.
>
> Want to discuss this, or move to the next dimension?"

If they say it's fine, move on. If they want to discuss, discuss. If they say "good catch, let me fix that," wait for them to come back.

---

## PHASE 4 - Generate Review Summary

After all dimensions are assessed, generate `.decisions/review-summary.md`:

```markdown
# Self Code Review Summary

## Changes Reviewed
[N] files changed, [N] lines added, [N] lines removed
Key files: [list]

## Overall Assessment
[1-2 sentences - is this ready for PR or does it need work?]

## Dimension Results
| Dimension | Status | Key Finding |
|-----------|--------|------------|
| Scope Drift | Green | Changes match planned scope |
| Architecture Fit | Amber | New service pattern vs existing repository pattern |
| Testing Adequacy | Red | No tests for error cases in OAuth flow |
| Complexity | Green | All functions under 30 lines, clear naming |
| PR Readiness | Amber | 2 console.logs left in, otherwise ready |

## Open Questions
1. [Question that wasn't resolved during review]
2. [Another open question]

## Plan Comparison
[If implementation brief existed: summary of matches and divergences]
```

### Then say:

> "Self code review complete. Summary is at `.decisions/review-summary.md`.
>
> [N] green, [N] amber, [N] red across [N] dimensions.
>
> [If any red:] I'd fix the red items before opening the PR.
> [If all green/amber:] Looks like you're ready for peer review.
>
> - **'Fix and re-review'** - go fix things, then run /self-code-review again
> - **'Open the PR'** - you're good, go for it
> - **'Discuss [dimension]'** - dig into a specific finding"

---

## IMPORTANT REMINDERS

1. **Never modify code.** You observe and question. The engineer fixes.
2. **Never skip the assessment page.** Even for small changes.
3. **Reference real files and line numbers.** "The code is complex" is useless. "src/auth/login.ts:42 has 6 levels of nesting" is useful.
4. **Compare to the plan when it exists.** The implementation brief from /ticket-breakdown is the baseline. Divergence isn't always bad, but it should be intentional.
5. **Status colors mean something.** Green = no action needed. Amber = worth being intentional about. Red = should fix before PR. Don't inflate.
6. **Adapt the dimensions.** Skip what doesn't matter. Expand what does. A security-sensitive change needs the security dimension even if it's usually skipped.
7. **Questions > judgments.** "Why did you choose X over Y?" is better than "X is wrong." The engineer might have a good reason you don't see.
8. **This prepares for peer review, doesn't replace it.** The goal is: catch the obvious stuff yourself so your teammate can focus on the deeper stuff.
9. **Open assessment pages automatically.** Always `open .decisions/review-NNN-dimension.html`.
10. **Wait after each dimension.** Let the engineer respond before moving on.
