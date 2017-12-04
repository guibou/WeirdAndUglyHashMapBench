import qualified Data.ByteString.Char8 as BS
import System.Environment (getArgs)
import Data.Foldable (for_)

import qualified Data.HashMap.Strict as HashMap

main :: IO ()
main = do
  wordFile:tests' <- getArgs

  let
    tests = map BS.pack tests'
    key = BS.sort

  items <- BS.lines <$> BS.readFile wordFile

  let d = HashMap.fromListWith (\[new] old -> new:old) (map (\s -> (key s, [s])) items)

  for_ tests (\v -> print (v, HashMap.lookup (key v) d))
