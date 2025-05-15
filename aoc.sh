#!/usr/bin/env bash

AOC_SESSION_COOKIE="53616c7465645f5f09fcb32ec169da17b918747cf2cb60477ef182b42e2a28cdebe652e712860025daea33903e0ab526d1fd82cdceae60b444ae24775c9e077d"
YEAR="${1}"
DAY="${2}"

DAY_NO_ZEROS="$(echo $DAY | sed 's/^0*//')"
PUZZLE_URL="https://adventofcode.com/${YEAR}/day/${DAY_NO_ZEROS}/input"
PUZZLE_FILE="aoc${YEAR}/inputs/day${DAY}.txt"
SRC="aoc${YEAR}/src/day${DAY}.hs"

curl "${PUZZLE_URL}" -H "cookie: session=${AOC_SESSION_COOKIE}" -o "${PUZZLE_FILE}"
touch "${SRC}"