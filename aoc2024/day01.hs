import qualified Data.List as L
import qualified Data.Map as M
import Data.Function ((&))
import Data.Bifunctor (Bifunctor(bimap))
import Data.Maybe (fromMaybe)

parse :: String -> ([Int], [Int])
parse s =
  let strToInt = map (read :: String -> Int)
      [x, y] =
        s
        & lines
        & map words
        & L.transpose
        & map strToInt
  in (x, y)

part1 :: ([Int], [Int]) -> Int
part1 =
  let diff (x, y) = abs (x - y) in
  sum . map diff . uncurry L.zip . bimap L.sort L.sort

frequencies :: [Int] -> M.Map Int Int
frequencies = L.foldl' insert M.empty
  where insert acc x = M.insertWith (+) x 1 acc

get :: Int -> M.Map Int Int -> Int
get k m = fromMaybe 0 (M.lookup k m)

part2 :: ([Int], [Int]) -> Int
part2 p =
  let (x, y) = p
      m = frequencies y in
  sum $ map (\e -> e * get e m) x

main :: IO ()
main = do
  input <- readFile "./inputs/day01.txt"
  let parsed = parse input
  -- print $ part1 parsed
  print $ part2 parsed