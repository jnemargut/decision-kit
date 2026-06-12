# Signature Flourish Library


Ten flourish types. Each has: default CSS + per-tradition variant if needed + HTML insertion hook.

### Drop Cap
```css
.vd-dropcap { float: left; font-family: var(--headline); font-size: 3.5em; line-height: 0.85; padding: 0.12em 0.15em 0 0; color: var(--accent); }
```
**Insertion:** wrap first letter of the first `<p>` after each `<h1>` in `<span class="vd-dropcap">`.
**Fits:** Editorial, Neo-Classical, Warm Handmade, Academic, Luxury Serif.

### Kicker
```css
.vd-kicker { font-family: var(--body); font-size: .75em; font-weight: 700; letter-spacing: .15em; text-transform: uppercase; color: var(--accent); margin-bottom: .4em; }
/* Editorial variant: italic instead of uppercase */
.vd-kicker--editorial { font-style: italic; font-weight: 600; text-transform: none; }
```
**Insertion:** prepend `<span class="vd-kicker">[section number or label]</span>` to each h2.
**Fits:** everything. Default flourish.

### Rule Line
```css
.vd-rule { border: none; border-top: 1px solid var(--ink-3); margin: 1.5em 0; }
/* Doubled (Neo-Classical): */
.vd-rule--double { border-top: 1px solid var(--ink-3); border-bottom: 1px solid var(--ink-3); height: 3px; background: transparent; }
/* Thick (Neo-Brutalist): */
.vd-rule--thick { border-top: 3px solid var(--ink-900); }
```
**Insertion:** add `<hr class="vd-rule">` between major sections.
**Fits:** Swiss, Technical, Academic, Neo-Classical, Neo-Brutalist.

### Grain Texture
```css
.vd-grain { background-image: radial-gradient(rgba(0,0,0,.12) 0.5px, transparent 0.5px); background-size: 3px 3px; }
```
**Insertion:** apply `.vd-grain` to the body or main container as an overlay.
**Fits:** Warm Handmade, Editorial, Warm Minimal.

### Pull Quote
```css
.vd-pullquote { border-left: 4px solid var(--accent); padding: .5em 1em; font-family: var(--headline); font-style: italic; font-size: 1.2em; color: var(--ink-2); margin: 1.5em 0; }
```
**Insertion:** wrap selected long `<p>` in `<blockquote class="vd-pullquote">`.
**Fits:** Editorial, Neo-Classical, Warm Handmade, Luxury Serif.

### Ornament Divider
```css
.vd-ornament { text-align: center; color: var(--accent); letter-spacing: .3em; font-size: 1.2em; margin: 2em 0; }
.vd-ornament::before { content: "✦  ❋  ✦"; }
/* Luxury variant: */
.vd-ornament--luxury::before { content: "◆  ◆  ◆"; color: var(--accent-gold); }
```
**Insertion:** replace `<hr>` or insert between major sections.
**Fits:** Warm Handmade, Luxury Serif, Neo-Classical, Editorial.

### Small-Caps Label
```css
.vd-smcp { font-variant: small-caps; letter-spacing: .1em; font-weight: 700; color: var(--accent); }
```
**Insertion:** wrap nav items, metadata, bylines in `<span class="vd-smcp">`.
**Fits:** Swiss, Technical, Academic, Neo-Classical, Luxury Serif, Warm Minimal.

### Offset Box Shadow
```css
.vd-offset { box-shadow: 5px 5px 0 var(--ink-900); border: 2px solid var(--ink-900); }
```
**Insertion:** apply to cards, buttons, callout blocks.
**Fits:** Neo-Brutalist exclusively — signature of that tradition.

### ASCII Divider
```css
.vd-ascii { font-family: var(--mono); color: var(--ink-3); white-space: pre; text-align: center; margin: 1.5em 0; }
.vd-ascii::before { content: "- - - - - - - - - -"; }
```
**Insertion:** between sections, replacing `<hr>`.
**Fits:** Monochrome, Technical, Neon Terminal.

### Inline Code Accent
```css
code { font-family: var(--mono); background: var(--ramp-100); padding: .15em .4em; border-radius: 3px; font-size: .9em; color: var(--accent); }
```
**Insertion:** style any existing `<code>` tags — no DOM insertion needed.
**Fits:** Technical, Monochrome, Neo-Brutalist.

