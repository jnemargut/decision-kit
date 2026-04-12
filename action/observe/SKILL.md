# Observe

You analyze any artifact — conversation transcripts, strategy docs, proposals, PRFAQs, planning notes, meeting recordings, Slack threads — and extract everything meaningful hiding in it: observations (objective and subjective), assumptions, and tensions. This is an **action skill** — it reads the input, runs a structured extraction process, and produces a visual analysis page plus structured data.

The user's input is: **$ARGUMENTS**

---

## Input Detection

Determine what the user gave you:

1. **File path** — If `$ARGUMENTS` looks like a file path (contains `/`, `.md`, `.txt`, `.doc`, etc.), read the file using the Read tool.
2. **Pasted text** — If `$ARGUMENTS` is a long block of text (more than a couple sentences), treat it as the artifact to analyze.
3. **Short description** — If `$ARGUMENTS` is a short phrase like "our product strategy" or "the sprint retro notes", ask the user to paste the content or provide a file path.
4. **Empty** — If `$ARGUMENTS` is empty or blank, ask:

> "What should I analyze? You can:
> - **Paste** a transcript, strategy doc, proposal, or any artifact right here
> - **Give me a file path** like `notes/meeting-2026-04-02.md`
>
> What are we working with?"

Wait for the user's response before proceeding.

---

## The Extraction Process

Once you have the artifact text, follow this exact process:

### Step 1: Identify Themes

Read the full artifact. Identify 2–5 high-level themes present in the content. These should be specific to THIS artifact, not a generic list.

Examples of good themes: "user willingness to pay", "technical scalability under load", "team capacity for Q3", "regulatory approval timeline"

Examples of bad themes: "business", "technology", "people" (too generic)

### Step 2: Derive Types

Based on the themes, create tailored type categories for each extraction type.

**Observation Types** (3–5 types):
- **Stated Fact** — Verifiable claims or data points mentioned in the artifact
- **Behavioral Observation** — Actions, reactions, or behaviors described or implied
- **Contextual Detail** — Background information, constraints, or environmental factors mentioned
- **Sentiment Signal** — Emotional tone, enthusiasm, hesitation, or discomfort expressed

**Assumption Types** (5–8 types):
- **User Behavior Assumption** — Beliefs about how users will act, adopt, or respond
- **Market Timing Assumption** — Beliefs about when the market will be ready
- **Technical Feasibility Assumption** — Beliefs about what can be built and how fast
- **Revenue Assumption** — Beliefs about willingness to pay, pricing, conversion rates

Tailor these to the specific artifact — the examples above are starting points, not fixed categories.

### Step 3: Extract Observations

Go through the artifact carefully. For each observation, capture:

1. **Quote** — The exact excerpt from the artifact
2. **Observation** — What was observed, clearly stated
3. **Objectivity** — Is this objective (verifiable fact) or subjective (interpretation, impression, tone)?
4. **Type** — Which observation type from Step 2

**Rules:**
- Objective observations are verifiable facts: "3 competitors were mentioned by name", "The meeting lasted 45 minutes", "Revenue was reported as $2M"
- Subjective observations are interpretations: "The team seemed hesitant about the timeline", "There was notable enthusiasm for the API approach", "The CEO appeared to defer to the CTO on technical decisions"
- Ground everything in the text — don't observe things that aren't there
- Focus on observations that matter for downstream analysis — skip trivial ones

### Step 4: Extract Assumptions

Go through the artifact carefully. For each assumption, capture:

1. **Quote** — The exact excerpt from the artifact (keep it short, just the relevant part)
2. **Assumption** — The underlying belief, clearly stated
3. **Type** — Which assumption type from Step 2
4. **Why it's an assumption** — What is uncertain or unverified about this
5. **Risk level** — Low, Medium, or High based on:
   - How critical is this to the overall plan?
   - How uncertain is this?
   - What's the blast radius if it's wrong?
6. **Validation suggestion** — One concrete way to test or validate this assumption

**Rules:**
- Do NOT infer assumptions that aren't grounded in the text
- Focus on meaningful assumptions, not trivial ones
- Prefer fewer, high-quality assumptions over many weak ones
- Be precise and avoid vague language
- An assumption is something stated as fact that could be wrong — not every statement is an assumption

### Step 5: Extract Tensions

Look for places where the artifact contradicts itself or holds competing priorities. For each tension, capture:

1. **Tension** — What's in conflict, clearly stated
2. **Sides** — The two (or more) competing positions, each described in one sentence
3. **Related IDs** — References to specific observations or assumptions that are part of this tension (use their prefixed IDs)

**Rules:**
- A tension is NOT just two different topics — it's two things that genuinely pull in different directions
- "Speed to market was emphasized, but so was quality" is a tension
- "We discussed pricing AND discussed marketing" is NOT a tension — they're just two topics
- Tensions are gold for downstream skills like /challenge and /core-principles
- Fewer, real tensions are better than many manufactured ones

### Step 6: Map Assumptions

Place each assumption on a 2×2 grid:
- **Y-axis:** Importance (how critical to the plan)
- **X-axis:** Uncertainty (how much we don't know)

This creates four quadrants:
- **Test First** (high importance, high uncertainty) — These are dangerous. Validate before building.
- **Monitor** (high importance, low uncertainty) — Important but you're probably right. Keep an eye on them.
- **Research** (low importance, high uncertainty) — Uncertain but won't kill you. Investigate when you have time.
- **Park** (low importance, low uncertainty) — Safe to ignore for now.

### Step 7: Write the Plain-Language Summary

Write a 3–5 sentence summary in plain English that captures the overall landscape. This should read like something you'd say out loud to a colleague:

- How many observations, assumptions, and tensions were found
- What the dominant themes are
- Which assumptions are most dangerous and why
- Any notable tensions worth addressing
- The one thing they should validate first

Example: "I found 6 observations, 8 assumptions, and 2 tensions in this strategy doc. The biggest cluster of assumptions is around user behavior — there are 3 high-risk assumptions about adoption without training. There's a real tension between the push for speed-to-market and the emphasis on trust-building, which are pulling the product in different directions. I'd validate the assumption about users sharing expensive tools with strangers first — that's the one that could sink the whole model."

---

## Output

Generate TWO artifacts plus speak the summary.

### 1. HTML Page

Save as `.decisions/observe-[slug].html` where `[slug]` is derived from the artifact name or content (e.g., `observe-sprint-retro.html`, `observe-product-strategy.html`).

The HTML page must include:

**Header:**
- Title: "Observation Analysis"
- Subtitle: the artifact name or source
- Date

**Plain-Language Summary:**
- The 3–5 sentence summary from Step 7, displayed prominently at the top in a callout/banner style

**Counts Bar:**
- Show counts inline: "X observations · Y assumptions · Z tensions"
- Color-coded: blue for observations, red for assumptions, purple for tensions

**Assumption Map (2×2 Grid):**
- Visual grid with four quadrants: Test First, Monitor, Research, Park
- Each assumption appears as a small labeled dot or card in its quadrant
- Color-coded: red (Test First), amber (Monitor), blue (Research), gray (Park)
- **This is the visual centerpiece — it should be prominent and immediately visible**

**Tension Strip:**
- Compact cards below the map showing each tension as "X vs Y"
- Purple accent color
- Each card shows the two sides briefly

**Tabbed Detail Section:**
- Three tabs: Observations (count), Assumptions (count), Tensions (count)
- Default to the Observations tab
- Use inline JavaScript for tab switching (simple `onclick` handlers)

**Observations Tab:**
- Cards for each observation
- Blue dot for objective, amber dot for subjective
- Shows: quote, observation statement, objectivity badge, type badge

**Assumptions Tab:**
- Cards for each assumption, ordered by risk level (High first)
- Each card shows: quote, assumption statement, type badge, risk badge, why it's an assumption, validation suggestion
- Cards are color-coded by quadrant placement

**Tensions Tab:**
- Cards for each tension
- Purple accent
- Shows: tension statement, the two sides, related observation/assumption IDs

**Use the same dark theme as all other skills in this repo:**
- Background: `#0f1117`
- Surface: `#1a1d27`
- Border: `#2d3140`
- Text: `#e2e4e9`
- Accent: `#7c6ef0`
- Observation color: `#3b82f6` (blue)
- Assumption color: `#ef4444` (red)
- Tension color: `#a855f7` (purple)
- Self-contained HTML with inline CSS and inline JavaScript, no external dependencies

Open the HTML page:
```bash
open .decisions/observe-[slug].html
```

### 2. JSON File

Save as `.decisions/observe-[slug].json` alongside the HTML.

Schema:
```json
{
  "source": "Name or path of the analyzed artifact",
  "analyzedAt": "ISO timestamp",
  "summary": "The plain-language summary from Step 7",
  "themes": [
    "Theme 1",
    "Theme 2"
  ],
  "observationTypes": [
    {
      "name": "Stated Fact",
      "definition": "Verifiable claims or data points mentioned in the artifact"
    }
  ],
  "assumptionTypes": [
    {
      "name": "User Behavior Assumption",
      "definition": "Beliefs about how users will act, adopt, or respond"
    }
  ],
  "observations": [
    {
      "id": "OBS-001",
      "quote": "Exact excerpt from the artifact",
      "observation": "What was observed, clearly stated",
      "objectivity": "objective",
      "type": "Stated Fact"
    }
  ],
  "assumptions": [
    {
      "id": "ASM-001",
      "quote": "Exact excerpt from the artifact",
      "assumption": "The underlying belief, clearly stated",
      "type": "User Behavior Assumption",
      "whyItsAnAssumption": "What is uncertain or unverified",
      "risk": "high",
      "quadrant": "test-first",
      "validation": "One concrete way to test this"
    }
  ],
  "tensions": [
    {
      "id": "TEN-001",
      "tension": "What's in conflict, clearly stated",
      "sides": ["Side A description", "Side B description"],
      "relatedIds": ["ASM-001", "OBS-003"]
    }
  ],
  "quadrantCounts": {
    "testFirst": 0,
    "monitor": 0,
    "research": 0,
    "park": 0
  }
}
```

### 3. Speak the Summary

After generating both files, say the plain-language summary conversationally to the user. Don't just paste the summary — introduce it naturally:

> "Here's what I found:
>
> [The plain-language summary from Step 7]
>
> The full analysis is at `.decisions/observe-[slug].html` — it has the assumption map, observation cards, and tension strips."

---

## Important Reminders

1. **Any artifact, not just transcripts.** Strategy docs, proposals, PRFAQs, meeting notes, Slack threads, product specs — anything where someone is stating beliefs, making observations, or holding competing priorities.
2. **Quality over quantity.** 5 solid observations and 5 solid assumptions are better than 15 weak ones of each. If something is trivial or obvious, skip it.
3. **Ground everything in the text.** Every extraction must trace back to a specific quote. Don't infer things the author didn't say or imply.
4. **The summary is key.** Both artifacts include it. The AI speaks it. Three places, same words. This is what people remember.
5. **Risk levels must be justified.** High risk = critical to the plan AND uncertain. Don't mark everything as high risk.
6. **The 2×2 map is the visual centerpiece.** It should be the first thing someone sees after the summary. The whole point is to show which assumptions need attention NOW.
7. **Tensions are gold.** They surface where the real decisions are hiding. Don't manufacture tensions, but don't miss real ones either.
8. **Open the HTML automatically.** Always `open .decisions/observe-[slug].html`.
9. **Prefixed IDs are required.** Use OBS-001, ASM-001, TEN-001 format. Tensions should reference related IDs when applicable.
