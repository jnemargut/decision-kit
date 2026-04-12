---
name: research-sources
description: "Configure your research trust preferences before running other thinking skills. Walk through 5 decisions: your domain, which source types you trust, specific voices and publications, domain allowlist/blocklist, and recency preferences. Saves to .decisions/sources.json which other thinking skills read to shape their research."
argument-hint: "[optional: domain, e.g. 'product development' or 'healthcare']"
---

# Sources

You are helping the user configure their research trust preferences. This is a pre-step that runs before other thinking skills like /strategize, /shape, or /product-strategy. It shapes WHERE those skills get their information.

Different people trust different sources. An academic researcher trusts peer-reviewed journals. A startup founder trusts practitioner blogs from people who've done the thing. A designer trusts case studies and portfolios. This skill makes those preferences explicit so every thinking skill that follows can respect them.

The user's input is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### This is a configuration skill
Unlike /strategize or /shape, this skill doesn't produce a strategy brief. It produces a `sources.json` file that other skills read. But it's still a thinking skill - it walks through decisions with visual pages, the human chooses, and choices are stored.

### Five decisions, one output
Walk through five decisions about source trust. Store the results in `.decisions/sources.json`. Other thinking skills check for this file when they research.

### Preferences are personal
There's no "right" answer. Someone might trust Reddit highly for engineering insights and avoid it for business strategy. Someone else might trust academic papers for everything. The skill presents the tradeoffs, the human decides.

### Never skip the decision page
Even if someone says "I just trust everything." Show them the options. They might not realize they have preferences until they see them laid out.

---

## PHASE 1 - Understand the Domain

If the user provided a domain (e.g. `/sources product development`), use it. If not, ask:

> "What space will you be researching? This shapes which source types and voices are most relevant.
>
> Examples: product development, engineering, healthcare, legal, food & restaurant, education, finance"

Wait for their answer. The domain context influences which trusted voices to suggest and how to frame source types.

---

## PHASE 2 - The Five Decisions

Walk through each decision with a visual HTML page in `.decisions/`.

### Decision 1: Domain Context

**What space are we in?** Present 4 options based on what the user said, plus common domains. Each option shows what kinds of sources are typically most valuable in that domain.

Visual preview: impact bars showing which source types are typically most valuable for each domain (e.g. "Healthcare: academic papers are critical, practitioner blogs less so" vs "Startups: practitioner blogs are gold, academic papers lag behind reality").

This decision shapes the defaults and suggestions for the remaining decisions.

### Decision 2: Source Type Trust Levels

**For each type of source, how much do you trust it?**

Present a visual page with each source type as an option card. For each type, the user assigns a trust level:
- **Trust highly** - actively prioritize these in research
- **Use with context** - include but label so I can evaluate
- **Avoid** - don't use these unless nothing else is available

Source types to rate:
- **Academic & research papers** - peer-reviewed journals, university publications, meta-analyses
- **Industry reports** - Gartner, Forrester, McKinsey, market research firms
- **Practitioner content** - blogs, talks, and books from people who've done the thing
- **Community discussion** - Reddit, Hacker News, Stack Overflow, forums
- **News & journalism** - tech press, business journalism, trade publications

Visual preview: a grid showing all 5 source types with their trust level as colored badges (green = trust highly, amber = use with context, red = avoid). Let the user set each one.

### Decision 3: Trusted Voices & Publications

**Who do you trust in this space?**

This is more free-form. The user names specific people, publications, or organizations they trust. For each one they name, generate a visual card showing:
- Name
- What they're known for
- Where to find them (website, publication)
- Why they're credible in this domain

Start by suggesting 4-6 well-known voices in the domain they chose in Decision 1. The user can accept any, reject any, or add their own.

Examples for product development:
- Teresa Torres (continuous discovery, producttalk.org)
- Marty Cagan (product management, svpg.com)
- Lenny Rachitsky (product growth, lennysnewsletter.com)
- Julie Zhuo (design leadership, medium.com/@joulee)

The user picks which ones to include and adds their own.

### Decision 4: Domain Allowlist & Blocklist

**Any specific websites you always want included or always want excluded?**

Present a visual page with two sections:
- **Always include** (green) - domains to actively search when researching
- **Never include** (red) - domains to hard-block from results

Start with a few suggestions based on the domain:
- For product: producttalk.org, svpg.com, lennysnewsletter.com (suggested include); ehow.com, wikihow.com (suggested block)
- For engineering: martinfowler.com, engineering blogs from major companies (suggested include)

The user can accept, reject, or add their own domains.

### Decision 5: Recency Preference

**How fresh does the information need to be?**

Present 4 options:
- **Option A: Cutting edge** - last 6 months. For fast-moving fields where last year's data is outdated.
- **Option B: Recent** - last 2 years. Good default for most domains.
- **Option C: Established** - last 5 years. For domains where fundamentals don't change fast.
- **Option D: Timeless** - no date filter. For principles, frameworks, and foundational knowledge.

Visual preview: timeline showing what falls within each window and what you'd miss.

---

## PHASE 3 - Generate sources.json

After all 5 decisions, save `.decisions/sources.json`:

```json
{
  "configuredAt": "ISO timestamp",
  "domain": "product development",
  "sourceTypes": {
    "academic": "use_with_context",
    "industry_reports": "trust_highly",
    "practitioner": "trust_highly",
    "community": "use_with_context",
    "news": "use_with_context"
  },
  "trustedVoices": [
    {
      "name": "Teresa Torres",
      "knownFor": "Continuous discovery, product decision-making",
      "domain": "producttalk.org"
    },
    {
      "name": "Marty Cagan",
      "knownFor": "Product management, empowered teams",
      "domain": "svpg.com"
    }
  ],
  "allowlist": [
    "producttalk.org",
    "svpg.com",
    "lennysnewsletter.com"
  ],
  "blocklist": [
    "ehow.com",
    "wikihow.com"
  ],
  "recency": "last_2_years"
}
```

Also generate the standard decision pages in `.decisions/` and a landing page.

### Then say:

> "Source preferences saved to `.decisions/sources.json`. When you run /strategize, /shape, or any thinking skill, it will:
>
> - Prioritize your trusted voices and allowlisted domains
> - Label every finding with your trust level for that source type
> - Hard-block your blocklisted domains
> - Prefer sources from the last [recency window]
>
> Your preferences are stored with this project. Run `/sources` again anytime to update them."

---

## HOW OTHER SKILLS USE THIS

When any thinking skill starts its research phase, it should:

1. **Check for `.decisions/sources.json`**
2. **If found, read it and adjust research:**
   - Include trusted voice domains in web searches (e.g. `site:producttalk.org [query]`)
   - Prioritize allowlisted domains in search queries
   - Hard-block blocklisted domains (use `blocked_domains` parameter in WebSearch)
   - Prefer results within the recency window
   - In the Research Context section, label each finding: "From [source] (you trust [type] highly)" or "From [source] (you marked [type] as use with context)"
3. **If not found, research normally** - no preferences, no labels, default behavior

This is documented in the SPEC.md so any thinking skill can implement it.

---

## IMPORTANT REMINDERS

1. **Never skip the decision page.** Even for seemingly obvious preferences.
2. **Suggest domain-appropriate voices.** The suggestions in Decision 3 should match the domain from Decision 1.
3. **Preferences are personal.** Don't judge someone for trusting Reddit highly or avoiding academic papers. Present the tradeoffs, let them choose.
4. **The blocklist is a hard filter.** Everything else is guidance. Only the blocklist actually prevents sources from appearing.
5. **Always 4 options per decision.** With a recommendation based on the domain.
6. **Open each decision page automatically.**
7. **Wait for the user after each decision.**
8. **The output is sources.json, not a strategy brief.** This is configuration, not strategy. But it's still a thinking skill with visual decision pages.
