import gleam/bool
import gleam/dict
import gleam/int
import gleam/list
import gleam/order
import gleam/string

fn sublist_of(subset: List(a), l1) {
  subset
  |> list.map(fn(x) { list.contains(l1, x) })
  |> list.fold(True, bool.and)
}

fn solve(input: String) {
  let #(rule_str, pages) =
    input
    |> string.split("\n")
    |> list.split_while(fn(x) { x != "" })

  let rules =
    rule_str
    |> list.group(fn(x) {
      let assert [first, _] = string.split(x, "|")
      first
    })
    |> dict.map_values(fn(_, v) {
      v
      |> list.map(fn(x) {
        let assert [_, second] = string.split(x, "|")
        second
      })
    })

  let splits =
    pages
    |> list.drop(1)
    |> list.take_while(fn(s) { s != "" })
    |> list.map(string.split(_, ","))

  let bools =
    splits
    |> list.map(fn(sp) {
      sp
      |> list.map(fn(j) { list.drop_while(sp, fn(x) { x != j }) })
      |> list.map(fn(l) {
        case l {
          [_] -> True
          [x, ..xs] -> {
            case dict.get(rules, x) {
              Ok(val) -> xs |> sublist_of(val)
              Error(_) -> False
            }
          }
          [] -> False
        }
      })
      |> list.fold(True, bool.and)
    })

  #(rules, splits, bools)
}

pub fn part1(input: String) {
  let #(_, splits, bools) = solve(input)

  list.map2(splits, bools, fn(s, b) {
    use <- bool.guard(!b, 0)
    list.index_fold(s, 0, fn(acc, e, i) {
      case i == { list.length(s) / 2 } {
        True -> {
          let assert Ok(int) = int.parse(e)
          acc + int
        }
        False -> acc
      }
    })
  })
  |> int.sum
}

pub fn part2(input: String) {
  let #(rules, splits, bools) = solve(input)

  list.map2(splits, bools, fn(s, b) {
    use <- bool.guard(b, 0)
    list.sort(s, fn(f, s) {
      case dict.get(rules, f) {
        Ok(values) ->
          case [s] |> sublist_of(values) {
            True -> order.Lt
            False -> order.Gt
          }
        Error(_) -> order.Gt
      }
    })
    |> list.index_fold(0, fn(acc, e, i) {
      case i == { list.length(s) / 2 } {
        True -> {
          let assert Ok(int) = int.parse(e)
          acc + int
        }
        False -> acc
      }
    })
  })
  |> int.sum
}
