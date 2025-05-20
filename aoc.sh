#!/usr/bin/env bash

AOC_SESSION_COOKIE="53616c7465645f5f2ea166131175a4f6ed1de6ad4d5b314bae9b06d20ea7eb6cef73fd416b420a327223cfbe9d287ac52f0b69d3e0d2dbf1134546e531efd52b"
YEAR="${1}"
DAY="${2}"

DAY_NO_ZEROS="$(echo $DAY | sed 's/^0*//')"
PUZZLE_URL="https://adventofcode.com/${YEAR}/day/${DAY_NO_ZEROS}/input"
PUZZLE_FILE="aoc${YEAR}/inputs/day${DAY}.txt"
SRC="aoc${YEAR}/src/day${DAY}.hs"

curl "${PUZZLE_URL}" -H "cookie: session=${AOC_SESSION_COOKIE}" -o "${PUZZLE_FILE}"

mkdir -p "$(dirname "$SRC")"

cat > "$SRC" <<EOF
module Day${DAY} where

parse s =
  error "Parser not implemented"

part1 i =
  error "Part 1 not implemented"

part2 i =
  error "Part 2 not implemented"

main :: IO ()
main = do
  input <- readFile "./inputs/day${DAY}.txt"
  print $ part1 $ parse input
  -- print $ part2 $ parse input
EOF