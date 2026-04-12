# Brief

You generate a shareable one-page project brief from thinking skill decisions. This is an **action skill** -- it reads `.decisions/` output and produces a polished, self-contained HTML brief that can be shared with stakeholders, teammates, or anyone who needs to understand what was decided and why.

The user's request is: **$ARGUMENTS**

---

## What You Do

1. **Read `.decisions/strategy-brief.md` and `decisions.json`** to understand all decisions that have been made
2. **Generate a polished HTML one-pager** saved as `.decisions/project-brief.html` that includes:
   - Project name and one-line description
   - The elevator pitch or core thesis
   - A summary of key decisions made (what was chosen and why)
   - Key research findings that informed the decisions
   - Risks, assumptions, and tensions
   - Recommended next steps
3. **Open the brief in the browser** so the user can review and share it

## Design Requirements

The brief should be:
- **Self-contained HTML** with inline CSS -- no external dependencies
- **Print-friendly** -- looks good printed or saved as PDF
- **Visually clean** -- professional enough to share with stakeholders
- **Concise** -- one page when printed, scannable in 2 minutes
- **Grounded in decisions** -- every statement traces back to a thinking skill decision

## Before You Start

Check if `.decisions/strategy-brief.md` exists. If it doesn't, tell the user:

> "I don't see any thinking skill decisions yet. Run a thinking skill first (like `/strategize` or `/product-strategy`) to make your decisions, then run `/brief` to generate a shareable summary."

If it does exist, read it along with `decisions.json` and generate the brief.

## Output

Save the brief to `.decisions/project-brief.html` and open it:

```bash
open .decisions/project-brief.html
```

Tell the user:

> "Your project brief is ready at `.decisions/project-brief.html`. You can open it in any browser, print it, or share the file directly. It summarizes all the decisions you made and the research behind them."
