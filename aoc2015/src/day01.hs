module Day01 where
import Data.List (foldl')

match :: Char -> Int
match c =
  case c of
    '(' -> 1
    ')' -> -1

part1 :: String -> Int
part1 =
  sum . map match

basement :: Int -> Int -> [Int] -> Int
basement (-1) i _ = i
basement acc i (x : xs) = basement (acc + x) (i + 1) xs

part2 :: String -> Int
part2 =
  basement 0 0 . map match

main :: IO ()
main = do
  input <- readFile "./inputs/day01.txt"
  -- print $ part1 input
  print $ part2 input
