import day01
import day02
import day03
import gleam/io
import simplifile

pub fn main() {
  let file_path = "./inputs/day03.txt"
  let assert Ok(content) = simplifile.read(file_path)
  // day01.part01(content) |> io.debug
  // day01.part02(content) |> io.debug
  // day02.part01(content) |> io.debug
  // day02.part02(content) |> io.debug
  // day03.part01(content) |> io.debug
  day03.part02(content) |> io.debug
}
