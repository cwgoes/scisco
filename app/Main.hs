module Main where

import           Control.Concurrent
import           Control.Monad
import           Foundation

import qualified ABCI.Server        as ABCI
import qualified Scisco.Core        as Scisco

main ∷ IO ()
main = do
  state ← Scisco.load
  void $ forkIO $ Scisco.serve
  ABCI.serve (Scisco.handle state)
