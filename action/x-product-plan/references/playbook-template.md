## PLAYBOOK HTML TEMPLATE

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Launch Playbook — [Project Name]</title>
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

    .container { max-width: 960px; margin: 0 auto; }

    /* === HEADER === */
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

    .subtitle {
      font-size: 1rem;
      color: #475569;
      margin-top: 0.5rem;
    }

    .playbook-meta {
      display: flex;
      justify-content: center;
      gap: 1.5rem;
      margin-top: 1rem;
      flex-wrap: wrap;
    }

    .meta-item {
      font-size: 0.8rem;
      color: #64748b;
      display: flex;
      align-items: center;
      gap: 4px;
    }

    .meta-value {
      font-weight: 700;
      color: #0f172a;
    }

    /* === RESEARCH PANEL === */
    .research-panel {
      background: white;
      border-radius: 16px;
      padding: 1.5rem;
      margin-bottom: 2rem;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08), 0 4px 16px rgba(0,0,0,0.04);
      border: 1px solid #e2e8f0;
      border-left: 4px solid #6366f1;
    }

    .research-panel h2 {
      font-size: 0.8rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      color: #6366f1;
      margin-bottom: 1rem;
    }

    .research-insights {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 0.75rem;
    }

    .insight {
      padding: 0.75rem;
      background: #f8fafc;
      border-radius: 10px;
      font-size: 0.8rem;
      color: #334155;
      line-height: 1.5;
    }

    .insight strong {
      color: #0f172a;
      display: block;
      margin-bottom: 2px;
    }

    .insight-source {
      font-size: 0.65rem;
      color: #94a3b8;
      font-style: italic;
      margin-top: 4px;
    }

    /* === PROGRESS === */
    .progress-section { margin-bottom: 2rem; }

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

    /* === EFFORT LEGEND === */
    .legend {
      display: flex;
      gap: 1.5rem;
      margin-bottom: 2rem;
      justify-content: center;
      flex-wrap: wrap;
    }

    .legend-item {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 0.75rem;
      color: #475569;
    }

    .legend-tag {
      padding: 2px 8px;
      border-radius: 6px;
      font-size: 0.65rem;
      font-weight: 700;
    }

    .tag-human { background: #fef2f2; color: #dc2626; }
    .tag-ai-assisted { background: #ede9fe; color: #6d28d9; }
    .tag-automatable { background: #ecfdf5; color: #047857; }

    /* === PHASE === */
    .phase {
      margin-bottom: 2.5rem;
    }

    .phase-header {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      margin-bottom: 1rem;
      padding-bottom: 0.75rem;
      border-bottom: 2px solid #e2e8f0;
    }

    .phase-number {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: #6366f1;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.8rem;
      font-weight: 700;
      flex-shrink: 0;
    }

    .phase-title {
      font-size: 1.15rem;
      font-weight: 700;
      color: #0f172a;
    }

    .phase-subtitle {
      font-size: 0.8rem;
      color: #64748b;
      margin-left: auto;
    }

    /* === PHASE OVERVIEW === */
    .phase-overview {
      background: white;
      border-radius: 12px;
      padding: 1.25rem;
      margin-bottom: 1.25rem;
      border: 1px solid #e2e8f0;
      border-left: 4px solid #6366f1;
    }

    .phase-overview p {
      font-size: 0.85rem;
      color: #334155;
      line-height: 1.6;
      margin-bottom: 0.75rem;
    }

    .phase-overview p:last-child {
      margin-bottom: 0;
    }

    .phase-overview-label {
      font-size: 0.65rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      margin-bottom: 2px;
    }

    .phase-overview-label.why { color: #6366f1; }
    .phase-overview-label.success { color: #059669; }

    /* === PRODUCT AT THIS PHASE === */
    .product-phase {
      background: #fffbeb;
      border: 1px solid #fde68a;
      border-radius: 12px;
      padding: 1.25rem;
      margin-bottom: 1.25rem;
    }

    .product-phase-header {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-bottom: 0.75rem;
    }

    .product-phase-icon {
      font-size: 1.1rem;
    }

    .product-phase-title {
      font-size: 0.75rem;
      font-weight: 700;
      letter-spacing: 0.05em;
      text-transform: uppercase;
      color: #d97706;
    }

    .product-phase-form {
      font-size: 0.9rem;
      font-weight: 600;
      color: #0f172a;
      margin-bottom: 0.75rem;
    }

    .product-capabilities {
      list-style: none;
      padding: 0;
      margin-bottom: 0.75rem;
    }

    .product-capabilities li {
      font-size: 0.8rem;
      color: #334155;
      line-height: 1.5;
      padding: 0.15rem 0;
      padding-left: 1.25rem;
      position: relative;
    }

    .product-capabilities li::before {
      content: "\2713";
      position: absolute;
      left: 0;
      color: #059669;
      font-weight: 700;
    }

    .product-capabilities li.not-yet::before {
      content: "\2717";
      color: #94a3b8;
    }

    .product-capabilities li.not-yet {
      color: #94a3b8;
    }

    .product-phase-transition {
      font-size: 0.75rem;
      color: #d97706;
      font-weight: 600;
      margin-top: 0.5rem;
      padding-top: 0.5rem;
      border-top: 1px dashed #fde68a;
    }

    /* === TASK CARD === */
    .task-card {
      background: white;
      border-radius: 12px;
      padding: 1.25rem;
      margin-bottom: 0.75rem;
      box-shadow: 0 1px 3px rgba(0,0,0,0.06);
      border: 1px solid #e2e8f0;
      transition: border-color 0.2s;
    }

    .task-card:hover {
      border-color: #cbd5e1;
    }

    .task-card.checked {
      opacity: 0.5;
      border-left: 3px solid #059669;
    }

    .task-top {
      display: flex;
      align-items: flex-start;
      gap: 0.75rem;
    }

    .task-checkbox {
      width: 20px;
      height: 20px;
      border: 2px solid #cbd5e1;
      border-radius: 4px;
      flex-shrink: 0;
      cursor: pointer;
      margin-top: 2px;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.15s;
    }

    .task-checkbox:hover {
      border-color: #059669;
    }

    .task-card.checked .task-checkbox {
      background: #059669;
      border-color: #059669;
    }

    .task-card.checked .task-checkbox::after {
      content: "\2713";
      color: white;
      font-size: 0.7rem;
      font-weight: 700;
    }

    .task-content { flex: 1; }

    .task-title-row {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      flex-wrap: wrap;
    }

    .task-title {
      font-size: 0.95rem;
      font-weight: 600;
      color: #0f172a;
    }

    .task-card.checked .task-title {
      text-decoration: line-through;
      color: #94a3b8;
    }

    .task-tags {
      display: flex;
      gap: 4px;
      flex-wrap: wrap;
    }

    .task-tag {
      padding: 2px 8px;
      border-radius: 6px;
      font-size: 0.6rem;
      font-weight: 700;
      letter-spacing: 0.03em;
    }

    .tag-critical { background: #fef2f2; color: #dc2626; }
    .tag-important { background: #fffbeb; color: #d97706; }
    .tag-nice { background: #f1f5f9; color: #64748b; }

    .tag-effort {
      background: #f1f5f9;
      color: #475569;
      font-weight: 600;
    }

    .task-why {
      font-size: 0.8rem;
      color: #64748b;
      margin-top: 0.5rem;
      line-height: 1.5;
      font-style: italic;
    }

    .task-how {
      margin-top: 0.75rem;
      padding-left: 0;
      list-style: none;
    }

    .task-how li {
      font-size: 0.8rem;
      color: #334155;
      line-height: 1.5;
      padding: 0.2rem 0;
      padding-left: 1.25rem;
      position: relative;
    }

    .task-how li::before {
      content: "\2192";
      position: absolute;
      left: 0;
      color: #6366f1;
      font-weight: 700;
    }

    /* === FOOTER === */
    .playbook-footer {
      text-align: center;
      padding: 1.5rem;
      background: white;
      border-radius: 12px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08);
      margin-top: 2rem;
    }

    .playbook-footer p {
      font-size: 0.85rem;
      color: #64748b;
      margin: 0.3rem 0;
    }

    .playbook-footer strong { color: #334155; }

    /* === RESPONSIVE === */
    @media (max-width: 768px) {
      body { padding: 1rem; }
      .research-insights { grid-template-columns: 1fr; }
      .playbook-meta { flex-direction: column; align-items: center; }
    }

    /* === ELEVATOR PITCH === */
    .elevator-pitch {
      background: white;
      border-radius: 16px;
      padding: 2rem;
      margin-bottom: 2rem;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08), 0 4px 16px rgba(0,0,0,0.04);
      border: 1px solid #e2e8f0;
      text-align: center;
    }

    .elevator-pitch-label {
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: #64748b;
      margin-bottom: 1rem;
    }

    .elevator-pitch-text {
      font-size: 1.15rem;
      font-weight: 500;
      color: #0f172a;
      line-height: 1.7;
      max-width: 700px;
      margin: 0 auto;
    }

    .elevator-pitch-source {
      font-size: 0.75rem;
      color: #94a3b8;
      margin-top: 1rem;
    }

    /* === INTERACTIVE CHECKBOX === */
    /* JavaScript handles toggling .checked class on task-card when checkbox is clicked */
  </style>
</head>
<body>
  <div class="container">
    <header>
      <h1>Launch Playbook</h1>
      <p class="subtitle">[Project Name] — Your complete launch roadmap</p>
      <div class="playbook-meta">
        <div class="meta-item">Phases: <span class="meta-value">[N]</span></div>
        <div class="meta-item">Tasks: <span class="meta-value">[N]</span></div>
        <div class="meta-item">Human tasks: <span class="meta-value">[N]</span></div>
        <div class="meta-item">AI-assisted: <span class="meta-value">[N]</span></div>
        <div class="meta-item">Automatable: <span class="meta-value">[N]</span></div>
      </div>
    </header>

    <!-- ELEVATOR PITCH — pulled from product-strategy's final decision, or generated from strategy brief / user description -->
    <section class="elevator-pitch">
      <div class="elevator-pitch-label">Elevator Pitch</div>
      <div class="elevator-pitch-text">[The 2-3 sentence elevator pitch. If the strategy brief has an "Elevator Pitch" section, use that verbatim. Otherwise, synthesize one from the product description, target user, and value proposition.]</div>
      <div class="elevator-pitch-source">From Product Strategy &mdash; Decision [N]</div>
    </section>

    <!-- RESEARCH PANEL -->
    <section class="research-panel">
      <h2>Launch Research — How Similar Products Did It</h2>
      <div class="research-insights">
        <div class="insight">
          <strong>[Company] — [What they did]</strong>
          [1-2 sentences about their specific launch tactic and what happened]
          <div class="insight-source">[Source]</div>
        </div>
        <!-- Repeat for 3-6 insights -->
      </div>
    </section>

    <!-- PROGRESS -->
    <div class="progress-section">
      <div class="progress-label">
        <span>0 of [N] tasks completed</span>
        <span>0%</span>
      </div>
      <div class="progress-bar">
        <div class="progress-fill" style="width: 0%"></div>
      </div>
    </div>

    <!-- LEGEND -->
    <div class="legend">
      <div class="legend-item"><span class="legend-tag tag-human">HUMAN</span> Requires a real person</div>
      <div class="legend-item"><span class="legend-tag tag-ai-assisted">AI-ASSISTED</span> Person + AI together</div>
      <div class="legend-item"><span class="legend-tag tag-automatable">AUTOMATABLE</span> AI or software can handle</div>
    </div>

    <!-- PHASES -->
    <section class="phase">
      <div class="phase-header">
        <div class="phase-number">1</div>
        <div class="phase-title">[Phase Name]</div>
        <div class="phase-subtitle">[N] tasks · [timeframe]</div>
      </div>

      <!-- PHASE OVERVIEW — brief description of what you're trying to accomplish -->
      <div class="phase-overview">
        <p>[2-3 sentences describing what this phase is about, what you're trying to accomplish, and why it matters at this stage. Write like you're explaining it to a friend. Be specific to the product.]</p>
        <div class="phase-overview-label why">Why this matters</div>
        <p>[1-2 sentences on why this phase is critical — what fails if you skip it, grounded in research or real examples.]</p>
        <div class="phase-overview-label success">Success looks like</div>
        <p>[1-2 sentences describing the concrete, measurable outcome that means this phase is done. Specific numbers when possible.]</p>
      </div>

      <!-- PRODUCT AT THIS PHASE — include one per phase -->
      <div class="product-phase">
        <div class="product-phase-header">
          <span class="product-phase-icon">&#128241;</span>
          <span class="product-phase-title">Product at This Phase</span>
        </div>
        <div class="product-phase-form">[What form the product takes — e.g. "A landing page + Google Form" or "Basic mobile app with core borrow flow"]</div>
        <ul class="product-capabilities">
          <li>[Capability users need now — e.g. "Browse tools nearby with photos"]</li>
          <li>[Another capability — e.g. "Request to borrow with one tap"]</li>
          <li>[Another capability — e.g. "In-app messaging between neighbors"]</li>
          <li class="not-yet">[Feature NOT needed yet — e.g. "Automated matching and recommendations"]</li>
          <li class="not-yet">[Another not-yet — e.g. "Push notifications for new tools nearby"]</li>
        </ul>
        <div class="product-phase-transition">Level up when: [trigger — e.g. "You hit 10 borrows and manual matching becomes a bottleneck"]</div>
      </div>

      <div class="task-card" onclick="this.classList.toggle('checked')">
        <div class="task-top">
          <div class="task-checkbox"></div>
          <div class="task-content">
            <div class="task-title-row">
              <span class="task-title">[Verb-first task title]</span>
              <div class="task-tags">
                <span class="task-tag tag-human">HUMAN</span>
                <span class="task-tag tag-critical">CRITICAL</span>
                <span class="task-tag tag-effort">~2 days</span>
              </div>
            </div>
            <p class="task-why">[Why this matters — grounded in research. "Uber did X because Y. For us, this means Z."]</p>
            <ul class="task-how">
              <li>[Specific actionable step 1]</li>
              <li>[Specific actionable step 2]</li>
              <li>[Specific actionable step 3]</li>
            </ul>
          </div>
        </div>
      </div>

      <!-- Repeat task-card for each task in this phase -->
    </section>

    <!-- Repeat phase section for each phase -->

    <div class="playbook-footer">
      <p>This playbook covers the <strong>full launch</strong> — operations, partnerships, trust-building, and how your product should evolve at each stage.</p>
      <p>For technical implementation decisions, run <strong>/product-design</strong> with your strategy brief.</p>
      <p>For strategy decisions, see your <strong>.decisions/</strong> folder from Product Strategy.</p>
    </div>
  </div>

  <script>
    // Progress tracking
    function updateProgress() {
      const total = document.querySelectorAll('.task-card').length;
      const checked = document.querySelectorAll('.task-card.checked').length;
      const pct = total > 0 ? Math.round((checked / total) * 100) : 0;
      const label = document.querySelector('.progress-label');
      const fill = document.querySelector('.progress-fill');
      if (label) label.innerHTML = '<span>' + checked + ' of ' + total + ' tasks completed</span><span>' + pct + '%</span>';
      if (fill) fill.style.width = pct + '%';
    }

    document.querySelectorAll('.task-card').forEach(card => {
      card.addEventListener('click', function() {
        this.classList.toggle('checked');
        updateProgress();
        // Save state to localStorage
        const states = {};
        document.querySelectorAll('.task-card').forEach((c, i) => {
          states[i] = c.classList.contains('checked');
        });
        localStorage.setItem('playbook-state', JSON.stringify(states));
      });
    });

    // Restore state from localStorage
    const saved = localStorage.getItem('playbook-state');
    if (saved) {
      const states = JSON.parse(saved);
      document.querySelectorAll('.task-card').forEach((card, i) => {
        if (states[i]) card.classList.add('checked');
      });
      updateProgress();
    }
  </script>
</body>
</html>
```

### Task Effort Tags — When To Use Each

**🧑 HUMAN** — Tasks that fundamentally require a person:
- Door-knocking, in-person meetings, networking events
- Negotiations (partnerships, licensing, legal agreements)
- Phone calls and relationship building
- Physical operations (setting up spaces, logistics)
- Judgment calls that require empathy or local context

**🤖 AI-ASSISTED** — Tasks where a person drives but AI significantly helps:
- Writing outreach emails, pitch decks, marketing copy
- Researching potential partners, competitors, regulations
- Creating content (blog posts, social media, help docs)
- Analyzing data, user feedback, market trends
- Drafting legal documents (then reviewed by a lawyer)

**⚡ AUTOMATABLE** — Tasks that software or AI can handle end-to-end:
- Setting up social media accounts and scheduling posts
- Creating landing pages and email capture
- Setting up analytics and tracking
- Automated email sequences and onboarding flows
- Monitoring and alerting systems

### Priority Levels

**Critical** — Must be done before launch. Blocking. If this isn't done, the product fails.
**Important** — Should be done around launch. High impact but not strictly blocking.
**Nice-to-have** — Do it when you have bandwidth. Makes things better but isn't essential.

### Task Specificity Rules

Bad: "Build trust with users"
Good: "Create a 60-second video showing a real tool borrow between two neighbors. Film it in your own neighborhood with actual tools. Post on local Facebook groups and Nextdoor."

Bad: "Get partnerships"
Good: "Email 5 realtors within 2 miles of your launch neighborhood. Pitch: 'We'll give your home buyers a free first borrow — a closing gift that makes you look thoughtful and costs you nothing.' Use the email template in the appendix."

Bad: "Set up social media"
Good: "Create an Instagram account with the handle @[project]. Post 3 photos of your own garage tools with the caption 'Your neighborhood already owns every tool you need.' Use Later.com to schedule 2 posts/week for the first month."

Every task should be specific enough that someone could start doing it immediately without asking "but how?"

---

