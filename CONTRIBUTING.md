# Contributing to Decision Kit

Thanks for considering a contribution. Decision Kit is small, focused, and opinionated, but it composes well, so there's a lot of room to extend it without changing the core.

This guide is short on purpose. The TL;DR: read [SPEC.md](SPEC.md), follow the patterns of the existing skills, and open a PR.

## What you can contribute

### A new thinking skill
A skill that shows decisions, lets humans make them, and remembers them. Read [docs/building-a-thinking-skill.md](docs/building-a-thinking-skill.md) for the step-by-step. The bar is: it follows the three rules in [SPEC.md](SPEC.md), it composes with existing skills (reads the prior `.decisions/` if present), and it has a reason to exist that isn't already covered.

### A new action skill
A skill that reads decisions and produces a deliverable (a brief, a roadmap, an artifact). Action skills don't present decision points, they execute on decisions already made. Look at `action/brief/` or `action/game-plan/` for the pattern.

### A hook package
A provider that connects Decision Kit to an external service (issue tracker, chat platform, dashboard, anything). Read [docs/building-a-provider.md](docs/building-a-provider.md) for the full guide. Hook packages can live in this repo as examples, or in their own repos. Both are welcome.

### A new example
A worked-through example showing Decision Kit applied to a real situation. Look at `examples/community-app/` or `examples/food-truck/` for the format. We especially want examples outside of pure software (events, life decisions, business choices).

### Documentation improvements
Typos, clarifications, better explanations, missing edge cases. PRs welcome.

### Bug reports and feature ideas
Open an issue. There are templates to help.

## What we're not looking for

- **Forks of existing skills with minor variations.** If `/strategize` doesn't quite fit your use case, propose a tweak to the existing skill or build something genuinely different. Don't fragment the ecosystem with near-duplicates.
- **Skills that bypass the decision gate.** Thinking skills must wait for human judgment. Action skills must read prior decisions, not invent new ones. Anything that shortcuts this isn't a good fit.
- **Tools that try to "automate the judgment."** Decision Kit's whole point is that judgment is the part you don't outsource. Suggestions that lean toward AI-makes-the-call are off-mission.
- **Major architectural changes** without an issue first. The spec is intentionally small. Talk to us before refactoring it.

## How to contribute

1. **Open an issue first** for anything non-trivial. A 5-minute conversation can save a 5-hour PR.
2. **Fork and branch.** One PR, one focused change.
3. **Follow the existing patterns.** New thinking skills should look like the existing thinking skills. Same SKILL.md structure, same dark theme for HTML decision pages, same conventions for `.decisions/` output.
4. **Test your skill end-to-end.** Run it on a real example. Make sure it composes (run another skill before it, see if it reads the prior decisions).
5. **Open a PR with a clear description.** What does it do? Who's it for? Why does it belong in Decision Kit?

## Code style

There isn't really code in this repo. There are SKILL.md files (Markdown with frontmatter) and HTML decision pages. The conventions are:

- **SKILL.md**: Follow the structure of existing skills. Frontmatter at the top with `name`, `description`, and `argument-hint`. Phases with clear numbered steps. Examples that sound conversational, not robotic.
- **HTML decision pages**: Self-contained. Inline CSS. Dark theme matching the rest of the project. No external dependencies. The visual options should help the human SEE the difference, not just read about it.
- **Plain English everywhere.** No jargon without explanation. Write like a smart friend, not a consultant.

## Decision records

This is meta but worth knowing: Decision Kit uses Decision Kit. Major decisions about the project itself live in `examples/` as worked-through decision records. If you're proposing something significant, consider running `/strategize` or `/shape` on it first and including the resulting `.decisions/` folder in your PR. Walking the talk.

## Code of conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold it. Be kind, be useful, assume good faith.

## License

By contributing to Decision Kit, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE).

## Questions?

Open an issue with the "Question" label, or just say what's on your mind. The maintainers are friendly.
