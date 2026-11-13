#!/usr/bin/env bash
# Rewrites the "uptime:" line in README.md with the exact age since BIRTH.
set -euo pipefail

BIRTH="${BIRTH_DATE:?set BIRTH_DATE (YYYY-MM-DD)}"   # comes from a repo variable, not hardcoded
TODAY="${TODAY:-$(date -u +%F)}"         # TODAY can be overridden for testing
README="${README:-README.md}"

IFS=- read -r by bm bd <<<"$BIRTH"
IFS=- read -r ty tm td <<<"$TODAY"
by=$((10#$by)); bm=$((10#$bm)); bd=$((10#$bd))
ty=$((10#$ty)); tm=$((10#$tm)); td=$((10#$td))

years=$((ty - by))
months=$((tm - bm))
days=$((td - bd))

if (( days < 0 )); then
  # borrow the length of the month before today's month
  pm=$((tm - 1)); py=$ty
  if (( pm == 0 )); then pm=12; py=$((ty - 1)); fi
  first="$py-$(printf '%02d' "$pm")-01"
  mdays=$(date -u -d "$first +1 month -1 day" +%d)
  days=$((days + 10#$mdays))
  months=$((months - 1))
fi
if (( months < 0 )); then
  months=$((months + 12))
  years=$((years - 1))
fi

plural() { (( $1 == 1 )) && echo "$1 $2" || echo "$1 ${2}s"; }

line="uptime: $(plural "$years" year), $(plural "$months" month) and $(plural "$days" day)"
sed -i "s/^uptime: .*/$line/" "$README"
echo "$line"
