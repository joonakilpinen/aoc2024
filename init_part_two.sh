#!/usr/bin/env bash

set -e

get_assignment() {
  curl --cookie "$(< .cookie)" "https://adventofcode.com/2024/day/${1}" |
  lynx -dump -nolist -stdin |
  sed "0,/--- Part Two/d"
}

assignment=$(get_assignment "$1")
assignment_comment=$(echo "${assignment}" | sed 's|^|// |')

cat <<EOF > "aoc2024/templates/_day${1}part2.tpl"
{{/*
${assignment_comment}
*/}}
{{- define "aoc2024.day${1}part2" -}}

{{- end }}
EOF

echo "${assignment}"
read -p "Expected test result? "

cat <<EOF >> "aoc2024/tests/day${1}part2_test.yaml"
---
templates:
  - "configmap.yaml"
tests:
  - it: Day ${1} part 2 solution should be ${REPLY}
    documentSelector:
      path: metadata.name
      value: aoc-results
    asserts:
      - equal:
          path: data.day${1}-test-part2
          value: ${REPLY}
EOF