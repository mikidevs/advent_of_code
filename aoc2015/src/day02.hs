module Day02 where
import qualified Data.Text as T
import           Data.Text (Text)
import Data.Function ((&))
import Data.List (sort)

newtype Measurement = Measurement [Int]

fromList' :: [Text] -> Measurement
fromList' = Measurement . map (read . T.unpack)

toList' :: Measurement -> [Int]
toList' (Measurement [l, w, h]) = [l, w, h]

areas :: Measurement -> [Int]
areas (Measurement [l, w, h]) = [l * w, w * h, h * l]
areas _ = error "found more than 3 measurements"

volume :: Measurement -> Int
volume = product . toList'

parse :: Text -> [Measurement]
parse = map (fromList' . T.split (=='x')) . T.lines

-- Surface area + minum area
part1' :: Measurement -> Int
part1' ms =
  sum (map (*2) as) + minimum as
  where as = areas ms

part1 :: [Measurement] -> Int
part1 = sum . map part1'

part2' :: Measurement -> Int
part2' ms =
  sum (map (*2) smallest) + volume ms
  where smallest = (take 2 . sort . toList') ms

part2 :: [Measurement] -> Int
part2 = sum . map part2'

main :: IO ()
main = do
  input <- readFile "./inputs/day02.txt"
  -- print $ part1 $ parse $ T.pack input
  print $ part2 $ parse $ T.pack input
