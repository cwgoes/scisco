module Scisco.Core (load, handle, serve) where

import           Control.Concurrent
import           Control.Lens
import           Control.Monad.Trans
import qualified Crypto.Hash                as C
import qualified Crypto.PubKey.ECC.ECDSA    as C
import qualified Crypto.PubKey.ECC.Generate as C
import qualified Data.Aeson                 as A
import qualified Data.Bimap                 as BM
import qualified Data.Binary                as B
import qualified Data.ByteString.Base16     as B16
import qualified Data.ByteString.Char8      as B
import qualified Data.ByteString.Lazy       as BL
import qualified Data.HashMap.Strict        as M
import           Data.List                  (map)
import qualified Data.Text                  as T
import qualified Data.Vector                as V
import           Foundation
import qualified Network.HTTP.Types         as S
import qualified Prelude
import qualified Web.Spock                  as S
import qualified Web.Spock.Config           as S

import           Proto.Types
import           Scisco.Consensus           (encodeToSign, opaqueDecode,
                                             opaqueEncode, sign)
import qualified Scisco.Consensus           as Consensus
import qualified Scisco.LRS                 as LRS
import           Scisco.Types

handle ∷ MVar State → Request → IO Response
handle state request = do

  let handleCase ∷ ∀ a . (Request → Maybe a) → (a → IO Response) → IO Response → IO Response
      handleCase getter func cont =
        case getter request of
          Just x  → func x
          Nothing → cont

      respondWith func handler = fmap (\val → func .~ val $ emptyResponse) . handler

  -- This is clumsy but concise; the autogenerated data structure is odd to handle (usually would be a sum type).
  handleCase _Request'info (respondWith info (handleInfo state)) $ do
    handleCase _Request'echo (respondWith echo handleEcho) $ do
      handleCase _Request'flush (respondWith flush handleFlush) $ do
        handleCase _Request'setOption (respondWith setOption handleOption) $ do
          handleCase _Request'initChain (respondWith initChain handleInitChain) $ do
            handleCase _Request'checkTx (respondWith checkTx (handleCheckTx state)) $ do
              handleCase _Request'beginBlock (respondWith beginBlock handleBeginBlock) $ do
                handleCase _Request'deliverTx (respondWith deliverTx (handleDeliverTx state)) $ do
                  handleCase _Request'endBlock (respondWith endBlock handleEndBlock) $ do
                    handleCase _Request'commit (respondWith commit (handleCommit state)) $ do
                      handleCase _Request'query (respondWith query (handleQuery state)) $ do
                        return $ exception .~ ResponseException unknown $ emptyResponse

load ∷ IO (MVar State)
load = do
  -- TODO Implement actual state serialization. Not necessary for demonstration purposes.
  state ← return $ State 0 M.empty
  newMVar state

serve ∷ IO ()
serve = do
  cfg ← S.defaultSpockCfg () S.PCNoDatabase ()
  S.runSpock 8080 $ S.spock cfg app

app ∷ S.SpockM () () () ()
app = do

  let crossOrigin = do
        S.setHeader "Access-Control-Allow-Origin" "*"
        S.setHeader "Access-Control-Allow-Methods" "GET, POST, HEAD, OPTIONS"

  S.get ("aux" S.<//> "ecc" S.<//> "keys" S.<//> "generate") $ do
    (C.PublicKey _ pub, C.PrivateKey _ pri) ← liftIO $ C.generate curve
    crossOrigin
    S.json $ A.Object $ M.fromList [("public", A.toJSON $ opaqueEncode pub), ("private", A.toJSON $ opaqueEncode pri)]

  S.post ("aux" S.<//> "ecc" S.<//> "accept") $ do
    body ← S.body
    crossOrigin
    case A.decodeStrict body of
      Just (election ∷ T.Text, which ∷ T.Text, pubkey' ∷ T.Text, privkey' ∷ T.Text) → do
        let pubkey  = opaqueDecode pubkey'
            privkey = opaqueDecode privkey'
        sig ← liftIO $ sign privkey $ encodeToSign (election, which, pubkey ∷ C.PublicPoint)
        S.json $ opaqueEncode sig
      Nothing → do
        S.setStatus $ S.Status 400 "Bad Request"

  S.post ("aux" S.<//> "ecc" S.<//> "reject") $ do
    body ← S.body
    crossOrigin
    case A.decodeStrict body of
      Just (election ∷ T.Text, which ∷ T.Text, pubkey' ∷ T.Text, reason ∷ T.Text, privkey' ∷ T.Text) → do
        let pubkey  = opaqueDecode pubkey'
            privkey = opaqueDecode privkey'
        sig ← liftIO $ sign privkey $ encodeToSign (election, which, pubkey ∷ C.PublicPoint, reason ∷ T.Text)
        S.json $ opaqueEncode sig
      Nothing → do
        S.setStatus $ S.Status 400 "Bad Request"

  S.get ("aux" S.<//> "lrs" S.<//> "keys" S.<//> "generate") $ do
    (pub, pri) ← liftIO LRS.genKeypair
    crossOrigin
    S.json $ A.Object $ M.fromList [("public", A.toJSON $ opaqueEncode pub), ("private", A.toJSON $ opaqueEncode pri)]

  S.post ("aux" S.<//> "lrs" S.<//> "votes" S.<//> "sign") $ do
    body ← S.body
    crossOrigin
    case A.decodeStrict body of
      Just (ring' ∷ V.Vector T.Text, keypair' ∷ T.Text, election ∷ T.Text, candidatePubKey' ∷ T.Text) → do
        let ring = V.map opaqueDecode ring'
            keypair = opaqueDecode keypair'
            candidatePubKey = opaqueDecode candidatePubKey'
        sig ← liftIO $ LRS.sign ring keypair $ BL.toStrict $ B.encode (election ∷ T.Text, "castVote" ∷ B.ByteString, candidatePubKey ∷ C.PublicPoint)
        S.json $ opaqueEncode sig
      Nothing → do
        S.setStatus $ S.Status 400 "Bad Request"

handleQuery ∷ MVar State → RequestQuery → IO ResponseQuery
handleQuery state (RequestQuery _ path _ _) = do
  case T.split ((==) '/') path of
    ["state", "elections"] → do
      state ← readMVar state
      let result =
            M.map (\e → A.Object $ M.fromList [
            ("authorityPubKey", A.toJSON $ opaqueEncode $ electionAuthorityPubKey e),
            ("transitionBlocks", A.toJSON $ electionTransitionBlocks e),
            ("stage", A.toJSON $ electionStage e),
            ("pendingCandidates", A.toJSON $ BM.map opaqueEncode $ electionPendingCandidates e),
            ("pendingVoters", A.toJSON $ BM.map opaqueEncode $ electionPendingVoters e),
            ("acceptedCandidates", A.toJSON $ BM.map opaqueEncode $ electionAcceptedCandidates e),
            ("acceptedVoters", A.toJSON $ BM.map opaqueEncode $ electionAcceptedVoters e),
            ("rejectedCandidates", A.toJSON $ map (\(k, v) → (opaqueEncode k, v)) $ M.toList $ electionRejectedCandidates e),
            ("rejectedVoters", A.toJSON $ map (\(k, v) → (opaqueEncode k, v)) $ M.toList $ electionRejectedVoters e),
            ("voterRing", A.toJSON $ V.map opaqueEncode $ electionVoterRing e),
            ("ballotSignatures", A.toJSON $ V.map opaqueEncode $ electionBallotSignatures e),
            ("votes", A.toJSON $ map (\(k, v) → (opaqueEncode k, v)) $ M.toList $ electionVotes e)
            ]) $ stateElections state
      return $ ResponseQuery OK 0 B.empty (BL.toStrict $ A.encode result) B.empty 0 T.empty
    ["p2p", "filter", "pubkey", _]  → return $ ResponseQuery OK 0 B.empty B.empty B.empty 0 T.empty
    ["p2p", "filter", "addr", _]    → return $ ResponseQuery OK 0 B.empty B.empty B.empty 0 T.empty
    _                               → return $ ResponseQuery UnknownRequest 0 B.empty B.empty B.empty 0 unknown

handleInfo ∷ MVar State → RequestInfo → IO ResponseInfo
handleInfo state RequestInfo = do
  state ← readMVar state
  return $ ResponseInfo {
    _ResponseInfo'data'             = "/scisco-alpha/",
    _ResponseInfo'version           = "0.1.0.0",
    _ResponseInfo'lastBlockHeight   = fromIntegral $ stateLastBlockHeight state,
    _ResponseInfo'lastBlockAppHash  = B.empty
  }

handleEcho ∷ RequestEcho → IO ResponseEcho
handleEcho (RequestEcho e) = return $ ResponseEcho e

handleFlush ∷ RequestFlush → IO ResponseFlush
handleFlush RequestFlush = return ResponseFlush

handleOption ∷ RequestSetOption → IO ResponseSetOption
handleOption _ = return $ ResponseSetOption "ok"

handleInitChain ∷ RequestInitChain → IO ResponseInitChain
handleInitChain _ = return ResponseInitChain

handleBeginBlock ∷ RequestBeginBlock → IO ResponseBeginBlock
handleBeginBlock _ = return ResponseBeginBlock

handleDeliverTx ∷ MVar State → RequestDeliverTx → IO ResponseDeliverTx
handleDeliverTx state (RequestDeliverTx tx') = do
  let (tx, _) = B16.decode tx'
  case A.decodeStrict tx of
    Nothing ->
      return $ ResponseDeliverTx EncodingError B.empty undecodable
    Just tx → do
      modifyMVar state $ \state → do
        case Consensus.apply state tx of
          Right updated → return (updated, ResponseDeliverTx OK B.empty T.empty)
          Left err      → return (state,   ResponseDeliverTx BadNonce B.empty $ "consensus_violation - " `T.append` (T.pack $ Prelude.show err))

handleCheckTx ∷ MVar State → RequestCheckTx → IO ResponseCheckTx
handleCheckTx state (RequestCheckTx tx') = do
  let (tx, _) = B16.decode tx'
  case A.decodeStrict tx of
    Nothing ->
      return $ ResponseCheckTx EncodingError B.empty undecodable
    Just tx → do
      modifyMVar state $ \state → do
        case Consensus.apply state tx of
          Right _   → return (state, ResponseCheckTx OK B.empty T.empty)
          Left err  → return (state, ResponseCheckTx BadNonce B.empty $ "consensus_violation - " `T.append` (T.pack $ Prelude.show err))

handleEndBlock ∷ RequestEndBlock → IO ResponseEndBlock
handleEndBlock _ = return $ ResponseEndBlock []

handleCommit ∷ MVar State → RequestCommit → IO ResponseCommit
handleCommit state _ = do
  state ← readMVar state
  return $ ResponseCommit OK (sha256 $ BL.toStrict $ B.encode state) T.empty

sha256 ∷ B.ByteString → B.ByteString
sha256 str = B.pack $ Prelude.show (C.hash str ∷ C.Digest C.SHA3_256)

emptyResponse ∷ Response
emptyResponse = Response Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing

unknown ∷ T.Text
unknown = "unknown_request"

undecodable ∷ T.Text
undecodable = "undecodable"
