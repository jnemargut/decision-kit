# What you can use this for

Back to the [README](../README.md).

---

These are just a handful of examples. Anywhere you need to make thoughtful decisions before committing to a direction, Decision Kit has a place. The pattern is always the same: you bring the situation, AI surfaces the decisions, you judge.

**In software:**

- **Prototype from scratch** - "I have an idea for an app" turns into a strategy brief, design decisions, and implementation plan before you write a line of code. Then you hand the decisions to an AI coding tool and what comes out actually makes sense.
- **Write a PRD** - Instead of staring at a blank doc, run `/product-strategy` and let it surface the decisions a good PRD needs to answer. Target user, positioning, business model, success metrics. Each one with options you can actually compare. The PRD writes itself from the decisions.
- **Think through a hard technical problem** - "Should we migrate to microservices or keep the monolith?" Stop debating in Slack. Run `/strategize` and get four well-framed options with real tradeoffs. Pick one. Move on.
- **Design a system architecture** - Run `/product-design` and walk through framework, database, auth, API design, state management. Each decision informs the next. You end up with an architecture that's deliberate, not accidental. And every choice is stored as a browsable artifact, basically ADRs that write themselves.
- **Break down a complex ticket** - Run `/ticket-breakdown` on a gnarly feature request. It reads your codebase, identifies the scope decisions, surfaces the testing strategy, and produces an implementation plan grounded in your actual code, not generic best practices.
- **Prepare for a design review** - Run `/strategize` on the problem space before you open Figma. Show up to the review with decisions already made about who it's for, what the constraints are, and why you went this direction.
- **Audit an inherited codebase** - Run `/excavate` on code you didn't write. It surfaces every decision the previous team made but never documented: why they chose JWT over sessions, why errors are handled that way, why the data model looks like that.

**Outside software:**

- **Launch a business** - Food truck, consulting practice, online store. Strategy first, then an operational game plan with concrete tasks and timelines.
- **Write a difficult email** - Run `/strategize` on "I need to push back on a client's timeline." It surfaces the decisions you need to make about framing, tone, what to include, what to leave out. The email you write afterward is deliberate, not reactive.
- **Plan an event** - Conference, workshop series, team offsite. Run `/shape` and walk through format, schedule, venue, content structure, guest experience. Each decision builds on the last.

The examples in this repo include [planning an app before building it](../examples/running-club-app/), [Decision Kit redesigning its own design skills](../examples/design-skills-upgrade/), a [neighborhood tool library](../examples/community-app/), a [food truck launch](../examples/food-truck/), and [wedding planning](../examples/wedding-planning/).
