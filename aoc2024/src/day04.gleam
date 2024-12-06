import gleam/bool
import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gleam/string

const word = ["X", "M", "A", "S"]

fn search_word(
  dict: dict.Dict(#(Int, Int), String),
  row_idx: Int,
  col_idx: Int,
  direction: #(Int, Int),
) {
  let #(x, y) = direction

  list.index_map(word, fn(l, idx) {
    let r = row_idx + idx * x
    let c = col_idx + idx * y
    let key = #(r, c)
    case dict.get(dict, key) {
      Ok(letter) -> l == letter
      Error(_) -> False
    }
  })
  |> list.fold(True, bool.and)
}

pub fn part1(input: String) {
  let grid =
    input
    |> string.split("\n")
    |> list.map(string.split(_, ""))

  let assert Ok(#(_, directions)) =
    list.flat_map([-1, 0, 1], fn(x) { list.map([-1, 0, 1], fn(y) { #(x, y) }) })
    |> list.pop(fn(t) {
      let #(f, s) = t
      f == 0 && s == 0
    })

  let dictl =
    list.index_map(grid, fn(y, col) {
      list.index_map(y, fn(x, row) { #(#(row, col), x) })
    })
    |> list.flatten

  let dict = dict.from_list(dictl)

  list.map(dictl, fn(e) {
    let #(#(row, col), letter) = e
    case letter == "X" {
      True ->
        list.map(directions, fn(dir) { search_word(dict, row, col, dir) })
        |> list.count(fn(b) { b })
      False -> 0
    }
  })
  |> int.sum
}

pub fn part2(input: String) {
  let grid =
    input
    |> string.split("\n")
    |> list.map(string.split(_, ""))

  let dictl =
    list.index_map(grid, fn(y, col) {
      list.index_map(y, fn(x, row) { #(#(row, col), x) })
    })
    |> list.flatten

  let dict = dict.from_list(dictl)

  list.map(dictl, fn(e) {
    let #(curr, letter) = e
    let #(row, col) = curr

    case letter == "A" {
      True ->
        {
          let d1l = #(row - 1, col - 1)
          let d1r = #(row + 1, col + 1)
          use l1 <- result.try(dict.get(dict, d1l))
          use l2 <- result.try(dict.get(dict, curr))
          use l3 <- result.try(dict.get(dict, d1r))

          let w1 = l1 <> l2 <> l3

          let d2l = #(row - 1, col + 1)
          let d2r = #(row + 1, col - 1)

          use r1 <- result.try(dict.get(dict, d2l))
          use r3 <- result.try(dict.get(dict, d2r))

          let w2 = r1 <> l2 <> r3
          [
            w1 == "MAS" && w2 == "MAS",
            w1 == "SAM" && w2 == "MAS",
            w1 == "SAM" && w2 == "SAM",
            w1 == "MAS" && w2 == "SAM",
          ]
          |> list.count(fn(b) { b })
          |> Ok
        }
        |> result.unwrap(0)
      False -> 0
    }
  })
  |> int.sum
}
