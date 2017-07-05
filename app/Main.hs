module Main where

import           Foundation

import qualified ABCI.Server as ABCI
import qualified Scisco.Core as Scisco

main ∷ IO ()
main = do
  state ← Scisco.load
  ABCI.serve (Scisco.handle state)
