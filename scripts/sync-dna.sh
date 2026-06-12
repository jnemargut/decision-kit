#!/usr/bin/env bash
# Sync shared/design-dna/ into each design skill's references/ folder.
#
# shared/design-dna/ is the single source of truth. Skills ship self-contained
# (installed copies must work standalone), so the DNA is copied in rather than
# referenced across directories. Edit the files in shared/design-dna/ only,
# then run this script. CI / pre-PR: run with --check to verify nothing drifted.
set -euo pipefail

cd "$(dirname "$0")/.."

SRC="shared/design-dna"
TARGETS=(
  "thinking/visual-design/references"
  "thinking/design-system/references"
)

MODE="${1:-sync}"

status=0
for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  for file in "$SRC"/*.md; do
    name="$(basename "$file")"
    if [[ "$MODE" == "--check" ]]; then
      if ! diff -q "$file" "$target/$name" >/dev/null 2>&1; then
        echo "DRIFT: $target/$name differs from $file (run scripts/sync-dna.sh)"
        status=1
      fi
    else
      cp "$file" "$target/$name"
      echo "synced $target/$name"
    fi
  done
done

if [[ "$MODE" == "--check" && $status -eq 0 ]]; then
  echo "design-dna in sync"
fi
exit $status
