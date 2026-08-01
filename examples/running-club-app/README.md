# Example: planning an app before writing it

The `.decisions/` record from running `/product-design` on: *"I want to build an app where my running club can log runs and see a leaderboard."*

Four decisions, each with four real options and a rendered artifact you can compare:

| | Decision | What the options show |
|---|---|---|
| 1 | [Architecture](decision-001-architecture.html) | Stack diagrams for each approach |
| 2 | [Data model](decision-002-data-model.html) | The actual table shapes |
| 3 | [Auth](decision-003-auth.html) | The code each choice makes you write |
| 4 | [Leaderboard UI](decision-004-leaderboard-ui.html) | Four rendered leaderboards, same data |

Nothing here was hand-designed. Every diagram, schema, snippet, and mockup was generated as part of surfacing the decision, so you can see the difference instead of imagining it.

Once these are settled, the folder is the spec: hand it to any AI coding tool and it already knows the stack, the schema, the auth model, and what the main screen should feel like.
