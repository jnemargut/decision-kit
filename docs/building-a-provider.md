# Building a Provider

A provider connects Decision Driven Development to an external service — Jira, Slack, Notion, a custom dashboard, anything. This guide walks you through building one from scratch.

## Before You Start

Read the [Hooks section of SPEC.md](../SPEC.md#hooks) for the full specification. The short version:

- **Hook metadata** (project, visibility, autoSync) lives in the `hooks` block of `decisions.json`
- **Hook scripts** live in `.decisions/hooks/` and fire at lifecycle moments
- **Credentials** live in `.decisions/.hook-env` (gitignored)
- The `/hook-init` skill installs your provider by reading a **hook package**

## What You're Building

A hook package. That's it. You don't need to build a CLI, an installer, or a setup wizard. The `/hook-init` skill handles installation — you just ship the package.

A hook package is a directory containing:

```
my-provider/
  manifest.json        ← declares what you need
  hooks/
    post-create        ← executable scripts
    post-decide
    push
    post-brief
```

## Step 1: Create the Manifest

The manifest tells `/hook-init` everything it needs to install your provider. Create `manifest.json`:

```json
{
  "provider": "my-provider",
  "displayName": "My Cloud Provider",
  "description": "What this provider does in one sentence",
  "content": "json",
  "hooks": ["post-create", "post-decide", "push", "post-brief"],
  "config": [
    {
      "key": "MY_API_URL",
      "prompt": "Your API endpoint URL",
      "example": "https://api.example.com"
    },
    {
      "key": "MY_PROJECT_ID",
      "prompt": "Project ID in your system",
      "example": "proj-123"
    },
    {
      "key": "MY_API_KEY",
      "prompt": "API key",
      "secret": true
    }
  ]
}
```

### Manifest fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `provider` | string | Yes | Machine-readable provider ID. Lowercase, no spaces. |
| `displayName` | string | Yes | Human-readable name shown during setup. |
| `description` | string | Yes | One sentence explaining what this provider does. |
| `content` | string | No | What the provider syncs: `"json"` (structured data from decisions.json only), `"html"` (visual decision pages only), or `"both"`. Defaults to `"both"` if omitted. |
| `hooks` | string[] | Yes | Which core hooks your provider implements. Only list the ones you actually need. |
| `config` | object[] | Yes | Configuration values your hooks need at runtime. |

### Choosing what content to sync

Not every provider needs both JSON and HTML. The `content` field declares what your hooks will use:

- **`"json"`** - Your hooks only read `decisions.json`. Good for issue trackers, chat notifications, dashboards that render their own UI from the structured data. Most providers will use this.
- **`"html"`** - Your hooks only read the HTML decision pages. Good for static hosting or document archiving where you want the visual pages as-is.
- **`"both"`** - Your hooks read JSON for data and also sync the HTML files. Good for platforms that want to display the visual decision pages alongside structured data.

This field is informational. Your hooks always have access to everything in `.decisions/` regardless of what you declare. But it tells `/hook-init` what to communicate to the user during setup and helps other tooling understand your provider's intent.

### Config entry fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `key` | string | Yes | Environment variable name. Convention: uppercase with underscores. |
| `prompt` | string | Yes | Human-readable question shown to the user during setup. |
| `example` | string | No | Example value shown as a hint. |
| `secret` | boolean | No | If `true`, the value is stored in `.hook-env` and never displayed after entry. Defaults to `false`. All config goes to `.hook-env`, but `secret: true` tells the UI to mask input. |

### You don't have to implement all 4 hooks

Only list the hooks you need. A Slack notifier might only implement `post-decide`. A full Jira integration might implement all 4. The `/hook-init` skill only installs the hooks you declare.

## Step 2: Write the Hook Scripts

Each hook is an executable file in `hooks/`. It can be written in any language — bash, Python, Node.js, Go, whatever. The only requirement: it must be executable (`chmod +x`).

### What your hooks receive

**Environment variables** (always available):

Your hooks can read the `.hook-env` file or expect the values as environment variables. The convention is that hook scripts source `.hook-env` themselves:

```bash
#!/bin/bash
# Source credentials
source "$(dirname "$0")/../.hook-env" 2>/dev/null
```

**Arguments** (depend on the hook):

| Hook | Arguments | Example |
|------|-----------|---------|
| `post-create` | Decision ID | `post-create decision-001` |
| `post-decide` | Decision ID | `post-decide decision-001` |
| `push` | Decision IDs (optional — no args = push all) | `push decision-001 decision-003` or `push` |
| `post-brief` | Brief filename | `post-brief strategy-brief.md` |

**Working directory:** The hook is executed from the `.decisions/` directory. So `decisions.json` is at `./decisions.json` and HTML files are at `./decision-001-slug.html`.

### What your hooks should do

**Read `decisions.json`** to get the data. Everything you need is there:

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

DECISION_ID="$1"
DECISIONS_FILE="./decisions.json"

# Read the hooks config
PROJECT=$(jq -r '.hooks.project // .projectName' "$DECISIONS_FILE")
VISIBILITY=$(jq -r '.hooks.defaultVisibility // "private"' "$DECISIONS_FILE")

# Read the specific decision
DECISION=$(jq --arg id "$DECISION_ID" '.decisions[] | select(.id == $id)' "$DECISIONS_FILE")
TITLE=$(echo "$DECISION" | jq -r '.title')
STATUS=$(echo "$DECISION" | jq -r '.status')

# Check per-decision visibility override
DECISION_VIS=$(echo "$DECISION" | jq -r '.visibility // empty')
EFFECTIVE_VIS="${DECISION_VIS:-$VISIBILITY}"

# Do your thing — push to your API
curl -X POST "$MY_API_URL/decisions" \
  -H "Authorization: Bearer $MY_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"project\": \"$PROJECT\", \"title\": \"$TITLE\", \"visibility\": \"$EFFECTIVE_VIS\"}"
```

### Resolving visibility

Your hook should resolve visibility using the cascade:

1. Check the decision's `visibility` field (if present, it wins)
2. Fall back to `hooks.defaultVisibility`
3. Fall back to `"private"`

```bash
# Resolve visibility for a decision
resolve_visibility() {
  local decision_vis=$(echo "$1" | jq -r '.visibility // empty')
  local default_vis=$(jq -r '.hooks.defaultVisibility // "private"' decisions.json)
  echo "${decision_vis:-$default_vis}"
}
```

### The push hook — handling "all" vs "specific"

The `push` hook is special because it can receive zero or more decision IDs:

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

if [ $# -eq 0 ]; then
  # No args — push all decisions
  DECISION_IDS=$(jq -r '.decisions[].id' decisions.json)
else
  # Specific IDs passed as arguments
  DECISION_IDS="$@"
fi

for ID in $DECISION_IDS; do
  # Push each decision...
  echo "Pushing $ID"
done
```

### Checking autoSync

The `post-create`, `post-decide`, and `post-brief` hooks should check `autoSync` before doing anything expensive:

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

# Check autoSync — exit silently if disabled
AUTO_SYNC=$(jq -r '.hooks.autoSync // false' decisions.json)
if [ "$AUTO_SYNC" != "true" ]; then
  exit 0
fi

# autoSync is on — proceed with sync
DECISION_ID="$1"
# ... push to provider
```

The `push` hook should **not** check autoSync — it's an explicit user action and always executes.

### Exit codes

| Exit code | Meaning |
|-----------|---------|
| 0 | Success |
| 1 | Error (hook failed, sync did not complete) |

The skill will report hook failures to the user but won't retry automatically.

### JSON-only providers

If your manifest declares `"content": "json"`, your hooks only need to read `decisions.json`. This is the most common case. Each decision object has all the structured data: title, status, chosen option, reasoning, visibility, and history. You don't need to touch the HTML files at all.

### Including HTML files

If your manifest declares `"content": "html"` or `"content": "both"`, you can also read the rendered decision pages. Each decision's `htmlFile` field points to its HTML file in the same directory:

```bash
HTML_FILE=$(echo "$DECISION" | jq -r '.htmlFile')
if [ -f "./$HTML_FILE" ]; then
  HTML_CONTENT=$(cat "./$HTML_FILE")
  # Upload, host, or attach the HTML...
fi
```

The HTML files are self-contained (inline CSS, no external dependencies) so they can be hosted or displayed anywhere.

## Step 3: Test Your Provider

### Test without autoSync

1. Put your hook package in a local directory
2. Run `/hook-init` and point it to your package
3. Set autoSync to `false`
4. Run a thinking skill (`/strategize`, `/shape`, etc.)
5. Make a decision
6. Say "push my decisions" — your `push` hook should fire
7. Say "push decision-001" — your `push` hook should fire with that ID

### Test with autoSync

1. Run `/hook-init` again, set autoSync to `true`
2. Run a thinking skill
3. When a decision is created, your `post-create` hook should fire automatically
4. When you choose an option, your `post-decide` hook should fire automatically

### Test visibility

1. Set `defaultVisibility` to `"private"` in the hooks block
2. Make a decision — your hook should see it as private
3. Add `"visibility": "public"` to that decision in `decisions.json`
4. Push again — your hook should now see it as public

## Step 4: Add Custom Hooks (Optional)

If your provider needs hooks beyond the 4 core ones, use the `custom-*` naming convention:

```
hooks/
  post-create
  post-decide
  push
  post-brief
  custom-jira-link-epic       ← Jira-specific
  custom-jira-transition      ← Jira-specific
```

Custom hooks are your provider's business. They aren't fired by thinking skills — only your own tooling triggers them. This lets you extend the system without asking for spec changes.

Don't add custom hooks to the `hooks` array in the manifest — they're installed alongside core hooks but managed by your provider's logic.

## Step 5: Package and Distribute

Your hook package can be distributed however makes sense:

- **Git repository** — users point `/hook-init` at the repo URL
- **Local directory** — for internal/private providers
- **npm/pip/brew package** — if you want discoverability
- **Bundled with your product** — ship it alongside your main tool

The only requirement: the package directory must contain `manifest.json` and a `hooks/` subdirectory with executable scripts.

## Examples

The Slack example below is a working integration — Slack incoming webhooks are a simple POST and this script should work as-is. The Jira example is a **reference implementation** that illustrates a more complex, multi-hook provider. It follows the correct Jira REST API structure but has not been tested against a live Jira instance — you may need to adjust authentication, field formats, or JQL queries for your setup.

### A Complete Slack Provider

Here's a minimal but complete provider that posts to Slack when decisions are made:

### manifest.json

```json
{
  "provider": "slack",
  "displayName": "Slack Notifications",
  "description": "Post to a Slack channel when decisions are made",
  "content": "json",
  "hooks": ["post-decide"],
  "config": [
    {
      "key": "SLACK_WEBHOOK_URL",
      "prompt": "Slack incoming webhook URL",
      "example": "https://hooks.slack.com/services/T00/B00/xxx",
      "secret": true
    },
    {
      "key": "SLACK_CHANNEL",
      "prompt": "Channel name (without #)",
      "example": "product-decisions"
    }
  ]
}
```

### hooks/post-decide

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

# Check autoSync
AUTO_SYNC=$(jq -r '.hooks.autoSync // false' decisions.json)
if [ "$AUTO_SYNC" != "true" ]; then
  exit 0
fi

DECISION_ID="$1"
PROJECT=$(jq -r '.hooks.project // .projectName' decisions.json)
DECISION=$(jq --arg id "$DECISION_ID" '.decisions[] | select(.id == $id)' decisions.json)
TITLE=$(echo "$DECISION" | jq -r '.title')
CHOSEN=$(echo "$DECISION" | jq -r '.chosenTitle')
STATUS=$(echo "$DECISION" | jq -r '.status')

if [ "$STATUS" != "chosen" ]; then
  exit 0
fi

curl -s -X POST "$SLACK_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d "{
    \"channel\": \"#$SLACK_CHANNEL\",
    \"text\": \"Decision made in *$PROJECT*\n*$TITLE* → $CHOSEN\"
  }"
```

That's it — a 30-line Slack provider. The user runs `/hook-init`, picks Slack, pastes their webhook URL, and decisions start posting to their channel.

### A Complete Jira Provider (Reference)

A more full-featured reference example that creates and updates Jira tickets. This illustrates the patterns for a multi-hook provider — adapt and test against your Jira instance before relying on it:

### manifest.json

```json
{
  "provider": "jira",
  "displayName": "Jira Cloud",
  "description": "Sync decisions to Jira as tickets in a project",
  "content": "json",
  "hooks": ["post-create", "post-decide", "push", "post-brief"],
  "config": [
    {
      "key": "JIRA_INSTANCE",
      "prompt": "Your Jira instance",
      "example": "yourteam.atlassian.net"
    },
    {
      "key": "JIRA_PROJECT_KEY",
      "prompt": "Jira project key for decision tickets",
      "example": "TOOL"
    },
    {
      "key": "JIRA_EMAIL",
      "prompt": "Your Jira account email",
      "example": "you@company.com"
    },
    {
      "key": "JIRA_API_TOKEN",
      "prompt": "Jira API token (from id.atlassian.com/manage-profile/security/api-tokens)",
      "secret": true
    }
  ]
}
```

### hooks/post-create

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

AUTO_SYNC=$(jq -r '.hooks.autoSync // false' decisions.json)
if [ "$AUTO_SYNC" != "true" ]; then exit 0; fi

DECISION_ID="$1"
DECISION=$(jq --arg id "$DECISION_ID" '.decisions[] | select(.id == $id)' decisions.json)
TITLE=$(echo "$DECISION" | jq -r '.title')
SUMMARY=$(echo "$DECISION" | jq -r '.summary // "Pending decision"')
AUTH=$(echo -n "$JIRA_EMAIL:$JIRA_API_TOKEN" | base64)

curl -s -X POST "https://$JIRA_INSTANCE/rest/api/3/issue" \
  -H "Authorization: Basic $AUTH" \
  -H "Content-Type: application/json" \
  -d "{
    \"fields\": {
      \"project\": {\"key\": \"$JIRA_PROJECT_KEY\"},
      \"summary\": \"[Decision] $TITLE\",
      \"description\": {\"type\": \"doc\", \"version\": 1, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"type\": \"text\", \"text\": \"$SUMMARY\"}]}]},
      \"issuetype\": {\"name\": \"Task\"},
      \"labels\": [\"ddd-decision\", \"$DECISION_ID\"]
    }
  }"
```

### hooks/post-decide

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

AUTO_SYNC=$(jq -r '.hooks.autoSync // false' decisions.json)
if [ "$AUTO_SYNC" != "true" ]; then exit 0; fi

DECISION_ID="$1"
DECISION=$(jq --arg id "$DECISION_ID" '.decisions[] | select(.id == $id)' decisions.json)
TITLE=$(echo "$DECISION" | jq -r '.title')
CHOSEN=$(echo "$DECISION" | jq -r '.chosenTitle')
STATUS=$(echo "$DECISION" | jq -r '.status')
AUTH=$(echo -n "$JIRA_EMAIL:$JIRA_API_TOKEN" | base64)

# Find the Jira issue by label
ISSUE_KEY=$(curl -s "https://$JIRA_INSTANCE/rest/api/3/search?jql=labels=$DECISION_ID" \
  -H "Authorization: Basic $AUTH" | jq -r '.issues[0].key // empty')

if [ -n "$ISSUE_KEY" ]; then
  # Add a comment with the decision
  curl -s -X POST "https://$JIRA_INSTANCE/rest/api/3/issue/$ISSUE_KEY/comment" \
    -H "Authorization: Basic $AUTH" \
    -H "Content-Type: application/json" \
    -d "{\"body\": {\"type\": \"doc\", \"version\": 1, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"type\": \"text\", \"text\": \"Decision made: $CHOSEN\"}]}]}}"
fi
```

### hooks/push

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

# Push always runs — no autoSync check
AUTH=$(echo -n "$JIRA_EMAIL:$JIRA_API_TOKEN" | base64)

if [ $# -eq 0 ]; then
  DECISION_IDS=$(jq -r '.decisions[].id' decisions.json)
else
  DECISION_IDS="$@"
fi

for ID in $DECISION_IDS; do
  DECISION=$(jq --arg id "$ID" '.decisions[] | select(.id == $id)' decisions.json)
  TITLE=$(echo "$DECISION" | jq -r '.title')
  STATUS=$(echo "$DECISION" | jq -r '.status')
  CHOSEN=$(echo "$DECISION" | jq -r '.chosenTitle // "Pending"')

  # Check if issue exists
  ISSUE_KEY=$(curl -s "https://$JIRA_INSTANCE/rest/api/3/search?jql=labels=$ID" \
    -H "Authorization: Basic $AUTH" | jq -r '.issues[0].key // empty')

  if [ -z "$ISSUE_KEY" ]; then
    # Create new issue
    echo "Creating Jira ticket for $ID: $TITLE"
    curl -s -X POST "https://$JIRA_INSTANCE/rest/api/3/issue" \
      -H "Authorization: Basic $AUTH" \
      -H "Content-Type: application/json" \
      -d "{
        \"fields\": {
          \"project\": {\"key\": \"$JIRA_PROJECT_KEY\"},
          \"summary\": \"[Decision] $TITLE — $CHOSEN\",
          \"issuetype\": {\"name\": \"Task\"},
          \"labels\": [\"ddd-decision\", \"$ID\"]
        }
      }"
  else
    # Update existing issue
    echo "Updating $ISSUE_KEY for $ID: $TITLE → $CHOSEN"
    curl -s -X PUT "https://$JIRA_INSTANCE/rest/api/3/issue/$ISSUE_KEY" \
      -H "Authorization: Basic $AUTH" \
      -H "Content-Type: application/json" \
      -d "{\"fields\": {\"summary\": \"[Decision] $TITLE — $CHOSEN\"}}"
  fi
done
```

### hooks/post-brief

```bash
#!/bin/bash
source "$(dirname "$0")/../.hook-env" 2>/dev/null

AUTO_SYNC=$(jq -r '.hooks.autoSync // false' decisions.json)
if [ "$AUTO_SYNC" != "true" ]; then exit 0; fi

BRIEF_FILE="$1"
AUTH=$(echo -n "$JIRA_EMAIL:$JIRA_API_TOKEN" | base64)
PROJECT=$(jq -r '.hooks.project // .projectName' decisions.json)

if [ -f "./$BRIEF_FILE" ]; then
  BRIEF_CONTENT=$(cat "./$BRIEF_FILE" | head -c 30000)

  echo "Attaching brief to Jira project $JIRA_PROJECT_KEY"
  # Create a summary ticket with the brief content
  curl -s -X POST "https://$JIRA_INSTANCE/rest/api/3/issue" \
    -H "Authorization: Basic $AUTH" \
    -H "Content-Type: application/json" \
    -d "{
      \"fields\": {
        \"project\": {\"key\": \"$JIRA_PROJECT_KEY\"},
        \"summary\": \"[Brief] $PROJECT — Strategy Brief\",
        \"description\": {\"type\": \"doc\", \"version\": 1, \"content\": [{\"type\": \"codeBlock\", \"content\": [{\"type\": \"text\", \"text\": $(echo "$BRIEF_CONTENT" | jq -Rs .)}]}]},
        \"issuetype\": {\"name\": \"Task\"},
        \"labels\": [\"ddd-brief\"]
      }
    }"
fi
```

---

## Tips

- **Start with one hook.** You don't need all 4. A Slack notifier with just `post-decide` is useful on day one.
- **Always source `.hook-env`.** Use `source "$(dirname "$0")/../.hook-env" 2>/dev/null` at the top of every hook. The `2>/dev/null` handles the case where the file doesn't exist yet.
- **Always check autoSync** in `post-create`, `post-decide`, and `post-brief`. Never check it in `push` — push is explicit.
- **Resolve visibility with the cascade.** Decision field > project default > "private".
- **Exit 0 on success, exit 1 on failure.** That's the only contract for exit codes.
- **The working directory is `.decisions/`.** All paths in your hooks are relative to that.
- **Test with `autoSync: false` first.** Use explicit `push` to debug, then turn on autoSync.
- **Use `jq` for JSON parsing.** It's the most common tool for reading `decisions.json` from shell scripts. If you're writing hooks in Python or Node.js, use your language's JSON library instead.

---

*For the full specification, see [SPEC.md](../SPEC.md#hooks).*
*For examples of decisions in action, see [examples/](../examples/).*
