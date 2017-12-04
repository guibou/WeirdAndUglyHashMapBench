import qualified Data.ByteString.Char8 as BS
import Data.ByteString.Char8 (ByteString)
import System.Environment (getArgs)
import Data.Foldable (for_)

import qualified Data.HashTable.IO as H

-- I tried Cuchoo and Linear, they are slower...
type HashTable k v = H.BasicHashTable k v

key :: ByteString -> ByteString
key = BS.sort

main :: IO ()
main = do
  wordFile:tests' <- getArgs
  let tests = map BS.pack tests'

  lines <- BS.lines <$> BS.readFile wordFile

  d <- (H.new) :: IO (HashTable ByteString [ByteString])

  for_ lines $ \v -> do
    let k = key v

    -- I tried *mutate*, it is slower
    l <- H.lookup d k
    case l of
      Nothing -> H.insert d k [v]
      Just l -> H.insert d k (v:l)

  for_ tests $ \v -> do
    res <- H.lookup d (key v)
    print (v, res)
