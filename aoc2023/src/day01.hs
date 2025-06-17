module Day01 where
import qualified Data.List as L
import qualified Data.Text as T
import Data.Char (isAlpha)
import Data.Bifunctor (bimap)

-- part1 :: String -> String
-- part1 s = fmap L.singleton (L.find isAlpha s)

part1 :: [String] -> Int
part1 = sum . map (read . part1')

part1' :: String -> String
part1' s = takeFirstChar s ++ takeFirstChar (reverse s)
  where takeFirstChar = L.take 1 . L.dropWhile isAlpha

digits :: [(T.Text, T.Text)]
digits = map (bimap T.pack T.pack) [
  ("one", "1"),
  ("two", "2"),
  ("three", "3"),
  ("four", "4"),
  ("five", "5"),
  ("six", "6"),
  ("seven", "7"),
  ("eight", "8"),
  ("nine", "9")]

-- part2 :: [String] -> Int
-- part2 =
--   sum . L.map (read . T.unpack . part2' digits . T.pack)

part2 =
  part1 . L.map (T.unpack . part2' digits . T.pack)

part2' :: [(T.Text, T.Text)] -> T.Text -> T.Text
part2' [] s = s
part2' ((expr, n) : xs) s =
  part2' xs (T.replace expr repr s)
  where repr = T.concat [T.take 1 expr, n, T.takeEnd 1 expr]

main :: IO ()
main = do
  input <- readFile "./inputs/day01.txt"
  -- let input = "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen"
  -- print $ part1 $ lines input
  print $ part2 $ lines input
