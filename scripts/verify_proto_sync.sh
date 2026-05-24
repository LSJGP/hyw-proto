#!/usr/bin/env bash
# Compare hyw-proto .proto files against a reference tree (e.g. original monorepo).
# Exit 0 only if every file is byte-identical.
set -euo pipefail

PROTO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REF_ROOT="${1:-}"

if [[ -z "$REF_ROOT" ]]; then
  echo "usage: $0 <reference_repo_root>" >&2
  echo "  e.g. $0 /path/to/hyw_grading" >&2
  exit 2
fi

REF_ROOT="$(cd "$REF_ROOT" && pwd)"
fail=0

check_pair() {
  local a="$1" b="$2"
  if [[ ! -f "$a" ]]; then
    echo "[FAIL] missing: $a" >&2
    fail=1
    return
  fi
  if [[ ! -f "$b" ]]; then
    echo "[FAIL] missing reference: $b" >&2
    fail=1
    return
  fi
  if ! cmp -s "$a" "$b"; then
    echo "[FAIL] differs: $a" >&2
    echo "       vs      $b" >&2
    fail=1
    return
  fi
  echo "[OK]   $(realpath --relative-to="$PROTO_ROOT" "$a")"
}

while IFS= read -r -d '' f; do
  rel="${f#"$PROTO_ROOT"/}"
  case "$rel" in
    proto/sim/*)
      check_pair "$f" "$REF_ROOT/sim/$rel"
      ;;
    proto/grading/*)
      check_pair "$f" "$REF_ROOT/grading_mini/$rel"
      ;;
  esac
done < <(find "$PROTO_ROOT/proto" -name '*.proto' -print0)

if [[ "$fail" -ne 0 ]]; then
  echo "proto verification FAILED" >&2
  exit 1
fi
echo "proto verification PASSED ($(find "$PROTO_ROOT/proto" -name '*.proto' | wc -l) files)"
