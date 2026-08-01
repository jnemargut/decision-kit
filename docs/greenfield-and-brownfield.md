# Greenfield and brownfield

How Decision Kit behaves when you are starting from nothing versus walking into code someone else already wrote.

Back to the [README](../README.md).

---

Works whether you're dreaming something up or knee-deep in existing code.

### Greenfield (new ideas, exploration)

When you have an idea but no code yet, the danger isn't that you'll make bad decisions. It's that you'll skip them. You'll start building and assume you can figure it out as you go. Three weeks later you've made 40 decisions without realizing it, half of them contradict each other, and you can't remember why you chose any of them.

Greenfield mode is the antidote. You tell `/strategize`, `/shape`, `/product-strategy`, or `/product-design` what you're working on, and it surfaces the decisions you actually need to make before code gets in the way. Not every decision. The ones that matter. The ones that will haunt you if you skip them.

```
/strategize should we build a tool-sharing app for neighbors?
```

It identifies the decisions hiding in your idea. Who's this actually for? How do strangers learn to trust each other? What's the model that makes this not feel like an awkward favor? You see options for each one, you pick, you move on. Twenty minutes later you have a strategy brief that captures every choice and every reason. Now you can build, and every line of code traces back to a decision you made on purpose.

### Brownfield (existing code, no decisions recorded)

Every line of code is a decision someone made. The framework you chose. The way you handle errors. Whether sessions live in cookies or JWTs. The fact that signups need email verification but password resets don't. None of those are written down anywhere. They're not in the docs. They're not in the commit messages. They're encoded in the code itself, and the code is the only place they exist.

Your codebase is a graveyard of decisions nobody can see anymore.

`/excavate` reads your code and digs them out.

```
/excavate
```

<p align="center"><img src="../assets/doomhiddendecisions.png" alt="Excavate results from the Doom source code showing hidden decisions grouped by category: Game Feel findings like view bobbing tied to momentum, UX Design findings like Doomguy having 42 face states as an emotional dashboard, and Game Design findings like monsters hearing through walls via recursive sound flooding" width="450"></p>

It scans in layers: configs and dependencies first, then architecture, then patterns like error handling and state management, then higher-level signals like UX patterns and business model decisions. You confirm, review, or reject findings. Every confirmed finding becomes a recorded decision. The invisible becomes browsable.

From there, `/journal` evolves those decisions over time:

```
/journal our target user ended up being suburban homeowners, not urban renters
```

<p align="center"><img src="../assets/example-journal-entry.png" alt="Decision journal entry showing reasoning in quotes: They have garages full of tools and love lending them out, with an expanded change history showing the decision was changed from Urban Renters to Suburban Homeowners with a dated trail of why" width="450"></p>

Decisions mature: early sketch (no reasoning) becomes firmed up (has reasoning) becomes evolved (has reasoning + history of changes). You can look at any decision and immediately know how mature it is.

> **Bonus for coders:** lost your context window? No problem. Your context is embedded in your decisions. Start a fresh session, point the AI at `.decisions/`, and it picks up exactly where you left off. The reasoning is right there in the JSON. The tradeoffs are in the HTML. The history is in the journal. You don't re-explain yourself, you just keep going.
