#!/usr/bin/env bash

set -e

get_assignment() {
  curl --cookie "$(< .cookie)" "https://adventofcode.com/2024/day/${1}" |
  lynx -dump -nolist -stdin |
  sed "0,/--- Day ${1}/d"
}

assignment=$(get_assignment "$1")
assignment_comment=$(echo "${assignment}" | sed 's|^|// |')

curl --cookie "$(< .cookie)" "https://adventofcode.com/2024/day/${1}/input" > "aoc2024/inputs/day${1}"

cat <<EOF > "aoc2024/templates/_day${1}part1.tpl"
{{/*
${assignment_comment}
*/}}
{{- define "aoc2024.day${1}part1" -}}

{{- end }}
EOF

cat <<EOF > "aoc2024/templates/_day${1}part2.tpl"
{{/* Placeholder needed until part 2 is initialized */}}
{{- define "aoc2024.day${1}part2" -}}

{{- end }}
EOF

echo "${assignment}"
echo "Paste test input and press Ctrl+D"
mapfile input

for line in "${input[@]}"; do
  printf "%s" "$line"
done > "aoc2024/inputs/day${1}-test"

read -p "Expected test result? "

cat <<EOF >> "aoc2024/tests/day${1}part1_test.yaml"
---
templates:
  - "configmap.yaml"
tests:
  - it: Day ${1} part 1 solution should be ${REPLY}
    documentSelector:
      path: metadata.name
      value: aoc-results
    asserts:
      - equal:
          path: data.day${1}-test-part1
          value: ${REPLY}
EOF