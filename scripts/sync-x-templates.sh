#!/usr/bin/env bash
# Sync shared/x-templates/ into each X-skill's references/ folder.
#
# shared/x-templates/ is the single source of truth for the templates the
# X tier shares (decision-page HTML/CSS incl. the V2 ADDITIONS section, and
# the interactive playbook template). Skills ship self-contained (installed
# copies must work standalone), so the templates are copied in rather than
# referenced across directories. Edit the files in shared/x-templates/ only,
# then run this script. CI / pre-PR: run with --check to verify nothing drifted.
set -euo pipefail

cd "$(dirname "$0")/.."

MODE="${1:-sync}"
status=0

# "source-file → target-path" pairs (target filename may differ per skill)
PAIRS=(
  "shared/x-templates/decision-page-templates.md|thinking/x-product-design/references/templates.md"
  "shared/x-templates/decision-page-templates.md|thinking/x-strategize/references/templates.md"
  "shared/x-templates/decision-page-templates.md|thinking/x-shape/references/templates.md"
  "shared/x-templates/decision-page-templates.md|thinking/x-product-strategy/references/page-templates.md"
  "shared/x-templates/playbook-template.md|action/x-product-plan/references/playbook-template.md"
  "shared/x-templates/playbook-template.md|action/x-game-plan/references/playbook-template.md"
)

for pair in "${PAIRS[@]}"; do
  src="${pair%%|*}"
  target="${pair##*|}"
  mkdir -p "$(dirname "$target")"
  if [[ "$MODE" == "--check" ]]; then
    if ! diff -q "$src" "$target" >/dev/null 2>&1; then
      echo "DRIFT: $target differs from $src (run scripts/sync-x-templates.sh)"
      status=1
    fi
  else
    cp "$src" "$target"
    echo "synced $target"
  fi
done

if [[ "$MODE" == "--check" && $status -eq 0 ]]; then
  echo "x-templates in sync"
fi
exit $status
