# Decision Driven Development - Thinking Skill Specification

A thinking skill is the decision-making layer in Decision Driven Development. It stops to ask for human judgment, presents visual options, and stores every decision as a persistent, browsable artifact that downstream skills build on.

The decision is the gate. Nothing executes until you've decided.

---

## The Three Rules

A thinking skill **MUST**:

### 1. Show Decisions

Present decisions as self-contained visual HTML pages with options, a comparison table, and a recommendation. Then **wait for the human to choose.** Never proceed autonomously past a decision point. Never skip the decision page, even for simple or obvious requests - if someone called the skill, they want the full visual treatment.

Each decision page includes:
- A clear description of what's being decided and why it matters
- Multiple options (recommended: 4) with visual previews, plain English summaries, and pros/cons
- A comparison table showing how options stack up across relevant dimensions
- A recommendation with reasoning
- Instructions for the human to respond

### 2. Make Decisions

The human chooses. The AI recommends, but the human's judgment is the point. Never skip a decision point or choose on the human's behalf.

The human can:
- **Pick an option:** "Option B"
- **Pick with reasoning:** "Option B because they're the ones paying" - store the reasoning alongside the choice
- **Tweak an option:** "Option B but with X" - regenerate with the modification
- **Bring their own answer:** "Actually I want to do X" - generate a full visual card for their answer with the same treatment as any AI option
- **Ask for more:** "More options" - add 4 more to the page

Custom answers are first-class. When the human brings their own answer, it gets the same visual card, pros/cons, and comparison treatment as any AI-generated option.

### 3. Remember Decisions

Store every decision in a `.decisions/` directory using this convention:

| File | Purpose |
|------|---------|
| `decisions.json` | Machine-readable state: all decisions, options, choices, status |
| `decision-NNN-slug.html` | Visual decision page for each decision (self-contained HTML) |
| `index.html` | Landing page showing all decisions and their status |
| `strategy-brief.md` or `implementation-plan.md` | Summary brief of all choices made |

Decisions must be **persistent** (survive across sessions), **browsable** (open any HTML file in a browser), and **contextual** (downstream skills can read and build on them).

Because decisions are remembered, thinking skills compose naturally:

- Check for `strategy-brief.md` and `decisions.json` from upstream thinking skills
- **Do not re-ask questions already answered** by prior skills
- Reference upstream decisions naturally in your options and recommendations
- Write your own decisions in the same format so downstream skills can build on yours

Any thinking skill following this convention composes with any other thinking skill. Strategy feeds design. Strategy stacks on strategy.

---

## Recommended Conventions (SHOULD)

A thinking skill **SHOULD**:

- **Gather context** before presenting each decision to frame better options
- **Present exactly 4 options** per decision (users can request more)
- **Include a comparison table** with 5-8 dimensions relevant to the decision
- **Include a recommendation** with clear reasoning
- **Use visual previews** that help the human see the difference (rendered UI, flow diagrams, positioning maps, architecture diagrams)
- **Generate a summary brief** after all decisions are resolved
- **Capture reasoning when volunteered.** If the user says "Option B because they're the ones paying," store the reasoning alongside the choice. Don't ask for it if they didn't offer it.
- **Never skip the decision page.** Even for simple requests. If someone called the skill, they want the full treatment.

These conventions make thinking skills excellent. But the three rules - show, make, remember - are what make them thinking skills.

---

## The Litmus Test

To determine if a skill is a thinking skill, ask:

1. Does it **show** visual decision pages with options? **Yes/No**
2. Does it wait for the human to **make** the decision? **Yes/No**
3. Does it **remember** every decision in `.decisions/` so downstream skills can build on them? **Yes/No**

All three **Yes** = thinking skill. Any **No** = not a thinking skill (but may still be a useful action skill).

---

## Decision Journal Mode

Decision Journal mode is a variation of thinking skills for when the **human leads and AI sharpens.** Regular thinking skills are for greenfield - AI surfaces decisions, presents options, and the human picks. Decision Journal mode is for brownfield - when the idea is more mature and the human already knows things.

### How it differs:

| | Thinking Skills | Decision Journal |
|---|---|---|
| Who leads | AI surfaces decisions | Human brings decisions |
| When to use | Greenfield, exploration | Brownfield, firming up |
| AI's role | Present options, recommend | Visualize, record, gently challenge |
| Pushback | None | One question on changes |
| History | Current choice only | Full changelog with reasoning |

### Key behaviors:

- **Always-visual:** Every decision gets a full HTML page, even "obvious" ones. Never skip.
- **Reasoning field:** Optional "why" on every decision. Ask once, accept null.
- **History tracking:** When decisions change, old values go to a `history` array. Never deleted.
- **Gentle reflection:** When a decision changes, AI asks one question referencing the prior reasoning. Human can skip.
- **Custom answers:** When the human brings their own answer, it gets the same visual treatment as AI-generated options.
- **Greenfield evolution:** Decisions from earlier thinking skills evolve into journal entries when touched. Untouched decisions stay as-is.

### Decision maturity signal:

- **No reasoning, no history** = greenfield sketch, not yet revisited
- **Has reasoning, no history** = firmed up, deliberately confirmed
- **Has reasoning AND history** = evolved, changed with a trail of why

### New fields (backward compatible):

- `reasoning` (string, nullable) - Why this decision was made
- `history` (array) - Previous values with dates and optional reasoning

These fields are optional. Existing thinking skills can write them when reasoning is volunteered. They don't break if absent.

---

## Configuration Skills

A **configuration skill** captures user preferences that shape how thinking skills behave. Configuration skills are a special case of thinking skills — they may walk through decisions or conduct lightweight interviews, and they store their output in `.decisions/` so other skills can read it.

### Current configuration skills:

| Skill | Output | What it shapes |
|-------|--------|----------------|
| `/research-sources` | `.decisions/sources.json` | Where thinking skills get their research (trusted voices, source types, allowlist/blocklist, recency) |
| `/whoiam` | `.decisions/profile.json` | How thinking skills frame their output (language level, analogies, comparison dimensions) |

### File Format: profile.json

```json
{
  "configuredAt": "ISO timestamp",
  "role": "teacher",
  "domainFamiliarity": "new_to_this",
  "domain": "investing / retirement planning",
  "rawInput": "I'm a teacher looking into investing for retirement"
}
```

`domainFamiliarity` values: `new_to_this` | `some_basics` | `deep_expertise`

### How thinking skills read profile.json

When any thinking skill starts, it should:

1. **Check** if `.decisions/profile.json` exists
2. **If found, adapt framing in three ways:**
   - **Language:** Adjust jargon level based on `domainFamiliarity`. For `new_to_this`, replace jargon with plain English + parenthetical glossary. For `deep_expertise`, use domain language naturally.
   - **Analogies:** Draw analogies from the user's `role` to explain unfamiliar concepts. Use as entry points, not replacements for accuracy. Skip if forced.
   - **Comparison dimensions:** Shift table dimensions to match how the user naturally evaluates things (e.g., "how much effort from you" instead of "monitoring frequency" for a non-medical user).
3. **If not found,** proceed with default framing.

---

## Action Skills

An **action skill** reads thinking skill output and produces actionable results - task lists, roadmaps, operational plans, briefs, sanity checks. Action skills don't present decision points or wait for human judgment. They execute on decisions already made.

Action skills:
- Read `.decisions/strategy-brief.md` and `decisions.json`
- Generate structured output (markdown plans, task lists, HTML artifacts, etc.)
- Complement thinking skills but don't follow this spec

The decision is the gate between thinking and doing. Action skills only run after decisions are made.

---

## Orchestrator Skills

An **orchestrator skill** is a routing layer that classifies user input and dispatches it to the right thinking or action skill. It doesn't present decisions, generate artifacts, or execute on prior decisions. It reads intent and routes.

Orchestrator skills:
- Classify user input against a catalog of skill profiles
- Route with confidence: fast-path when clear, disambiguate when ambiguous
- Invoke the target skill directly, preserving the user's original input
- Optionally enrich the input with routing context when disambiguation happened

An orchestrator skill follows none of the three thinking skill rules (show, make, remember). It's a third category — the entry point that makes the rest accessible without a user manual.

### The `/decide` orchestrator

The default orchestrator uses structured skill profiles with "Does / Signals / Not this if / Examples" fields. It determines confidence based on how clearly the input maps to a single skill:

- **High confidence:** Routes immediately with a brief note ("This sounds like a product idea → routing to /product-strategy")
- **Low confidence:** Presents 2-3 plain-English interpretations of what the user might mean, lets them pick, then routes with enriched context

The user picks the *interpretation*, not the tool. Skill names are revealed only after the choice is made.

---

## File Format: decisions.json

```json
{
  "projectName": "Project Name",
  "projectDescription": "One-sentence description",
  "createdAt": "ISO timestamp",
  "decisions": [
    {
      "id": "decision-001",
      "slug": "decision-slug",
      "title": "Human Readable Title",
      "status": "pending | chosen",
      "chosenOption": "B",
      "chosenTitle": "Option Name",
      "reasoning": "Why this was chosen (nullable - not always provided)",
      "options": ["A", "B", "C", "D"],
      "recommended": "B",
      "htmlFile": "decision-001-slug.html",
      "decidedAt": "ISO timestamp",
      "summary": "One sentence about this decision",
      "history": [
        {
          "was": "Previous Choice",
          "wasReasoning": "Why it was chosen originally (nullable)",
          "changedTo": "Current Choice",
          "changeReasoning": "Why it changed (nullable)",
          "date": "ISO timestamp"
        }
      ]
    }
  ]
}
```

Note: `chosenOption` can be `"custom"` when the human brings their own answer instead of picking from AI-generated options.

## File Format: strategy-brief.md

```markdown
# Strategy Brief: [Project Name]

## Elevator Pitch
[The chosen summary]

## Decisions Made
| # | Decision | Choice |
|---|----------|--------|
| 1 | [Title] | Option [X]: [Name] |

## Key Findings
- [Finding with source]

## Risks & Assumptions
- [Risk]

## Next Steps
[What to do with these decisions]
```

---

## Hooks

Hooks enable providers to sync decisions to external services, enforce privacy, and organize decisions into projects. The system is **hybrid**: hook metadata lives in `decisions.json` always (works offline), and optional hook scripts fire for real-time sync when a provider is configured.

> **Note on naming:** "Hooks" refers to two related things that share a name. The `hooks` block in `decisions.json` is *configuration*. The `.decisions/hooks/` directory holds *executable scripts*. One is data, the other is code.

### Hooks Block in decisions.json

The top-level `hooks` object stores shareable provider configuration. It is committed to version control so teams share the same project identity and visibility defaults.

```json
{
  "projectName": "ToolShare",
  "hooks": {
    "project": "toolshare-2026",
    "defaultVisibility": "private",
    "autoSync": false
  },
  "decisions": [...]
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `project` | string | No | Provider project identifier. Multiple `.decisions/` directories can share the same `hooks.project` to bundle decisions into one project on the provider. Falls back to `projectName` if absent. |
| `defaultVisibility` | string | No | Default visibility for all decisions: `"public"` or `"private"`. Defaults to `"private"` if absent. |
| `autoSync` | boolean | No | When `true`, `post-create` and `post-decide` hooks automatically push as decisions are made. When `false` or absent, decisions accumulate locally and sync only when the user explicitly triggers `push`. Defaults to `false`. |

### Per-Decision Visibility

Each decision may include an optional `visibility` field that overrides the project default:

```json
{
  "id": "decision-001",
  "slug": "target-user",
  "title": "Who Is This For?",
  "visibility": "public",
  ...
}
```

**Visibility resolution order:**
1. Decision-level `visibility` field (if present) — wins
2. `hooks.defaultVisibility` (if set) — fallback
3. `"private"` — safe default when nothing is configured

Private by default. You must opt in to sharing, never opt out to protect.

### Hook Scripts

Hook scripts live in `.decisions/hooks/` and are executable files. They are **optional** — everything works without them. When present, they fire at specific lifecycle moments.

#### Core Hooks

| Hook | Fires when | Arguments | autoSync behavior |
|------|-----------|-----------|-------------------|
| `post-create` | A new pending decision is added to `decisions.json` | Decision ID (e.g., `decision-001`) | If `autoSync: true`, pushes the new decision. If `false`, no-op. |
| `post-decide` | A decision is chosen or changed (covers journal mode revisions) | Decision ID | If `autoSync: true`, pushes the updated decision. If `false`, no-op. |
| `push` | User explicitly requests a sync | Decision IDs as args. No args = push all. | Always pushes, regardless of `autoSync`. This is explicit intent. |
| `post-brief` | A summary brief (strategy-brief.md, implementation-plan.md) is generated | Brief filename | If `autoSync: true`, pushes the brief. If `false`, no-op. |

#### Push Argument Contract

The `push` hook follows a git-push-style interface:

```bash
# Push one decision
.decisions/hooks/push decision-001

# Push multiple specific decisions
.decisions/hooks/push decision-001 decision-003

# Push all decisions
.decisions/hooks/push
```

No arguments means push everything. The hook script reads `decisions.json` to resolve project, visibility, and decision data.

#### Custom Hooks

Providers may define additional hooks using the `custom-*` naming convention:

```
.decisions/hooks/custom-pre-push-validate
.decisions/hooks/custom-post-sync-notify
```

Custom hooks are provider-specific. Skills do not need to know about them — only the provider's own tooling fires them. This allows providers to extend the hook system without requiring spec changes.

### Hook Execution

When a thinking skill reaches a hook trigger point, it:

1. Checks if the corresponding hook script exists in `.decisions/hooks/`
2. If the hook is `post-create`, `post-decide`, or `post-brief`: checks `hooks.autoSync` — skips if `false` or absent
3. If the hook is `push`: always executes (explicit user intent)
4. Executes the hook script, passing the relevant arguments
5. If the hook script is not present, continues silently (hooks are optional)

### Configuration and Credentials

Configuration is split between shareable and secret:

**Shareable (committed to git):**
- `hooks.project`, `hooks.defaultVisibility`, `hooks.autoSync` in `decisions.json`
- Per-decision `visibility` fields in `decisions.json`

**Secret (never committed):**
- `.decisions/.hook-env` — provider credentials and endpoint configuration
- Environment variables (e.g., `DDD_API_KEY`, `DDD_PROVIDER`, `DDD_ENDPOINT`)

The `.hook-env` file should be added to `.gitignore`. Hook scripts read credentials from environment variables or this file.

### File Structure with Hooks

```
.decisions/
├── decisions.json          ← decisions + hooks block (commit this)
├── .hook-env               ← provider credentials (gitignored)
├── hooks/
│   ├── post-create         ← fires on new pending decision
│   ├── post-decide         ← fires on choice made or changed
│   ├── push                ← explicit sync (ID args or all)
│   └── post-brief          ← fires on brief generation
├── decision-001-slug.html
├── decision-002-slug.html
├── index.html
└── strategy-brief.md
```

### Provider Initialization

Providers are set up through a **configuration skill** (`/hook-init`), consistent with how `/whoiam` and `/research-sources` configure other aspects of the system. The user says "connect my decisions to Jira" (or runs `/hook-init`), and the skill walks them through setup conversationally.

#### Hook Packages

Providers ship **hook packages** — a directory containing hook scripts and a manifest file that describes what the provider needs:

```json
{
  "provider": "my-provider",
  "displayName": "My Provider",
  "description": "Sync decisions to my platform",
  "content": "json",
  "hooks": ["post-create", "post-decide", "push", "post-brief"],
  "config": [
    { "key": "PROVIDER_URL", "prompt": "Your instance URL", "example": "https://my-instance.example.com" },
    { "key": "PROVIDER_PROJECT", "prompt": "Project key", "example": "MY-PROJECT" },
    { "key": "PROVIDER_API_KEY", "prompt": "API key", "secret": true }
  ]
}
```

The manifest declares:
- What content the provider syncs: `"json"` (structured data only), `"html"` (visual decision pages only), or `"both"` (default if omitted)
- Which hooks the provider implements
- What configuration values it needs, with human-readable prompts
- Which values are secrets (written to `.hook-env`, never to git)

#### Init Flow

The `/hook-init` skill:

1. Asks which provider to connect (shows known providers or accepts a hook package path/URL)
2. Reads the provider's manifest
3. Asks the user for each config value using the manifest's prompts
4. Sets up the `hooks` block in `decisions.json` (project, defaultVisibility, autoSync)
5. Copies hook scripts from the package into `.decisions/hooks/`
6. Writes secret config values to `.decisions/.hook-env`
7. Ensures `.hook-env` is in `.gitignore`
8. If decisions already exist, offers: *"You have N decisions. Want to push them now?"*

This means providers don't need to build an installer, a CLI, or a setup wizard. They ship their hooks and a manifest — the skill handles the rest.

### Backward Compatibility

All hook fields are optional. A `decisions.json` without a `hooks` block works exactly as before. Skills that don't check for hook scripts continue to function — the scripts simply don't fire. Existing thinking skills compose with hooks through the shared spec, not through individual skill changes.

---

## Platform Compatibility

This specification is platform-agnostic. Thinking skills work in any environment that supports the SKILL.md format:

- Any AI coding tool that reads SKILL.md files (Claude Code, Cursor, Gemini CLI, Codex CLI, etc.)

The composability convention is filesystem-based (`.decisions/` directory), not platform-specific.

---

*Decision Driven Development: make thoughtful decisions fast, then build.*
