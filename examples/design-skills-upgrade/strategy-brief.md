# Strategy Brief: Decision-Kit Design Skills Upgrade

## Elevator Pitch

> "Every AI-generated site looks the same — same font, same purple gradient, same three cards. It's not laziness, it's statistics: models sample the high-probability center of their training data. I rebuilt decision-kit's design skills to force the model off that center: banned defaults by name, a tradition library where no two aesthetics share a voice, layout that actually changes, and a critique gate where the skill screenshots its own output and fixes what it sees before showing you."

## The Situation

The /visual-design and /design-system skills in [decision-kit](https://github.com/jnemargut/decision-kit) produce outputs that look samey and underwhelming. The audit found the causes are structural, not cosmetic: the 30-tradition library converges on the same fonts (Inter in 4+ traditions — the #1 "AI slop" signature), /visual-design never touches layout so every artifact shares identical bones, the workshop skill's four discovery signals get compressed through static lookup tables into a generic middle, and neither skill ever looks at what it produced.

## Key Decisions

| # | Decision | Choice | Category |
|---|----------|--------|----------|
| 1 | Root cause priority | Option A: Token diversity + banned defaults first | Diagnosis |
| 2 | /visual-design upgrade | Option B: Catalog overhaul + CSS-only composition signatures | Skill design |
| 3 | /design-system upgrade | Option B: Make the signals bite (amplification rules) | Skill design |
| 4 | Shared core architecture | Option B: Single source (`shared/design-dna/`), synced at release | Architecture |
| 5 | Quality validation | Option A: Runtime critique gate (script checks → screenshot → binary self-critique) | Verification |
| 6 | Contribution packaging | Option A: One epic PR (chosen over recommended phased PR train) | Shipping |
| 7 | Elevator pitch | Option A: Problem-first (the convergence story) | Positioning |

## What Gets Built

1. **`shared/design-dna/`** — canonical home for the banned-defaults list, characterful font pool (Bricolage Grotesque, Space Grotesk, Plus Jakarta Sans, Fraunces, Fontshare faces…), traditions library, and composition signatures. A small sync script copies it into each skill's `references/` so installed skills stay self-contained. Forces the overdue refactor of the ~1,800-line visual-design SKILL.md down to the recommended size.
2. **/visual-design overhaul** — no two traditions share a typographic voice; each tradition gains a CSS-only composition signature (grid-template-areas remixes, asymmetric heroes, broken-grid offsets — DOM untouched); a new "Composition" step joins the flow; the rewrite step enforces the ban list.
3. **/design-system amplification** — every generated choice must trace to a named workshop signal; slider extremes force non-obvious picks; the signature tension must produce at least one visible rule-breaking move; reference DNA can override the archetype table; wider font pools + ban list as the data layer; rationale printed per choice in the showcase.
4. **Runtime critique gate (both skills)** — deterministic checks (ban-list grep, WCAG contrast, font overlap) → screenshot via headless Chrome where available → analytic binary self-critique → one fix loop. Graceful CSS-review fallback keeps the kit's no-dependency promise.
5. **Evidence** — a small before/after gallery (one artifact × 4 traditions, one workshop profile) included in the PR, plus this `.decisions/` folder per CONTRIBUTING.md's own convention.

## Key Research Findings

- **Distributional convergence** is the named root cause of AI design sameness — models default to Inter, purple gradients, and three-column layouts unless forced off the statistical center ([Shuffle](https://shuffle.dev/blog/2026/01/why-do-most-ai-generated-websites-look-the-same/), [925studios](https://www.925studios.co/blog/ai-slop-web-design-guide), [Vandelay Design](https://www.vandelaydesign.com/why-ai-generated-designs-look-the-same/)).
- **Anthropic's frontend-design skill** bans defaults by name ("Inter, Roboto, Arial, system fonts"; "purple gradients on white") and guides five dimensions individually — typography, color, motion, spatial composition, backgrounds. "The key is intentionality, not intensity." ([SKILL.md](https://github.com/anthropics/claude-code/blob/main/plugins/frontend-design/skills/frontend-design/SKILL.md), [Claude cookbook](https://platform.claude.com/cookbook/coding-prompting-for-frontend-aesthetics))
- **CSS Grid `grid-template-areas` enables art direction without touching the DOM** — magazine spreads, asymmetric heroes, broken grids from the stylesheet alone ([Smashing Magazine](https://www.smashingmagazine.com/2018/04/art-directing-web-css-grid/)).
- **Agents that inspect their own rendered output converge in 2–3 iterations instead of 10+** — the Playwright screenshot feedback pattern ([luca-becker.me](https://luca-becker.me/blog/level-up-agentic-coding-mcp-2-playwright/), [azukiazusa.dev](https://azukiazusa.dev/en/blog/playwright-cli-ai-agent-visual-feedback/)).
- **Binary analytic rubrics beat numeric scales for LLM judging**; pairwise comparison is where judges are reliable ([Evidently AI](https://www.evidentlyai.com/llm-guide/llm-as-a-judge), [Confident AI](https://www.confident-ai.com/blog/why-llm-as-a-judge-is-the-best-llm-evaluation-method)).
- **Skills must be self-contained**; SKILL.md should be ~1,500–2,000 words with detail in `references/` under progressive disclosure ([Claude Code docs](https://code.claude.com/docs/en/skills)).
- **2026 characterful font supply**: Bricolage Grotesque, Space Grotesk, Plus Jakarta Sans, Fraunces, plus free Fontshare faces (Satoshi, General Sans) — "pairing a ubiquitous body with a distinctive display is the secret weapon of modern product design" ([Typewolf](https://www.typewolf.com/google-fonts), [Precode](https://www.precode.co/insights/best-font-pairings-2026-beyond-google-fonts)).

## Risks and Assumptions

- **The epic PR (Decision 6) trades reviewability for coherence.** Defect detection drops sharply past ~400 reviewable lines; this PR will be thousands. Mitigation: structure the branch as 4 clean, logically ordered commits mirroring the phases (DNA → visual-design → design-system → critique gate) and run `/code-review ultra` on the branch before merge.
- **Amplification rules can overshoot into gimmicky output.** The "one rule-breaking move" constraint needs tuning against real artifacts before merge.
- **Composition signatures assume artifacts tolerate re-areaing.** Dense tables/dashboards may not; the signature must no-op gracefully per artifact type.
- **The critique gate's screenshot step assumes headless Chrome.** The CSS-review fallback must be genuinely useful, not a stub, or headless/CI users get a worse skill.
- **Validate first:** restyle one real artifact (e.g., an EdTech report page) with the new traditions before building everything — the fastest test of whether the new voices actually read as different.

## Next Steps

Run `/game-plan` for the operational roadmap (build order, tasks tagged human/AI-assisted/automatable), or start implementing directly — the natural first move is creating `shared/design-dna/banned-defaults.md` and `font-pool.md`, since every other piece reads from them.
