#!/usr/bin/env bash

YEAR="${1}"
DAY="${2}"
DAY_NO_ZEROS="$(echo $DAY | sed 's/^0*//')"
AOC_SESSION_COOKIE="53616c7465645f5f3d93a730353cf6638a8b35b7ea5ca9aeac478e7c6c0d3f799acf91e95b80b1383d075de379182f0834df333319a72d5e41b5d5949da94d09"
OUTPUT="src/Year${YEAR}/Day${DAY}.elm"
PUZZLE_URL="https://adventofcode.com/${YEAR}/day/${DAY_NO_ZEROS}/input"
PUZZLE_FILE="src/year${YEAR}/inputs/input${YEAR}${DAY}.txt"

curl "${PUZZLE_URL}" -H "cookie: session=${AOC_SESSION_COOKIE}" -o "${PUZZLE_FILE}"
