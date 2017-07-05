module Scisco.Consensus (apply) where

import           Control.Monad.Except
import qualified Crypto.PubKey.ECC.ECDSA as C
import qualified Data.Bimap              as BM
import qualified Data.Binary             as B
import qualified Data.ByteString         as B
import qualified Data.ByteString.Lazy    as BL
import qualified Data.HashMap.Strict     as M
import qualified Data.Vector             as V
import           Foundation
import           Prelude                 (map)

import qualified Scisco.LRS              as LRS
import           Scisco.Types

apply ∷ (MonadError ApplyError m) ⇒ State → Transaction → m State
apply state tx = do
  let height    = stateLastBlockHeight state
      elections = stateElections state

  case tx of

    StartElection name pubKey transitionBlocks ->
      case M.lookup name elections of
        -- Consensus rule: all elections must be unique by name.
        Just _  → throwError DuplicateElection
        Nothing → do
          return $ state { stateElections = M.insert name (newElection pubKey transitionBlocks) elections }

    Transition name from to ->
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: all transitions must happen in strict order and only after the prespecified block heights have been passed.
          case (from, to) of
            (Registration, Voting) | electionStage e == Registration && fst (electionTransitionBlocks e) <= height ->
              return $ state { stateElections = M.adjust (\e → e { electionStage = Voting, electionVoterRing = V.fromList $ map (\k → electionVoterLRSPubKeys e M.! k) $ BM.keys $ electionAcceptedVoters e }) name elections }
            (Voting, Finished) | electionStage e == Voting && snd (electionTransitionBlocks e) <= height ->
              return $ state { stateElections = M.adjust (\e → e { electionStage = Finished }) name elections }
            _ → throwError InvalidTransition

    RegisterAsCandidate name candidateName candidatePubKey → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: candidates may only register during the registration stage.
          let stage = electionStage e
          unless (stage == Registration) $ throwError WrongStage
          -- Consensus rule: all candidate registrations must be unique by both identifier and public key.
          let pending = electionPendingCandidates e
          when (BM.memberR candidateName pending) $ throwError DuplicateName
          when (BM.member candidatePubKey pending) $ throwError DuplicatePubKey
          return $ state { stateElections = M.adjust (\e → e { electionPendingCandidates = BM.insert candidatePubKey candidateName pending }) name elections }

    RegisterAsVoter name voterName voterPubKey lrsPubKey → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: voters may only register during the registration stage.
          let stage = electionStage e
          unless (stage == Registration) $ throwError WrongStage
          -- Consensus rule: all voter registrations must be unique by both identifier and public key.
          let pending = electionPendingVoters e
          when (BM.memberR voterName pending) $ throwError DuplicateName
          when (BM.member voterPubKey pending) $ throwError DuplicatePubKey
          return $ state { stateElections = M.adjust (\e → e { electionPendingVoters = BM.insert voterPubKey voterName pending, electionVoterLRSPubKeys = M.insert voterPubKey lrsPubKey $ electionVoterLRSPubKeys e }) name elections }

    AcceptCandidate name candidatePubKey authoritySignature → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: candidates may only be accepted during the registration stage.
          let stage = electionStage e
          unless (stage == Registration) $ throwError WrongStage
          -- Consensus rule: accepted candidates must have previously registered.
          let pending = electionPendingCandidates e
          case BM.lookup candidatePubKey pending of
            Nothing            → throwError CandidateNotFound
            Just candidateName → do
              -- Consensus rule: accepted candidates must not already been accepted.
              let accepted  = electionAcceptedCandidates e
              when (BM.member candidatePubKey accepted) $ throwError CandidateAlreadyAccepted
              -- Consensus rule: accepted candidates must not already been rejected.
              let rejected  = electionRejectedCandidates e
              when (M.member candidatePubKey rejected) $ throwError CandidateAlreadyRejected
              -- Consensus rule: only the authority can accept candidates.
              let authority = electionAuthorityPubKey e
                  toSign    = encodeToSign (name, "acceptCandidate" ∷ B.ByteString, candidatePubKey)
              unless (verifySignature authority authoritySignature toSign) $ throwError InvalidSignature
              return $ state { stateElections = M.adjust (\e → e { electionAcceptedCandidates = BM.insert candidatePubKey candidateName accepted }) name elections }

    RejectCandidate name candidatePubKey authoritySignature reason → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: candidates may only be rejected during the registration stage.
          let stage = electionStage e
          unless (stage == Registration) $ throwError WrongStage
          -- Consensus rule: rejected candidates must have previously registered.
          let pending = electionPendingCandidates e
          case BM.lookup candidatePubKey pending of
            Nothing → throwError CandidateNotFound
            Just _  → do
              -- Consensus rule: rejected candidates must not already been accepted.
              let accepted  = electionAcceptedCandidates e
              when (BM.member candidatePubKey accepted) $ throwError CandidateAlreadyAccepted
              -- Consensus rule: rejected candidates must not already been rejected.
              let rejected  = electionRejectedCandidates e
              when (M.member candidatePubKey rejected) $ throwError CandidateAlreadyRejected
              -- Consensus rule: only the authority can reject candidates.
              let authority = electionAuthorityPubKey e
                  toSign    = encodeToSign (name, "rejectCandidate" ∷ B.ByteString, candidatePubKey, reason)
              unless (verifySignature authority authoritySignature toSign) $ throwError InvalidSignature
              return $ state { stateElections = M.adjust (\e → e { electionRejectedCandidates = M.insert candidatePubKey reason rejected }) name elections }

    AcceptVoter name voterPubKey authoritySignature → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: voters may only be accepted during the registration stage.
          let stage = electionStage e
          unless (stage == Registration) $ throwError WrongStage
          -- Consensus rule: accepted voters must have previously registered.
          let pending = electionPendingVoters e
          case BM.lookup voterPubKey pending of
            Nothing         → throwError VoterNotFound
            Just voterName  → do
              -- Consensus rule: accepted voters must not have already been accepted.
              let accepted = electionAcceptedVoters e
              when (BM.member voterPubKey accepted) $ throwError VoterAlreadyAccepted
              -- Consensus rule: accepted voters must not have already been rejected.
              let rejected = electionRejectedVoters e
              when (M.member voterPubKey rejected) $ throwError VoterAlreadyRejected
              -- Consensus rule: only the authority can accept voters.
              let authority = electionAuthorityPubKey e
                  toSign    = encodeToSign (name, "acceptVoter" ∷ B.ByteString, voterPubKey)
              unless (verifySignature authority authoritySignature toSign) $ throwError InvalidSignature
              return $ state { stateElections = M.adjust (\e → e { electionAcceptedVoters = BM.insert voterPubKey voterName accepted }) name elections }

    RejectVoter name voterPubKey authoritySignature reason → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: voters may only be rejected during the registration stage.
          let stage = electionStage e
          unless (stage == Registration) $ throwError WrongStage
          -- Consensus rule: rejected voters must have previously registered.
          let pending = electionPendingVoters e
          case BM.lookup voterPubKey pending of
            Nothing → throwError VoterNotFound
            Just _  → do
              -- Consensus rule: rejected voters must not have already been accepted.
              let accepted = electionAcceptedVoters e
              when (BM.member voterPubKey accepted) $ throwError VoterAlreadyAccepted
              -- Consensus rule: rejected voters must not have already been rejected.
              let rejected = electionRejectedVoters e
              when (M.member voterPubKey rejected) $ throwError VoterAlreadyRejected
              -- Consensus rule: only the authority can reject voters.
              let authority = electionAuthorityPubKey e
                  toSign    = encodeToSign (name, "rejectVoter" ∷ B.ByteString, voterPubKey, reason)
              unless (verifySignature authority authoritySignature toSign) $ throwError InvalidSignature
              return $ state { stateElections = M.adjust (\e → e { electionRejectedVoters = M.insert voterPubKey reason rejected }) name elections }

    CastBallot name signature candidatePubKey → do
      case M.lookup name elections of
        Nothing → throwError ElectionNotFound
        Just e  → do
          -- Consensus rule: ballots may only be cast during the voting stage.
          let stage = electionStage e
          unless (stage == Voting) $ throwError WrongStage
          -- Consensus rule: cast ballot signatures must not have been duplicated.
          let signatures = electionBallotSignatures e
          when (V.any (LRS.link signature) signatures) $ throwError DuplicateSignature
          -- Consensus rule: signature must be valid.
          let ring    = electionVoterRing e
              toSign  = encodeToSign (name, "castVote" ∷ B.ByteString, candidatePubKey)
          unless (LRS.verify ring signature toSign) $ throwError InvalidSignature
          return $ state { stateElections = M.adjust (\e → e { electionVotes = M.insertWith ((+)) candidatePubKey 1 $ electionVotes e, electionBallotSignatures = V.cons signature $ electionBallotSignatures e }) name elections }

newElection ∷ C.PublicPoint → (Integer, Integer) → Election
newElection pubKey transitionBlocks = Election pubKey transitionBlocks Registration BM.empty BM.empty BM.empty BM.empty M.empty M.empty M.empty V.empty V.empty M.empty

verifySignature ∷ C.PublicPoint → C.Signature → B.ByteString → Bool
verifySignature pubKey signature msg = C.verify hashAlgorithm (C.PublicKey curve pubKey) signature msg

encodeToSign ∷ (B.Binary a) ⇒ a → B.ByteString
encodeToSign = BL.toStrict . B.encode
