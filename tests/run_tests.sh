#!/bin/sh
# M4CR41N test runner. Runs every tests/test_*.nvs with the nvs runtime.
# Usage: ./tests/run_tests.sh [path-to-nvs]
set -u
NVS="${1:-nvs}"
if ! command -v "$NVS" >/dev/null 2>&1 && [ ! -x "$NVS" ]; then
  echo "nvs runtime not found: $NVS" >&2
  echo "hint: build from ~/workspace/nvs-lang (go build ./cmd/nvs) or pass the binary path" >&2
  exit 2
fi
cd "$(dirname "$0")"
pass=0; fail=0; failed=""
for t in test_*.nvs; do
  if "$NVS" run "$t" >/tmp/m4cr41n-test.log 2>&1; then
    echo "PASS $t"
    pass=$((pass+1))
  else
    echo "FAIL $t"
    head -5 /tmp/m4cr41n-test.log | sed 's/^/    /'
    fail=$((fail+1)); failed="$failed $t"
  fi
done
echo "----"
echo "passed: $pass  failed: $fail"
[ "$fail" -eq 0 ]
