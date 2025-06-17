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

part2 :: [Direction] -> Int
part2 ds = flatCount $ part2' (0, 0) (0, 0) ds (M.fromList [(0, S.singleton 0)])

part2' :: Coord -> Coord -> [Direction] -> CoordMap -> CoordMap
part2' _ _ [] coordMap = coordMap
part2' c1 c2 (dir1 : dir2: xs) coordMap =
  let shifted1@(x1,y1) = shift dir1 c1
      shifted2@(x2,y2) = shift dir2 c2
      ins x y = M.insertWith S.union x (S.singleton y) in
        part2' shifted1 shifted2 xs (ins x2 y2 (ins x1 y1 coordMap))

main :: IO ()
main = do
  input <- readFile "./inputs/day03.txt"
  -- print $ part1 $ parse input
  print $ part2 $ parse input
