import day01
import gleam/io
import simplifile

pub fn main() {
  let file_path = "./inputs/day01.txt"
  let assert Ok(content) = simplifile.read(file_path)
  // day01.part01(content) |> io.debug
  day01.part02(content) |> io.debug
}
