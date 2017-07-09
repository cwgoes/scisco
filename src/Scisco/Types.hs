module Scisco.Types where

import qualified Crypto.Hash.Algorithms  as C
import qualified Crypto.PubKey.ECC.ECDSA as C
import qualified Crypto.PubKey.ECC.Types as C
import qualified Data.Aeson              as A
import qualified Data.Aeson.Types        as A
import qualified Data.Bimap              as BM
import qualified Data.Binary             as B
import           Data.Char
import qualified Data.Hashable           as H
import qualified Data.HashMap.Strict     as M
import           Data.List               (map)
import qualified Data.Text               as T
import qualified Data.Vector             as V
import           Foundation
import           GHC.Generics
import qualified Prelude

import qualified Scisco.LRS              as LRS

curve ∷ C.Curve
curve = C.getCurveByName C.SEC_p521r1

hashAlgorithm ∷ C.SHA3_512
hashAlgorithm = C.SHA3_512

data State = State {
  stateLastBlockHeight ∷ Integer,
  stateElections       ∷ M.HashMap T.Text Election
} deriving (Show, Eq, Generic)

data Election = Election {
  electionAuthorityPubKey    ∷ C.PublicPoint,
  electionTransitionBlocks   ∷ (Integer, Integer),
  electionStage              ∷ Stage,
  electionPendingCandidates  ∷ BM.Bimap C.PublicPoint T.Text,
  electionPendingVoters      ∷ BM.Bimap C.PublicPoint T.Text,
  electionAcceptedCandidates ∷ BM.Bimap C.PublicPoint T.Text,
  electionAcceptedVoters     ∷ BM.Bimap C.PublicPoint T.Text,
  electionRejectedCandidates ∷ M.HashMap C.PublicPoint T.Text,
  electionRejectedVoters     ∷ M.HashMap C.PublicPoint T.Text,
  electionVoterLRSPubKeys    ∷ M.HashMap C.PublicPoint LRS.PublicKey,
  electionVoterRing          ∷ LRS.Ring,
  electionBallotSignatures   ∷ V.Vector LRS.Signature,
  electionVotes              ∷ M.HashMap C.PublicPoint Integer
} deriving (Show, Eq, Generic)

data Stage =

  Registration |
  Voting |
  Finished

  deriving (Show, Eq, Generic)

data Transaction =

  StartElection { startElectionName ∷ T.Text, startElectionAuthorityPubKey ∷ T.Text, startElectionTransitionBlocks ∷ (Integer, Integer) } |
  Transition { transitionElectionName ∷ T.Text, transitionFromStage ∷ Stage, transitionToStage ∷ Stage } |

  RegisterAsCandidate { candidateElectionName ∷ T.Text, candidateName ∷ T.Text, candidatePubKey ∷ T.Text } |
  RegisterAsVoter     { voterElectionName ∷ T.Text, voterName ∷ T.Text, voterPubKey ∷ T.Text, voterLRSPubKey ∷ T.Text } |

  AcceptCandidate { acceptCandidateElectionName ∷ T.Text, acceptCandidatePubKey ∷ T.Text, acceptCandidateSignature ∷ T.Text } |
  RejectCandidate { rejectCandidateElectionName ∷ T.Text, rejectCandidatePubKey ∷ T.Text, rejectCandidateSignature ∷ T.Text, rejectCandidateReason ∷ T.Text } |
  AcceptVoter     { acceptVoterElectionName ∷ T.Text, acceptVoterPubKey ∷ T.Text, acceptVoterSignature ∷ T.Text } |
  RejectVoter     { rejectVoterElectionName ∷ T.Text, rejectVoterPubKey ∷ T.Text, rejectVoterSignature ∷ T.Text, rejectVoterReason ∷ T.Text } |

  CastBallot      { castBallotElectionName ∷ T.Text, castSignature ∷ T.Text, castCandidate ∷ T.Text }

  deriving (Show, Eq, Generic)

data ApplyError =

  DuplicateElection |
  ElectionNotFound |

  InvalidTransition |
  WrongStage |

  DuplicateName |
  DuplicatePubKey |

  CandidateNotFound |
  CandidateAlreadyAccepted |
  CandidateAlreadyRejected |

  DuplicateVoter |
  VoterNotFound |
  VoterAlreadyAccepted |
  VoterAlreadyRejected |

  InvalidSignature |
  DuplicateSignature

  deriving (Show, Eq, Generic)

deriving instance Generic C.Point
deriving instance Ord C.Point
deriving instance Generic C.Signature

instance H.Hashable C.PublicPoint

instance (Ord a, Ord b, B.Binary a, B.Binary b) ⇒ B.Binary (BM.Bimap a b) where
  put = B.put . BM.toList
  get = BM.fromList `fmap` B.get

instance (B.Binary a) ⇒ B.Binary (V.Vector a) where
  put = B.put . V.toList
  get = V.fromList `fmap` B.get

instance (Ord k, H.Hashable k, B.Binary k, B.Binary v) ⇒ B.Binary (M.HashMap k v) where
  put = B.put . M.toList
  get = M.fromList `fmap` B.get

instance B.Binary LRS.Signature
instance B.Binary C.Signature
instance B.Binary C.Point
instance B.Binary State
instance B.Binary Transaction
instance B.Binary Stage
instance B.Binary Election

instance (A.ToJSON a, A.ToJSON b, Ord a, Ord b) ⇒ A.ToJSON (BM.Bimap a b) where
  toJSON = A.toJSON . BM.toList

instance (A.FromJSON a, A.FromJSON b, Ord a, Ord b) ⇒ A.FromJSON (BM.Bimap a b) where
  parseJSON v = do
    val ← A.parseJSON v
    return $ BM.fromList val

options ∷ A.Options
options = A.defaultOptions {
  A.constructorTagModifier = map toLower,
  A.fieldLabelModifier = (\x → toLower (Prelude.head x) : Prelude.tail x) . dropWhile isLower,
  A.omitNothingFields  = True,
  A.sumEncoding        = A.ObjectWithSingleField
}

customToEncoding ∷ (A.GToEncoding A.Zero (Rep a), Generic a) ⇒ a → A.Encoding
customToEncoding = A.genericToEncoding options

customParseJSON ∷ (A.GFromJSON A.Zero (Rep a), Generic a) ⇒ A.Value → A.Parser a
customParseJSON = A.genericParseJSON options

instance A.ToJSONKey    C.Point
instance A.FromJSONKey  C.Point
instance A.ToJSON   Stage where toEncoding = customToEncoding
instance A.FromJSON Stage where parseJSON = customParseJSON
instance A.ToJSON   C.PublicPoint where toEncoding = customToEncoding
instance A.FromJSON C.PublicPoint where parseJSON = customParseJSON
instance A.ToJSON   C.Signature   where toEncoding = customToEncoding
instance A.FromJSON C.Signature   where parseJSON = customParseJSON
instance A.ToJSON   LRS.Signature where toEncoding = customToEncoding
instance A.FromJSON LRS.Signature where parseJSON = customParseJSON
instance A.ToJSON   Election    where toEncoding = customToEncoding
instance A.FromJSON Election    where parseJSON = customParseJSON
instance A.ToJSON   Transaction where toEncoding = customToEncoding
instance A.FromJSON Transaction where parseJSON = customParseJSON
