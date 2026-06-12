# /design-system

A Claude Code thinking skill that walks you through a four-step designer workshop — archetype, adjective sliders, reference triage, signature tension — then generates a unique, AI-driven design system: novel SVG icons, a curated Google Fonts pairing, a semantic palette, and an applied showcase HTML plus a framework-agnostic bundle that any downstream generator (Claude Code, v0, Lovable, Subframe) can adopt in one line.

## Pitch

> Walk away with a design system that's yours alone — a typography pairing curated for your brand, AI-generated icons that match, a palette built from your discovery, components — delivered as an applied showcase you can see, plus a framework-agnostic bundle Claude Code adopts in one command. Twenty minutes. No designer required.

## Who it's for

The **Taste-Aspiring Builder**: developers with design sensibility who know they lack a formal taste framework. Already runs Claude Code thinking skills. Wants craft, not a quiz. Learns the framework while using it.

## What it does

Runs a four-step workshop:

1. **Archetype** — Pick primary (70%) + secondary (30%) from the 12 Jungian archetypes, presented as an illustrated card deck (sigil + essence quote + example brands).
2. **Adjective axes** — Place your product on 6 bipolar sliders (playful/serious, warm/cool, classic/modern, quiet/loud, organic/geometric, restrained/expressive).
3. **Reference triage** — 3 products you love from unrelated industries. URL + one sentence on why. Skill fetches each page for visual DNA + combines with your articulation.
4. **Signature tension** — Declare a stance in the form "X but Y" where both sides are good. Prevents generic-middle outputs.

Then generates:

- **Palette** — full semantic token set (10-step neutral ramp + brand + accent + success/warning/danger/info + surfaces) driven by all four discovery signals
- **Icons** — ~20 novel SVG icons with anchor-first + spec + two-pass review for consistency
- **Typography** — a curated Google Fonts pairing (one display, one body) chosen from the archetype's type tendency, narrowed by adjective sliders, refined by reference DNA and tension. Real production fonts, with a written rationale for the pairing.
- **Showcase** — a self-contained HTML with DNA tab (palette, typography, icons, tension) and Applied tab (hero, card, form, nav rendered in the system)
- **Bundle** — `design/` folder with showcase.html, tokens.json (W3C), tokens.css (universal), icons/, claude.md

Output is **framework-agnostic**. No Tailwind config, no framework-specific files. The `claude.md` tells Claude Code to detect your stack (Tailwind / CSS Modules / styled-components / Svelte / plain CSS / anything) and adapt at consumption time.

## How to use it

In any project directory:

```
/design-system
```

Answer the four workshop steps. The skill opens each decision as a visual HTML page in your browser. When the bundle is ready, the showcase opens automatically. Then hand it to Claude Code with one line:

```
use the design system in design/
```

## What's NOT in scope

- No external APIs, no Node dependencies, no MCP server
- **No AI-generated fonts.** Typography is curated from Google Fonts, not synthesized. The skill picks well from thousands of real fonts based on your discovery — never invents a fake one.
- No Tailwind config generation (framework-agnostic by design)
- No pre-built component code — only tokens + assets + patterns documented in claude.md

## Files in this skill

| File | Purpose |
|------|---------|
| `skill.md` | Core orchestration — the prompt Claude Code executes |
| `archetypes.md` | The 12 Jungian archetypes with sigils, essences, example brands |
| `showcase-skeleton.html` | Fixed-layer template for the output `showcase.html` |
| `claude-md-template.md` | Template for the `design/claude.md` consume guide |
| `README.md` | This file |

## Output structure (per run, in the user's project)

```
design/
├── showcase.html
├── tokens.json           # W3C Design Tokens format (incl. typography family + Google Fonts URL)
├── tokens.css            # CSS custom properties — universal (incl. --font-display, --font-body)
├── claude.md             # Deep-integration consume guide
└── icons/                # Individual SVG icons (~20 files)
```

## Requirements

- Claude Code (or compatible runner)
- A terminal that can execute `open <file>` (macOS default; adjust for Linux/Windows)
- Nothing else

## Installation

Drop this directory into `~/.claude/skills/design-system/`. The skill will appear as `/design-system` in your Claude Code skill list.
