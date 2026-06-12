# Banned Defaults

The shared "never do" list for every design-producing skill in Decision Kit. These are the high-probability defaults language models fall into when no one stops them — the signatures of AI-generated sameness. Anthropic's own frontend-design guidance bans most of these by name; Decision Kit enforces them.

**The rule:** none of the items below may appear in generated output unless the user explicitly asks for them, or a tradition's own tokens demand them (each exception is noted). Before declaring any output done, run the self-check at the bottom.

## Banned fonts

| Font | Status | Why |
|------|--------|-----|
| Inter, Inter Tight | Banned as display AND as default body | The #1 AI-slop signature. Allowed only in fallback stacks (`..., Inter, sans-serif`). |
| Roboto, Roboto Condensed/Slab | Banned everywhere | Android default; reads as "no decision was made." |
| Arial, Helvetica | Banned as a choice | Allowed only as final fallback stack entries. |
| `system-ui` / -apple-system as the *chosen* voice | Banned | Fine as fallback tail; never the answer to "what should this feel like." |
| Open Sans, Lato, Montserrat | Banned as display | 2015 defaults. Body use discouraged; pick something with intent. |
| Poppins | Banned as display | The 2022 default. Geometric ≠ character. |
| One mono to rule them all | Banned pattern | JetBrains Mono may not be the universal mono across traditions. Each tradition owns its own mono voice (JetBrains Mono belongs to Dashboard Operator). |

## Banned color moves

- **Purple-to-blue gradients on white.** The canonical AI hero. Includes indigo `#6366f1`, violet `#8b5cf6`, and the Tailwind indigo ramp as unconsidered accent defaults.
- **Timid, evenly-distributed palettes.** Every semantic color at equal visual weight. Required instead: one dominant color family + one sharp accent. ("Dominant colors with sharp accents outperform timid, evenly-distributed palettes" — Claude frontend-aesthetics cookbook.)
- **Pure `#000` on pure `#fff`** without intent. Exceptions: Monochrome, Neo-Brutalist, Zine, Anti-Design — traditions whose tokens demand it.
- **The same accent for every interactive state.** Hover/active/focus deserve deliberate shifts.

## Banned layout moves

- **The identical centered single-column card stack** for every artifact regardless of content. Composition must be a decision, not an absence of one.
- **Three equal cards in a row** as the reflexive feature/option layout (`1fr 1fr 1fr` with identical card chrome).
- **Uniform border-radius on every element.** Radius is a voice decision per tradition, not a global soften.
- **Entrance animation on everything.** One orchestrated page-load moment beats scattered fade-ins.

## Banned typography moves

- 16px/1.5 body with unconsidered scale — the scale must come from the tradition's tokens.
- Display font used at body sizes, or body font doing display work because no display face was chosen.
- Letter-spacing left at default on all-caps text.

## Self-check (run before declaring output done)

Deterministic — no judgment required:

1. `grep -iE "Inter|Roboto|Open Sans|Lato|Montserrat|Poppins" <output>` → every hit must be inside a fallback stack tail or a deliberate, user-approved choice. Arial/Helvetica may appear only after a chosen face in a stack.
2. `grep -iE "#6366f1|#8b5cf6|#7c3aed|#4f46e5" <output>` → no hits unless the user picked them.
3. Check the resolved palette: is there one dominant family and one sharp accent, or five timid equals? Fix the latter.
4. Check computed body-text contrast against its background: ≥ 4.5:1 (WCAG AA).
5. If a composition signature was chosen: confirm at least one structural CSS property (grid-template-areas, asymmetric column widths, span/offset) actually differs from a default single column.

If any check fails, fix and re-check once. Report what was caught in your final message.
