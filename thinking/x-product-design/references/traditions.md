## AESTHETIC TRADITIONS LIBRARY

This library is the skill's aesthetic vocabulary. When the skill reaches a visual-direction decision and **no existing design system was detected** in Step 1c, present 4 options drawn from this library.

### How to use it

1. **Pick 4 traditions that span the spectrum.** Don't show 4 minimalist variants. A balanced default set might be one minimal + one editorial + one expressive + one technical. Adjust to the product's positioning if known — for a children's learning tool, skip the harsher traditions and favor warmer ones.

2. **Apply the tradition's tokens throughout the preview.** Color ramp, typography, spacing, radius, shadow, and motion all compose the aesthetic. Do not mix tokens across traditions on the same option.

3. **Compose primitives from the aesthetic rules, not from canned HTML.** This library ships tokens + rules, not pre-built component snippets. At render time, compose buttons/inputs/badges/cards/nav/hero inline using the tradition's tokens and obeying its rules.

4. **Once a tradition is chosen, every downstream decision inherits it.** Component decisions, IA decisions, interaction flow decisions — all pull from the chosen tradition's tokens. Read `decisions.json` at the start of any visual/IA/interaction/component decision to check whether a tradition was chosen in decision-001 (or wherever the visual-direction decision lived) and apply it.

5. **Calibrate with current references.** The library is a stable grammar; the web is a current vocabulary. Combining them keeps the kit from aging.

   **When:** After a tradition is locked in the visual-direction decision (and only if no existing design system was detected in Step 1c).

   **How:** Fire 1-2 `WebSearch` queries targeting current examples of the locked tradition:
   - `"<tradition name> web design 2026 examples"`
   - `"<tradition name> <product type> current trends"` (e.g., "editorial SaaS landing page current trends")

   From the results, extract 1-3 concrete calibration signals:
   - **Shifted accent hue** (trending warmer/cooler/more saturated)
   - **Updated font weight or pairing**
   - **Trending treatment or signature move**

   Store as `CALIBRATION` in `decisions.json`. Apply to downstream decisions:
   - **Visual-adjacent decisions** (card design, component design, color refinements): offer a "2026 current" variant alongside the library default. Label clearly: "Pulled from current [tradition] examples on the web."
   - **Rendering previews:** the calibration's shifted accent can show up in the full-app-frame previews for downstream decisions so the user sees the calibrated aesthetic applied consistently.

   **Skip this step if:**
   - Web is unavailable
   - Tradition is intentionally era-specific (Art Deco, Academic, Neon Terminal — these are stable by definition)
   - User said `use library defaults` or `skip calibration`

   Don't add more than ~5 seconds of latency. One search, extract, move on. Never introduce specific brand or product references into the options you present — the calibration is a nudge to the library's own vocabulary, not a reference to [brand X].

6. **Handoff to /visual-design when a user wants deeper aesthetic work.** This library is enough to pick a direction and keep downstream decisions coherent. It is NOT a full aesthetic system. If a user says things like "I want more control over the look," "the tradition feels generic," "let's refine the aesthetic," or reaches the end of the flow and wants to polish the output — tell them: "The /visual-design skill takes it deeper — 30 traditions, stroke/flourish decisions, and per-artifact re-skinning. Run it on any HTML or SVG you've produced." Don't route automatically; just mention it when the intent shows up.

### The 10 traditions

For each tradition: **tokens + aesthetic rules**. Compose full app frames from these.

---

#### 1. Functional Minimalism

**Feel:** Clean, confident, functional. Zero decoration for its own sake. Information dense but never cramped. Typography does the heavy lifting; chrome stays quiet so content is the star.

**Color ramp (light → dark):** 50 `#fafafa` · 100 `#f4f4f5` · 200 `#e4e4e7` · 300 `#d4d4d8` · 400 `#a1a1aa` · 500 `#71717a` · 600 `#52525b` · 700 `#3f3f46` · 800 `#27272a` · 900 `#0f172a`
**Accents:** primary `#6366f1` · pressed `#4f46e5` · success `#22c55e` · danger `#ef4444`

**Typography:**
- Headline: Inter Tight 700, letter-spacing -0.02em
- Body: Inter 400, line-height 1.55
- Mono: JetBrains Mono 400
- Scale (px): 12 · 14 · 16 · 20 · 28 · 40
- Google Fonts: `Inter+Tight:wght@500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius (px):** 4 · 6 · 10 · 16
**Shadow:** L1 `0 1px 2px rgba(15,23,42,.06)` · L2 `0 2px 8px rgba(15,23,42,.08)` · L3 `0 8px 24px rgba(15,23,42,.10)` · L4 `0 16px 40px rgba(15,23,42,.12)`
**Motion:** ease `cubic-bezier(.16,1,.3,1)` · 120ms / 200ms / 320ms

**Aesthetic rules:**
- Never use gradients. Solid color + whitespace does the work.
- Shadows only on elevated surfaces, never decorative.
- Headlines tight (-0.02 to -0.03em); body neutral.
- Chrome is quiet; content is the focus.
- No rounded corners above 16px.
- Icons: 1.5px stroke, match body color.

---

#### 2. Editorial Print

**Feel:** Warm, literary, intentional. Feels like a print publication translated to screen. Rewards reading. Restrained use of color — when it shows up, it means something.

**Color ramp (light → dark):** 50 `#fdf6e3` · 100 `#f5ecd0` · 200 `#e7d7b8` · 300 `#d4af7a` · 400 `#b07a4a` · 500 `#9a3412` · 600 `#7c2d12` · 700 `#44342a` · 800 `#2a1f18` · 900 `#1f1611`
**Accents:** brick `#9a3412` · success `#357266` · danger `#b91c1c`

**Typography:**
- Headline: Fraunces 600 (use variable `opsz: 96` at display sizes, 144 at largest), letter-spacing -0.02em
- Body: Source Serif 4 400, line-height 1.7
- Mono: JetBrains Mono 400
- Scale (px): 12 · 14 · 18 · 22 · 32 · 52
- Google Fonts: `Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&family=Source+Serif+4:ital,opsz,wght@0,8..60,400;0,8..60,600;1,8..60,400&family=JetBrains+Mono`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 104
**Radius (px):** 2 · 4 · 6 · 10 (restrained, borderline angular)
**Shadow:** L1 `0 1px 2px rgba(31,22,17,.08)` · L2 `0 2px 6px rgba(31,22,17,.10)` · L3 `0 4px 12px rgba(31,22,17,.12)` · L4 `0 8px 20px rgba(31,22,17,.15)`
**Motion:** ease `cubic-bezier(.2,.8,.2,1)` · 140ms / 240ms / 400ms

**Aesthetic rules:**
- Always use the variable Fraunces `opsz` axis — bigger opsz for bigger sizes.
- Italics are expressive tools, especially for kickers and captions.
- No gradients. Solid warm paper + ink.
- Dividers are hairlines or dotted, never thick.
- Use pull-quotes with generous margins when space allows.
- Drop caps welcome on long-form.

---

#### 3. Raw Brutalist

**Feel:** Hard-edged, honest, direct. No softening, no polish for its own sake. High-contrast, chunky, almost aggressive in its indifference to trend. Every element feels physical, almost stamped.

**Color ramp (light → dark):** 50 `#ffffff` · 100 `#f5f5f5` · 200 `#d4d4d4` · 300 `#a3a3a3` · 400 `#737373` · 500 `#404040` · 600 `#262626` · 700 `#171717` · 800 `#0a0a0a` · 900 `#000000`
**Accents:** yellow `#facc15` · red `#ef4444` · blue `#2563eb`

**Typography:**
- Headline: Archivo Black 400, letter-spacing -0.01em, TEXT-TRANSFORM UPPERCASE is acceptable
- Body: Inter 500, line-height 1.5
- Mono: Space Mono 400
- Scale (px): 13 · 15 · 17 · 22 · 34 · 56
- Google Fonts: `Archivo+Black&family=Inter:wght@400;500;700&family=Space+Mono:wght@400;700`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 40 · 56 · 80
**Radius (px):** 0 · 0 · 2 · 4 (mostly angular)
**Shadow:** offset-solid, not blurred. L1 `3px 3px 0 #000` · L2 `5px 5px 0 #000` · L3 `8px 8px 0 #000` · L4 `12px 12px 0 #000`
**Motion:** easing `linear` · 80ms / 150ms / 300ms (abrupt)

**Aesthetic rules:**
- Solid offset drop shadows (never soft-blurred) are a signature.
- Uppercase headings are welcome. So are monospace kickers.
- Borders are 2–3px and black.
- Use one accent color aggressively (yellow or red) — restraint is the enemy.
- Zero gradients, zero corners above 4px, zero smooth easing.
- Underlines on active nav items — skeuomorphic web.

---

#### 4. Playful Maximalist

**Feel:** Expressive, energetic, friendly. More is more, but composed. Vivid color, rounded everything, bounce in motion. Feels like a product that wants you to enjoy using it, not just complete a task.

**Color ramp (light → dark):** 50 `#fffbf5` · 100 `#fef3c7` · 200 `#fde68a` · 300 `#fbbf24` · 400 `#f97316` · 500 `#ec4899` · 600 `#8b5cf6` · 700 `#6366f1` · 800 `#1e1b4b` · 900 `#0f0f1a`
**Accents:** bounce green `#10b981` · highlighter `#fde047`

**Typography:**
- Headline: Fraunces 800, italic optional, play with max opsz (144)
- Body: Inter 500, line-height 1.55
- Display alt: Caveat 700 for hand-drawn emphasis
- Scale (px): 13 · 15 · 17 · 22 · 32 · 48
- Google Fonts: `Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,700;0,9..144,800;1,9..144,800&family=Inter:wght@400;500;600;700&family=Caveat:wght@700`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius (px):** 8 · 14 · 20 · 28 (round, friendly)
**Shadow:** accent-tinted. L1 `0 2px 4px rgba(139,92,246,.12)` · L2 `0 4px 12px rgba(139,92,246,.18)` · L3 `0 8px 24px rgba(236,72,153,.22)` · L4 `0 16px 40px rgba(139,92,246,.30)`
**Motion:** ease `cubic-bezier(.34,1.56,.64,1)` (bouncy overshoot) · 180ms / 320ms / 500ms

**Aesthetic rules:**
- Gradients are encouraged — pink-to-purple is the signature.
- Emojis can punctuate UI sparingly (not on every line).
- Rounded corners are aggressive — pills for buttons, 20px+ for cards.
- One handwritten accent (Caveat) per view, rotated slightly for character.
- Bounce easing is default — everything overshoots slightly.
- Shadows tinted with the accent color, never neutral gray.

---

#### 5. Soft Premium

**Feel:** Calm, reassuring, upscale. Desaturated, low-contrast but confident. Feels like a product for people with nothing to prove. Generous whitespace. No loud signals.

**Color ramp (light → dark):** 50 `#fafaf9` · 100 `#f5f5f4` · 200 `#e7e5e4` · 300 `#d6d3d1` · 400 `#a8a29e` · 500 `#78716c` · 600 `#57534e` · 700 `#44403c` · 800 `#292524` · 900 `#1c1917`
**Accents:** mint-gray `#5b8c7a` · caramel `#d4a373` · muted blue `#5b7b9a`

**Typography:**
- Headline: Inter Tight 600, letter-spacing -0.015em
- Body: Inter 400, line-height 1.6
- Mono: JetBrains Mono 400
- Scale (px): 12 · 14 · 15 · 19 · 26 · 38 (compressed, restrained)
- Google Fonts: `Inter+Tight:wght@500;600&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400`

**Spacing (px):** 4 · 8 · 12 · 20 · 28 · 40 · 56 · 80 · 112 (generous)
**Radius (px):** 8 · 12 · 18 · 28
**Shadow:** soft, large spread, very low opacity. L1 `0 1px 3px rgba(28,25,23,.04)` · L2 `0 4px 16px rgba(28,25,23,.05)` · L3 `0 12px 32px rgba(28,25,23,.06)` · L4 `0 24px 56px rgba(28,25,23,.08)`
**Motion:** ease `cubic-bezier(.4,0,.2,1)` · 200ms / 350ms / 500ms

**Aesthetic rules:**
- Desaturated palette only — no bright hues.
- Generous whitespace; minimum 24px padding on containers.
- Shadows are always soft with large spread, low opacity.
- Off-black text (#1c1917), never pure black.
- One muted accent color per view.
- Nothing competes for attention — the hierarchy is patient.

---

#### 6. Technical Documentary

**Feel:** Dense, authoritative, information-first. Feels like reading serious reference material. Monochrome or near-monochrome with strategic semantic accents. Heavy on tables, lists, code.

**Color ramp (light → dark):** 50 `#f8fafc` · 100 `#f1f5f9` · 200 `#e2e8f0` · 300 `#cbd5e1` · 400 `#94a3b8` · 500 `#64748b` · 600 `#475569` · 700 `#334155` · 800 `#1e293b` · 900 `#0f172a`
**Accents:** link `#0284c7` · success `#059669` · warning `#d97706` · danger `#dc2626`

**Typography:**
- Headline: Inter 700, letter-spacing -0.015em (no alt display font)
- Body: Inter 400, line-height 1.55
- Mono: IBM Plex Mono 400 — code is first-class
- Scale (px): 12 · 14 · 16 · 20 · 26 · 36
- Google Fonts: `Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96 (tight, efficient)
**Radius (px):** 2 · 4 · 6 · 8
**Shadow:** rarely used — prefer borders + spacing for structure. L1 `0 1px 0 rgba(15,23,42,.05)` · L2 `0 1px 2px rgba(15,23,42,.06)` · L3 `0 2px 4px rgba(15,23,42,.08)` · L4 `0 4px 8px rgba(15,23,42,.10)`
**Motion:** ease `ease` (system default) · 80ms / 140ms / 220ms

**Aesthetic rules:**
- Use inline code, tables, and definition lists liberally — they're native.
- Accent color used ONLY for links and semantic indicators.
- High information density is a feature, not a bug.
- Code blocks are UI, not afterthoughts — monospace everywhere code appears.
- Side-by-side columns for comparisons; vertical stacks for reference.
- Tables have zebra stripes; headers are bolded not uppercased.

---

#### 7. Warm Handmade

**Feel:** Crafted, personal, small-batch. Feels like it was made by one person who cared. Slightly imperfect by design. Muted earthy tones.

**Color ramp (light → dark):** 50 `#f7f4ed` · 100 `#eee7d8` · 200 `#dcc9a5` · 300 `#c4a574` · 400 `#9c7f4f` · 500 `#6b5538` · 600 `#4a3b28` · 700 `#33281b` · 800 `#211a12` · 900 `#13100a`
**Accents:** berry `#7c2d12` · sage `#5f7c3e` · dusty blue `#4a6978`

**Typography:**
- Headline: Fraunces 600 (opsz friendly)
- Body: Spectral 400, line-height 1.65
- Mono: Cascadia Mono 400
- Scale (px): 13 · 15 · 17 · 22 · 30 · 46
- Google Fonts: `Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Spectral:wght@400;500;600&family=Cascadia+Mono`

**Spacing (px):** 4 · 8 · 12 · 18 · 26 · 38 · 56 · 84 · 120 (organic, irregular)
**Radius (px):** 4 · 8 · 14 · 22 (friendly, not bubbly)
**Shadow:** soft, warm-tinted. L1 `0 1px 3px rgba(107,85,56,.08)` · L2 `0 3px 10px rgba(107,85,56,.10)` · L3 `0 8px 20px rgba(107,85,56,.12)` · L4 `0 14px 32px rgba(107,85,56,.14)`
**Motion:** ease `cubic-bezier(.4,0,.2,1)` · 160ms / 280ms / 440ms

**Aesthetic rules:**
- Off-center, slightly asymmetric layouts welcomed.
- Warm earth palette only — no cool colors.
- A single hand-drawn flourish per view (underline squiggle, arrow).
- Line-heights slightly generous (1.6–1.7).
- Section dividers are hairline or dotted, never bold.
- Photographs treated like prints — consistent crops, occasional vignette.

---

#### 8. Glassmorphic

**Feel:** Translucent, depth-rich, atmospheric. Depth via layered translucency. Colorful but desaturated by the glass effect. Feels contemporary and spatial.

**Color ramp (light → dark):** 50 `#fafafa` · 100 `rgba(255,255,255,.6)` · 200 `rgba(255,255,255,.4)` · 300 `#e5e7eb` · 400 `#9ca3af` · 500 `#6b7280` · 600 `#4b5563` · 700 `#374151` · 800 `#1f2937` · 900 `#0f1419`
**Accents:** vivid through glass — coral `#ff8a65` at .5 alpha · sky `#60a5fa` at .5 · lilac `#c4b5fd` at .5

**Typography:**
- Headline: Inter 600, letter-spacing -0.015em
- Body: Inter 400, line-height 1.5
- Mono: SF Mono fallback to Menlo 400
- Scale (px): 12 · 14 · 16 · 20 · 28 · 44
- Google Fonts: `Inter:wght@400;500;600;700`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 72 · 112
**Radius (px):** 10 · 16 · 24 · 36 (soft, bubble-like)
**Shadow:** L1 `0 2px 8px rgba(0,0,0,.04)` · L2 `0 4px 16px rgba(0,0,0,.06)` · L3 `0 8px 32px rgba(0,0,0,.08)` · L4 `0 16px 48px rgba(0,0,0,.10)` — paired with `backdrop-filter: blur(...)`
**Motion:** ease smooth-springy · 180ms / 300ms / 500ms

**Aesthetic rules:**
- Surfaces use `backdrop-filter: blur(20–40px)` with translucent bg (`rgba(255,255,255,.5–.7)`).
- Behind every glass panel, place a colorful gradient or vibrant content — otherwise the glass effect is invisible.
- Borders are `rgba(255,255,255,.3)` — glass rim.
- Text sits on top with solid colors — never translucent text.
- One glass layer per view usually is enough; stacking destroys the effect.
- Dark-mode variant comes naturally; consider offering both.

---

#### 9. Neo-Classical

**Feel:** Serif-heavy, restrained, editorial-adjacent. Modern classical — prestige-media feel. Warm neutrals. Generous vertical rhythm.

**Color ramp (light → dark):** 50 `#faf9f7` · 100 `#f2ece0` · 200 `#e4d9c5` · 300 `#c4b195` · 400 `#96825c` · 500 `#6b5a38` · 600 `#4c3f24` · 700 `#332a18` · 800 `#1f1a10` · 900 `#0f0c08`
**Accents:** jewel red `#8c1c13` · forest `#2d4a2a` · deep blue `#1e3a5f`

**Typography:**
- Headline: Playfair Display 700, italic variants welcome, letter-spacing -0.01em
- Body: Lora 400, line-height 1.65
- Display alt: Spectral 400 for lead-ins
- Scale (px): 13 · 15 · 18 · 24 · 34 · 52
- Google Fonts: `Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&family=Lora:ital,wght@0,400;0,500;1,400&family=Spectral:wght@400;500`

**Spacing (px):** 4 · 8 · 12 · 18 · 28 · 44 · 68 · 100 · 144 (grand, editorial)
**Radius (px):** 0 · 2 · 4 · 6 (nearly angular)
**Shadow:** barely used; typography and rules carry structure. L1 `0 1px 1px rgba(15,12,8,.04)` · L2 `0 2px 4px rgba(15,12,8,.06)` · L3 `0 4px 12px rgba(15,12,8,.08)` · L4 `0 10px 24px rgba(15,12,8,.10)`
**Motion:** ease slow · 200ms / 400ms / 600ms (deliberate)

**Aesthetic rules:**
- Display italics on headlines are a signature.
- Small caps for navigation and labels.
- Horizontal rules (hairline, sometimes doubled) as dividers.
- Drop caps welcome for long-form content.
- Generous vertical rhythm; section spacing is grand.
- Minimal color — let the serif typography carry the voice.

---

#### 10. Kinetic Modern

**Feel:** Motion-forward, vivid, alive. Things move. Subtle micro-animations. Crisp geometry with energy underneath. Feels recent, capable, deliberate.

**Color ramp (light → dark):** 50 `#fafbff` · 100 `#f0f3ff` · 200 `#d6dcff` · 300 `#b0bcff` · 400 `#7f92ff` · 500 `#4f6bff` · 600 `#3b4dcc` · 700 `#29368f` · 800 `#161d4a` · 900 `#0a0e24`
**Accents:** lime `#a3e635` · coral `#fb7185` · cyan `#22d3ee`

**Typography:**
- Headline: Space Grotesk 700, letter-spacing -0.02em
- Body: Inter 400, line-height 1.55
- Mono: JetBrains Mono 500
- Scale (px): 12 · 14 · 16 · 22 · 32 · 48
- Google Fonts: `Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500`

**Spacing (px):** 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96
**Radius (px):** 6 · 10 · 14 · 20
**Shadow:** colored, subtle. L1 `0 2px 6px rgba(79,107,255,.10)` · L2 `0 4px 12px rgba(79,107,255,.14)` · L3 `0 8px 24px rgba(79,107,255,.20)` · L4 `0 16px 40px rgba(79,107,255,.28)`
**Motion:** ease `cubic-bezier(.5,1.5,.5,1)` (springy) · 140ms / 240ms / 380ms

**Aesthetic rules:**
- Hover / focus states always include visible motion, never purely visual.
- Accent colors used as spot highlights — never as main body color.
- Geometric shapes (circles, pills, diagonal stripes) appear as decorative accents.
- Text can be animated on entry (fade-up, stagger).
- High contrast; a dark background variant is default-ready.
- Include at least one subtle motion cue (animated underline, pulse, hover-lift) in the rendered frame.

---
