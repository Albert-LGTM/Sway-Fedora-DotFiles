#!/usr/bin/env bash
set -euo pipefail

if ! command -v dnf >/dev/null 2>&1; then
    echo '{"text":"n/a","tooltip":"dnf not found","class":"warn"}'
    exit 0
fi

count=$(dnf check-update -q 2>/dev/null | awk 'NF == 3 && $1 !~ /^(Last|Obsoleting|Security:)/ {c++} END {print c+0}')

if [[ "$count" -eq 0 ]]; then
    echo '{"text":"0","tooltip":"System up to date","class":"ok"}'
else
    echo "{\"text\":\"$count\",\"tooltip\":\"$count package updates available\",\"class\":\"warn\"}"
fi
