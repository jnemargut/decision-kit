# Aesthetic Traditions Library

> Loaded by /visual-design at Phase 3 (Tradition selection) and Phase 5 (rewrite). Every tradition has a unique display voice; body and mono faces repeat at most twice across the catalog — enforced by `references/banned-defaults.md`. Each tradition carries a default composition signature from `references/composition-signatures.md`.


30 starter traditions, grouped by feel. Each entry provides the tokens and aesthetic rules needed to render previews AND to generate the final rewrite.

**Feel groups** (used only for internal organization — all traditions render in the flat grid):
- **Structural:** Swiss Modern, Technical Documentary, Monochrome, Newsprint, Academic, Bauhaus Grid, Dashboard Operator
- **Warm:** Editorial Print, Warm Minimal, Warm Handmade, Kraft Paper, Japandi
- **Expressive:** Neo-Brutalist, Playful Maximalist, Y2K Maximalist, Memphis Revival, Anti-Design
- **Quiet:** Soft Premium, Neo-Classical, Botanical Herbarium, Midnight Marine
- **Raw:** Neon Terminal, Zine, Sketchbook
- **Kinetic / Premium:** Kinetic Modern, Glassmorphic, Luxury Serif, Art Deco, Retro Futurism, Cyberpunk Neon

Below are the 30 seed traditions. Add more over time by appending new entries in the same format.

---

### 1. Swiss Modern

**Feel:** Clean, confident, functional. Zero decoration. Information dense but never cramped. Typography does the heavy lifting.

**Color ramp:** `#fafafa` · `#f4f4f5` · `#e4e4e7` · `#d4d4d8` · `#a1a1aa` · `#71717a` · `#52525b` · `#3f3f46` · `#27272a` · `#0f172a`
**Accents:** primary `#6366f1` · pressed `#4f46e5` · success `#22c55e` · danger `#ef4444`

**Type:**
- Headline: `"Schibsted Grotesk"` 700, letter-spacing -0.02em
- Body: `"Hanken Grotesk"` 400, line-height 1.55
- Mono: `"Spline Sans Mono"` 400
- Scale: 12 · 14 · 16 · 20 · 28 · 40
- Google Fonts: `Schibsted+Grotesk:wght@500;600;700&family=Hanken+Grotesk:wght@400;500;600;700&family=Spline+Sans+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 4 · 6 · 10 · 16
**Shadow:** L1 `0 1px 2px rgba(15,23,42,.06)` · L2 `0 2px 8px rgba(15,23,42,.08)` · L3 `0 8px 24px rgba(15,23,42,.10)` · L4 `0 16px 40px rgba(15,23,42,.12)`
**Motion:** `cubic-bezier(.16,1,.3,1)` · 120 / 200 / 320ms

**Rules:**
- No gradients. Solid color + whitespace.
- Shadows only on elevated surfaces.
- Headlines tight (-0.02 to -0.03em); body neutral.
- No rounded corners above 16px.
- Icons: 1.5px stroke, match body color.

**Flourish picks:** Kicker · Rule Line · Small-Caps Label
**Composition signature:** `bento` — see `references/composition-signatures.md`

---

### 2. Editorial Print

**Feel:** Warm, literary, intentional. Print publication translated to screen. Rewards reading. Restrained color — when it shows up, it means something.

**Color ramp:** `#fdf6e3` · `#f5ecd0` · `#e7d7b8` · `#d4af7a` · `#b07a4a` · `#9a3412` · `#7c2d12` · `#44342a` · `#2a1f18` · `#1f1611`
**Accents:** brick `#9a3412` · success `#357266` · danger `#b91c1c`

**Type:**
- Headline: `Fraunces` 600 with `opsz` 96-144, letter-spacing -0.02em
- Body: `"Source Serif 4"` 400, line-height 1.7
- Mono: `"Fragment Mono"` 400
- Scale: 12 · 14 · 18 · 22 · 32 · 52
- Google Fonts: `Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Source+Serif+4:ital,opsz,wght@0,8..60,400;0,8..60,600;1,8..60,400&family=Fragment+Mono:ital@0;1`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 104
**Radius:** 2 · 4 · 6 · 10
**Shadow:** L1 `0 1px 2px rgba(31,22,17,.08)` · L2 `0 2px 6px rgba(31,22,17,.10)` · L3 `0 4px 12px rgba(31,22,17,.12)` · L4 `0 8px 20px rgba(31,22,17,.15)`
**Motion:** `cubic-bezier(.2,.8,.2,1)` · 140 / 240 / 400ms

**Rules:**
- Always use Fraunces `opsz` axis — bigger opsz for bigger sizes.
- Italics are expressive tools, especially for kickers and captions.
- No gradients. Solid warm paper + ink.
- Dividers hairline or dotted, never thick.
- Use pull-quotes with generous margins when space allows.
- Drop caps welcome on long-form.

**Flourish picks:** Drop Cap · Kicker · Pull Quote
**Composition signature:** `editorial-spread` — see `references/composition-signatures.md`

---

### 3. Neo-Brutalist

**Feel:** Hard-edged, honest, direct. No softening. High-contrast, chunky, almost aggressive in its indifference to trend.

**Color ramp:** `#ffffff` · `#f5f5f5` · `#d4d4d4` · `#a3a3a3` · `#737373` · `#404040` · `#262626` · `#171717` · `#0a0a0a` · `#000000`
**Accents:** yellow `#facc15` · red `#ef4444` · blue `#2563eb`

**Type:**
- Headline: `"Archivo Black"` 400, letter-spacing -0.01em, UPPERCASE acceptable
- Body: `"Libre Franklin"` 500, line-height 1.5
- Mono: `"Space Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 34 · 56
- Google Fonts: `Archivo+Black&family=Libre+Franklin:wght@400;500;700&family=Space+Mono:wght@400;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 40 · 56 · 80
**Radius:** 0 · 0 · 2 · 4 (mostly angular)
**Shadow:** offset-solid, not blurred. L1 `3px 3px 0 #000` · L2 `5px 5px 0 #000` · L3 `8px 8px 0 #000` · L4 `12px 12px 0 #000`
**Motion:** `linear` · 80 / 150 / 300ms (abrupt)

**Rules:**
- Solid offset drop shadows (never soft-blurred) are a signature.
- Uppercase headings welcome. Monospace kickers welcome.
- Borders are 2-3px and black.
- One accent color used aggressively (yellow or red) — restraint is the enemy.
- Zero gradients. Zero corners above 4px. Zero smooth easing.
- Underlines on active nav items — skeuomorphic web.

**Flourish picks:** Offset Box Shadow · Uppercase Kicker · Thick Rule
**Composition signature:** `broken-grid` — see `references/composition-signatures.md`

---

### 4. Warm Minimal

**Feel:** Muted earth tones, generous whitespace, serif revival. Calm, upscale, nothing loud.

**Color ramp:** `#fafaf9` · `#f5f5f4` · `#e7e5e4` · `#d6d3d1` · `#a8a29e` · `#78716c` · `#57534e` · `#44403c` · `#292524` · `#1c1917`
**Accents:** mint-gray `#5b8c7a` · caramel `#d4a373` · muted blue `#5b7b9a`

**Type:**
- Headline: `Petrona` 600, letter-spacing -0.01em
- Body: `Karla` 400, line-height 1.6
- Mono: `"Sometype Mono"` 400
- Scale: 12 · 14 · 15 · 19 · 26 · 38
- Google Fonts: `Petrona:wght@400;500;600&family=Karla:wght@400;500;600&family=Sometype+Mono:wght@400`

**Spacing:** 4 · 8 · 12 · 20 · 28 · 40 · 56 · 80 · 112 (generous)
**Radius:** 8 · 12 · 18 · 28
**Shadow:** soft, large spread. L1 `0 1px 3px rgba(28,25,23,.04)` · L2 `0 4px 16px rgba(28,25,23,.05)` · L3 `0 12px 32px rgba(28,25,23,.06)` · L4 `0 24px 56px rgba(28,25,23,.08)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 200 / 350 / 500ms

**Rules:**
- Desaturated palette only.
- Generous whitespace — minimum 24px padding on containers.
- Soft shadows with large spread, low opacity.
- Off-black text (#1c1917), never pure black.
- One muted accent color per view.

**Flourish picks:** Kicker · Rule Line · Small-Caps Label
**Composition signature:** `monolith` — see `references/composition-signatures.md`

---

### 5. Technical Documentary

**Feel:** Dense, authoritative, information-first. Feels like serious reference material. Heavy on tables, lists, code.

**Color ramp:** `#f8fafc` · `#f1f5f9` · `#e2e8f0` · `#cbd5e1` · `#94a3b8` · `#64748b` · `#475569` · `#334155` · `#1e293b` · `#0f172a`
**Accents:** link `#0284c7` · success `#059669` · warning `#d97706` · danger `#dc2626`

**Type:**
- Headline: `"IBM Plex Sans"` 700, letter-spacing -0.015em
- Body: `"IBM Plex Sans"` 400, line-height 1.55
- Mono: `"IBM Plex Mono"` 400 — code is first-class
- Scale: 12 · 14 · 16 · 20 · 26 · 36
- Google Fonts: `IBM+Plex+Sans:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 2 · 4 · 6 · 8
**Shadow:** rarely used — prefer borders + spacing. L1 `0 1px 0 rgba(15,23,42,.05)` · L2 `0 1px 2px rgba(15,23,42,.06)` · L3 `0 2px 4px rgba(15,23,42,.08)` · L4 `0 4px 8px rgba(15,23,42,.10)`
**Motion:** `ease` · 80 / 140 / 220ms

**Rules:**
- Inline code, tables, and definition lists are native.
- Accent color used ONLY for links and semantic indicators.
- High information density is a feature, not a bug.
- Code blocks are UI, not afterthoughts.
- Tables have zebra stripes; headers are bolded not uppercased.

**Flourish picks:** Inline Code · Rule Line · Small-Caps Label
**Composition signature:** `marginalia` — see `references/composition-signatures.md`

---

### 6. Monochrome

**Feel:** Pure black and white. Uncompromising. Type is everything.

**Color ramp:** `#ffffff` · `#fafafa` · `#e5e5e5` · `#d4d4d4` · `#a3a3a3` · `#737373` · `#404040` · `#262626` · `#171717` · `#000000`
**Accents:** none — mono stays mono. Optional single accent at user request.

**Type:**
- Headline: `"Martian Mono"` 500, letter-spacing 0
- Body: `"Martian Mono"` 400, line-height 1.55
- Mono: same
- Scale: 12 · 14 · 16 · 20 · 28 · 40
- Google Fonts: `Martian+Mono:wght@400;500;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 0 · 0 · 2 · 4
**Shadow:** L1 `0 1px 0 rgba(0,0,0,.1)` · L2 `0 2px 0 rgba(0,0,0,.15)` · L3 `0 4px 0 rgba(0,0,0,.2)` · L4 `0 8px 0 rgba(0,0,0,.25)`
**Motion:** `linear` · 100 / 200 / 400ms

**Rules:**
- Pure mono — no color accents.
- All text in a monospace family.
- Borders are 1px solid #000 or #e5e5e5.
- Headings differentiated by weight, not color.
- Use `_` or `-` as visual separators in labels.

**Flourish picks:** ASCII Divider · Small-Caps Label · Inline Code
**Composition signature:** `monolith` — see `references/composition-signatures.md`

---

### 7. Glassmorphic

**Feel:** Translucent, depth-rich, atmospheric. Depth via layered translucency.

**Color ramp:** `#fafafa` · `rgba(255,255,255,.6)` · `rgba(255,255,255,.4)` · `#e5e7eb` · `#9ca3af` · `#6b7280` · `#4b5563` · `#374151` · `#1f2937` · `#0f1419`
**Accents:** coral `#ff8a65` · sky `#60a5fa` · lilac `#c4b5fd` (all at .5 alpha)

**Type:**
- Headline: `Sora` 600, letter-spacing -0.015em
- Body: `Figtree` 400, line-height 1.5
- Mono: `"Geist Mono"` 400
- Scale: 12 · 14 · 16 · 20 · 28 · 44
- Google Fonts: `Sora:wght@400;600;700&family=Figtree:wght@400;500;600&family=Geist+Mono:wght@400`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 112
**Radius:** 10 · 16 · 24 · 36 (soft, bubble-like)
**Shadow:** L1 `0 2px 8px rgba(0,0,0,.04)` · L2 `0 4px 16px rgba(0,0,0,.06)` · L3 `0 8px 32px rgba(0,0,0,.08)` · L4 `0 16px 48px rgba(0,0,0,.10)` — paired with `backdrop-filter: blur(...)`
**Motion:** smooth-springy · 180 / 300 / 500ms

**Rules:**
- Surfaces use `backdrop-filter: blur(20-40px)` with translucent bg.
- Behind every glass panel: a colorful gradient or vibrant content.
- Borders are `rgba(255,255,255,.3)` — glass rim.
- Text solid colors — never translucent text.
- One glass layer per view — stacking destroys the effect.

**Flourish picks:** Gradient Backdrop · Glass Rim · Soft Glow
**Composition signature:** `bento` — see `references/composition-signatures.md`

---

### 8. Neo-Classical

**Feel:** Serif-heavy, restrained, editorial-adjacent. Prestige-media feel. Warm neutrals, grand vertical rhythm.

**Color ramp:** `#faf9f7` · `#f2ece0` · `#e4d9c5` · `#c4b195` · `#96825c` · `#6b5a38` · `#4c3f24` · `#332a18` · `#1f1a10` · `#0f0c08`
**Accents:** jewel red `#8c1c13` · forest `#2d4a2a` · deep blue `#1e3a5f`

**Type:**
- Headline: `"Playfair Display"` 700, italic variants welcome
- Body: `Lora` 400, line-height 1.65
- Display alt: `Spectral` 400 for lead-ins
- Scale: 13 · 15 · 18 · 24 · 34 · 52
- Google Fonts: `Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&family=Lora:ital,wght@0,400;0,500;1,400&family=Spectral:wght@400;500`

**Spacing:** 4 · 8 · 12 · 18 · 28 · 44 · 68 · 100 · 144 (grand)
**Radius:** 0 · 2 · 4 · 6 (nearly angular)
**Shadow:** barely used. L1 `0 1px 1px rgba(15,12,8,.04)` · L2 `0 2px 4px rgba(15,12,8,.06)` · L3 `0 4px 12px rgba(15,12,8,.08)` · L4 `0 10px 24px rgba(15,12,8,.10)`
**Motion:** slow · 200 / 400 / 600ms (deliberate)

**Rules:**
- Display italics on headlines are a signature.
- Small caps for navigation and labels.
- Horizontal rules (hairline, sometimes doubled) as dividers.
- Drop caps welcome for long-form.
- Generous vertical rhythm; section spacing is grand.
- Minimal color — serif typography carries voice.

**Flourish picks:** Drop Cap · Small-Caps Label · Doubled Rule
**Composition signature:** `monolith` — see `references/composition-signatures.md`

---

### 9. Warm Handmade

**Feel:** Crafted, personal, small-batch. Made by one person who cared. Slightly imperfect by design.

**Color ramp:** `#f7f4ed` · `#eee7d8` · `#dcc9a5` · `#c4a574` · `#9c7f4f` · `#6b5538` · `#4a3b28` · `#33281b` · `#211a12` · `#13100a`
**Accents:** berry `#7c2d12` · sage `#5f7c3e` · dusty blue `#4a6978`

**Type:**
- Headline: `Vollkorn` 600, italic welcome
- Body: `Spectral` 400, line-height 1.65
- Mono: `"Cascadia Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 30 · 46
- Google Fonts: `Vollkorn:ital,wght@0,400;0,600;0,700;1,400&family=Spectral:wght@400;500;600`

**Spacing:** 4 · 8 · 12 · 18 · 26 · 38 · 56 · 84 · 120 (organic)
**Radius:** 4 · 8 · 14 · 22 (friendly, not bubbly)
**Shadow:** warm-tinted. L1 `0 1px 3px rgba(107,85,56,.08)` · L2 `0 3px 10px rgba(107,85,56,.10)` · L3 `0 8px 20px rgba(107,85,56,.12)` · L4 `0 14px 32px rgba(107,85,56,.14)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 160 / 280 / 440ms

**Rules:**
- Off-center, slightly asymmetric layouts welcome.
- Warm earth palette only — no cool colors.
- A single hand-drawn flourish per view (squiggle underline, arrow).
- Line-heights generous (1.6-1.7).
- Section dividers hairline or dotted, never bold.

**Flourish picks:** Grain Texture · Squiggle Underline · Pull Quote
**Composition signature:** `diagonal-flow` — see `references/composition-signatures.md`

---

### 10. Kinetic Modern

**Feel:** Motion-forward, vivid, alive. Crisp geometry with energy underneath. Feels recent, capable, deliberate.

**Color ramp:** `#fafbff` · `#f0f3ff` · `#d6dcff` · `#b0bcff` · `#7f92ff` · `#4f6bff` · `#3b4dcc` · `#29368f` · `#161d4a` · `#0a0e24`
**Accents:** lime `#a3e635` · coral `#fb7185` · cyan `#22d3ee`

**Type:**
- Headline: `"Space Grotesk"` 700, letter-spacing -0.02em
- Body: `"Instrument Sans"` 400, line-height 1.55
- Mono: `"Victor Mono"` 500 — cursive italics for kinetic accents
- Scale: 12 · 14 · 16 · 22 · 32 · 48
- Google Fonts: `Space+Grotesk:wght@500;700&family=Instrument+Sans:wght@400;500;600&family=Victor+Mono:ital,wght@0,400;0,500;1,400`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 6 · 10 · 14 · 20
**Shadow:** colored, subtle. L1 `0 2px 6px rgba(79,107,255,.10)` · L2 `0 4px 12px rgba(79,107,255,.14)` · L3 `0 8px 24px rgba(79,107,255,.20)` · L4 `0 16px 40px rgba(79,107,255,.28)`
**Motion:** `cubic-bezier(.5,1.5,.5,1)` (springy) · 140 / 240 / 380ms

**Rules:**
- Hover / focus states include visible motion.
- Accent colors as spot highlights — never main body color.
- Geometric shapes (circles, pills, diagonal stripes) as decorative accents.
- High contrast; dark background variant default-ready.

**Flourish picks:** Animated Underline · Geometric Accent · Colored Glow
**Composition signature:** `diagonal-flow` — see `references/composition-signatures.md`

---

### 11. Academic

**Feel:** Old-textbook, scholarly. Classic serif, disciplined layout, functional decoration.

**Color ramp:** `#fbfaf6` · `#f2ede0` · `#e2d9c2` · `#bfa981` · `#8a7547` · `#5a4a2a` · `#3f331c` · `#2a2114` · `#1a140c` · `#0d0a07`
**Accents:** ink blue `#1e3a5f` · burgundy `#7c1d2e` · forest `#2d4a2a`

**Type:**
- Headline: `Georgia`/`"Iowan Old Style"` serif 700
- Body: `Georgia` 400, line-height 1.7
- Mono: `"Courier New"` 400
- Scale: 12 · 14 · 16 · 20 · 26 · 38
- Google Fonts: (uses system serifs, optionally load `Lora`)

**Spacing:** 4 · 8 · 12 · 16 · 24 · 36 · 56 · 84 · 120
**Radius:** 0 · 2 · 4 · 4
**Shadow:** not used.
**Motion:** slow · 200 / 400 / 600ms

**Rules:**
- Traditional page layout — centered columns, wide margins.
- Small caps for section labels.
- Footnote-style indicators (superscript numbers).
- No gradients, no shadows, no rounded corners above 4px.
- Hairline rules between sections.

**Flourish picks:** Drop Cap · Footnote Marker · Small-Caps Label
**Composition signature:** `marginalia` — see `references/composition-signatures.md`

---

### 12. Luxury Serif

**Feel:** Dark, upscale, gold-accented. Fashion-editorial. High-contrast, serif display.

**Color ramp:** `#1a1a1a` · `#232323` · `#2e2e2e` · `#3f3f3f` · `#5e5e5e` · `#8a8a8a` · `#b4b4b4` · `#d6d6d6` · `#ededed` · `#ffffff`
**Accents:** gold `#d4af37` · champagne `#e8c87a` · deep red `#8b1a1a`

**Type:**
- Headline: `"Bodoni Moda"` 700, letter-spacing -0.01em, ALL CAPS welcome
- Body: `"Cormorant Garamond"` 400, line-height 1.65
- Scale: 12 · 14 · 16 · 22 · 34 · 60
- Google Fonts: `Bodoni+Moda:ital,opsz,wght@0,6..96,400;0,6..96,700;1,6..96,400&family=Cormorant+Garamond:ital,wght@0,400;0,500;1,400`

**Spacing:** 4 · 8 · 12 · 20 · 32 · 48 · 72 · 108 · 160 (grand)
**Radius:** 0 · 0 · 0 · 2 (angular)
**Shadow:** gold-tinted. L1 `0 1px 2px rgba(212,175,55,.08)` · L2 `0 2px 8px rgba(0,0,0,.25)` · L3 `0 4px 16px rgba(0,0,0,.35)` · L4 `0 8px 32px rgba(0,0,0,.45)`
**Motion:** slow elegant · 240 / 480 / 720ms

**Rules:**
- Dark background; gold accent used sparingly.
- All-caps display headlines with wide tracking.
- High-contrast serifs (Bodoni) for drama.
- Minimal chrome — let type + gold do the work.
- Hairline gold rules as dividers.

**Flourish picks:** Gold Hairline · Ornament Divider · All-Caps Kicker
**Composition signature:** `poster` — see `references/composition-signatures.md`

---

### 13. Playful Maximalist

**Feel:** Expressive, energetic, friendly. More is more, but composed. Vivid color, rounded everything, bounce in motion.

**Color ramp:** `#fffbf5` · `#fef3c7` · `#fde68a` · `#fbbf24` · `#f97316` · `#ec4899` · `#8b5cf6` · `#6366f1` · `#1e1b4b` · `#0f0f1a`
**Accents:** bounce green `#10b981` · highlighter `#fde047`

**Type:**
- Headline: `"Bricolage Grotesque"` 800, opsz up for display
- Body: `"Plus Jakarta Sans"` 500, line-height 1.55
- Display alt: `Caveat` 700 for hand-drawn emphasis
- Scale: 13 · 15 · 17 · 22 · 32 · 48
- Google Fonts: `Bricolage+Grotesque:opsz,wght@12..96,400;12..96,600;12..96,800&family=Plus+Jakarta+Sans:wght@400;500;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 8 · 14 · 20 · 28 (round, friendly)
**Shadow:** accent-tinted. L1 `0 2px 4px rgba(139,92,246,.12)` · L2 `0 4px 12px rgba(139,92,246,.18)` · L3 `0 8px 24px rgba(236,72,153,.22)` · L4 `0 16px 40px rgba(139,92,246,.30)`
**Motion:** `cubic-bezier(.34,1.56,.64,1)` (bouncy overshoot) · 180 / 320 / 500ms

**Rules:**
- Gradients encouraged — pink-to-purple is the signature.
- Rounded corners aggressive — pills for buttons, 20px+ for cards.
- One handwritten accent (Caveat) per view, rotated slightly.
- Bounce easing default — everything overshoots.
- Shadows tinted with accent, never neutral gray.

**Flourish picks:** Hand-Drawn Squiggle · Pill Button · Tinted Shadow
**Composition signature:** `broken-grid` — see `references/composition-signatures.md`

---

### 14. Soft Premium

**Feel:** Calm, reassuring, upscale. Desaturated, low-contrast but confident. Nothing to prove.

**Color ramp:** `#fafaf9` · `#f5f5f4` · `#e7e5e4` · `#d6d3d1` · `#a8a29e` · `#78716c` · `#57534e` · `#44403c` · `#292524` · `#1c1917`
**Accents:** mint-gray `#5b8c7a` · caramel `#d4a373` · muted blue `#5b7b9a`

**Type:**
- Headline: `Manrope` 700, letter-spacing -0.015em
- Body: `Mulish` 400, line-height 1.6
- Mono: `Inconsolata` 400
- Scale: 12 · 14 · 15 · 19 · 26 · 38 (compressed)
- Google Fonts: `Manrope:wght@400;600;700&family=Mulish:wght@400;500;600&family=Inconsolata:wght@400`

**Spacing:** 4 · 8 · 12 · 20 · 28 · 40 · 56 · 80 · 112 (generous)
**Radius:** 8 · 12 · 18 · 28
**Shadow:** soft, large spread. L1 `0 1px 3px rgba(28,25,23,.04)` · L2 `0 4px 16px rgba(28,25,23,.05)` · L3 `0 12px 32px rgba(28,25,23,.06)` · L4 `0 24px 56px rgba(28,25,23,.08)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 200 / 350 / 500ms

**Rules:**
- Desaturated palette only — no bright hues.
- Generous whitespace, minimum 24px padding.
- Shadows always soft with large spread, low opacity.
- Off-black text (#1c1917), never pure black.
- One muted accent per view.
- Nothing competes for attention.

**Flourish picks:** Hairline Rule · Small-Caps Label · Soft Shadow
**Composition signature:** `bento` — see `references/composition-signatures.md`

---

### 15. Newsprint

**Feel:** Newspaper condensed sans on cream paper. Black ink + red accent splash. Dense columns, thick rules.

**Color ramp:** `#faf7f0` · `#f2ece0` · `#e5dcc8` · `#c9beaa` · `#8a7f6a` · `#52483a` · `#332a1e` · `#1f1912` · `#14100a` · `#0a0805`
**Accents:** red splash `#c1272d` · ink black `#0f0f0f`

**Type:**
- Headline: `Oswald` 700 condensed, ALL CAPS welcome
- Body: `Merriweather` 400, line-height 1.55
- Mono: `"Cutive Mono"` 400 — typewriter wire-copy
- Scale: 11 · 13 · 15 · 20 · 30 · 48
- Google Fonts: `Oswald:wght@500;700&family=Merriweather:ital,wght@0,400;0,700;1,400&family=Cutive+Mono`

**Spacing:** 4 · 6 · 10 · 14 · 20 · 28 · 40 · 56 · 80 (dense)
**Radius:** 0 · 2 · 4 · 4 (mostly angular)
**Shadow:** rarely. L1 `0 1px 0 rgba(0,0,0,.1)` · L2 `0 2px 4px rgba(0,0,0,.08)` · L3 `0 4px 8px rgba(0,0,0,.1)` · L4 `0 8px 16px rgba(0,0,0,.12)`
**Motion:** `ease` · 100 / 180 / 300ms

**Rules:**
- Condensed sans for headlines; serif body.
- Red reserved for kickers, dates, alerts.
- Thick black rules (3-4px) between sections.
- Multi-column body layout if space allows.
- Datelines and bylines in italics, small caps.

**Flourish picks:** Thick Rule · Red Kicker · Byline Italic
**Composition signature:** `editorial-spread` — see `references/composition-signatures.md`

---

### 16. Y2K Maximalist

**Feel:** Chrome gradients, bubble text, holographic accents. Early 2000s web aesthetic revived and refined.

**Color ramp:** `#f5f3ff` · `#e9e5ff` · `#c4bbff` · `#918aff` · `#6b65ff` · `#4f4af0` · `#3d38c8` · `#2b2798` · `#1a186e` · `#0a094a`
**Accents:** magenta `#ec4899` · cyan `#22d3ee` · lime `#a3e635` · chrome silver gradient

**Type:**
- Headline: `Unbounded` 800, wide chrome display
- Body: `Nunito` 500, line-height 1.55
- Mono: `"Azeret Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 32 · 52
- Google Fonts: `Unbounded:wght@500;700;800&family=Nunito:wght@400;500;700&family=Azeret+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 16 · 24 · 32 · 999 (pills everywhere)
**Shadow:** colored + holographic. L1 `0 2px 8px rgba(139,92,246,.3)` · L2 `0 4px 16px rgba(236,72,153,.3)` · L3 `0 8px 32px rgba(34,211,238,.3)` · L4 `0 16px 48px rgba(163,230,53,.3)`
**Motion:** `cubic-bezier(.25,.1,.25,1)` · 200 / 320 / 500ms

**Rules:**
- Gradients everywhere — magenta-cyan, chrome silver.
- Bubble pill buttons (999px radius).
- Holographic accents on CTAs (multi-color gradient).
- Rounded geometric sans for everything.
- Subtle glossy overlays on cards (top-to-transparent white gradient).

**Flourish picks:** Chrome Gradient · Pill Button · Holographic Accent
**Composition signature:** `broken-grid` — see `references/composition-signatures.md`

---

### 17. Zine / Photocopied

**Feel:** Cut-and-paste, punk, xerox aesthetic. Deliberately crooked, noisy, hand-made.

**Color ramp:** `#fffefb` · `#f5f1e6` · `#d8cfbb` · `#b0a384` · `#7a6f55` · `#4a4131` · `#2e2817` · `#1a1508` · `#0f0b04` · `#000000`
**Accents:** toner black `#0a0a0a` · photocopy red `#c1272d`

**Type:**
- Headline: `Anton` condensed, UPPERCASE
- Body: `"Courier Prime"` 400, line-height 1.5
- Display alt: `"Permanent Marker"` for hand-scrawled
- Scale: 12 · 14 · 16 · 22 · 36 · 64
- Google Fonts: `Anton&family=Courier+Prime:ital,wght@0,400;0,700;1,400&family=Permanent+Marker`

**Spacing:** 3 · 6 · 10 · 14 · 20 · 28 · 40 · 56 · 80 (tight, uneven feel)
**Radius:** 0 · 0 · 2 · 2 (mostly none)
**Shadow:** solid offset + xerox smudge. L1 `2px 2px 0 #000` · L2 `4px 4px 0 #000` · L3 `6px 6px 0 #000` · L4 `0 0 8px rgba(0,0,0,.4)` (smudge)
**Motion:** `linear` · 80 / 150 / 300ms (abrupt)

**Rules:**
- Elements rotated 0.5-2deg for paste-up feel.
- Grain/noise overlay on backgrounds.
- Mix UPPERCASE condensed sans + typewriter + marker.
- Black borders 2-3px, occasional taped-down edges.
- High-contrast only — no gradients, no subtle colors.
- Photocopy smudge shadows.

**Flourish picks:** Paste-Up Rotation · Grain Overlay · Marker Scrawl
**Composition signature:** `broken-grid` — see `references/composition-signatures.md`

---

### 18. Neon Terminal

**Feel:** CRT terminal, phosphor glow, hacker aesthetic. Green on black. Monospace everything.

**Color ramp:** `#000000` · `#0a0a0a` · `#111111` · `#1a1a1a` · `#2a2a2a` · `#4a4a4a` · `#6a6a6a` · `#8a8a8a` · `#b0b0b0` · `#d0d0d0`
**Accents:** phosphor green `#00ff66` · amber `#ffb000` · cyan `#00ffff` · danger red `#ff0040`

**Type:**
- Headline: `"VT323"` 400, pixelated monospace
- Body: `"Fira Code"` 400, line-height 1.5
- Display alt: `"Major Mono Display"` for headers
- Scale: 13 · 15 · 17 · 20 · 28 · 40
- Google Fonts: `VT323&family=Fira+Code:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 0 · 0 · 0 · 2 (sharp)
**Shadow:** phosphor glow. L1 `0 0 4px rgba(0,255,102,.4)` · L2 `0 0 8px rgba(0,255,102,.5)` · L3 `0 0 16px rgba(0,255,102,.6)` · L4 `0 0 24px rgba(0,255,102,.7)`
**Motion:** `steps(4)` · 80 / 160 / 320ms (stepped)

**Rules:**
- Monospace everywhere; no proportional fonts.
- Green phosphor glow on interactive elements.
- Scanline overlay (`repeating-linear-gradient`, 2-4px).
- Terminal prompts (`$ `, `> `) as visual anchors.
- Blinking cursor on active inputs.
- Zero color outside the accent palette.

**Flourish picks:** Phosphor Glow · Scanline Overlay · Terminal Prompt
**Composition signature:** `dense-console` — see `references/composition-signatures.md`

---

### 19. Japandi

**Feel:** Japanese minimalism + Scandinavian warmth. Generous negative space, thin strokes, mixed serif + sans.

**Color ramp:** `#faf8f3` · `#f0ebe0` · `#e0d8c5` · `#c4b8a0` · `#9a8e75` · `#6d634e` · `#483f2f` · `#2f2918` · `#1c1810` · `#0a0805`
**Accents:** tea green `#7a8f6c` · sumi ink `#1c1810` · persimmon `#c96e3e`

**Type:**
- Headline: `"Shippori Mincho"` 700 or `"Noto Serif"` 600
- Body: `"Zen Kaku Gothic New"` 400, line-height 1.75
- Display alt: `"Noto Serif JP"` 400 italic
- Scale: 12 · 14 · 16 · 20 · 28 · 42
- Google Fonts: `Shippori+Mincho:wght@500;600;700&family=Zen+Kaku+Gothic+New:wght@400;500`

**Spacing:** 4 · 8 · 16 · 24 · 40 · 64 · 96 · 144 · 200 (very generous)
**Radius:** 0 · 2 · 4 · 6 (restrained)
**Shadow:** barely. L1 `0 1px 1px rgba(0,0,0,.03)` · L2 `0 1px 3px rgba(0,0,0,.04)` · L3 `0 2px 6px rgba(0,0,0,.05)` · L4 `0 4px 12px rgba(0,0,0,.06)`
**Motion:** slow · 280 / 500 / 800ms (meditative)

**Rules:**
- Negative space is the primary design element.
- Thin 1px hairlines for dividers; no thick rules.
- Mix mincho serif for headings + geometric sans body.
- Single accent per view (tea green or persimmon).
- Asymmetric layouts with intentional empty quadrants.
- No gradients, no shadows deeper than L2.

**Flourish picks:** Negative Space · Hairline Rule · Vertical Text
**Composition signature:** `monolith` — see `references/composition-signatures.md`

---

### 20. Bauhaus Grid

**Feel:** Primary colors, geometric shapes, Futura-style sans. Strict grid. Form follows function.

**Color ramp:** `#ffffff` · `#f5f5f5` · `#e0e0e0` · `#b0b0b0` · `#707070` · `#404040` · `#202020` · `#101010` · `#080808` · `#000000`
**Accents:** red `#e63946` · blue `#1d4ed8` · yellow `#fbbf24`

**Type:**
- Headline: `"Josefin Sans"` 700, geometric
- Body: `Chivo` 400, line-height 1.55
- Mono: `"Chivo Mono"` 400
- Scale: 12 · 14 · 16 · 20 · 28 · 44
- Google Fonts: `Josefin+Sans:wght@400;600;700&family=Chivo:wght@400;500;700&family=Chivo+Mono:wght@400;500`

**Spacing:** 4 · 8 · 16 · 24 · 32 · 48 · 64 · 96 · 128 (grid-aligned)
**Radius:** 0 · 0 · 0 · 0 (zero — angular only)
**Shadow:** not used.
**Motion:** `linear` · 100 / 200 / 400ms

**Rules:**
- Strict modular grid; elements align to 8px multiples.
- Primary colors only — no tints, no gradients.
- Geometric primitives (circles, squares, triangles) as decoration.
- Sans-serif everything, zero serifs.
- No rounded corners anywhere.
- Hairline black rules as dividers.

**Flourish picks:** Primary Color Block · Geometric Primitive · Hairline Rule
**Composition signature:** `bento` — see `references/composition-signatures.md`

---

### 21. Memphis Revival

**Feel:** 80s geometric, zigzags, terrazzo. Playful clashing pastels + primaries + black outlines.

**Color ramp:** `#fff8f3` · `#ffd9e8` · `#ffb9d1` · `#ff7bac` · `#f43e8a` · `#d61e6a` · `#9b1650` · `#5f0e38` · `#330620` · `#1a0310`
**Accents:** teal `#14b8a6` · mustard `#eab308` · black `#000000`

**Type:**
- Headline: `Syne` 800, postmodern gallery-poster energy
- Body: `"Space Grotesk"` 500, line-height 1.55
- Mono: `"DM Mono"` 400
- Scale: 14 · 16 · 18 · 24 · 36 · 56
- Google Fonts: `Syne:wght@600;700;800&family=Space+Grotesk:wght@400;500;700&family=DM+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 104
**Radius:** 4 · 12 · 24 · 999 (mix sharp + round)
**Shadow:** solid offset in contrast color. L1 `3px 3px 0 #000` · L2 `5px 5px 0 #14b8a6` · L3 `8px 8px 0 #eab308` · L4 `12px 12px 0 #000`
**Motion:** `cubic-bezier(.34,1.56,.64,1)` · 160 / 280 / 440ms

**Rules:**
- Clashing pastel + primary accents.
- Black outlines on cards and buttons (2-3px).
- Terrazzo / zigzag / squiggle decorative patterns.
- Mix rounded corners and sharp corners on same view.
- Solid colored drop shadows (not blurred).

**Flourish picks:** Terrazzo Pattern · Squiggle Underline · Colored Offset Shadow
**Composition signature:** `diagonal-flow` — see `references/composition-signatures.md`

---

### 22. Sketchbook

**Feel:** Hand-drawn, pencil, loose. Feels like a designer's notebook page.

**Color ramp:** `#fdfbf6` · `#f5f0e3` · `#e4dcc6` · `#c4b89a` · `#9a8b65` · `#6b5f42` · `#44392a` · `#2b2317` · `#18130c` · `#0c0906`
**Accents:** pencil graphite `#2b2317` · sepia `#8a5a2b` · dusty blue `#4a6978`

**Type:**
- Headline: `"Caveat"` 700 or `"Architects Daughter"` 400
- Body: `Nunito` 400, line-height 1.6
- Mono: `"Cascadia Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 32 · 48
- Google Fonts: `Caveat:wght@400;600;700&family=Architects+Daughter&family=Nunito:wght@300;400;600`

**Spacing:** 4 · 8 · 12 · 18 · 26 · 40 · 56 · 84 · 112 (organic)
**Radius:** 4 · 8 · 14 · 22
**Shadow:** pencil-smudge soft. L1 `0 1px 2px rgba(43,35,23,.08)` · L2 `0 2px 6px rgba(43,35,23,.10)` · L3 `0 4px 12px rgba(43,35,23,.12)` · L4 `0 8px 20px rgba(43,35,23,.15)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 180 / 320 / 500ms

**Rules:**
- Hand-drawn fonts for headlines + display.
- Slight element rotation (0.5-1.5deg) for sketchy feel.
- Dashed or dotted borders (hand-drawn effect).
- Paper-texture backgrounds welcome.
- Sketchy arrows and squiggle dividers.

**Flourish picks:** Squiggle Underline · Hand-Drawn Arrow · Pencil Margin Note
**Composition signature:** `diagonal-flow` — see `references/composition-signatures.md`

---

### 23. Retro Futurism

**Feel:** 70s sci-fi, chrome edges, wide stretched type, burnt orange + teal. Bladerunner-meets-Apollo.

**Color ramp:** `#fef6e8` · `#fde4b8` · `#f9c878` · `#ec9a3f` · `#c9691e` · `#8a3a12` · `#5a2810` · `#3b1a0b` · `#231007` · `#120803`
**Accents:** teal `#0891b2` · mustard `#eab308` · cream `#fef6e8` · chrome silver gradient

**Type:**
- Headline: `"Righteous"` 400 or `"Bungee"` 400 wide display
- Body: `"Exo 2"` 400, line-height 1.5
- Mono: `"Space Mono"` 500
- Scale: 14 · 16 · 18 · 24 · 38 · 60
- Google Fonts: `Righteous&family=Bungee&family=Exo+2:wght@400;500;700&family=Space+Mono:wght@400;700`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 112
**Radius:** 0 · 2 · 4 · 16 (mix sharp + occasional curve)
**Shadow:** chrome-tinted. L1 `0 1px 0 rgba(255,255,255,.3), 0 2px 4px rgba(0,0,0,.15)` · L2 same + blur 4 · L3 same + blur 8 · L4 same + blur 16
**Motion:** `cubic-bezier(.25,.46,.45,.94)` · 200 / 400 / 640ms

**Rules:**
- Wide-set type for headlines (letter-spacing 0.05-0.1em).
- Burnt orange + teal is the signature combo.
- Chrome gradient (silver) on buttons and CTA borders.
- Sunburst / starburst motifs as decorative accents.
- Dark-mode variant natural.

**Flourish picks:** Chrome Border · Sunburst Motif · Wide Letterspacing
**Composition signature:** `poster` — see `references/composition-signatures.md`

---

### 24. Cyberpunk Neon

**Feel:** Dark + neon magenta/cyan/purple. Glitch effects, hard angles, deliberately oppressive.

**Color ramp:** `#030014` · `#0a0a1e` · `#14142b` · `#1e1e40` · `#2e2e60` · `#4a4a8a` · `#8080bf` · `#b3b3d9` · `#d6d6ed` · `#f5f5ff`
**Accents:** neon magenta `#ff006e` · cyan `#00f5ff` · purple `#8338ec` · yellow-warning `#ffbe0b`

**Type:**
- Headline: `"Rajdhani"` 700 or `"Orbitron"` 800 geometric
- Body: `Saira` 400, line-height 1.5
- Mono: `"Share Tech Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 32 · 52
- Google Fonts: `Rajdhani:wght@500;700&family=Orbitron:wght@500;800&family=Saira:wght@400;500;600&family=Share+Tech+Mono`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius:** 0 · 0 · 2 · 4 (sharp)
**Shadow:** neon glow. L1 `0 0 4px rgba(255,0,110,.5)` · L2 `0 0 12px rgba(255,0,110,.4), 0 0 24px rgba(131,56,236,.3)` · L3 `0 0 20px rgba(0,245,255,.5)` · L4 `0 0 40px rgba(0,245,255,.6)`
**Motion:** `cubic-bezier(.7,0,.3,1)` · 120 / 240 / 400ms (glitchy)

**Rules:**
- Dark background, neon foreground.
- Hard angles, zero curves on primary elements.
- Neon glow on interactive states.
- Occasional glitch offset (::after translated 2px).
- Uppercase headings with wide letter-spacing.
- Never use neutral color accents — always neon.

**Flourish picks:** Neon Glow · Glitch Offset · Chromatic Split
**Composition signature:** `dense-console` — see `references/composition-signatures.md`

---

### 25. Art Deco

**Feel:** 1920s luxury, gold accents, fan shapes, vertical symmetry, Gatsby-era.

**Color ramp:** `#fef9f0` · `#f2e4c2` · `#d9c08a` · `#b89a5a` · `#8a6f3a` · `#5a4520` · `#3d2f16` · `#241d0e` · `#141008` · `#0a0704`
**Accents:** gold `#d4af37` · deep navy `#1e3a5f` · burgundy `#7c1d2e`

**Type:**
- Headline: `"Limelight"` 400 display or `"Poiret One"` 400 thin elegant
- Body: `"Cormorant Garamond"` 400, line-height 1.65
- Scale: 12 · 14 · 16 · 22 · 36 · 64
- Google Fonts: `Limelight&family=Poiret+One&family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;1,400`

**Spacing:** 4 · 8 · 14 · 22 · 36 · 56 · 88 · 136 · 200 (grand)
**Radius:** 0 · 0 · 0 · 2 (angular)
**Shadow:** rarely — use geometric ornament instead.
**Motion:** slow elegant · 240 / 480 / 720ms

**Rules:**
- Gold hairlines as dividers (1px).
- Vertical symmetry on hero sections.
- Fan-shape and sunburst motifs as ornament.
- Tall thin typography with extreme letter-spacing.
- Deep navy + cream + gold is the signature palette.
- No rounded corners, no gradients except gold foil effect.

**Flourish picks:** Gold Hairline · Fan Ornament · Vertical Symmetry
**Composition signature:** `poster` — see `references/composition-signatures.md`

---

### 26. Botanical Herbarium

**Feel:** Muted greens + warm cream. Italic display, botanical illustration adjacency, herbarium-specimen feel.

**Color ramp:** `#fbf9f3` · `#f0ece0` · `#dfd8c2` · `#c2b89a` · `#9a9276` · `#6b6a4c` · `#48472f` · `#2a2b1b` · `#18180f` · `#0b0b06`
**Accents:** sage `#7a8b5c` · moss `#556b3a` · ink brown `#48472f` · burnt sienna `#9a3e1c`

**Type:**
- Headline: `"Cormorant Garamond"` 600 italic display
- Body: `"Source Serif 4"` 400, line-height 1.7
- Mono: `"IBM Plex Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 32 · 48
- Google Fonts: `Cormorant+Garamond:ital,wght@0,400;0,500;0,600;1,400;1,500;1,600&family=Source+Serif+4:ital,opsz,wght@0,8..60,400;0,8..60,500;1,8..60,400`

**Spacing:** 4 · 8 · 12 · 18 · 28 · 44 · 68 · 100 · 144
**Radius:** 2 · 4 · 8 · 12
**Shadow:** soft earth-tinted. L1 `0 1px 2px rgba(72,71,47,.08)` · L2 `0 2px 6px rgba(72,71,47,.10)` · L3 `0 4px 12px rgba(72,71,47,.12)` · L4 `0 8px 20px rgba(72,71,47,.14)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 200 / 360 / 520ms

**Rules:**
- Italic display type for headlines.
- Sage + moss + ink brown palette.
- Hairline botanical-style borders.
- Latin-style small caps for labels.
- No bright accents — all earth tones.
- Line engravings / botanical illustrations welcome.

**Flourish picks:** Botanical Border · Italic Kicker · Small-Caps Label
**Composition signature:** `editorial-spread` — see `references/composition-signatures.md`

---

### 27. Kraft Paper

**Feel:** Brown paper bag texture, rubber stamps, ink-on-cardboard. Hand-made small-batch feel.

**Color ramp:** `#f4ead6` · `#e8d9b3` · `#d4bf8e` · `#b89e68` · `#8e7445` · `#634e2a` · `#3d2e17` · `#241a0d` · `#140d06` · `#0a0603`
**Accents:** rubber-stamp red `#a3281c` · charcoal `#2a2218` · muted teal `#4a6c63`

**Type:**
- Headline: `"Courier Prime"` 700, stenciled feel
- Body: `"Anonymous Pro"` 400, line-height 1.55
- Display alt: `"Special Elite"` for hand-stamped
- Scale: 12 · 14 · 16 · 20 · 28 · 44
- Google Fonts: `Courier+Prime:ital,wght@0,400;0,700;1,400;1,700&family=Anonymous+Pro:ital,wght@0,400;0,700;1,400&family=Special+Elite`

**Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 104
**Radius:** 0 · 2 · 4 · 6
**Shadow:** ink-blot soft. L1 `0 1px 2px rgba(99,78,42,.15)` · L2 `0 2px 6px rgba(99,78,42,.18)` · L3 `0 4px 12px rgba(99,78,42,.22)` · L4 `0 8px 20px rgba(99,78,42,.26)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 180 / 320 / 500ms

**Rules:**
- Warm brown/kraft backgrounds on cards.
- Rubber-stamp red for emphasis (sparingly).
- Typewriter / stencil typography.
- Slight ink-bleed effect on borders (inset box-shadow).
- Hand-rough uneven edges (no perfect alignment).

**Flourish picks:** Rubber Stamp · Paper Grain · Hand-Rough Border
**Composition signature:** `monolith` — see `references/composition-signatures.md`

---

### 28. Dashboard Operator

**Feel:** Data-dense, telemetry-style, serious operator UI. Mono + compact sans, alert colors, table-first.

**Color ramp:** `#0b0f19` · `#111827` · `#1f2937` · `#374151` · `#4b5563` · `#6b7280` · `#9ca3af` · `#d1d5db` · `#e5e7eb` · `#f9fafb`
**Accents:** acid green `#10b981` (OK) · alert red `#ef4444` · amber warning `#f59e0b` · info cyan `#06b6d4`

**Type:**
- Headline: `"JetBrains Mono"` 700 — the mono-display identity tradition
- Body: `Archivo` 400, line-height 1.45 (compact)
- Mono: `"JetBrains Mono"` 500
- Scale: 11 · 13 · 14 · 16 · 20 · 28
- Google Fonts: `JetBrains+Mono:wght@400;500;700&family=Archivo:wght@400;500;600;700`

**Spacing:** 2 · 4 · 6 · 8 · 12 · 16 · 24 · 32 · 48 (tight)
**Radius:** 2 · 4 · 6 · 6
**Shadow:** none (borders do the work).
**Motion:** `linear` · 60 / 120 / 200ms (snappy)

**Rules:**
- Dark background default; everything high contrast.
- Monospace numerals in all tables/metrics.
- Status colors used ONLY for semantic state (OK / warn / error / info).
- Tables with zebra stripes, 1px hairline borders.
- Small-caps labels for sections.
- Information density > breathing room.

**Flourish picks:** Status Dot · Mono Table · Small-Caps Section Label
**Composition signature:** `dense-console` — see `references/composition-signatures.md`

---

### 29. Anti-Design

**Feel:** Intentionally ugly. Clashing fonts, broken grid, provocative. Subverts expectations. Used sparingly for effect.

**Color ramp:** `#ffffff` · `#f0f0f0` · `#cccccc` · `#888888` · `#555555` · `#000000` · `#ff00ff` · `#00ff00` · `#ffff00` · `#ff0000`
**Accents:** hot pink `#ff00aa` · lime `#aaff00` · electric yellow `#ffee00`

**Type:**
- Headline: `"Times New Roman"` serif (system, no import)
- Body: `"Comic Sans MS"` or `"Papyrus"` (intentionally)
- Display alt: `"Wingdings"` for chaos
- Scale: 11 · 14 · 19 · 23 · 38 · 70 (deliberately uneven)
- Google Fonts: none (system fonts intentionally)

**Spacing:** 3 · 7 · 11 · 17 · 23 · 31 · 43 · 59 · 89 (primes)
**Radius:** 0 · 30 · 3 · 40 (mix wildly)
**Shadow:** clashing. L1 `7px 7px 0 #ff00aa` · L2 `-4px 4px 0 #aaff00` · L3 `0 10px 0 #ffee00` · L4 `3px -3px 0 #000`
**Motion:** `steps(3)` · 90 / 220 / 370ms

**Rules:**
- Clashing fonts are the point — mix serif + Comic Sans + system.
- Broken grid — elements aligned to nothing.
- Clashing color combos (hot pink on lime).
- Mixed radii — some elements pill-round, others sharp.
- Intentionally misaligned shadows and borders.
- Use only for artifacts meant to provoke.

**Flourish picks:** Clashing Font Pair · Broken Grid · Mismatched Radii
**Composition signature:** `broken-grid` — see `references/composition-signatures.md`

---

### 30. Midnight Marine

**Feel:** Deep navy + aqua + pale gold + cream. Modern nautical. Calm, upscale, considered.

**Color ramp:** `#f5f3ed` · `#e4e0d0` · `#c9c3a8` · `#8a9ba5` · `#4a6b7a` · `#2a4a5f` · `#1a2f40` · `#0f1e2b` · `#08121a` · `#04090d`
**Accents:** aqua `#6ec1c9` · pale gold `#c9a867` · cream `#f5f3ed` · signal red `#c13f3f`

**Type:**
- Headline: `Marcellus` 400, classical inscriptional elegance
- Body: `"Alegreya Sans"` 400, line-height 1.65
- Mono: `"Red Hat Mono"` 400
- Scale: 13 · 15 · 17 · 22 · 32 · 52
- Google Fonts: `Marcellus&family=Alegreya+Sans:ital,wght@0,400;0,500;0,700;1,400&family=Red+Hat+Mono:wght@400;500`

**Spacing:** 4 · 8 · 12 · 18 · 28 · 44 · 68 · 100 · 144 (grand)
**Radius:** 0 · 2 · 4 · 6 (restrained)
**Shadow:** deep, quiet. L1 `0 1px 3px rgba(8,18,26,.15)` · L2 `0 2px 8px rgba(8,18,26,.20)` · L3 `0 4px 16px rgba(8,18,26,.25)` · L4 `0 8px 32px rgba(8,18,26,.30)`
**Motion:** `cubic-bezier(.4,0,.2,1)` · 240 / 420 / 640ms (deliberate)

**Rules:**
- Dark navy backgrounds with cream text preferred.
- Pale gold for accents only — never dominant.
- Hairline gold rules (1px) as dividers.
- Italic display type for editorial feel.
- Compass-rose or nautical ornament sparingly.
- Aqua used for interactive states only.

**Flourish picks:** Gold Hairline · Italic Display · Compass Ornament
**Composition signature:** `poster` — see `references/composition-signatures.md`

---
