{-# LANGUAGE LambdaCase #-}
module Day03 where
import qualified Data.Map as M
import qualified Data.Set as S

type Coord = (Int, Int)
data Direction = L | U | D | R
type CoordMap = M.Map Int (S.Set Int)

shift :: Direction -> Coord -> Coord
shift d (x, y) =
  case d of
    L -> (x - 1, y)
    U -> (x, y + 1)
    D -> (x, y - 1)
    R -> (x + 1, y)

flatCount :: CoordMap -> Int
flatCount = sum . M.map S.size 

parse :: String -> [Direction]
parse =
  map (\case
        '>' -> L
        '^' -> U
        'v' -> D
        '<' -> R)

part1 :: [Direction] -> Int
part1 ds = flatCount $ part1' (0, 0) ds (M.fromList [(0, S.singleton 0)])

part1' :: Coord -> [Direction] -> CoordMap -> CoordMap
part1' _ [] coordMap = coordMap
part1' c (dir : xs) coordMap =
  let shifted@(x, y) = shift dir c in
    part1' shifted xs (M.insertWith S.union x (S.singleton y) coordMap)

part2 i =
  error "Part 2 not implemented"

main :: IO ()
main = do
  input <- readFile "./inputs/day03.txt"
  print $ part1 $ parse input
  -- print $ part1 $ parse ">v<<^>vv"
