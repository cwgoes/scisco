module Examples.Counter where

import           Control.Concurrent
import           Control.Lens
import qualified Data.Binary          as B
import qualified Data.Binary.Get      as B
import qualified Data.ByteString      as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text            as T
import           Foundation

import           Proto.Types

handleInfo ∷ MVar State → RequestInfo → IO ResponseInfo
handleInfo _ RequestInfo = do
  return $ ResponseInfo {
    _ResponseInfo'data'             = "scisco",
    _ResponseInfo'version           = "1.0.0",
    _ResponseInfo'lastBlockHeight   = 0,
    _ResponseInfo'lastBlockAppHash  = B.empty
  }

handleEcho ∷ RequestEcho → IO ResponseEcho
handleEcho (RequestEcho e) = return $ ResponseEcho e

handleFlush ∷ RequestFlush → IO ResponseFlush
handleFlush RequestFlush = return ResponseFlush

handleOption ∷ MVar State → RequestSetOption → IO ResponseSetOption
handleOption _ _ = return $ ResponseSetOption "ok"

handleInitChain ∷ RequestInitChain → IO ResponseInitChain
handleInitChain _ = return ResponseInitChain

handleBeginBlock ∷ RequestBeginBlock → IO ResponseBeginBlock
handleBeginBlock _ = return ResponseBeginBlock

handleCheckTx ∷ MVar State → RequestCheckTx → IO ResponseCheckTx
handleCheckTx state (RequestCheckTx tx) = do
  case B.runGetOrFail B.getWord8 $ BL.fromStrict tx of
    Right (_, _, num) → do
      state ← readMVar state
      if fromIntegral num == stateCounter state + 1 then do
        return $ ResponseCheckTx OK tx T.empty
      else do
        return $ ResponseCheckTx BadNonce B.empty invalidNumber
    Left _ → return $ ResponseCheckTx EncodingError B.empty undecodable

handleDeliverTx ∷ MVar State → RequestDeliverTx → IO ResponseDeliverTx
handleDeliverTx state (RequestDeliverTx tx) = do
  case B.runGetOrFail B.getWord8 $ BL.fromStrict tx of
    Right (_, _, num) → do
      modifyMVar state $ \state → do
        if fromIntegral num == stateCounter state + 1 then do
          return (state { stateCounter = fromIntegral num }, ResponseDeliverTx OK tx T.empty)
        else do
          return (state, ResponseDeliverTx BadNonce B.empty invalidNumber)
    Left _ → return $ ResponseDeliverTx EncodingError B.empty undecodable

handleEndBlock ∷ RequestEndBlock → IO ResponseEndBlock
handleEndBlock _ = return $ ResponseEndBlock []

handleCommit ∷ MVar State → RequestCommit → IO ResponseCommit
handleCommit state _ = do
  state ← readMVar state
  return $ ResponseCommit OK (BL.toStrict $ B.encode $ stateCounter state) T.empty

counter ∷ IO (Request → IO Response)
counter = do
  state ← newMVar freshState
  let respondWith func val = func .~ val $ emptyResponse
  return $ \req → do
    handleCase _Request'info (fmap (respondWith info) . handleInfo state) req $ do
      handleCase _Request'echo (fmap (respondWith echo) . handleEcho) req $ do
        handleCase _Request'flush (fmap (respondWith flush) . handleFlush) req $ do
          handleCase _Request'setOption (fmap (respondWith setOption) . handleOption state) req $ do
            handleCase _Request'initChain (fmap (respondWith initChain) . handleInitChain) req $ do
              handleCase _Request'checkTx (fmap (respondWith checkTx) . handleCheckTx state) req $ do
                handleCase _Request'beginBlock (fmap (respondWith beginBlock) . handleBeginBlock) req $ do
                  handleCase _Request'deliverTx (fmap (respondWith deliverTx) . handleDeliverTx state) req $ do
                    handleCase _Request'endBlock (fmap (respondWith endBlock) . handleEndBlock) req $ do
                      handleCase _Request'commit (fmap (respondWith commit) . handleCommit state) req $ do
                        putStrLn $ show ("error handling", req)
                        return $ exception .~ ResponseException unknown $ emptyResponse

flushResponse ∷ Response
flushResponse = flush .~ ResponseFlush $ emptyResponse

handleCase ∷ ∀ a b c m . (a → Maybe b) → (b → m c) → a → m c → m c
handleCase getter func val cont =
  case getter val of
    Just x  → func x
    Nothing → cont

emptyResponse ∷ Response
emptyResponse = Response Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing

freshState ∷ State
freshState = State 0

unknown ∷ T.Text
unknown = "unknown_request"

invalidNumber ∷ T.Text
invalidNumber = "invalid_number"

undecodable ∷ T.Text
undecodable = "undecodable"

data State = State {
  stateCounter    ∷ Integer
} deriving (Show, Eq)
