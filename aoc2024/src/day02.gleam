import gleam/bool
import gleam/int
import gleam/list
import gleam/string

fn parse(input: String) {
  string.split(input, "\n")
  |> list.take_while(fn(x) { !string.is_empty(x) })
  |> list.map(string.split(_, " "))
}

fn predicate(windows: List(#(Int, Int))) {
  let assert Ok(#(f, s)) = list.first(windows)

  let tup_compare = fn(tup, greater) {
    let #(a, b) = tup
    let diff = int.absolute_value(a - b)
    let bounded = diff > 0 && diff <= 3

    case greater {
      True -> b > a && bounded
      False -> b < a && bounded
    }
  }

  case s > f {
    True -> tup_compare(_, True)
    False -> tup_compare(_, False)
  }
}

fn is_monotonic(ints: List(Int)) {
  let windows = list.window_by_2(ints)
  let pred = predicate(windows)
  list.map(windows, pred)
  |> list.fold(True, bool.and)
}

fn maybe_monotonic(ints: List(Int)) {
  use <- bool.guard(is_monotonic(ints), True)

  list.range(0, list.length(ints) - 1)
  |> list.map(fn(r_idx) {
    list.index_fold(ints, [], fn(acc, x, idx) {
      case r_idx == idx {
        True -> acc
        False -> [x, ..acc]
      }
    })
    |> list.reverse
    |> is_monotonic
  })
  |> list.any(fn(x) { x })
}

pub fn part01(input: String) {
  parse(input)
  |> list.map(fn(l) {
    list.map(l, fn(i) {
      let assert Ok(int) = int.parse(i)
      int
    })
    |> is_monotonic
  })
  |> list.count(fn(x) { x == True })
}

pub fn part02(input: String) {
  parse(input)
  |> list.map(fn(l) {
    list.map(l, fn(i) {
      let assert Ok(int) = int.parse(i)
      int
    })
    |> maybe_monotonic
  })
  |> list.count(fn(x) { x == True })
}
