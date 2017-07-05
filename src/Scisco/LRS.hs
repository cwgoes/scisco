{-

Linkable ring signatures, per https://link.springer.com/chapter/10.1007%2F11424826_65#page-1
Significant fraction of code adapted from https://github.com/MaiaVictor/lrs (sadly, the original paper is paywalled).

-}

module Scisco.LRS (
  PrivateKey,
  PublicKey,
  Keypair,
  Ring,
  Signature,
  genKeypair,
  sign,
  verify,
  link
) where

import qualified Crypto.Hash           as C
import           Data.Bits
import qualified Data.ByteString.Char8 as B
import           Data.Maybe
import qualified Data.Vector           as V
import           Foundation
import           GHC.Generics
import qualified Numeric
import qualified Prelude
import           System.Random

type PrivateKey = Integer
type PublicKey  = Integer
type Keypair    = (PublicKey, PrivateKey)
type Ring       = V.Vector PublicKey
data Signature  = Signature Integer Integer (V.Vector Integer) deriving (Show, Eq, Generic)
data LGroup     = LGroup Integer Integer Integer

sha512 ∷ B.ByteString → B.ByteString
sha512 str = B.pack $ Prelude.show (C.hash str ∷ C.Digest C.SHA3_512)

genKeypair ∷ IO Keypair
genKeypair = do
  let LGroup _ q _ = hard
  priv ← fmap (\x → x `mMod` q) randomInteger
  return (makePublicKey hard priv, priv)

sign ∷ Ring → Keypair → B.ByteString → IO Signature
sign ring keypair msg = do
  rand ← V.replicateM (V.length ring) randomInteger
  return $ pureSign rand hard ring keypair msg

verify ∷ Ring → Signature → B.ByteString → Bool
verify = pureVerify hard

link ∷ Signature → Signature → Bool
link = pureLink

randomInteger ∷ IO Integer
randomInteger = randomRIO (0, 2 Prelude.^ 256)

makePublicKey ∷ LGroup → PrivateKey → PublicKey
makePublicKey (LGroup g _ p) priv = mPow p g priv

pureSign ∷ V.Vector Integer → LGroup → Ring → Keypair → B.ByteString → Signature
pureSign rand grp@(LGroup g q p) ring (pub, pvt) msg =
  let e   = V.map (\x → x `mMod` q) rand
      n   = fromMaybe 0 (V.findIndex ((==) pub) ring)
      r   = fromMaybe 0 $ e V.!? n
      c   = V.update e (V.singleton (n, 0))
      l   = mJoin ring
      h   = hash2 grp l
      y0  = mPow p h pvt
      sc  = V.sum c
      a   = mMul p (mPow p g r) (mProd p (V.zipWith (mPow p) ring c))
      b   = mMul p (mPow p h r) (mPow p y0 sc)
      h1  = hash1 grp (l <> mJoin (V.singleton y0) <> msg <> mJoin (V.fromList [a, b]))
      ci  = (h1 - sc) `mMod` q
      s   = (r - (ci * pvt)) `mMod` q
      sig = Signature y0 s (V.update c (V.singleton (n, ci)))
  in sig

pureVerify ∷ LGroup → Ring → Signature → B.ByteString → Bool
pureVerify grp@(LGroup g q p) ring (Signature y0 s c) msg =
  let l   = mJoin ring
      h   = hash2 grp l
      a   = mMul p (mPow p g s) (mProd p (V.zipWith (mPow p) ring c))
      b   = mMul p (mPow p h s) (mPow p y0 (V.sum c))
      h1  = hash1 grp (l <> mJoin (V.singleton y0) <> msg <> mJoin (V.fromList [a, b]))
  in V.sum c `mod` q == h1

pureLink ∷ Signature → Signature → Bool
pureLink (Signature y0a _ _) (Signature y0b _ _) = y0a == y0b

hash1 ∷ LGroup → B.ByteString → Integer
hash1 lg bits = hash lg "salt1" bits

hash2 ∷ LGroup → B.ByteString → Integer
hash2 lg@(LGroup _ q _) bits = (h*h) `mMod` (2*q + 1)
  where h = hash lg "salt3" bits `mMod` (q - 2) + 2

hash ∷ LGroup → B.ByteString → B.ByteString → Integer
hash (LGroup _ q _) salt bits = mMod bigInt q where
  bigInt         = parseHex hashed2560bits
  distinctHashes = V.map (\x → sha512 $ x <> (salt<>bits)) (V.map ((<>) salt) $ V.fromList ["a","b","c","d","e"])
  hashed2560bits = V.foldr (<>) "" distinctHashes

order ∷ Integer → Integer
order p = (p - 1) `div` 2

mPow ∷ Integer → Integer → Integer → Integer
mPow p a b = if b < 0 then mInv p (modPow a (-b) p) else modPow a b p

mMod ∷ Integer → Integer → Integer
mMod a b =
  let ab = a `mod` b in if ab < 0 then (ab + b) `mod` b else ab

mMul ∷ Integer → Integer → Integer → Integer
mMul p a b = (a * b) `mMod` p

mInv ∷ Integer → Integer → Integer
mInv p i = mPow p i (p - 2)

mProd ∷ Integer → V.Vector Integer → Integer
mProd p a = V.foldr (mMul p) 1 a

mJoin ∷ V.Vector Integer → B.ByteString
mJoin = V.foldl B.append "" . V.map (B.pack . flip Numeric.showHex "")

-- Fast modular exponentiation. Source: https://gist.github.com/trevordixon/6788535

modPow ∷ Integer → Integer → Integer → Integer
modPow _ 0 _ = 1
modPow b e m = t * modPow ((b * b) `mod` m) (shiftR e 1) m `mod` m
  where t = if testBit e 0 then b `mod` m else 1

-- IETF standard - https://tools.ietf.org/html/rfc2409#section-6.2 (Second Oakley Group)

hard ∷ LGroup
hard =
  let prime = parseHex "FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF"
  in LGroup 2 (order prime) prime

parseHex ∷ B.ByteString → Integer
parseHex = fst . Prelude.head . Numeric.readHex . B.unpack
