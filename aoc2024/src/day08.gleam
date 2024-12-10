import gleam/bool
import gleam/dict
import gleam/list
import gleam/set
import gleam/string
import gleam/yielder

fn parse(input: String) {
  string.split(input, "\n")
  |> list.take_while(fn(x) { !string.is_empty(x) })
  |> list.map(string.split(_, ""))
}

fn get_antinodes(p1, p2) {
  let #(x1, y1) = p1
  let #(x2, y2) = p2

  [#(2 * x2 - x1, 2 * y2 - y1), #(2 * x1 - x2, 2 * y1 - y2)]
}

fn get_all_antinodes(p1, p2, in_bounds) {
  let #(x1, y1) = p1
  let #(x2, y2) = p2

  let right =
    yielder.unfold(2, fn(n) {
      let point = #(n * x2 - { n - 1 } * x1, n * y2 - { n - 1 } * y1)
      case in_bounds(point) {
        True -> yielder.Next(point, n + 1)
        False -> yielder.Done
      }
    })
    |> yielder.to_list

  let left =
    yielder.unfold(2, fn(n) {
      let point = #(n * x1 - { n - 1 } * x2, n * y1 - { n - 1 } * y2)
      case in_bounds(point) {
        True -> yielder.Next(point, n + 1)
        False -> yielder.Done
      }
    })
    |> yielder.to_list

  [p1, p2, ..list.append(right, left)]
}

fn get_dict(input) {
  let grid =
    input
    |> parse

  let dict =
    grid
    |> list.index_fold(dict.new(), fn(acc, a, y) {
      a
      |> list.index_fold(dict.new(), fn(acc, b, x) {
        use <- bool.guard(b == ".", acc)
        acc |> dict.insert(b, [#(x, y)])
      })
      |> dict.combine(acc, fn(one, other) { list.flatten([one, other]) })
    })

  #(grid, dict)
}

pub fn part1(input: String) {
  let #(grid, dict) = get_dict(input)

  let height = grid |> list.length

  let assert [x, ..] = grid
  let width = x |> list.length

  let in_bounds = fn(p1) {
    let #(x, y) = p1
    x >= 0 && x < width && y >= 0 && y < height
  }

  dict
  |> dict.fold(set.new(), fn(acc, _, val) {
    let nodes =
      val
      |> list.combination_pairs
      |> list.flat_map(fn(p) {
        let #(first, second) = p
        get_antinodes(first, second)
        |> list.filter(in_bounds)
      })
      |> list.fold(set.new(), set.insert)

    set.union(acc, nodes)
  })
  |> set.size
}

pub fn part2(input: String) {
  let #(grid, dict) = get_dict(input)

  let height = grid |> list.length

  let assert [x, ..] = grid
  let width = x |> list.length

  let in_bounds = fn(p1) {
    let #(x, y) = p1
    x >= 0 && x < width && y >= 0 && y < height
  }

  dict
  |> dict.fold(set.new(), fn(acc, _, val) {
    let nodes =
      val
      |> list.combination_pairs
      |> list.flat_map(fn(p) {
        let #(first, second) = p
        get_all_antinodes(first, second, in_bounds)
      })
      |> list.fold(set.new(), set.insert)

    set.union(acc, nodes)
  })
  |> set.size
}
