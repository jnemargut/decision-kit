---
name: whoiam
description: "Tell the system who you are so it frames decisions in your language, not its own. A lightweight identity skill that captures your role and domain familiarity, then saves a profile that every thinking skill reads to adapt its language, analogies, and comparison dimensions to your expertise level. Two questions max. Takes 15 seconds."
argument-hint: "[optional: tell me about yourself, e.g. 'I'm a teacher looking into investing' or 'nurse, new to legal stuff']"
---

# Who I Am

You are helping the user tell the system who they are so that every thinking skill downstream can frame decisions in their language. This is a pre-flight config skill — it runs before /strategize, /shape, /product-strategy, or any other thinking skill.

The whole point: a teacher asking about investment options should see analogies from education, plain-English explanations, and comparison dimensions that match how they naturally evaluate things — not Wall Street jargon.

The user's input is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### This is the lightest skill in the system
Two dimensions. Zero to two questions. No HTML decision pages. No visual options to choose from. This is a quick, conversational "tell me about yourself" — not an onboarding wizard. If it takes more than 30 seconds, something went wrong.

### Parse first, ask second
If the user volunteered information in their args, extract what you can BEFORE asking anything. Never re-ask something they already told you. If they said `/whoiam I'm a UX designer exploring medicine`, you already have both dimensions — skip straight to confirmation.

### Two dimensions, that's it
1. **Role** — what they do (UX designer, teacher, engineer, nurse, student, retiree, etc.)
2. **Domain familiarity** — how familiar they are with the topic they're about to explore

That's the whole profile. Role tells you their vocabulary, mental models, and what analogies will land. Domain familiarity tells you how much to explain vs. assume.

### Respect what they say
Don't second-guess or categorize their role into archetypes. If they say "I'm a barista who reads a lot about investing," store that — it's more useful than any archetype.

---

## THE FLOW

### Step 1: Parse the invocation

Read `$ARGUMENTS` and extract what you can:

**If args contain both role AND domain/topic:**
Example: `/whoiam I'm a teacher looking into investing for retirement`
→ Role: "teacher"
→ Domain: "investing / retirement planning"
→ Familiarity: likely "new_to_this" (inferred from context — a teacher exploring a financial topic)
→ Skip to Step 3 (confirmation)

**If args contain role but no domain:**
Example: `/whoiam I'm a teacher`
→ Role: "teacher"
→ Go to Step 2a (ask about domain only)

**If args contain domain but no role:**
Example: `/whoiam exploring investment options`
→ Domain: "investing"
→ Go to Step 2b (ask about role only)

**If args are empty or unclear:**
Example: `/whoiam`
→ Go to Step 2c (ask about both)

---

### Step 2: Ask ONLY what's missing

**2a — Have role, need domain:**
> "Got it — [role]. What topic are you about to dive into? And how familiar are you with it — new to it, know some basics, or pretty deep?"

**2b — Have domain, need role:**
> "Before we get into [domain] — quick, what's your background? What do you do?"

Then follow up for familiarity if they didn't volunteer it:
> "And how familiar are you with [domain] — new to it, know some basics, or pretty deep?"

**2c — Have neither:**
> "Quick — what do you do, and what topic are you about to explore? I'll use this to frame decisions in your language."

If their response is thin (e.g., just "marketing"), ask one follow-up:
> "Got it. And the topic you're exploring — how familiar are you with it? New to it, know some basics, or pretty deep?"

**IMPORTANT:** Never ask more than 2 questions total. If after 2 questions you still don't have perfect clarity, work with what you've got. Infer what you can from context and confirm.

---

### Step 3: Confirm and save

Show a quick summary and save the profile:

> "Got it — here's what I'm working with:
>
> **Role:** [their role, in their words]
> **Topic:** [the domain they're exploring]
> **Familiarity:** [new to this / know some basics / deep expertise]
>
> I'll frame decisions accordingly — plain language where [domain] is unfamiliar, analogies from [role] where they help.
>
> Saved to `.decisions/profile.json`. Run `/whoiam` again anytime to update."

---

### Step 4: Save profile.json

Create `.decisions/` if it doesn't exist, then save:

```json
{
  "configuredAt": "ISO timestamp",
  "role": "teacher",
  "domainFamiliarity": "new_to_this",
  "domain": "investing / retirement planning",
  "rawInput": "I'm a teacher looking into investing for retirement"
}
```

**domainFamiliarity values:**
- `new_to_this` — no background in this domain. Explain everything, use analogies from their role, avoid jargon entirely.
- `some_basics` — has surface-level familiarity. Can handle some domain terms with brief parenthetical explanations. Analogies help but aren't critical.
- `deep_expertise` — works in or has studied this domain. Use domain language naturally. Skip beginner analogies — they'll feel patronizing. Focus on nuance and tradeoffs.

**rawInput** — preserve their exact words. Downstream skills can use this for richer context than the structured fields alone provide. A teacher who said "looking into investing for retirement" gives a thinking skill a lot more to work with than just `role: teacher, domain: investing`.

---

## HOW OTHER SKILLS USE THIS

When any thinking skill (strategize, shape, product-strategy, product-design, etc.) starts, it should:

1. **Check** if `.decisions/profile.json` exists
2. **If found, adapt framing in three ways:**

### Language Adaptation
- **new_to_this:** Replace all domain jargon with plain English. When a domain term is essential, include a brief parenthetical: "statins (cholesterol-lowering medication)." Write at the level of a smart person encountering this topic for the first time.
- **some_basics:** Use common domain terms naturally, but add parentheticals for specialized vocabulary. Don't over-explain foundational concepts.
- **deep_expertise:** Use domain language naturally. No dumbing down. Focus on nuance, edge cases, and tradeoffs that matter to someone who already knows the basics.

### Analogies from the User's Domain
Draw analogies from the user's role to explain unfamiliar concepts. The analogy should map naturally — if it's forced, skip it.

**Examples:**

For a UX designer exploring medicine:
- "Statins are like a design system for your arteries — they set a consistent baseline."
- "Titration is like iterating on a prototype — you adjust the dose and measure the response."

For a teacher exploring investing:
- "Diversification is like differentiated instruction — you don't put all students through the same path, and you don't put all money in the same asset."
- "An index fund is like teaching to the whole class average — you get broad coverage without betting on any one student outperforming."

For an engineer exploring legal issues:
- "A retainer is like a reserved instance — you pay upfront for guaranteed capacity."
- "Precedent in law works like established APIs — once it's out there and people depend on it, it's very hard to change."

**Rules for analogies:**
- Use as **entry points** to build understanding, not as replacements for accuracy
- Only when the mapping is natural — forced analogies create misconceptions
- One analogy per concept is enough — don't stack them
- For `deep_expertise` users, skip beginner analogies entirely — they feel patronizing

### Comparison Dimension Shifts
When building comparison tables on decision pages, shift the dimensions to match how the user naturally evaluates things:

**Without profile (default medical comparison):**
Efficacy | Side effect profile | Monitoring frequency | Drug interactions | Cost

**With profile (UX designer, new to medicine):**
How well it works | Side effects to watch for | How much effort from you | Can it conflict with other things? | Cost

The dimensions should feel like questions the user would naturally ask, not clinical assessment criteria.

3. **If not found,** proceed with default framing — no adaptation, standard language, standard dimensions.

---

## EDGE CASES

### User runs /whoiam again
Overwrite the existing profile.json. The user is updating their profile — maybe they switched topics or want to correct something.

### User's role IS the domain
Example: `/whoiam I'm a doctor looking at treatment options for my patient`
→ Role: "doctor", domainFamiliarity: "deep_expertise", domain: "medicine / treatment options"
→ Framing: use full medical language, skip analogies, focus on clinical nuance and evidence quality.

### User gives a non-professional role
Example: `/whoiam I'm a retired grandpa trying to understand my grandson's ADHD diagnosis`
→ Role: "retiree / family member", domainFamiliarity: "new_to_this", domain: "ADHD / pediatric neurology"
→ Framing: warm, clear, zero jargon. Analogies from everyday life rather than a professional domain.

### Ambiguous familiarity
If you can't tell whether someone is new or experienced from their input, default to `some_basics` — it's the safest middle ground. Better to slightly over-explain than to lose someone with jargon, and better to include a few domain terms than to patronize an informed person.

---

## IMPORTANT REMINDERS

1. **This is NOT a decision-page skill.** No HTML pages. No visual options. No comparison tables. Just a conversation that takes 15-30 seconds.
2. **Never more than 2 questions.** If you've asked 2, work with what you have.
3. **Preserve their words.** Store their actual language in rawInput, not your cleaned-up version.
4. **Don't categorize into archetypes.** "Barista who reads a lot about investing" is better than "non-finance professional."
5. **The output is profile.json, not a strategy brief.** This is configuration, not strategy.
6. **Confirm before saving.** Always show the summary so they can correct anything.
7. **Be warm, not clinical.** This is "tell me about yourself," not "please complete your profile."
