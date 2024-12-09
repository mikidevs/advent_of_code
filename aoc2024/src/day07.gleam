import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn c_product(lists) {
  list.fold(lists, [list.new()], fn(acc, curr) {
    list.flat_map(acc, fn(a) { list.map(curr, fn(b) { [b, ..a] }) })
  })
}

fn apply_funcs(nums: List(Int), ops: List(fn(Int, Int) -> Int)) {
  case nums, ops {
    [i], [] -> i
    [x, y], [op] -> apply_funcs([op(x, y)], [])
    [x, y, ..xs], [op, ..ops] -> apply_funcs([op(x, y), ..xs], ops)
    _, _ -> 0
  }
}

fn solve(input: String, ops) {
  input
  |> string.split("\n")
  |> list.map(string.split(_, ": "))
  |> list.take_while(fn(l) { list.length(l) > 1 })
  |> list.map(fn(l) {
    let assert [sum, nums] = l
    let assert Ok(sum) = int.parse(sum)
    let nums =
      nums
      |> string.split(" ")
      |> list.map(fn(n) {
        let assert Ok(num) = int.parse(n)
        num
      })

    c_product(list.repeat(ops, list.length(nums) - 1))
    |> list.map(apply_funcs(nums, _))
    |> list.find(fn(n) { n == sum })
  })
  |> list.map(result.unwrap(_, 0))
  |> int.sum
}

pub fn part1(input: String) {
  let ops = [int.add, int.multiply]
  solve(input, ops)
}

pub fn part2(input: String) {
  let int_concat = fn(x, y) {
    let assert Ok(i) =
      { int.to_string(x) <> int.to_string(y) }
      |> int.parse
    i
  }

  let ops = [int.add, int.multiply, int_concat]
  solve(input, ops)
}
