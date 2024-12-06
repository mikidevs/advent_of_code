import gleam/int
import gleam/list
import gleam/regexp
import gleam/string

pub fn part1(input: String) {
  let assert Ok(re) = regexp.from_string("mul\\(\\d{1,3},\\d{1,3}\\)")
  regexp.scan(re, input)
  |> list.map(fn(x) {
    let assert regexp.Match(str, []) = x
    let assert "mul(" <> first = str

    let assert Ok(#(f, s)) =
      first
      |> string.drop_end(1)
      |> string.split_once(",")

    let assert Ok(fi) = int.parse(f)
    let assert Ok(si) = int.parse(s)

    fi * si
  })
  |> int.sum
}

pub fn part2(input: String) {
  let assert Ok(re) =
    regexp.from_string("don't|do|(mul\\(\\d{1,3},\\d{1,3}\\))")

  let tup =
    regexp.scan(re, input)
    |> list.map(fn(x) {
      let regexp.Match(str, _) = x
      str
    })
    |> list.fold(#(0, True), fn(acc, i) {
      case i {
        "do" -> {
          let #(f, _) = acc
          #(f, True)
        }
        "don't" -> {
          let #(f, _) = acc
          #(f, False)
        }
        _ -> {
          let #(f, s) = acc
          case s {
            True -> #(f + part1(i), s)
            False -> #(f, s)
          }
        }
      }
    })

  let #(f, _) = tup
  f
}
