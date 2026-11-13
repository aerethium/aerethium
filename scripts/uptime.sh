#!/usr/bin/env bash
# Rewrites the "uptime:" line in README.md with your exact age:
# years, months, days, hours, minutes and seconds since BIRTH_DATE (UTC).
set -euo pipefail

# BIRTH_DATE: "YYYY-MM-DD" or "YYYY-MM-DD HH:MM:SS" (time defaults to 00:00:00)
BIRTH="${BIRTH_DATE:?set BIRTH_DATE (YYYY-MM-DD)}"
NOW="${NOW:-$(date -u '+%F %T')}"          # NOW can be overridden for testing
README="${README:-README.md}"

parts() {                                   # "YYYY-MM-DD [HH:MM:SS]" -> 6 numbers
  local d t
  read -r d t <<<"$1"
  t="${t:-00:00:00}"
  IFS='-: ' read -r Y M D h m s <<<"$d $t"
  echo "$((10#$Y)) $((10#$M)) $((10#$D)) $((10#$h)) $((10#$m)) $((10#$s))"
}

read -r by bm bd bh bi bs <<<"$(parts "$BIRTH")"
read -r ty tm td th ti ts <<<"$(parts "$NOW")"

y=$((ty - by)); mo=$((tm - bm)); d=$((td - bd))
h=$((th - bh)); mi=$((ti - bi)); s=$((ts - bs))

if (( s  < 0 )); then s=$((s + 60));  mi=$((mi - 1)); fi
if (( mi < 0 )); then mi=$((mi + 60)); h=$((h - 1));  fi
if (( h  < 0 )); then h=$((h + 24));  d=$((d - 1));   fi
if (( d  < 0 )); then
  pm=$((tm - 1)); py=$ty
  if (( pm == 0 )); then pm=12; py=$((ty - 1)); fi
  first="$py-$(printf '%02d' "$pm")-01"
  d=$((d + 10#$(date -u -d "$first +1 month -1 day" +%d)))
  mo=$((mo - 1))
fi
if (( mo < 0 )); then mo=$((mo + 12)); y=$((y - 1)); fi

plural() { (( $1 == 1 )) && echo "$1 $2" || echo "$1 ${2}s"; }

line="uptime: $(plural "$y" year), $(plural "$mo" month), $(plural "$d" day), $(plural "$h" hour), $(plural "$mi" minute) and $(plural "$s" second)"
sed -i "s/^uptime: .*/$line/" "$README"
echo "$line"
