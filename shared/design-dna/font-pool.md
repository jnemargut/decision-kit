# Characterful Font Pool

The curated supply of distinctive, production-quality faces for Decision Kit's design skills. Every face here is on Google Fonts (free, linkable) unless marked otherwise. The pool exists so no two aesthetics ever need to share a voice — see `banned-defaults.md` for what's excluded.

**Uniqueness rules (enforced across the tradition library and design-system outputs):**
- No two traditions share a **display** face.
- A **body** face may appear in at most two traditions.
- A **mono** face may appear in at most two traditions.
- When generating bespoke pairings (design-system), prefer faces the project's references and archetype point to — and check the chosen display isn't already the voice of a sibling project (`.visual-design/tokens.json`, `design/tokens.json`).

## Display faces (carry the voice)

| Face | Voice | Pairs well with |
|------|-------|-----------------|
| Bricolage Grotesque | Warm, quirky grotesque; the trending 2025–26 face | Plus Jakarta Sans, Source Serif 4 |
| Space Grotesk | Retro-futuristic, techy charm | Instrument Sans, IBM Plex Sans |
| Fraunces (variable opsz) | "Wonky" old-style soul; personality at display sizes | Source Serif 4, Karla |
| Schibsted Grotesk | Confident editorial grotesque | Hanken Grotesk |
| Unbounded | Wide, chromey, Y2K-future | Azeret Mono, Nunito |
| Syne | Artsy, postmodern, gallery-poster | Space Grotesk, DM Mono |
| Sora | Soft technical, atmospheric | Figtree, Mulish |
| Petrona | Warm contemporary serif | Karla, Mulish |
| Vollkorn | Bready, crafted, hearty serif | Spectral |
| Marcellus | Classical inscriptional elegance | Alegreya Sans, Lora |
| Bodoni Moda | High-contrast luxury didone | Cormorant Garamond |
| Playfair Display | Prestige transitional serif | Lora, Spectral |
| Archivo Black | Blunt-force poster grotesque | Libre Franklin, Space Mono |
| Anton | Condensed impact | Courier Prime |
| Oswald | Condensed news masthead | Merriweather |
| Bungee / Righteous | Chrome signage, retro-future | Exo 2 |
| Rajdhani / Orbitron | Squared sci-fi tech | Saira, Share Tech Mono |
| Limelight / Poiret One | Deco marquee / thin elegance | Cormorant Garamond |
| Josefin Sans | Geometric 1920s modernism | Chivo |
| Shippori Mincho | Japanese mincho dignity | Zen Kaku Gothic New |
| Caveat / Architects Daughter | Handwritten | Nunito |
| VT323 | Phosphor terminal pixel | Fira Code |
| Cormorant Garamond (italic display) | Botanical, romantic | Source Serif 4 |
| IBM Plex Sans | Engineered documentary neutrality | IBM Plex Mono |
| Manrope | Refined semi-geometric premium | Mulish |
| Young Serif | Chunky friendly seventies serif | Figtree, Karla |
| Instrument Serif | Sharp contemporary display serif | Instrument Sans |
| DM Serif Display | Confident editorial display | DM Sans, Lora |
| Gloock | High-contrast modern display serif | Hanken Grotesk |
| Newsreader | Screen-first news serif | Sometype Mono, Karla |

## Body faces (do the reading work)

Hanken Grotesk · Libre Franklin · Karla · Figtree · Mulish · Instrument Sans · Plus Jakarta Sans · Spectral · Source Serif 4 · Lora · Merriweather · Alegreya Sans · Chivo · Exo 2 · Saira · Nunito · Zen Kaku Gothic New · Cormorant Garamond · Anonymous Pro · Courier Prime · Crimson Pro · Literata · Petrona (text sizes) · Bitter

## Mono faces (one voice each)

| Face | Character |
|------|-----------|
| Fragment Mono | Plain, literary, Helvetica-of-monos |
| Spline Sans Mono | Crisp UI mono |
| Sometype Mono | Warm writerly mono |
| Geist Mono | Contemporary product mono |
| Victor Mono | Cursive italics — kinetic |
| Martian Mono | Wide, sturdy, sci-fi |
| Azeret Mono | Chunky display-ish mono |
| Chivo Mono | Geometric grotesque mono |
| DM Mono | Light, designy |
| Space Mono | Retro NASA quirk |
| IBM Plex Mono | Engineered documentary |
| JetBrains Mono | Developer console (reserved: Dashboard Operator's identity) |
| Share Tech Mono | Squared cyber |
| Fira Code | Terminal with ligatures |
| Cutive Mono | Typewriter |
| Red Hat Mono | Friendly corporate mono |
| Cascadia Mono | Casual code |
| Inconsolata | Humanist classic |

## Beyond Google Fonts (note for design-system outputs)

Fontshare (Indian Type Foundry) offers free, production-grade faces with more character than most of Google Fonts: **Satoshi, General Sans, Clash Display, Cabinet Grotesk, Sentient, Boska**. They require self-hosting or Fontshare's CDN `<link>` rather than the Google Fonts API. Offer them when the user can self-host; default to Google Fonts for zero-friction artifacts.

## Selection heuristics

- Pick the display face first — it carries the voice. Then choose a body that *recedes* next to it.
- Contrast beats harmony when the brief has tension ("warm but formal" → expressive serif display + crisp neutral body). Harmonize (same superfamily) when the brief is calm.
- A distinctive display + quiet body is "the secret weapon of modern product design" (Precode, 2026). The reverse — loud body, quiet display — is almost always a mistake.
- When unsure between two displays, take the one you'd be less likely to see on a SaaS template.
