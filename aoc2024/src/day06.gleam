import gleam/bool
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/string

fn update_map(grid_dict) {
  grid_dict
  |> dict.fold(dict.new(), fn(acc, key, value) {
    let #(y, x) = key
    case value {
      "^" -> {
        let above_coord = #(y - 1, x)
        let above = dict.get(grid_dict, above_coord)

        case above {
          Ok(c_above) ->
            case c_above == "#" {
              True -> acc |> dict.insert(key, ">")
              False ->
                acc |> dict.insert(above_coord, "^") |> dict.insert(key, "X")
            }
          Error(_) -> acc |> dict.insert(key, "X")
        }
      }
      ">" -> {
        let right_coord = #(y, x + 1)
        let right = dict.get(grid_dict, right_coord)

        case right {
          Ok(c_right) ->
            case c_right == "#" {
              True -> acc |> dict.insert(key, "v")
              False ->
                acc |> dict.insert(right_coord, ">") |> dict.insert(key, "X")
            }
          Error(_) -> acc |> dict.insert(key, "X")
        }
      }
      "v" -> {
        let down_coord = #(y + 1, x)
        let down = dict.get(grid_dict, down_coord)

        case down {
          Ok(c_down) ->
            case c_down == "#" {
              True -> acc |> dict.insert(key, "<")
              False ->
                acc |> dict.insert(down_coord, "v") |> dict.insert(key, "X")
            }
          Error(_) -> acc |> dict.insert(key, "X")
        }
      }
      "<" -> {
        let left_coord = #(y, x - 1)
        let left = dict.get(grid_dict, left_coord)

        case left {
          Ok(c_left) ->
            case c_left == "#" {
              True -> acc |> dict.insert(key, "^")
              False ->
                acc |> dict.insert(left_coord, "<") |> dict.insert(key, "X")
            }
          Error(_) -> acc |> dict.insert(key, "X")
        }
      }
      _ ->
        case dict.has_key(acc, key) {
          True -> acc
          False -> acc |> dict.insert(key, value)
        }
    }
  })
}

fn completed(grid_dict) {
  grid_dict
  |> dict.values
  |> list.any(fn(x) { x == "^" || x == ">" || x == "v" || x == "<" })
  |> bool.negate
}

fn run_iters(grid_dict) {
  case completed(grid_dict) {
    True -> grid_dict
    False -> run_iters(update_map(grid_dict))
  }
}

fn display_grid(grid_dict) {
  grid_dict
  |> dict.to_list
  |> list.sort(fn(f, s) {
    let #(#(x1, y1), _) = f
    let #(#(x2, y2), _) = s
    case int.compare(x1, x2) {
      order.Eq -> int.compare(y1, y2)
      other -> other
    }
  })
  |> list.map(fn(x) {
    let #(#(_, y), s) = x
    case y == 129 {
      True -> s <> "\n"
      False -> s
    }
  })
  |> string.concat
  |> io.println

  grid_dict
}

pub fn part1(input) {
  let grid =
    input
    |> string.split("\n")
    |> list.map(string.split(_, ""))

  let grid_dict =
    grid
    |> list.index_map(fn(x, i) {
      x
      |> list.index_map(fn(y, j) { #(#(i, j), y) })
    })
    |> list.flatten
    |> dict.from_list

  run_iters(grid_dict)
  |> dict.values
  |> list.count(fn(l) { l == "X" })
}
