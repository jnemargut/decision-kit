# Critique Gate

Design skills must look at their own output before the user does. Agents that inspect rendered results converge on good output in 2–3 iterations; blind generation takes 10+. The gate runs after the final artifact is written and **before** it is opened for the user. Maximum two fix loops — this is a gate, not a polishing treadmill.

## Stage 1 — Deterministic checks (always run; no judgment)

1. **Ban scan** — run the self-check greps from `banned-defaults.md` against the generated file(s): banned fonts outside fallback tails, banned accent hexes.
2. **Contrast** — compute WCAG contrast for body text on its background from the resolved tokens; require ≥ 4.5:1 (large display text ≥ 3:1).
3. **Composition proof** — if a composition signature was chosen, confirm the final CSS contains at least one structural property that differs from a default single column (grid-template-areas, asymmetric fractions, span, offset).
4. **Font-delivery check** — every non-system family referenced in CSS has a corresponding Google Fonts (or declared) `<link>`/`@font-face`.

Any failure: fix immediately (these have unambiguous fixes), note it for the final report.

## Stage 2 — Render

Try, in order; use the first that works:

1. **Chrome/Chromium headless** (present on most dev machines):
   ```bash
   # macOS
   "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu \
     --screenshot="$TMPDIR/vd-critique.png" --window-size=1280,2200 "file://$PWD/<artifact>"
   # Linux: google-chrome or chromium with the same flags
   ```
2. **Playwright MCP / browser tools**, if available in the session.
3. **Fallback — no renderer available:** skip to the CSS self-review variant of Stage 3. Do not silently skip the gate.

Read the screenshot (you can read images natively).

## Stage 3 — Binary critique

Answer each question yes/no against the screenshot (or, in fallback mode, against the final CSS + HTML read carefully). Binary beats scales: "rate this 1–10" is noise; "is X true" is signal.

| # | Question | Pass is |
|---|----------|---------|
| 1 | Is any banned default visible (slop font rendering, indigo-gradient accent, reflexive 3-card row)? | No |
| 2 | Does the headline establish hierarchy at a glance (one clear entry point)? | Yes |
| 3 | Are more than two accent colors competing? | No |
| 4 | Is the composition visibly different from a default centered single column (when a signature was chosen)? | Yes |
| 5 | Is all text comfortably readable at rendered size (no clipped, overlapping, or sub-12px body text)? | Yes |
| 6 | Is the signature flourish (or rule-breaking move) actually visible in the render? | Yes |
| 7 | Does anything overflow, collide, or break at 1280px width? | No |
| 8 | If project memory exists (`.visual-design/tokens.json` / prior `design/`): would this output be mistaken for the previous project's at a squint? | No |

**Fallback (CSS self-review) variant:** answer 1, 3, 4, 6 from the code; replace 2, 5, 7 with: "does the type scale put the h1 at ≥ 2.4× body size," "is body line-height between 1.4–1.8 and measure ≤ 80ch," "do absolute/negative-margin rules have a `@media` collapse below 720px."

## Stage 4 — Fix loop

- Any failed question → make the smallest fix that flips it, then re-run Stage 1 + the failed questions only.
- **Maximum 2 loops.** If something still fails after two, ship anyway and tell the user exactly what's unresolved and why.
- Never "fix" by deleting the distinctive move (flourish, composition, rule-break). The gate guards quality, not safety-by-blandness. If the distinctive move itself is the problem, adjust its execution, not its existence.

## Reporting

Append one short paragraph to the final user-facing message: what the gate checked, what it caught, what it fixed, and anything left unresolved. One sentence each. If everything passed first try, one sentence total.
