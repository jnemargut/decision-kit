---
name: hook-init
description: "Connect your decisions to an external service for sync, privacy controls, and project bundling. Walks through provider selection, project config, visibility defaults, and auto-sync preferences. Installs hook scripts from a provider's hook package and sets up credentials. Run once per project."
argument-hint: "[optional: provider name or intent, e.g. 'jira' or 'connect to Slack' or 'set up sync']"
---

# Hook Init

You are helping the user connect their `.decisions/` directory to an external service through hooks. This is a configuration skill — like `/whoiam` configures identity and `/research-sources` configures source preferences, `/hook-init` configures which external services receive your decisions.

After this skill runs, decisions will sync to the configured provider either automatically (if autoSync is enabled) or on explicit push. The user never needs to think about hook scripts, manifests, or config files — this skill handles all of that.

The user's input is: **$ARGUMENTS**

---

## CORE PRINCIPLES

### This is a configuration skill, not a thinking skill
No decision pages with 4 visual options. This is a guided conversation — closer to `/whoiam` than `/strategize`. The output is config in `decisions.json` + installed hook scripts, not a strategy brief.

### Parse first, ask second
If the user said `/hook-init jira`, you already know the provider. Don't re-ask. If they said `/hook-init`, ask.

### Respect the hybrid architecture
Hook metadata (project, visibility, autoSync) goes in the `hooks` block of `decisions.json`. Provider credentials go in `.decisions/.hook-env` (gitignored). Hook scripts go in `.decisions/hooks/`. These three locations are the contract — never put secrets in decisions.json, never put project config in .hook-env.

### Idempotent
If the user runs `/hook-init` again, update the existing config rather than creating duplicates. If hooks already exist, ask before overwriting: "You already have hooks from [provider]. Replace them?"

---

## PHASE 1 — Understand the Request

### Step 1a: Check current state

Before doing anything, check what already exists:

1. Read `decisions.json` — does a `hooks` block already exist?
2. Check if `.decisions/hooks/` exists and has scripts
3. Check if `.decisions/.hook-env` exists

**If hooks are already configured:**
> "You're already connected to **[provider]** with project **[project]**. Want to:
>
> - **Update config** — change project, visibility, or autoSync settings
> - **Switch providers** — replace the current hook scripts with a new provider
> - **Reconfigure credentials** — update API keys or endpoints
>
> Or tell me what you'd like to change."

**If not configured:** proceed to Step 1b.

### Step 1b: Determine the provider

**If args name a provider** (e.g., `/hook-init my-provider`):
→ Look for a hook package for that provider. Skip to Phase 2.

**If args describe intent** (e.g., "connect to Slack", "sync my decisions"):
→ Infer the provider if possible. If ambiguous, ask.

**If args are empty:**
> "Where would you like your decisions to sync? You can:
>
> - **Name a provider** if you have one in mind
> - **Point me to a hook package** (local path, git repo, or URL)
> - **Set up manually** and add hook scripts yourself later
>
> Or tell me what you're trying to do and I'll figure out the right setup."

Wait for the user to pick.

---

## PHASE 2 — Load the Hook Package

### What is a hook package?

A hook package is a directory (local path, git repo, or URL) containing:

```
my-provider/
  manifest.json      ← declares what the provider needs
  hooks/
    post-create      ← executable hook scripts
    post-decide
    push
    post-brief
```

### Read the manifest

The `manifest.json` tells you everything about the provider:

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

The `content` field declares what the provider syncs: `"json"` (structured decision data only), `"html"` (visual decision pages only), or `"both"` (default if omitted). Most providers only need `"json"`.

**If the package can't be found:**
> "I don't have a built-in hook package for [provider]. You can:
>
> - **Point me to one** — give me a local path, git repo URL, or download URL
> - **Set up manually** — I'll configure the hooks block and you can add hook scripts yourself
>
> What would you prefer?"

---

## PHASE 3 — Walk Through Configuration

Ask each question in order. Skip any that the user already answered in their args or that can be inferred from context.

### 3a: Project identity

> "What should this project be called on the provider? This is the identifier that groups your decisions together.
>
> **Suggestion:** `[slugified projectName from decisions.json]`
>
> You can use this or pick something else. If you have another repo with decisions for the same product, use the same project name to bundle them together."

Store as `hooks.project` in `decisions.json`. If the user accepts the default, use the slugified `projectName`.

### 3b: Default visibility

> "Should your decisions be **private** or **public** by default?
>
> - **Private** (recommended) — decisions are only visible to you. You can make individual ones public later.
> - **Public** — all decisions are visible by default. You can make individual ones private later.
>
> You can always change this, and you can override it per-decision."

Store as `hooks.defaultVisibility` in `decisions.json`.

### 3c: Auto-sync

> "Should decisions sync automatically as you make them, or only when you explicitly push?
>
> - **Auto-sync on** — every decision syncs to [provider] the moment it's made. Great for team visibility.
> - **Auto-sync off** (recommended) — decisions stay local until you say 'push my decisions.' Better for work-in-progress.
>
> You can change this anytime."

Store as `hooks.autoSync` in `decisions.json`.

### 3d: Provider credentials

Read the `config` array from the manifest. For each entry:

**If `secret: true`:**
> "[prompt from manifest] (e.g., `[example]`)
> This will be stored in `.hook-env` and never committed to git."

**If not secret:**
> "[prompt from manifest] (e.g., `[example]`)"

Store secrets in `.decisions/.hook-env` as `KEY=value` lines.
Store non-secret config in `.decisions/.hook-env` as well (provider-specific config doesn't belong in decisions.json).

---

## PHASE 4 — Install Everything

Once all config is gathered:

### 4a: Write the hooks block to decisions.json

Add or update the `hooks` object at the top level of `decisions.json`:

```json
{
  "hooks": {
    "project": "[user's choice]",
    "defaultVisibility": "[user's choice]",
    "autoSync": [true/false]
  }
}
```

**Do not overwrite existing decisions or other fields.** Only add/update the `hooks` block.

Note: this is the `hooks` block in JSON, not the `.decisions/hooks/` directory where scripts live. Same word, different things.

### 4b: Install hook scripts

1. Create `.decisions/hooks/` if it doesn't exist
2. Copy each hook script from the provider package into `.decisions/hooks/`
3. Make each script executable (`chmod +x`)

If hooks already exist, ask before overwriting:
> "You already have a `post-decide` hook. Replace it with the one from [provider]?"

### 4c: Write credentials

Create or update `.decisions/.hook-env`:

```
# Provider credentials — DO NOT COMMIT
# Provider: [displayName]
# Configured: [ISO timestamp]

PROVIDER_URL=https://my-instance.example.com
PROVIDER_PROJECT=MY-PROJECT
PROVIDER_API_KEY=sk-abc123...
```

### 4d: Update .gitignore

Check if `.gitignore` (in the project root or `.decisions/`) includes `.hook-env`. If not, add it:

```
# Provider credentials
.decisions/.hook-env
```

### 4e: Confirm setup

> "All set! Here's what I configured:
>
> **Provider:** [displayName]
> **Syncs:** [json only / html only / json + html] (based on manifest `content` field)
> **Project:** [project]
> **Default visibility:** [private/public]
> **Auto-sync:** [on/off]
> **Hooks installed:** [list of hooks]
> **Credentials:** stored in `.decisions/.hook-env` (gitignored)
>
> Your decisions will [sync automatically as you make them / sync when you say 'push my decisions']."

---

## PHASE 5 — Offer Initial Push

Check if there are existing decisions in `decisions.json`.

**If decisions exist:**
> "You have **[N] decisions** already. Want to push them to [provider] now?
>
> - **Push all** — sync everything right now
> - **Push chosen only** — sync only the decisions that have been resolved (skip pending)
> - **Not yet** — I'll leave them local, you can push later"

If the user says push, execute the `push` hook:
- "Push all": `.decisions/hooks/push` (no args)
- "Push chosen only": `.decisions/hooks/push [list of chosen decision IDs]`

**If no decisions exist:**
> "No decisions yet — when you run a thinking skill like `/strategize` or `/shape`, your decisions will [auto-sync / be ready to push]."

---

## PHASE 6 — Manual Setup (no hook package)

If the user chose manual setup (no hook package available):

### 6a: Configure the hooks block

Walk through steps 3a-3c as normal (project, visibility, autoSync).

### 6b: Create placeholder hooks directory

Create `.decisions/hooks/` with a README:

```markdown
# Hook Scripts

Place your provider's hook scripts here. The spec defines 4 core hooks:

- `post-create` — fires when a new pending decision is added (arg: decision ID)
- `post-decide` — fires when a decision is chosen or changed (arg: decision ID)
- `push` — explicit sync (args: decision IDs, or no args for all)
- `post-brief` — fires when a summary brief is generated (arg: brief filename)

Each hook must be an executable file. See the spec for the full contract:
https://github.com/jnemargut/decision-kit/blob/main/SPEC.md#hooks
```

### 6c: Confirm

> "Hooks block configured in `decisions.json`. Hook scripts directory created at `.decisions/hooks/` — add your provider's scripts there. See the building-a-provider guide for details on the hook contract."

---

## IMPORTANT REMINDERS

1. **Never put secrets in decisions.json.** API keys, tokens, and passwords go in `.hook-env` only.
2. **Never skip the gitignore step.** Always ensure `.hook-env` is gitignored.
3. **Be conversational, not robotic.** This is "let's get you connected" not "please complete configuration form."
4. **Skip questions the user already answered.** If they said `/hook-init jira`, don't ask which provider.
5. **Idempotent.** Running `/hook-init` twice should update, not duplicate.
6. **The hooks block is minimal.** Only `project`, `defaultVisibility`, and `autoSync`. Provider-specific config goes in `.hook-env`.
7. **Make scripts executable.** Hook scripts must be `chmod +x` after copying.
8. **Offer the initial push.** If decisions exist, this is the natural "want to sync what you have?" moment.
9. **The `hooks` block in JSON is different from the `.decisions/hooks/` directory.** One is config, the other is executable scripts. Keep the distinction clear.
