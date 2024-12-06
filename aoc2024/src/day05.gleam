import gleam/bool
import gleam/dict
import gleam/io
import gleam/list
import gleam/set
import gleam/string

pub fn part1() {
  let input =
    "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"
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
      |> set.from_list
    })
    |> io.debug

  pages
  |> list.drop(1)
  |> list.take_while(fn(s) { s != "" })
  |> list.map(fn(i) {
    let sp = string.split(i, ",")
    let parts =
      sp
      |> list.map(fn(j) { list.split_while(sp, fn(x) { x != j }) })
      |> list.map(fn(p) {
        let #(first, second) = p
        use <- bool.guard(list.is_empty(first), True)
      })
  })
}
