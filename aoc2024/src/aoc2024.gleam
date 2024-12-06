import day01
import day02
import day03
import day04
import day05
import day06
import gleam/io
import simplifile

pub fn main() {
  let file_path = "./inputs/day06.txt"
  let assert Ok(content) = simplifile.read(file_path)
  // day01.part1(content) |> io.debug
  // day01.part2(content) |> io.debug
  // day02.part1(content) |> io.debug
  // day02.part2(content) |> io.debug
  // day03.part1(content) |> io.debug
  // day03.part2(content) |> io.debug
  // day04.part1(content) |> io.debug
  // day04.part2(content) |> io.debug
  // day05.part1() |> io.debug
  day06.part1(content) |> io.debug
}
