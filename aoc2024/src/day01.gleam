import gleam/int
import gleam/io
import gleam/list
import gleam/string

fn parse(input: String) {
  string.split(input, "\n")
  |> list.take_while(fn(x) { !string.is_empty(x) })
  |> list.map(string.split(_, "   "))
  |> list.transpose
  |> list.map(fn(l) {
    list.map(l, fn(i) {
      let assert Ok(int) = int.parse(i)
      int
    })
  })
}

pub fn part01(input: String) {
  let assert [f, s] =
    parse(input)
    |> list.map(list.sort(_, int.compare))

  list.map2(f, s, fn(f, s) { int.absolute_value(f - s) })
  |> int.sum
}

pub fn part02(input: String) {
  let assert [f, s] = parse(input)
  list.map(f, fn(a) { a * list.count(s, fn(b) { a == b }) })
  |> int.sum
}
