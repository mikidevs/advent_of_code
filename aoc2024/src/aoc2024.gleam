import day01
import day02
import day03
import day04
import day05
import day06
import day07
import day08
import gleam/io
import gleam/string
import simplifile

pub fn main() {
  let file_path = "./inputs/day08.txt"
  let assert Ok(content) = simplifile.read(file_path)
  // day01.part1(content) |> io.debug
  // day01.part2(content) |> io.debug
  // day02.part1(content) |> io.debug
  // day02.part2(content) |> io.debug
  // day03.part1(content) |> io.debug
  // day03.part2(content) |> io.debug
  // day04.part1(content) |> io.debug
  // day04.part2(content) |> io.debug
  // day05.part2(content) |> io.debug
  // day06.part1(content) |> io.debug
  // day07.part1(content) |> io.debug
  // day07.part2(content) |> io.debug
  day08.part2(content) |> io.debug
}
