import qualified Data.List as L
import qualified Data.Map as M
import Data.Function ((&))
import Data.List (foldl')

parse :: String -> [[Int]]
parse s =
  map (strToInt . words) (lines s)
  where
    strToInt = map (read :: String -> Int)

isBounded :: Int -> Int -> Bool
isBounded x y = abs (x - y) < 4

isMonoBounded :: [Int] -> Bool
isMonoBounded s@(x : y : _) = 
  foldl' (&&) True $ map (\(x, y) -> x `op` y && isBounded x y) windows
  where
    op = if x > y then (>) else (<)
    windows = L.zip (L.init s) (L.tail s)

-- windows:
-- s = [1, 2, 3, 4]
-- tail s = [2, 3, 4]
-- init s = [1, 2, 3]
-- zip => [(1,2), (2,3), (3,4)]

part1 :: [[Int]] -> Int
part1 = length . filter isMonoBounded

part2 :: [[Int]] -> Int
part2 =
  length . filter id . map anyMono
  -- map anyMono
  where
    spread xs = [take i xs ++ drop (i + 1) xs | i <- [0 .. length xs - 1]]
    anyMono x = any isMonoBounded (spread x)

main :: IO ()
main = do
  input <- readFile "./inputs/day02.txt"
  let parsed = parse input
  print $ part2 parsed