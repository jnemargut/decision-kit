# Investigate

You bridge the gap between "we have assumptions" and "we have evidence." You take assumptions (from `/observe` output or user-provided hypotheses), turn the riskiest ones into testable hypotheses, research each one from multiple angles, and produce insights with actionable recommendations. This is a **hybrid skill** — it automates the mechanical parts but pauses at two checkpoints for human judgment.

The user's input is: **$ARGUMENTS**

---

## Input Detection

Determine what the user gave you:

1. **Observe output exists** — Check for `.decisions/observe-*.json` files. If found, read the most recent one and use its `assumptions[]` array as input. Tell the user which file you're reading.
2. **File path** — If `$ARGUMENTS` is a file path to a JSON file, read it and look for an `assumptions[]` array.
3. **User-provided hypotheses** — If `$ARGUMENTS` contains hypotheses directly (e.g., "investigate whether users will pay for premium features"), treat these as user-provided hypotheses and skip to Checkpoint 1.
4. **Empty** — If `$ARGUMENTS` is empty, check for observe output. If none found, ask:

> "What should I investigate? You can:
> - **Run `/observe` first** to extract assumptions from an artifact, then run `/investigate`
> - **Give me hypotheses directly** like 'investigate whether enterprise customers will self-serve'
>
> What are we working with?"

Wait for the user's response before proceeding.

---

## The Pipeline

### Stage 1: Filter and Prioritize Assumptions

If reading from `/observe` output:

1. **Filter** to assumptions in the `test-first` and `monitor` quadrants — these are the ones that actually threaten the plan
2. **Rank** by risk level within those quadrants (high risk first)
3. **Select** the top 3-7 assumptions to generate hypotheses from

If the user provided hypotheses directly, skip this stage.

### Stage 2: Generate Hypotheses

For each selected assumption, generate a testable hypothesis using the standard format:

> **We believe** [specific belief from the assumption]
> **We'll know this is true when** [concrete, observable signal]

Each hypothesis gets:
- **ID**: H-001, H-002, etc.
- **Source assumption ID**: ASM-001 (from observe output) or "user-provided"
- **Priority**: rank order based on risk
- **The "We believe" statement**
- **The "We'll know" signal**

---

### ═══ CHECKPOINT 1: Review Hypotheses ═══

Generate an HTML triage page at `.decisions/investigate-hypotheses.html` and open it.

**Page layout:**
- Header: "Hypothesis Review" with count
- Summary: "Generated X hypotheses from your top-risk assumptions. Review, edit, add, or remove before I research them."
- Hypothesis cards, each showing:
  - Priority number and hypothesis ID
  - The source assumption (quoted from observe output)
  - "We believe..." statement
  - "We'll know..." signal
  - Risk badge from the source assumption

**Open the page:**
```bash
open .decisions/investigate-hypotheses.html
```

**Present to the user and STOP:**

> "I've generated [X] hypotheses from your top-risk assumptions. Here they are — review the page and tell me:
> - **'looks good'** — approve all and start researching
> - **'drop 3'** — remove hypothesis #3
> - **'edit 2 to focus on pricing'** — reword hypothesis #2
> - **'add: we believe X will Y'** — add a new hypothesis
> - **'move 4 to top'** — reprioritize
>
> You can combine these: 'drop 3, edit 2 to focus on enterprise, add one about API adoption'"

**Wait for the user's response.** Apply their changes, then proceed.

---

### Stage 3: Research Evidence (Multi-Query Triangulation)

For each approved hypothesis, run 2-3 web searches from different angles:

1. **General/market search** — Look for market data, industry reports, benchmarks
   - Query pattern: "[topic] market data statistics [year]" or "[topic] industry benchmark report"

2. **Community/practitioner search** — Look for real-world experience from practitioners
   - Query pattern: "[topic] reddit experience" or "[topic] forum discussion lessons learned"

3. **Expert/industry search** — Look for expert opinions and analysis
   - Query pattern: "[topic] expert analysis" or "[topic] thought leader opinion [industry]"

For each hypothesis, synthesize:
- **What the sources agree on**
- **Where sources disagree**
- **Key data points or quotes**
- **Source URLs for citation**

### Stage 4: Synthesize Insights (What / So What / Now What)

For each researched hypothesis, produce an insight using the three-layer framework:

- **What** (Evidence): What did the research find? Synthesize across all search angles.
- **So What** (Insight): Why does this matter? What does it mean for the plan?
- **Now What** (Recommendation): What should be done about it? Concrete, actionable.

Plus:
- **Verdict**: `supported` (evidence confirms the hypothesis), `mixed` (some evidence for, some against), or `refuted` (evidence contradicts the hypothesis)
- **Lineage**: insight ID → hypothesis ID → assumption ID (full chain back to the original observation)
- **Sources**: URLs from the research

### Stage 5: Generate Recommendations

Review all insights together and identify:
- **Patterns** across insights (multiple insights pointing the same direction)
- **Highest-priority actions** based on verdict and risk level
- **Contradictions** between insights that need resolution

---

### ═══ CHECKPOINT 2: Validate Insights ═══

Generate an HTML insights page at `.decisions/investigate-insights.html` and open it.

**Page layout (dark theme, same as all skills):**
- Header: "Investigation Results" with counts
- Summary callout with the overall narrative (2-3 sentences)
- Verdict distribution bar: X supported, Y mixed, Z refuted
- Insight cards, each showing:
  - Insight ID and verdict badge (green=supported, amber=mixed, red=refuted)
  - **What**: evidence summary with source tags
  - **So What**: the insight
  - **Now What**: the recommendation
  - Lineage trail: I-001 ← H-001 ← ASM-003
- Recommendations section at the bottom

**Use the same dark theme:**
- Background: `#0f1117`
- Surface: `#1a1d27`
- Border: `#2d3140`
- Text: `#e2e4e9`
- Accent: `#7c6ef0`
- Supported: `#10b981` (green)
- Mixed: `#f59e0b` (amber)
- Refuted: `#ef4444` (red)

**Open the page:**
```bash
open .decisions/investigate-insights.html
```

**Present to the user and STOP:**

> "Here's what I found — [X] insights from researching your hypotheses. [Brief narrative: e.g., '3 were supported, 1 was mixed, and 1 was refuted.']
>
> Review the page and tell me:
> - **'looks good'** — approve all, save to .decisions/
> - **'drop 2'** — remove insight #2
> - **'edit 3 recommendation'** — modify the recommendation for insight #3
> - **'add insight about X'** — add a custom insight
>
> Once approved, these insights will be available for downstream skills like /strategize and /shape."

**Wait for the user's response.** Apply their changes, then proceed to output.

---

## Output

After Checkpoint 2 approval, save the final output.

### 1. JSON File

Save as `.decisions/investigate-[slug].json`:

```json
{
  "source": "investigate",
  "analyzedAt": "ISO timestamp",
  "entryMode": "observe | hypotheses",
  "observeSource": "observe-[slug].json (if applicable)",
  "summary": "Overall narrative summary",
  "hypotheses": [
    {
      "id": "H-001",
      "sourceAssumptionId": "ASM-003",
      "belief": "We believe enterprise customers will integrate via API",
      "signal": "We'll know when API adoption exceeds 60% in the first enterprise cohort",
      "status": "approved",
      "priority": 1
    }
  ],
  "insights": [
    {
      "id": "I-001",
      "hypothesisId": "H-001",
      "assumptionId": "ASM-003",
      "what": "Industry reports show 45-65% enterprise API adoption. Reddit devs cite docs as #1 driver. Analyst says API-first is table stakes.",
      "soWhat": "Enterprise API adoption is viable but docs-dependent. Without strong documentation, adoption will stall at the lower end.",
      "nowWhat": "Invest in API documentation and developer onboarding before enterprise launch. Consider a developer relations hire.",
      "verdict": "supported",
      "sources": ["https://example.com/report", "https://reddit.com/r/..."],
      "status": "approved"
    }
  ],
  "recommendations": [
    "Prioritize API documentation before enterprise launch",
    "Validate pricing assumptions with 10 user interviews",
    "Resolve the speed-vs-quality tension before committing to Q3 timeline"
  ]
}
```

### 2. Final HTML Page

The Checkpoint 2 HTML page (`.decisions/investigate-insights.html`) serves as the final output. Update it to reflect any changes from the checkpoint review.

### 3. Speak the Summary

> "Investigation complete. Here's the bottom line:
>
> [Overall narrative — which hypotheses were supported, which weren't, and what to do about it]
>
> The full results are at `.decisions/investigate-insights.html` with detailed evidence and recommendations for each insight."

---

## Important Reminders

1. **Two checkpoints, no more.** Human judgment matters at hypothesis review and insight validation. Everything else is automated.
2. **Excavate-style triage at checkpoints.** Let the user batch-command: "drop 3, edit 2, add one about pricing." Natural language, not forms.
3. **Always research from 3 angles.** General market data, community practitioners, and industry experts. Cross-reference where they agree and disagree.
4. **Verdict is a judgment, not a score.** Supported/mixed/refuted is honest about what the evidence shows. Don't force a verdict — "mixed" is a valid and useful answer.
5. **Full lineage chain.** Every insight traces back through its hypothesis to the original assumption. This is what makes the ecosystem composable.
6. **"We believe / We'll know" format is mandatory.** It's the industry standard and makes hypotheses testable.
7. **Quality over quantity.** 3 deeply researched insights are better than 7 shallow ones.
8. **Open HTML pages automatically.** Always `open .decisions/investigate-*.html`.
9. **Prefixed IDs.** H-001 for hypotheses, I-001 for insights. Cross-reference with ASM-001 from observe output.
