# Advent of code 2024

## Prerequisites
- helm
- [helm unittest plugin](https://github.com/helm-unittest/helm-unittest)
- curl
- lynx

## Instructions

Initialize parts with `./init_part(one/two).sh ${daynumber}`

Run `helm template aoc2024` to output a ConfigMap with calculated results.
Run `helm unittest aoc2024` to test if the test inputs produce correct outputs.
