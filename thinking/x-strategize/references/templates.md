## HTML TEMPLATE REFERENCE

### Decision Page HTML Structure

Each decision page must be a self-contained HTML file with this structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Decision [N]: [Title] — [Project Name]</title>
  <!-- NOTE: Use plain numbers (1, 2, 3) not zero-padded (001, 002, 003) in display text.
       Zero-padding is only for filenames (decision-001-slug.html). -->
  <!-- Load Google Fonts for EVERY visual-direction decision — each tradition has its own pairing. -->
  <!-- Combine all 4 traditions' font imports into one <link> in <head>. -->
  <!-- For other decisions (IA, interaction, technical), load fonts only if typography is part of the decision. -->
  <!-- Load Chart.js ONLY if the decision involves data visualization -->
  <style>
    /* === BASE RESET & TYPOGRAPHY === */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
      background: #f1f5f9;
      color: #1a1a2e;
      min-height: 100vh;
      padding: 2rem;
      line-height: 1.6;
    }

    /* === HEADER === */
    header {
      text-align: center;
      margin-bottom: 2.5rem;
      padding-bottom: 1.5rem;
      border-bottom: 2px solid #e2e8f0;
      max-width: 1200px;
      margin-left: auto;
      margin-right: auto;
    }

    .decision-number {
      font-size: 0.75rem;
      font-weight: 700;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: #64748b;
    }

    header h1 {
      font-size: 1.6rem;
      font-weight: 700;
      color: #0f172a;
      letter-spacing: -0.02em;
      margin-top: 0.25rem;
    }

    .category-badge {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 999px;
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      margin-top: 0.5rem;
    }

    .category-badge.technical { background: #ede9fe; color: #6d28d9; }
    .category-badge.visual { background: #fce7f3; color: #be185d; }
    .category-badge.interaction { background: #e0f2fe; color: #0369a1; }
    .category-badge.ia { background: #ecfdf5; color: #047857; }

    .decision-description {
      font-size: 1rem;
      color: #475569;
      margin-top: 0.75rem;
      max-width: 700px;
      margin-left: auto;
      margin-right: auto;
      line-height: 1.7;
    }

    .instruction {
      margin-top: 1rem;
      font-size: 0.85rem;
      background: #eff6ff;
      color: #1d4ed8;
      padding: 0.6rem 1.25rem;
      border-radius: 8px;
      display: inline-block;
      border: 1px solid #bfdbfe;
    }

    /* === OPTION CARDS GRID === */
    .options-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.5rem;
      max-width: 1200px;
      margin: 0 auto 3rem;
    }

    /* === OPTION CARD === */
    .option-card {
      background: white;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08), 0 4px 16px rgba(0,0,0,0.04);
      border: 2px solid #e2e8f0;
      transition: all 0.2s ease;
      display: flex;
      flex-direction: column;
      position: relative;
    }

    .option-card:hover {
      border-color: #6366f1;
      box-shadow: 0 4px 20px rgba(99,102,241,0.12);
    }

    .card-header {
      padding: 1rem 1.25rem 0.75rem;
      border-bottom: 1px solid #f1f5f9;
      display: flex;
      flex-direction: column;
      gap: 0.2rem;
    }

    .card-header-top {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 0.5rem;
    }

    .option-label {
      font-size: 0.65rem;
      font-weight: 800;
      letter-spacing: 0.1em;
      text-transform: uppercase;
    }

    /* Option label colors */
    .option-card.option-a .option-label { color: #7c3aed; }
    .option-card.option-b .option-label { color: #0891b2; }
    .option-card.option-c .option-label { color: #059669; }
    .option-card.option-d .option-label { color: #dc2626; }

    .option-title {
      font-size: 1.05rem;
      font-weight: 600;
      color: #0f172a;
    }

    /* === RECOMMENDED BADGE === */
    .recommended-badge {
      background: #f59e0b;
      color: white;
      padding: 3px 10px;
      border-radius: 999px;
      font-size: 0.65rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      white-space: nowrap;
    }

    /* === CHOSEN STATE === */
    .option-card.chosen {
      border: 3px solid #059669;
      box-shadow: 0 4px 20px rgba(5,150,105,0.15);
    }

    .option-card.chosen:hover {
      border-color: #059669;
    }

    /* Badges container — stacks recommended and chosen badges vertically */
    .card-badges {
      display: flex;
      flex-direction: column;
      align-items: flex-end;
      gap: 4px;
      flex-shrink: 0;
    }

    .chosen-badge {
      background: #059669;
      color: white;
      padding: 3px 10px;
      border-radius: 999px;
      font-size: 0.65rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      white-space: nowrap;
      display: none;
    }

    .option-card.chosen .chosen-badge {
      display: inline-block;
    }

    .option-card.not-chosen {
      opacity: 0.55;
      filter: grayscale(20%);
    }

    .option-card.not-chosen:hover {
      opacity: 0.8;
      filter: none;
    }

    /* === VISUAL PREVIEW === */
    .visual-preview {
      padding: 1.25rem;
      background: #f8fafc;
      min-height: 360px;
      display: flex;
      align-items: stretch;
      justify-content: center;
      flex: 1;
    }

    /* === PLAIN ENGLISH SUMMARY === */
    .option-summary {
      padding: 1rem 1.25rem;
      font-size: 0.875rem;
      color: #334155;
      line-height: 1.65;
      border-top: 1px solid #f1f5f9;
    }

    /* === PROS / CONS === */
    .verdict {
      display: grid;
      grid-template-columns: 1fr 1fr;
      border-top: 1px solid #f1f5f9;
    }

    .pros, .cons { padding: 1rem 1.25rem; }
    .pros { border-right: 1px solid #f1f5f9; }

    .pros h3, .cons h3 {
      font-size: 0.65rem;
      font-weight: 800;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      margin-bottom: 0.5rem;
    }

    .pros h3 { color: #059669; }
    .cons h3 { color: #e11d48; }

    .verdict ul { list-style: none; padding: 0; }

    .verdict li {
      font-size: 0.8rem;
      color: #475569;
      line-height: 1.5;
      padding: 0.15rem 0;
      padding-left: 1rem;
      position: relative;
    }

    .pros li::before { content: "✓ "; color: #059669; font-weight: 700; position: absolute; left: 0; }
    .cons li::before { content: "! "; color: #e11d48; font-weight: 700; position: absolute; left: 0; }

    /* === CARD FOOTER === */
    .card-footer {
      padding: 0.75rem 1.25rem;
      background: #f8fafc;
      border-top: 1px solid #f1f5f9;
    }

    .tell-ai {
      font-size: 0.75rem;
      color: #64748b;
      background: #f1f5f9;
      padding: 0.35rem 0.65rem;
      border-radius: 6px;
      display: block;
      font-family: 'SF Mono', 'Fira Code', 'Cascadia Code', monospace;
    }

    /* === COMPARISON TABLE === */
    .comparison-section {
      max-width: 1200px;
      margin: 0 auto 3rem;
    }

    .comparison-section h2 {
      font-size: 1.1rem;
      font-weight: 700;
      color: #0f172a;
      margin-bottom: 1rem;
    }

    .comparison-table-wrapper {
      overflow-x: auto;
      border-radius: 12px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08), 0 4px 16px rgba(0,0,0,0.04);
    }

    .comparison-table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      font-size: 0.85rem;
    }

    .comparison-table th {
      padding: 0.85rem 1rem;
      text-align: left;
      font-weight: 700;
      font-size: 0.75rem;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      border-bottom: 2px solid #e2e8f0;
      white-space: nowrap;
      position: sticky;
      top: 0;
      background: white;
    }

    .comparison-table th:first-child {
      position: sticky;
      left: 0;
      z-index: 2;
      background: #f8fafc;
      color: #64748b;
    }

    /* Color-code the option column headers */
    .comparison-table th.col-a { color: #7c3aed; }
    .comparison-table th.col-b { color: #0891b2; }
    .comparison-table th.col-c { color: #059669; }
    .comparison-table th.col-d { color: #dc2626; }

    .comparison-table td {
      padding: 0.75rem 1rem;
      border-bottom: 1px solid #f1f5f9;
      color: #334155;
    }

    .comparison-table td:first-child {
      font-weight: 600;
      color: #475569;
      position: sticky;
      left: 0;
      background: #f8fafc;
    }

    .comparison-table tr:nth-child(even) td { background: #fafbfc; }
    .comparison-table tr:nth-child(even) td:first-child { background: #f1f5f9; }

    /* Recommended column highlight */
    .comparison-table .col-recommended { background: #fffbeb !important; }

    /* Chosen column highlight */
    .comparison-table .col-chosen { background: #ecfdf5 !important; }

    .comparison-table tr:last-child td { border-bottom: none; }

    /* === INSTRUCTIONS FOOTER === */
    .page-footer {
      max-width: 1200px;
      margin: 0 auto;
      text-align: center;
      padding: 1.5rem;
      background: white;
      border-radius: 12px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08);
    }

    .page-footer p {
      font-size: 0.85rem;
      color: #64748b;
      margin: 0.3rem 0;
    }

    .page-footer strong {
      color: #334155;
    }

    /* === NAV LINK TO LANDING PAGE === */
    .back-link {
      display: inline-block;
      margin-bottom: 1.5rem;
      font-size: 0.85rem;
      color: #6366f1;
      text-decoration: none;
      max-width: 1200px;
    }

    .back-link:hover { text-decoration: underline; }

    /* === RESPONSIVE === */
    @media (max-width: 768px) {
      .options-grid { grid-template-columns: 1fr; }
      body { padding: 1rem; }
    }

    /* === EXTENDED OPTION COLORS (for "more options") === */
    .option-card.option-e .option-label { color: #ea580c; }
    .option-card.option-f .option-label { color: #db2777; }
    .option-card.option-g .option-label { color: #0d9488; }
    .option-card.option-h .option-label { color: #4338ca; }
    .option-card.option-i .option-label { color: #d97706; }
    .option-card.option-j .option-label { color: #9333ea; }
    .option-card.option-k .option-label { color: #65a30d; }
    .option-card.option-l .option-label { color: #0284c7; }

    /* Extended comparison table header colors */
    .comparison-table th.col-e { color: #ea580c; }
    .comparison-table th.col-f { color: #db2777; }
    .comparison-table th.col-g { color: #0d9488; }
    .comparison-table th.col-h { color: #4338ca; }
    .comparison-table th.col-i { color: #d97706; }
    .comparison-table th.col-j { color: #9333ea; }
    .comparison-table th.col-k { color: #65a30d; }
    .comparison-table th.col-l { color: #0284c7; }

    /* === FLOW DIAGRAM STYLES (for interaction decisions) === */

    /* Vertical numbered flow: each step is a numbered box in a single column.
       This is the ONLY supported flow diagram layout. Do NOT use horizontal rows. */
    .flow-container {
      display: flex;
      flex-direction: column;
      align-items: stretch;
      gap: 0;
      padding: 0.5rem;
      width: 100%;
      max-width: 280px;
    }

    .flow-step {
      display: flex;
      align-items: center;
      gap: 10px;
      background: white;
      border: 2px solid #e2e8f0;
      border-radius: 10px;
      padding: 8px 12px;
      font-size: 0.7rem;
      font-weight: 600;
      color: #334155;
      text-align: left;
      box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    }

    .flow-step.highlight {
      border-color: #6366f1;
      background: #eff6ff;
      color: #1d4ed8;
    }

    .flow-step-number {
      width: 22px;
      height: 22px;
      border-radius: 50%;
      background: #e2e8f0;
      color: #475569;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.6rem;
      font-weight: 700;
      flex-shrink: 0;
    }

    .flow-step.highlight .flow-step-number {
      background: #6366f1;
      color: white;
    }

    .flow-step-label {
      flex: 1;
    }

    /* Down arrow between steps */
    .flow-down-arrow {
      font-size: 1rem;
      color: #94a3b8;
      padding: 2px 0;
      text-align: center;
    }

    /* Error/failure step variant */
    .flow-step.error {
      border-color: #e11d48;
      background: #fff1f2;
      color: #be123c;
    }

    .flow-step.error .flow-step-number {
      background: #e11d48;
      color: white;
    }

    /* Branch label — dashed separator showing a conditional path */
    .flow-branch-label {
      font-size: 0.6rem;
      font-weight: 700;
      color: #94a3b8;
      text-transform: uppercase;
      letter-spacing: 0.08em;
      text-align: center;
      padding: 6px 0 2px;
      border-top: 1px dashed #cbd5e1;
      margin-top: 4px;
    }

    /* === SITE MAP / NAV VISUALIZATION (for IA decisions) === */
    .sitemap {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 8px;
      padding: 0.5rem;
    }

    .sitemap-level {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
      justify-content: center;
    }

    .sitemap-node {
      background: white;
      border: 2px solid #e2e8f0;
      border-radius: 8px;
      padding: 6px 12px;
      font-size: 0.7rem;
      font-weight: 600;
      color: #334155;
      box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    }

    .sitemap-node.primary {
      background: #6366f1;
      color: white;
      border-color: #6366f1;
    }

    .sitemap-connector {
      width: 2px;
      height: 12px;
      background: #cbd5e1;
      margin: 0 auto;
    }

    /* === ARCHITECTURE DIAGRAM (for technical decisions) === */
    .arch-diagram {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
      padding: 0.5rem;
      width: 100%;
    }

    .arch-layer {
      display: flex;
      gap: 8px;
      justify-content: center;
      flex-wrap: wrap;
      width: 100%;
    }

    .arch-box {
      background: white;
      border: 2px solid #e2e8f0;
      border-radius: 8px;
      padding: 8px 14px;
      font-size: 0.7rem;
      font-weight: 600;
      color: #334155;
      text-align: center;
      min-width: 70px;
      box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    }

    .arch-box.frontend { border-color: #7c3aed; color: #7c3aed; }
    .arch-box.backend { border-color: #0891b2; color: #0891b2; }
    .arch-box.database { border-color: #059669; color: #059669; }
    .arch-box.service { border-color: #dc2626; color: #dc2626; }

    .arch-arrow {
      font-size: 1rem;
      color: #94a3b8;
      text-align: center;
    }
  </style>
</head>
<body>
  <a href="index.html" class="back-link">← All Decisions</a>

  <header>
    <span class="decision-number">Decision [N] of [TOTAL]</span>
    <!-- Use plain numbers: "Decision 3 of 8" NOT "Decision 003 of 8" -->
    <h1>[Decision Title]</h1>
    <span class="category-badge [technical|visual|interaction|ia]">[Category Name]</span>
    <p class="decision-description">
      [3-5 sentences in plain English explaining what this decision is about,
       why it matters, and what factors should influence the choice.
       Write like you're explaining it to a smart friend over coffee.]
    </p>
    <p class="instruction">
      Respond with: <strong>"Option B"</strong> · <strong>"Option A but [change]"</strong> · <strong>"more options"</strong>
    </p>
  </header>

  <main class="options-grid">
    <!-- Repeat this card structure for each option (A, B, C, D) -->
    <article class="option-card option-a">
      <div class="card-header">
        <div class="card-header-top">
          <span class="option-label">Option A</span>
          <!-- Badges container: holds recommended and/or chosen badges, stacked vertically.
               ALWAYS include this container. Only include the badges that apply. -->
          <div class="card-badges">
            <!-- Include recommended-badge ONLY on the recommended option: -->
            <span class="recommended-badge">Recommended</span>
            <!-- chosen-badge is always present in HTML but hidden via CSS until .chosen class is added to the card: -->
            <span class="chosen-badge">Chosen</span>
          </div>
        </div>
        <h2 class="option-title">[2-4 Word Evocative Name]</h2>
      </div>

      <div class="visual-preview">
        <!-- CONTEXT-DEPENDENT VISUAL — see rules below -->
      </div>

      <div class="option-summary">
        [3-4 sentences in plain English. What does choosing this option actually mean?
         How will it affect the project? Who is this a good fit for?
         Write conversationally — no jargon without explanation.]
      </div>

      <div class="verdict">
        <div class="pros">
          <h3>Works well when</h3>
          <ul>
            <li>[Specific context where this shines]</li>
            <li>[Another strength]</li>
            <li>[A third point if genuinely useful]</li>
          </ul>
        </div>
        <div class="cons">
          <h3>Watch out for</h3>
          <ul>
            <li>[Honest trade-off — not FUD, a real consideration]</li>
            <li>[Another trade-off]</li>
          </ul>
        </div>
      </div>

      <div class="card-footer">
        <code class="tell-ai">Respond with: "Option A"</code>
      </div>
    </article>
    <!-- ... repeat for B, C, D ... -->
  </main>

  <!-- COMPARISON TABLE -->
  <section class="comparison-section">
    <h2>How They Compare</h2>
    <div class="comparison-table-wrapper">
      <table class="comparison-table">
        <thead>
          <tr>
            <th></th>
            <th class="col-a [col-recommended]">Option A: [Name]</th>
            <th class="col-b [col-recommended]">Option B: [Name]</th>
            <th class="col-c [col-recommended]">Option C: [Name]</th>
            <th class="col-d [col-recommended]">Option D: [Name]</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>[Dimension 1, e.g. "Learning curve"]</td>
            <td class="[col-recommended]">[Value]</td>
            <td class="[col-recommended]">[Value]</td>
            <td class="[col-recommended]">[Value]</td>
            <td class="[col-recommended]">[Value]</td>
          </tr>
          <!-- 4-8 rows comparing meaningful dimensions -->
          <!-- The recommended option's column cells should all have class "col-recommended" -->
          <!-- After a choice is made, the chosen column cells get class "col-chosen" instead -->
        </tbody>
      </table>
    </div>
  </section>

  <!-- PAGE FOOTER -->
  <div class="page-footer">
    <p>Respond with: <strong>"Option A"</strong>, <strong>"Option C but [your change]"</strong>, or <strong>"more options"</strong></p>
    <p>To change a past decision: <strong>"for decision-001 I want Option B instead"</strong></p>
  </div>

</body>
</html>
```

### Visual Preview Rules — What To Put in `.visual-preview`

The visual preview should contain a **real rendered visual**, not just text. What to show depends on the decision type:

**For Visual/UX decisions (visual direction, overall style):**

Render a **full app frame** per option — a realistic slice of a product screen that lets the user feel the aesthetic. Target dimensions: 280–320px wide, 340–420px tall. A thumbnail-sized mini-card is not enough — an aesthetic needs room to breathe. If you show four options in a thumbnail format, they'll collapse into "four different colored rectangles" and the user won't feel the difference.

Pull the chosen tradition's tokens and aesthetic rules from the **Aesthetic Traditions Library** (see that section above) and compose the frame inline. Every option card MUST include all of these elements:

1. **Browser chrome** — three traffic-light dots on a neutral bar
2. **App header** with brand name (using the tradition's headline font) and 3 nav items (using its body font)
3. **Hero section** with: a kicker (small, accent-colored, usually uppercase unless the tradition's rules say otherwise), a headline (display treatment using the tradition's max scale step), a subhead (body font, ~60ch max width), and a primary CTA button composed from the tradition's aesthetic
4. **Content strip** with 2–3 cards composed following the tradition's aesthetic rules

**Use realistic product-relevant content** — never `Card 1`, `Item A`, or Lorem ipsum. Pull names, taglines, and item content from the product context (the strategy brief if available, otherwise invent reasonable examples fitting the product's domain).

**Skeleton** — replace every `[token]` with the chosen tradition's actual values, and adapt the structure to the tradition's aesthetic rules:

```html
<div style="width:300px;background:[ramp-50];border:1px solid [ramp-200];border-radius:[radius-lg];overflow:hidden;box-shadow:[shadow-L2];font-family:[body-font]">
  <!-- chrome -->
  <div style="background:[ramp-100];padding:6px 10px;display:flex;gap:5px;border-bottom:1px solid [ramp-200]">
    <span style="width:8px;height:8px;border-radius:50%;background:#ef4444"></span>
    <span style="width:8px;height:8px;border-radius:50%;background:#eab308"></span>
    <span style="width:8px;height:8px;border-radius:50%;background:#22c55e"></span>
  </div>
  <!-- nav -->
  <header style="display:flex;justify-content:space-between;align-items:center;padding:10px 14px;border-bottom:1px solid [ramp-200]">
    <div style="font-family:[headline-font];font-weight:[headline-weight];font-size:15px;color:[ramp-900];letter-spacing:[headline-tracking]">[Brand]</div>
    <nav style="display:flex;gap:14px;font-size:12px;color:[ramp-600];font-weight:500">
      <span>Nav A</span><span>Nav B</span><span>Nav C</span>
    </nav>
  </header>
  <!-- hero -->
  <section style="padding:24px 16px">
    <div style="font-size:11px;font-weight:700;color:[accent];letter-spacing:.08em;text-transform:uppercase">Kicker</div>
    <h1 style="font-family:[headline-font];font-weight:[headline-weight];font-size:32px;color:[ramp-900];letter-spacing:[headline-tracking];line-height:1.05;margin:6px 0 0">Realistic headline, two lines max</h1>
    <p style="font-size:13px;color:[ramp-600];margin-top:8px;line-height:1.55;max-width:260px">Realistic subhead describing what the product does in one sentence.</p>
    <button style="font-family:[body-font];font-weight:600;font-size:13px;padding:8px 16px;background:[ramp-900];color:[ramp-50];border:none;border-radius:[radius-md];margin-top:14px;cursor:pointer">Primary CTA →</button>
  </section>
  <!-- content strip -->
  <div style="display:grid;grid-template-columns:1fr 1fr;gap:6px;padding:10px 14px 14px">
    <div style="background:[ramp-50];border:1px solid [ramp-200];border-radius:[radius-md];padding:8px 10px">
      <div style="font-family:[headline-font];font-weight:600;font-size:12px;color:[ramp-900]">Realistic item 1</div>
      <div style="font-size:10px;color:[ramp-500];margin-top:2px">context line</div>
    </div>
    <div style="background:[ramp-50];border:1px solid [ramp-200];border-radius:[radius-md];padding:8px 10px">
      <div style="font-family:[headline-font];font-weight:600;font-size:12px;color:[ramp-900]">Realistic item 2</div>
      <div style="font-size:10px;color:[ramp-500];margin-top:2px">context line</div>
    </div>
  </div>
</div>
```

This skeleton is a *starting point*, not the final rule. Each tradition's aesthetic rules determine how to modify the skeleton. A tradition with offset-solid shadows applies them to cards; a tradition with gradients on CTAs applies them to the primary button; a tradition with italic kickers applies font-style to the kicker text.

**IMPORTANT — load the right Google Fonts for every tradition being shown.** The HTML `<head>` must include a Google Fonts import line covering the headline + body + mono fonts of every tradition in the 4 options. If you present Functional Minimalism + Editorial Print + Raw Brutalist + Playful Maximalist, you need Inter Tight, Inter, Fraunces, Source Serif 4, Archivo Black, JetBrains Mono, Caveat, etc., all loaded at once.

Do NOT:
- Use placeholder text in the final output — every string must be product-specific and realistic
- Mix tokens across traditions on the same option
- Ignore the tradition's aesthetic rules (e.g., use gradients on a tradition whose rules forbid them)
- Ship without running the **Principles Checklist** (see that section below)

**For component-design decisions (button styles, card treatments, specific component patterns) when a tradition has already been chosen:**
Compose the rendered component using the chosen tradition's tokens. Do NOT fall back to the skeleton above — component decisions render the specific component(s) under discussion (e.g., 4 different button treatments, all composed from the tradition's tokens with meaningfully different takes).

**For Interaction decisions (user flows, how actions work):**
Build a vertical numbered flow diagram using `.flow-container`, `.flow-step`, `.flow-step-number`, `.flow-step-label`, and `.flow-down-arrow`.

**ALWAYS use this pattern — a vertical column of numbered steps:**
```html
<div class="flow-container">
  <div class="flow-step">
    <span class="flow-step-number">1</span>
    <span class="flow-step-label">Browse books nearby</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step highlight">
    <span class="flow-step-number">2</span>
    <span class="flow-step-label">Tap "Request to Borrow"</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step">
    <span class="flow-step-number">3</span>
    <span class="flow-step-label">Owner gets notified</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step highlight">
    <span class="flow-step-number">4</span>
    <span class="flow-step-label">Owner approves request</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step">
    <span class="flow-step-number">5</span>
    <span class="flow-step-label">Chat opens — arrange pickup</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step highlight">
    <span class="flow-step-number">6</span>
    <span class="flow-step-label">Both confirm handoff — done!</span>
  </div>
</div>
```

**Branching flows (when the path splits based on a condition):**
Use `.flow-branch-label` for the condition and sub-numbered steps (4a, 4b, etc.) for each branch. Use `.flow-step.error` for failure/error steps:
```html
<div class="flow-container">
  <div class="flow-step">
    <span class="flow-step-number">1</span>
    <span class="flow-step-label">Tap "Request to Borrow"</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step error">
    <span class="flow-step-number">2</span>
    <span class="flow-step-label">Request fails</span>
  </div>
  <div class="flow-down-arrow">↓</div>
  <div class="flow-step highlight">
    <span class="flow-step-number">3</span>
    <span class="flow-step-label">Button changes to suggested action</span>
  </div>
  <div class="flow-branch-label">if book was taken ↓</div>
  <div class="flow-step">
    <span class="flow-step-number">3a</span>
    <span class="flow-step-label">Button says "See Similar Books"</span>
  </div>
  <div class="flow-branch-label">if network error ↓</div>
  <div class="flow-step">
    <span class="flow-step-number">3b</span>
    <span class="flow-step-label">Button says "Try Again"</span>
  </div>
</div>
```

**IMPORTANT flow diagram rules:**
- ALWAYS use a vertical single-column layout. NEVER use horizontal rows — they create confusing arrow connections.
- ALWAYS number every step with `.flow-step-number` (1, 2, 3, etc.). Use sub-numbers (4a, 4b) for branches.
- Use `↓` arrows (`.flow-down-arrow`) between sequential steps
- Use `.flow-branch-label` with a condition ("if book was taken ↓") before branching sub-steps
- Use `.flow-step.error` for failure/error steps (red styling)
- Use `.highlight` on the 2-3 most important/differentiating steps (the ones that make this option unique)
- Keep to 4-7 steps. Combine trivial steps if needed.
- In the **option-summary text below the diagram**, reference step numbers: "In step 2, the borrower taps..." This ties the visual to the explanation.
- Each step label should be a short action phrase (verb first): "Tap request button", "Owner approves", "Chat opens"

**For Information Architecture decisions (navigation, content hierarchy):**
Build a mini site-map using the `.sitemap`, `.sitemap-level`, and `.sitemap-node` CSS classes:
```html
<div class="sitemap">
  <div class="sitemap-level">
    <div class="sitemap-node primary">Map View</div>
  </div>
  <div class="sitemap-connector"></div>
  <div class="sitemap-level">
    <div class="sitemap-node">My Books</div>
    <div class="sitemap-node">Browse</div>
    <div class="sitemap-node">Messages</div>
    <div class="sitemap-node">Profile</div>
  </div>
</div>
```

**For Technical decisions (framework, database, architecture):**
Build an architecture diagram using the `.arch-diagram`, `.arch-layer`, and `.arch-box` CSS classes:
```html
<div class="arch-diagram">
  <div class="arch-layer">
    <div class="arch-box frontend">React SPA</div>
  </div>
  <div class="arch-arrow">↕</div>
  <div class="arch-layer">
    <div class="arch-box backend">REST API</div>
    <div class="arch-box service">Auth</div>
  </div>
  <div class="arch-arrow">↕</div>
  <div class="arch-layer">
    <div class="arch-box database">PostgreSQL</div>
  </div>
</div>
```

For some technical decisions (like "which database"), a simple stats/features list may be more useful than a diagram — use your judgment. The point is to help the user *see* the difference, not to force a visual where one doesn't help.

### Comparison Table Dimensions

Choose 5-8 dimensions that genuinely matter for the specific decision. Adapt per category:

**Technical decisions:**
- Learning curve, Community/ecosystem, Performance, Scalability, Cost, Hosting options, Best suited for

**Visual/UX decisions:**
- Mood/feeling, Accessibility, Brand alignment, User demographic fit, Trend durability, Implementation effort

**Interaction decisions:**
- Number of steps, User effort, Error recovery, Speed to complete, Flexibility, Familiarity

**IA decisions:**
- Discoverability, Scalability (as content grows), Mobile friendliness, Cognitive load, Engagement pattern

---

## LANDING PAGE TEMPLATE

The landing page at `.decisions/index.html` shows all decisions at a glance:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Decision Hub — [Project Name]</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
      background: #f1f5f9;
      color: #1a1a2e;
      min-height: 100vh;
      padding: 2rem;
      line-height: 1.6;
    }

    .container {
      max-width: 900px;
      margin: 0 auto;
    }

    header {
      text-align: center;
      margin-bottom: 2rem;
      padding-bottom: 1.5rem;
      border-bottom: 2px solid #e2e8f0;
    }

    header h1 {
      font-size: 1.6rem;
      font-weight: 700;
      color: #0f172a;
      letter-spacing: -0.02em;
    }

    .project-description {
      font-size: 1rem;
      color: #475569;
      margin-top: 0.5rem;
    }

    /* Progress bar */
    .progress-section {
      margin: 1.5rem 0;
    }

    .progress-label {
      font-size: 0.85rem;
      color: #64748b;
      margin-bottom: 0.5rem;
      display: flex;
      justify-content: space-between;
    }

    .progress-bar {
      width: 100%;
      height: 8px;
      background: #e2e8f0;
      border-radius: 999px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: #059669;
      border-radius: 999px;
      transition: width 0.3s ease;
    }

    /* Decision list */
    .decision-list {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .decision-item {
      background: white;
      border-radius: 12px;
      padding: 1.25rem 1.5rem;
      box-shadow: 0 1px 3px rgba(0,0,0,0.06);
      border: 2px solid #e2e8f0;
      text-decoration: none;
      color: inherit;
      display: flex;
      align-items: center;
      gap: 1rem;
      transition: border-color 0.2s;
    }

    .decision-item:hover {
      border-color: #6366f1;
    }

    .decision-item.resolved {
      border-left: 4px solid #059669;
    }

    .decision-item.pending {
      border-left: 4px solid #f59e0b;
    }

    .decision-number-badge {
      width: 36px;
      height: 36px;
      border-radius: 999px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.8rem;
      font-weight: 700;
      flex-shrink: 0;
    }

    .decision-item.resolved .decision-number-badge {
      background: #ecfdf5;
      color: #059669;
    }

    .decision-item.pending .decision-number-badge {
      background: #fffbeb;
      color: #d97706;
    }

    .decision-info {
      flex: 1;
    }

    .decision-info h3 {
      font-size: 1rem;
      font-weight: 600;
      color: #0f172a;
    }

    .decision-meta {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-top: 0.3rem;
      flex-wrap: wrap;
    }

    .landing-category-badge {
      display: inline-block;
      padding: 2px 8px;
      border-radius: 999px;
      font-size: 0.6rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
    }

    .landing-category-badge.technical { background: #ede9fe; color: #6d28d9; }
    .landing-category-badge.visual { background: #fce7f3; color: #be185d; }
    .landing-category-badge.interaction { background: #e0f2fe; color: #0369a1; }
    .landing-category-badge.ia { background: #ecfdf5; color: #047857; }

    .decision-status {
      font-size: 0.8rem;
      color: #64748b;
    }

    .decision-status .chosen-text {
      color: #059669;
      font-weight: 600;
    }

    .decision-status .pending-text {
      color: #d97706;
      font-weight: 600;
    }

    .decision-summary {
      font-size: 0.8rem;
      color: #64748b;
      margin-top: 0.25rem;
    }

    .arrow-icon {
      color: #94a3b8;
      font-size: 1.1rem;
      flex-shrink: 0;
    }

    .footer-note {
      text-align: center;
      margin-top: 2rem;
      font-size: 0.8rem;
      color: #94a3b8;
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <h1>Decision Hub</h1>
      <p class="project-description">[Project Name] — [1-sentence description]</p>
    </header>

    <div class="progress-section">
      <div class="progress-label">
        <span>[X] of [Y] decisions made</span>
        <span>[percentage]%</span>
      </div>
      <div class="progress-bar">
        <div class="progress-fill" style="width: [percentage]%"></div>
      </div>
    </div>

    <div class="decision-list">
      <!-- For each decision: -->
      <a href="decision-001-slug.html" class="decision-item [resolved|pending]">
        <div class="decision-number-badge">1</div>
        <div class="decision-info">
          <h3>[Decision Title]</h3>
          <div class="decision-meta">
            <span class="landing-category-badge [technical|visual|interaction|ia]">[Category]</span>
            <span class="decision-status">
              <!-- If resolved: -->
              <span class="chosen-text">Chosen: Option B — [Title]</span>
              <!-- If pending: -->
              <span class="pending-text">Pending</span>
            </span>
          </div>
          <p class="decision-summary">[One sentence summary]</p>
        </div>
        <span class="arrow-icon">→</span>
      </a>
      <!-- ... repeat for each decision ... -->
    </div>

    <p class="footer-note">
      To change a decision, respond with: "for decision-001 I want Option B instead"
    </p>
  </div>
</body>
</html>
```

---

## V2 ADDITIONS — CSS + markup for the new page elements

Add these to every decision page generated by x-product-design / x-strategize.

### Triage badges (header, next to category badge)

```html
<span class="triage-badge one-way">🚪 One-way door</span>
<span class="triage-badge two-way">🔁 Two-way door</span>
<span class="triage-badge stakes-high">High stakes</span>
```
```css
.triage-badge { display:inline-block; padding:4px 12px; border-radius:999px; font-size:0.7rem; font-weight:700; letter-spacing:0.05em; text-transform:uppercase; margin-top:0.5rem; margin-left:6px; }
.triage-badge.one-way { background:#fef2f2; color:#dc2626; }
.triage-badge.two-way { background:#ecfeff; color:#0891b2; }
.triage-badge.stakes-high { background:#fff7ed; color:#c2410c; }
.triage-badge.stakes-med  { background:#fefce8; color:#a16207; }
.triage-badge.stakes-low  { background:#f8fafc; color:#64748b; }
```

### Confidence badge (inside .card-badges, under the recommended badge)

```html
<span class="confidence-badge strong">Strong pick</span>   <!-- or -->
<span class="confidence-badge lean">Lean</span>            <!-- or -->
<span class="confidence-badge tossup">Toss-up</span>
```
```css
.confidence-badge { padding:3px 10px; border-radius:999px; font-size:0.65rem; font-weight:700; letter-spacing:0.05em; text-transform:uppercase; white-space:nowrap; color:white; }
.confidence-badge.strong { background:#059669; }
.confidence-badge.lean   { background:#d97706; }
.confidence-badge.tossup { background:#64748b; }
```

### "The case against my pick" callout (below options grid, before comparison table)

```html
<section class="case-against">
  <h2>The case against my pick</h2>
  <p>[2-4 sentences of real steelman — sourced from the "what fails" research where possible.]</p>
</section>
```
```css
.case-against { max-width:1200px; margin:0 auto 3rem; background:white; border-left:4px solid #e11d48; border-radius:12px; padding:1.25rem 1.5rem; box-shadow:0 1px 3px rgba(0,0,0,0.08); }
.case-against h2 { font-size:0.8rem; font-weight:800; letter-spacing:0.08em; text-transform:uppercase; color:#e11d48; margin-bottom:0.5rem; }
.case-against p { font-size:0.9rem; color:#334155; line-height:1.65; }
```

### Research Context with receipts + expert-disagreement callout

```html
<section class="research-context">
  <h2>What the research says</h2>
  <ul class="findings">
    <li>[Finding in plain English.] <a class="cite" href="[url]">Source Name</a> <span class="trusted-tag">voice you trust</span></li>
  </ul>
  <div class="experts-disagree">
    <h3>Where experts disagree</h3>
    <p>[Both camps, plain English, and what condition decides between them.]</p>
  </div>
</section>
```
```css
.research-context { max-width:1200px; margin:0 auto 3rem; background:white; border-radius:12px; padding:1.25rem 1.5rem; box-shadow:0 1px 3px rgba(0,0,0,0.08); }
.research-context h2 { font-size:0.8rem; font-weight:800; letter-spacing:0.08em; text-transform:uppercase; color:#6366f1; margin-bottom:0.75rem; }
.findings { list-style:none; padding:0; }
.findings li { font-size:0.875rem; color:#334155; line-height:1.6; padding:0.35rem 0 0.35rem 1.1rem; position:relative; }
.findings li::before { content:"→"; position:absolute; left:0; color:#6366f1; font-weight:700; }
.cite { color:#6366f1; font-size:0.8rem; text-decoration:none; border-bottom:1px dotted #6366f1; margin-left:4px; }
.trusted-tag { font-size:0.65rem; font-weight:700; text-transform:uppercase; letter-spacing:0.05em; background:#ecfdf5; color:#047857; padding:2px 8px; border-radius:999px; margin-left:6px; }
.experts-disagree { margin-top:1rem; border-left:4px solid #f59e0b; background:#fffbeb; border-radius:0 8px 8px 0; padding:0.85rem 1.1rem; }
.experts-disagree h3 { font-size:0.7rem; font-weight:800; letter-spacing:0.08em; text-transform:uppercase; color:#b45309; margin-bottom:0.35rem; }
.experts-disagree p { font-size:0.85rem; color:#451a03; line-height:1.6; }
```

### Assumptions strip (below case-against)

```html
<section class="assumptions">
  <h2>This recommendation assumes</h2>
  <ul><li>[Assumption]</li></ul>
</section>
```
```css
.assumptions { max-width:1200px; margin:0 auto 3rem; font-size:0.85rem; color:#475569; background:#f8fafc; border:1px dashed #cbd5e1; border-radius:12px; padding:1rem 1.5rem; }
.assumptions h2 { font-size:0.7rem; font-weight:800; letter-spacing:0.08em; text-transform:uppercase; color:#64748b; margin-bottom:0.4rem; }
.assumptions ul { padding-left:1.1rem; }
```

### Living Preview link (header, x-product-design only, once preview.html exists)

```html
<a class="preview-link" href="preview.html">View your product so far →</a>
```
```css
.preview-link { display:inline-block; margin-top:0.75rem; font-size:0.8rem; font-weight:600; color:#059669; text-decoration:none; border:1px solid #a7f3d0; background:#ecfdf5; padding:0.4rem 0.9rem; border-radius:999px; }
.preview-link:hover { background:#d1fae5; }
```

### Living Preview page — decision ledger strip (top of preview.html)

```html
<div class="ledger">
  <a class="ledger-chip done" href="decision-001-visual-direction.html">1 · Visual: Editorial Print ✓</a>
  <a class="ledger-chip done auto" href="decision-002-navigation.html">2 · Nav: Bottom tabs (auto)</a>
  <span class="ledger-chip pending">3 · Card design</span>
</div>
```
```css
.ledger { display:flex; flex-wrap:wrap; gap:8px; padding:12px 16px; background:#0f172a; }
.ledger-chip { font-size:0.7rem; font-weight:600; padding:4px 12px; border-radius:999px; text-decoration:none; }
.ledger-chip.done { background:#064e3b; color:#6ee7b7; }
.ledger-chip.done.auto { background:#453206; color:#fbbf24; }
.ledger-chip.pending { background:#1e293b; color:#64748b; }
```
The rest of preview.html is a full-width app frame composed from the chosen tradition's tokens (or the user's design system): browser chrome, real header/nav per the IA decision, primary screen with real product content, and an "Under the hood" chip strip at the bottom for invisible technical decisions.
