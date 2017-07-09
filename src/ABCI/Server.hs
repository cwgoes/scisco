module ABCI.Server (serve) where

import qualified Conduit                 as C
import           Control.Monad
import qualified Data.Binary             as B
import qualified Data.Bits               as B
import qualified Data.ByteString         as B
import qualified Data.ByteString.Lazy    as BL
import qualified Data.Conduit.Network    as N
import           Data.List               (unfoldr)
import qualified Data.ProtoLens.Encoding as P
import           Foundation

import           Proto.Types

serve ∷ (Request → IO Response) → IO ()
serve func = do
  N.runTCPServer (N.serverSettings 46658 "*") $ \app → do
    void $ (N.appSource app C.=$= unbuffer C.=$= handle func) C.$$+ N.appSink app

unbuffer ∷ C.ConduitM B.ByteString B.ByteString IO ()
unbuffer = go B.empty
  where go buffer = do
          val ← C.await
          case val of
            Just v  → do
              let joined = buffer `B.append` v
                  loop str = do
                    if B.length str == 0 then go str else do
                      let (enc, length) = decodeLength str
                          remaining     = B.drop enc str
                      if B.length remaining >= length then do
                        let msg = B.take length remaining
                        C.yield msg
                        loop (B.drop length remaining)
                      else go str
              loop joined
            Nothing → do
              return ()

handle ∷ (Request → IO Response) → C.ConduitM B.ByteString B.ByteString IO ()
handle func = go
  where go = do
          val ← C.await
          case val of
            Just v → do
              case P.decodeMessage v of
                Right m → do
                  r ← C.liftIO $ func m
                  let encoded       = P.encodeMessage r
                      encodedLength = fromIntegral $ B.length encoded
                      lengthEncoded = B.pack $ unroll encodedLength
                      lengthLength  ∷ Word8
                      lengthLength  = fromIntegral $ B.length lengthEncoded
                      concatenated  = lengthLength `B.cons` lengthEncoded `B.append` encoded
                  C.yield concatenated
                  go
                Left _ → do
                  return ()
            Nothing → do
              return ()

decodeLength ∷ B.ByteString → (Int, Int)
decodeLength str =
  let lengthSizeEncoded = BL.fromStrict $ B.take 1 str
      lengthSizeDecoded ∷ Word8
      lengthSizeDecoded = B.decode lengthSizeEncoded
      lengthSize        ∷ Int
      lengthSize        = fromIntegral lengthSizeDecoded
      lengthEncoded     = B.take lengthSize $ B.drop 1 str
      lengthDecoded     ∷ Integer
      lengthDecoded     = roll $ B.unpack lengthEncoded
  in (1 + lengthSize, fromIntegral lengthDecoded)

roll ∷ [Word8] → Integer
roll = foldr unstep 0 . reverse
  where
    unstep b a = a `B.shiftL` 8 B..|. fromIntegral b

unroll ∷ Integer → [Word8]
unroll = reverse . unfoldr step
  where
    step 0 = Nothing
    step i = Just (fromIntegral i, i `B.shiftR` 8)
