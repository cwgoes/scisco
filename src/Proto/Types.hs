{- This file was auto-generated from types.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
module Proto.Types where
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Reexport.Lens.Family2
       as Lens.Family2
import qualified Data.ProtoLens.Reexport.Lens.Family2.Unchecked
       as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Reexport.Data.Default.Class
       as Data.Default.Class
import qualified Data.ProtoLens.Reexport.Data.Text as Data.Text
import qualified Data.ProtoLens.Reexport.Data.Map as Data.Map
import qualified Data.ProtoLens.Reexport.Data.ByteString
       as Data.ByteString
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels

data BlockID = BlockID{_BlockID'hash ::
                       !Data.ByteString.ByteString,
                       _BlockID'parts :: !(Prelude.Maybe PartSetHeader)}
             deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "hash" f BlockID BlockID a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _BlockID'hash
              (\ x__ y__ -> x__{_BlockID'hash = y__})

instance (a ~ PartSetHeader, b ~ PartSetHeader,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "parts" f BlockID BlockID a b
         where
        lensOf _
          = (Prelude..) maybe'parts
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe PartSetHeader,
          b ~ Prelude.Maybe PartSetHeader, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'parts" f BlockID BlockID a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _BlockID'parts
              (\ x__ y__ -> x__{_BlockID'parts = y__})

instance Data.Default.Class.Default BlockID where
        def
          = BlockID{_BlockID'hash = Data.ProtoLens.fieldDefault,
                    _BlockID'parts = Prelude.Nothing}

instance Data.ProtoLens.Message BlockID where
        descriptor
          = let hash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional hash)
                      :: Data.ProtoLens.FieldDescriptor BlockID
                parts__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parts"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor PartSetHeader)
                      (Data.ProtoLens.OptionalField maybe'parts)
                      :: Data.ProtoLens.FieldDescriptor BlockID
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, hash__field_descriptor),
                    (Data.ProtoLens.Tag 2, parts__field_descriptor)])
                (Data.Map.fromList
                   [("hash", hash__field_descriptor),
                    ("parts", parts__field_descriptor)])

data CodeType = OK
              | InternalError
              | EncodingError
              | BadNonce
              | Unauthorized
              | InsufficientFunds
              | UnknownRequest
              | BaseDuplicateAddress
              | BaseEncodingError
              | BaseInsufficientFees
              | BaseInsufficientFunds
              | BaseInsufficientGasPrice
              | BaseInvalidInput
              | BaseInvalidOutput
              | BaseInvalidPubKey
              | BaseInvalidSequence
              | BaseInvalidSignature
              | BaseUnknownAddress
              | BaseUnknownPubKey
              | BaseUnknownPlugin
              | GovUnknownEntity
              | GovUnknownGroup
              | GovUnknownProposal
              | GovDuplicateGroup
              | GovDuplicateMember
              | GovDuplicateProposal
              | GovDuplicateVote
              | GovInvalidMember
              | GovInvalidVote
              | GovInvalidVotingPower
              deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default CodeType where
        def = OK

instance Data.ProtoLens.FieldDefault CodeType where
        fieldDefault = OK

instance Data.ProtoLens.MessageEnum CodeType where
        maybeToEnum 0 = Prelude.Just OK
        maybeToEnum 1 = Prelude.Just InternalError
        maybeToEnum 2 = Prelude.Just EncodingError
        maybeToEnum 3 = Prelude.Just BadNonce
        maybeToEnum 4 = Prelude.Just Unauthorized
        maybeToEnum 5 = Prelude.Just InsufficientFunds
        maybeToEnum 6 = Prelude.Just UnknownRequest
        maybeToEnum 101 = Prelude.Just BaseDuplicateAddress
        maybeToEnum 102 = Prelude.Just BaseEncodingError
        maybeToEnum 103 = Prelude.Just BaseInsufficientFees
        maybeToEnum 104 = Prelude.Just BaseInsufficientFunds
        maybeToEnum 105 = Prelude.Just BaseInsufficientGasPrice
        maybeToEnum 106 = Prelude.Just BaseInvalidInput
        maybeToEnum 107 = Prelude.Just BaseInvalidOutput
        maybeToEnum 108 = Prelude.Just BaseInvalidPubKey
        maybeToEnum 109 = Prelude.Just BaseInvalidSequence
        maybeToEnum 110 = Prelude.Just BaseInvalidSignature
        maybeToEnum 111 = Prelude.Just BaseUnknownAddress
        maybeToEnum 112 = Prelude.Just BaseUnknownPubKey
        maybeToEnum 113 = Prelude.Just BaseUnknownPlugin
        maybeToEnum 201 = Prelude.Just GovUnknownEntity
        maybeToEnum 202 = Prelude.Just GovUnknownGroup
        maybeToEnum 203 = Prelude.Just GovUnknownProposal
        maybeToEnum 204 = Prelude.Just GovDuplicateGroup
        maybeToEnum 205 = Prelude.Just GovDuplicateMember
        maybeToEnum 206 = Prelude.Just GovDuplicateProposal
        maybeToEnum 207 = Prelude.Just GovDuplicateVote
        maybeToEnum 208 = Prelude.Just GovInvalidMember
        maybeToEnum 209 = Prelude.Just GovInvalidVote
        maybeToEnum 210 = Prelude.Just GovInvalidVotingPower
        maybeToEnum _ = Prelude.Nothing
        showEnum OK = "OK"
        showEnum InternalError = "InternalError"
        showEnum EncodingError = "EncodingError"
        showEnum BadNonce = "BadNonce"
        showEnum Unauthorized = "Unauthorized"
        showEnum InsufficientFunds = "InsufficientFunds"
        showEnum UnknownRequest = "UnknownRequest"
        showEnum BaseDuplicateAddress = "BaseDuplicateAddress"
        showEnum BaseEncodingError = "BaseEncodingError"
        showEnum BaseInsufficientFees = "BaseInsufficientFees"
        showEnum BaseInsufficientFunds = "BaseInsufficientFunds"
        showEnum BaseInsufficientGasPrice = "BaseInsufficientGasPrice"
        showEnum BaseInvalidInput = "BaseInvalidInput"
        showEnum BaseInvalidOutput = "BaseInvalidOutput"
        showEnum BaseInvalidPubKey = "BaseInvalidPubKey"
        showEnum BaseInvalidSequence = "BaseInvalidSequence"
        showEnum BaseInvalidSignature = "BaseInvalidSignature"
        showEnum BaseUnknownAddress = "BaseUnknownAddress"
        showEnum BaseUnknownPubKey = "BaseUnknownPubKey"
        showEnum BaseUnknownPlugin = "BaseUnknownPlugin"
        showEnum GovUnknownEntity = "GovUnknownEntity"
        showEnum GovUnknownGroup = "GovUnknownGroup"
        showEnum GovUnknownProposal = "GovUnknownProposal"
        showEnum GovDuplicateGroup = "GovDuplicateGroup"
        showEnum GovDuplicateMember = "GovDuplicateMember"
        showEnum GovDuplicateProposal = "GovDuplicateProposal"
        showEnum GovDuplicateVote = "GovDuplicateVote"
        showEnum GovInvalidMember = "GovInvalidMember"
        showEnum GovInvalidVote = "GovInvalidVote"
        showEnum GovInvalidVotingPower = "GovInvalidVotingPower"
        readEnum "OK" = Prelude.Just OK
        readEnum "InternalError" = Prelude.Just InternalError
        readEnum "EncodingError" = Prelude.Just EncodingError
        readEnum "BadNonce" = Prelude.Just BadNonce
        readEnum "Unauthorized" = Prelude.Just Unauthorized
        readEnum "InsufficientFunds" = Prelude.Just InsufficientFunds
        readEnum "UnknownRequest" = Prelude.Just UnknownRequest
        readEnum "BaseDuplicateAddress" = Prelude.Just BaseDuplicateAddress
        readEnum "BaseEncodingError" = Prelude.Just BaseEncodingError
        readEnum "BaseInsufficientFees" = Prelude.Just BaseInsufficientFees
        readEnum "BaseInsufficientFunds"
          = Prelude.Just BaseInsufficientFunds
        readEnum "BaseInsufficientGasPrice"
          = Prelude.Just BaseInsufficientGasPrice
        readEnum "BaseInvalidInput" = Prelude.Just BaseInvalidInput
        readEnum "BaseInvalidOutput" = Prelude.Just BaseInvalidOutput
        readEnum "BaseInvalidPubKey" = Prelude.Just BaseInvalidPubKey
        readEnum "BaseInvalidSequence" = Prelude.Just BaseInvalidSequence
        readEnum "BaseInvalidSignature" = Prelude.Just BaseInvalidSignature
        readEnum "BaseUnknownAddress" = Prelude.Just BaseUnknownAddress
        readEnum "BaseUnknownPubKey" = Prelude.Just BaseUnknownPubKey
        readEnum "BaseUnknownPlugin" = Prelude.Just BaseUnknownPlugin
        readEnum "GovUnknownEntity" = Prelude.Just GovUnknownEntity
        readEnum "GovUnknownGroup" = Prelude.Just GovUnknownGroup
        readEnum "GovUnknownProposal" = Prelude.Just GovUnknownProposal
        readEnum "GovDuplicateGroup" = Prelude.Just GovDuplicateGroup
        readEnum "GovDuplicateMember" = Prelude.Just GovDuplicateMember
        readEnum "GovDuplicateProposal" = Prelude.Just GovDuplicateProposal
        readEnum "GovDuplicateVote" = Prelude.Just GovDuplicateVote
        readEnum "GovInvalidMember" = Prelude.Just GovInvalidMember
        readEnum "GovInvalidVote" = Prelude.Just GovInvalidVote
        readEnum "GovInvalidVotingPower"
          = Prelude.Just GovInvalidVotingPower
        readEnum _ = Prelude.Nothing

instance Prelude.Enum CodeType where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum CodeType: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum OK = 0
        fromEnum InternalError = 1
        fromEnum EncodingError = 2
        fromEnum BadNonce = 3
        fromEnum Unauthorized = 4
        fromEnum InsufficientFunds = 5
        fromEnum UnknownRequest = 6
        fromEnum BaseDuplicateAddress = 101
        fromEnum BaseEncodingError = 102
        fromEnum BaseInsufficientFees = 103
        fromEnum BaseInsufficientFunds = 104
        fromEnum BaseInsufficientGasPrice = 105
        fromEnum BaseInvalidInput = 106
        fromEnum BaseInvalidOutput = 107
        fromEnum BaseInvalidPubKey = 108
        fromEnum BaseInvalidSequence = 109
        fromEnum BaseInvalidSignature = 110
        fromEnum BaseUnknownAddress = 111
        fromEnum BaseUnknownPubKey = 112
        fromEnum BaseUnknownPlugin = 113
        fromEnum GovUnknownEntity = 201
        fromEnum GovUnknownGroup = 202
        fromEnum GovUnknownProposal = 203
        fromEnum GovDuplicateGroup = 204
        fromEnum GovDuplicateMember = 205
        fromEnum GovDuplicateProposal = 206
        fromEnum GovDuplicateVote = 207
        fromEnum GovInvalidMember = 208
        fromEnum GovInvalidVote = 209
        fromEnum GovInvalidVotingPower = 210
        succ GovInvalidVotingPower
          = Prelude.error
              "CodeType.succ: bad argument GovInvalidVotingPower. This value would be out of bounds."
        succ OK = InternalError
        succ InternalError = EncodingError
        succ EncodingError = BadNonce
        succ BadNonce = Unauthorized
        succ Unauthorized = InsufficientFunds
        succ InsufficientFunds = UnknownRequest
        succ UnknownRequest = BaseDuplicateAddress
        succ BaseDuplicateAddress = BaseEncodingError
        succ BaseEncodingError = BaseInsufficientFees
        succ BaseInsufficientFees = BaseInsufficientFunds
        succ BaseInsufficientFunds = BaseInsufficientGasPrice
        succ BaseInsufficientGasPrice = BaseInvalidInput
        succ BaseInvalidInput = BaseInvalidOutput
        succ BaseInvalidOutput = BaseInvalidPubKey
        succ BaseInvalidPubKey = BaseInvalidSequence
        succ BaseInvalidSequence = BaseInvalidSignature
        succ BaseInvalidSignature = BaseUnknownAddress
        succ BaseUnknownAddress = BaseUnknownPubKey
        succ BaseUnknownPubKey = BaseUnknownPlugin
        succ BaseUnknownPlugin = GovUnknownEntity
        succ GovUnknownEntity = GovUnknownGroup
        succ GovUnknownGroup = GovUnknownProposal
        succ GovUnknownProposal = GovDuplicateGroup
        succ GovDuplicateGroup = GovDuplicateMember
        succ GovDuplicateMember = GovDuplicateProposal
        succ GovDuplicateProposal = GovDuplicateVote
        succ GovDuplicateVote = GovInvalidMember
        succ GovInvalidMember = GovInvalidVote
        succ GovInvalidVote = GovInvalidVotingPower
        pred OK
          = Prelude.error
              "CodeType.pred: bad argument OK. This value would be out of bounds."
        pred InternalError = OK
        pred EncodingError = InternalError
        pred BadNonce = EncodingError
        pred Unauthorized = BadNonce
        pred InsufficientFunds = Unauthorized
        pred UnknownRequest = InsufficientFunds
        pred BaseDuplicateAddress = UnknownRequest
        pred BaseEncodingError = BaseDuplicateAddress
        pred BaseInsufficientFees = BaseEncodingError
        pred BaseInsufficientFunds = BaseInsufficientFees
        pred BaseInsufficientGasPrice = BaseInsufficientFunds
        pred BaseInvalidInput = BaseInsufficientGasPrice
        pred BaseInvalidOutput = BaseInvalidInput
        pred BaseInvalidPubKey = BaseInvalidOutput
        pred BaseInvalidSequence = BaseInvalidPubKey
        pred BaseInvalidSignature = BaseInvalidSequence
        pred BaseUnknownAddress = BaseInvalidSignature
        pred BaseUnknownPubKey = BaseUnknownAddress
        pred BaseUnknownPlugin = BaseUnknownPubKey
        pred GovUnknownEntity = BaseUnknownPlugin
        pred GovUnknownGroup = GovUnknownEntity
        pred GovUnknownProposal = GovUnknownGroup
        pred GovDuplicateGroup = GovUnknownProposal
        pred GovDuplicateMember = GovDuplicateGroup
        pred GovDuplicateProposal = GovDuplicateMember
        pred GovDuplicateVote = GovDuplicateProposal
        pred GovInvalidMember = GovDuplicateVote
        pred GovInvalidVote = GovInvalidMember
        pred GovInvalidVotingPower = GovInvalidVote
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded CodeType where
        minBound = OK
        maxBound = GovInvalidVotingPower

data Header = Header{_Header'chainId :: !Data.Text.Text,
                     _Header'height :: !Data.Word.Word64,
                     _Header'time :: !Data.Word.Word64,
                     _Header'numTxs :: !Data.Word.Word64,
                     _Header'lastBlockId :: !(Prelude.Maybe BlockID),
                     _Header'lastCommitHash :: !Data.ByteString.ByteString,
                     _Header'dataHash :: !Data.ByteString.ByteString,
                     _Header'validatorsHash :: !Data.ByteString.ByteString,
                     _Header'appHash :: !Data.ByteString.ByteString}
            deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "chainId" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'chainId
              (\ x__ y__ -> x__{_Header'chainId = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "height" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'height
              (\ x__ y__ -> x__{_Header'height = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "time" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'time
              (\ x__ y__ -> x__{_Header'time = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "numTxs" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'numTxs
              (\ x__ y__ -> x__{_Header'numTxs = y__})

instance (a ~ BlockID, b ~ BlockID, Prelude.Functor f) =>
         Lens.Labels.HasLens "lastBlockId" f Header Header a b
         where
        lensOf _
          = (Prelude..) maybe'lastBlockId
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe BlockID, b ~ Prelude.Maybe BlockID,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'lastBlockId" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'lastBlockId
              (\ x__ y__ -> x__{_Header'lastBlockId = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "lastCommitHash" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'lastCommitHash
              (\ x__ y__ -> x__{_Header'lastCommitHash = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "dataHash" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'dataHash
              (\ x__ y__ -> x__{_Header'dataHash = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "validatorsHash" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'validatorsHash
              (\ x__ y__ -> x__{_Header'validatorsHash = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "appHash" f Header Header a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Header'appHash
              (\ x__ y__ -> x__{_Header'appHash = y__})

instance Data.Default.Class.Default Header where
        def
          = Header{_Header'chainId = Data.ProtoLens.fieldDefault,
                   _Header'height = Data.ProtoLens.fieldDefault,
                   _Header'time = Data.ProtoLens.fieldDefault,
                   _Header'numTxs = Data.ProtoLens.fieldDefault,
                   _Header'lastBlockId = Prelude.Nothing,
                   _Header'lastCommitHash = Data.ProtoLens.fieldDefault,
                   _Header'dataHash = Data.ProtoLens.fieldDefault,
                   _Header'validatorsHash = Data.ProtoLens.fieldDefault,
                   _Header'appHash = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message Header where
        descriptor
          = let chainId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "chain_id"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional chainId)
                      :: Data.ProtoLens.FieldDescriptor Header
                height__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "height"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional height)
                      :: Data.ProtoLens.FieldDescriptor Header
                time__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "time"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional time)
                      :: Data.ProtoLens.FieldDescriptor Header
                numTxs__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "num_txs"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional numTxs)
                      :: Data.ProtoLens.FieldDescriptor Header
                lastBlockId__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "last_block_id"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor BlockID)
                      (Data.ProtoLens.OptionalField maybe'lastBlockId)
                      :: Data.ProtoLens.FieldDescriptor Header
                lastCommitHash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "last_commit_hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional lastCommitHash)
                      :: Data.ProtoLens.FieldDescriptor Header
                dataHash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data_hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional dataHash)
                      :: Data.ProtoLens.FieldDescriptor Header
                validatorsHash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "validators_hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional validatorsHash)
                      :: Data.ProtoLens.FieldDescriptor Header
                appHash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "app_hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional appHash)
                      :: Data.ProtoLens.FieldDescriptor Header
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, chainId__field_descriptor),
                    (Data.ProtoLens.Tag 2, height__field_descriptor),
                    (Data.ProtoLens.Tag 3, time__field_descriptor),
                    (Data.ProtoLens.Tag 4, numTxs__field_descriptor),
                    (Data.ProtoLens.Tag 5, lastBlockId__field_descriptor),
                    (Data.ProtoLens.Tag 6, lastCommitHash__field_descriptor),
                    (Data.ProtoLens.Tag 7, dataHash__field_descriptor),
                    (Data.ProtoLens.Tag 8, validatorsHash__field_descriptor),
                    (Data.ProtoLens.Tag 9, appHash__field_descriptor)])
                (Data.Map.fromList
                   [("chain_id", chainId__field_descriptor),
                    ("height", height__field_descriptor),
                    ("time", time__field_descriptor),
                    ("num_txs", numTxs__field_descriptor),
                    ("last_block_id", lastBlockId__field_descriptor),
                    ("last_commit_hash", lastCommitHash__field_descriptor),
                    ("data_hash", dataHash__field_descriptor),
                    ("validators_hash", validatorsHash__field_descriptor),
                    ("app_hash", appHash__field_descriptor)])

data PartSetHeader = PartSetHeader{_PartSetHeader'total ::
                                   !Data.Word.Word64,
                                   _PartSetHeader'hash :: !Data.ByteString.ByteString}
                   deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "total" f PartSetHeader PartSetHeader a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _PartSetHeader'total
              (\ x__ y__ -> x__{_PartSetHeader'total = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "hash" f PartSetHeader PartSetHeader a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _PartSetHeader'hash
              (\ x__ y__ -> x__{_PartSetHeader'hash = y__})

instance Data.Default.Class.Default PartSetHeader where
        def
          = PartSetHeader{_PartSetHeader'total = Data.ProtoLens.fieldDefault,
                          _PartSetHeader'hash = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message PartSetHeader where
        descriptor
          = let total__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "total"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional total)
                      :: Data.ProtoLens.FieldDescriptor PartSetHeader
                hash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional hash)
                      :: Data.ProtoLens.FieldDescriptor PartSetHeader
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, total__field_descriptor),
                    (Data.ProtoLens.Tag 2, hash__field_descriptor)])
                (Data.Map.fromList
                   [("total", total__field_descriptor),
                    ("hash", hash__field_descriptor)])

data Request = Request{_Request'echo ::
                       !(Prelude.Maybe RequestEcho),
                       _Request'flush :: !(Prelude.Maybe RequestFlush),
                       _Request'info :: !(Prelude.Maybe RequestInfo),
                       _Request'setOption :: !(Prelude.Maybe RequestSetOption),
                       _Request'deliverTx :: !(Prelude.Maybe RequestDeliverTx),
                       _Request'checkTx :: !(Prelude.Maybe RequestCheckTx),
                       _Request'commit :: !(Prelude.Maybe RequestCommit),
                       _Request'query :: !(Prelude.Maybe RequestQuery),
                       _Request'initChain :: !(Prelude.Maybe RequestInitChain),
                       _Request'beginBlock :: !(Prelude.Maybe RequestBeginBlock),
                       _Request'endBlock :: !(Prelude.Maybe RequestEndBlock)}
             deriving (Prelude.Show, Prelude.Eq)

instance (a ~ RequestEcho, b ~ RequestEcho, Prelude.Functor f) =>
         Lens.Labels.HasLens "echo" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'echo
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestEcho,
          b ~ Prelude.Maybe RequestEcho, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'echo" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'echo
              (\ x__ y__ -> x__{_Request'echo = y__})

instance (a ~ RequestFlush, b ~ RequestFlush, Prelude.Functor f) =>
         Lens.Labels.HasLens "flush" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'flush
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestFlush,
          b ~ Prelude.Maybe RequestFlush, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'flush" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'flush
              (\ x__ y__ -> x__{_Request'flush = y__})

instance (a ~ RequestInfo, b ~ RequestInfo, Prelude.Functor f) =>
         Lens.Labels.HasLens "info" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'info
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestInfo,
          b ~ Prelude.Maybe RequestInfo, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'info" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'info
              (\ x__ y__ -> x__{_Request'info = y__})

instance (a ~ RequestSetOption, b ~ RequestSetOption,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "setOption" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'setOption
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestSetOption,
          b ~ Prelude.Maybe RequestSetOption, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'setOption" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'setOption
              (\ x__ y__ -> x__{_Request'setOption = y__})

instance (a ~ RequestDeliverTx, b ~ RequestDeliverTx,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "deliverTx" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'deliverTx
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestDeliverTx,
          b ~ Prelude.Maybe RequestDeliverTx, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'deliverTx" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'deliverTx
              (\ x__ y__ -> x__{_Request'deliverTx = y__})

instance (a ~ RequestCheckTx, b ~ RequestCheckTx,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "checkTx" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'checkTx
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestCheckTx,
          b ~ Prelude.Maybe RequestCheckTx, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'checkTx" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'checkTx
              (\ x__ y__ -> x__{_Request'checkTx = y__})

instance (a ~ RequestCommit, b ~ RequestCommit,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "commit" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'commit
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestCommit,
          b ~ Prelude.Maybe RequestCommit, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'commit" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'commit
              (\ x__ y__ -> x__{_Request'commit = y__})

instance (a ~ RequestQuery, b ~ RequestQuery, Prelude.Functor f) =>
         Lens.Labels.HasLens "query" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'query
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestQuery,
          b ~ Prelude.Maybe RequestQuery, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'query" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'query
              (\ x__ y__ -> x__{_Request'query = y__})

instance (a ~ RequestInitChain, b ~ RequestInitChain,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "initChain" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'initChain
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestInitChain,
          b ~ Prelude.Maybe RequestInitChain, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'initChain" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'initChain
              (\ x__ y__ -> x__{_Request'initChain = y__})

instance (a ~ RequestBeginBlock, b ~ RequestBeginBlock,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "beginBlock" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'beginBlock
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestBeginBlock,
          b ~ Prelude.Maybe RequestBeginBlock, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'beginBlock" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'beginBlock
              (\ x__ y__ -> x__{_Request'beginBlock = y__})

instance (a ~ RequestEndBlock, b ~ RequestEndBlock,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "endBlock" f Request Request a b
         where
        lensOf _
          = (Prelude..) maybe'endBlock
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe RequestEndBlock,
          b ~ Prelude.Maybe RequestEndBlock, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'endBlock" f Request Request a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Request'endBlock
              (\ x__ y__ -> x__{_Request'endBlock = y__})

instance Data.Default.Class.Default Request where
        def
          = Request{_Request'echo = Prelude.Nothing,
                    _Request'flush = Prelude.Nothing, _Request'info = Prelude.Nothing,
                    _Request'setOption = Prelude.Nothing,
                    _Request'deliverTx = Prelude.Nothing,
                    _Request'checkTx = Prelude.Nothing,
                    _Request'commit = Prelude.Nothing,
                    _Request'query = Prelude.Nothing,
                    _Request'initChain = Prelude.Nothing,
                    _Request'beginBlock = Prelude.Nothing,
                    _Request'endBlock = Prelude.Nothing}

instance Data.ProtoLens.Message Request where
        descriptor
          = let echo__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "echo"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestEcho)
                      (Data.ProtoLens.OptionalField maybe'echo)
                      :: Data.ProtoLens.FieldDescriptor Request
                flush__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "flush"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestFlush)
                      (Data.ProtoLens.OptionalField maybe'flush)
                      :: Data.ProtoLens.FieldDescriptor Request
                info__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "info"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestInfo)
                      (Data.ProtoLens.OptionalField maybe'info)
                      :: Data.ProtoLens.FieldDescriptor Request
                setOption__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "set_option"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestSetOption)
                      (Data.ProtoLens.OptionalField maybe'setOption)
                      :: Data.ProtoLens.FieldDescriptor Request
                deliverTx__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "deliver_tx"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestDeliverTx)
                      (Data.ProtoLens.OptionalField maybe'deliverTx)
                      :: Data.ProtoLens.FieldDescriptor Request
                checkTx__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "check_tx"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestCheckTx)
                      (Data.ProtoLens.OptionalField maybe'checkTx)
                      :: Data.ProtoLens.FieldDescriptor Request
                commit__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "commit"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestCommit)
                      (Data.ProtoLens.OptionalField maybe'commit)
                      :: Data.ProtoLens.FieldDescriptor Request
                query__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "query"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestQuery)
                      (Data.ProtoLens.OptionalField maybe'query)
                      :: Data.ProtoLens.FieldDescriptor Request
                initChain__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "init_chain"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestInitChain)
                      (Data.ProtoLens.OptionalField maybe'initChain)
                      :: Data.ProtoLens.FieldDescriptor Request
                beginBlock__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "begin_block"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestBeginBlock)
                      (Data.ProtoLens.OptionalField maybe'beginBlock)
                      :: Data.ProtoLens.FieldDescriptor Request
                endBlock__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "end_block"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor RequestEndBlock)
                      (Data.ProtoLens.OptionalField maybe'endBlock)
                      :: Data.ProtoLens.FieldDescriptor Request
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, echo__field_descriptor),
                    (Data.ProtoLens.Tag 2, flush__field_descriptor),
                    (Data.ProtoLens.Tag 3, info__field_descriptor),
                    (Data.ProtoLens.Tag 4, setOption__field_descriptor),
                    (Data.ProtoLens.Tag 5, deliverTx__field_descriptor),
                    (Data.ProtoLens.Tag 6, checkTx__field_descriptor),
                    (Data.ProtoLens.Tag 7, commit__field_descriptor),
                    (Data.ProtoLens.Tag 8, query__field_descriptor),
                    (Data.ProtoLens.Tag 9, initChain__field_descriptor),
                    (Data.ProtoLens.Tag 10, beginBlock__field_descriptor),
                    (Data.ProtoLens.Tag 11, endBlock__field_descriptor)])
                (Data.Map.fromList
                   [("echo", echo__field_descriptor),
                    ("flush", flush__field_descriptor),
                    ("info", info__field_descriptor),
                    ("set_option", setOption__field_descriptor),
                    ("deliver_tx", deliverTx__field_descriptor),
                    ("check_tx", checkTx__field_descriptor),
                    ("commit", commit__field_descriptor),
                    ("query", query__field_descriptor),
                    ("init_chain", initChain__field_descriptor),
                    ("begin_block", beginBlock__field_descriptor),
                    ("end_block", endBlock__field_descriptor)])

data RequestBeginBlock = RequestBeginBlock{_RequestBeginBlock'hash
                                           :: !Data.ByteString.ByteString,
                                           _RequestBeginBlock'header :: !(Prelude.Maybe Header)}
                       deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "hash" f RequestBeginBlock RequestBeginBlock a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestBeginBlock'hash
              (\ x__ y__ -> x__{_RequestBeginBlock'hash = y__})

instance (a ~ Header, b ~ Header, Prelude.Functor f) =>
         Lens.Labels.HasLens "header" f RequestBeginBlock RequestBeginBlock
           a
           b
         where
        lensOf _
          = (Prelude..) maybe'header
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Header, b ~ Prelude.Maybe Header,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'header" f RequestBeginBlock
           RequestBeginBlock
           a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestBeginBlock'header
              (\ x__ y__ -> x__{_RequestBeginBlock'header = y__})

instance Data.Default.Class.Default RequestBeginBlock where
        def
          = RequestBeginBlock{_RequestBeginBlock'hash =
                                Data.ProtoLens.fieldDefault,
                              _RequestBeginBlock'header = Prelude.Nothing}

instance Data.ProtoLens.Message RequestBeginBlock where
        descriptor
          = let hash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional hash)
                      :: Data.ProtoLens.FieldDescriptor RequestBeginBlock
                header__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "header"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Header)
                      (Data.ProtoLens.OptionalField maybe'header)
                      :: Data.ProtoLens.FieldDescriptor RequestBeginBlock
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, hash__field_descriptor),
                    (Data.ProtoLens.Tag 2, header__field_descriptor)])
                (Data.Map.fromList
                   [("hash", hash__field_descriptor),
                    ("header", header__field_descriptor)])

data RequestCheckTx = RequestCheckTx{_RequestCheckTx'tx ::
                                     !Data.ByteString.ByteString}
                    deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "tx" f RequestCheckTx RequestCheckTx a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestCheckTx'tx
              (\ x__ y__ -> x__{_RequestCheckTx'tx = y__})

instance Data.Default.Class.Default RequestCheckTx where
        def
          = RequestCheckTx{_RequestCheckTx'tx = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message RequestCheckTx where
        descriptor
          = let tx__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "tx"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional tx)
                      :: Data.ProtoLens.FieldDescriptor RequestCheckTx
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList [(Data.ProtoLens.Tag 1, tx__field_descriptor)])
                (Data.Map.fromList [("tx", tx__field_descriptor)])

data RequestCommit = RequestCommit{}
                   deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default RequestCommit where
        def = RequestCommit{}

instance Data.ProtoLens.Message RequestCommit where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor (Data.Map.fromList [])
                (Data.Map.fromList [])

data RequestDeliverTx = RequestDeliverTx{_RequestDeliverTx'tx ::
                                         !Data.ByteString.ByteString}
                      deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "tx" f RequestDeliverTx RequestDeliverTx a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestDeliverTx'tx
              (\ x__ y__ -> x__{_RequestDeliverTx'tx = y__})

instance Data.Default.Class.Default RequestDeliverTx where
        def
          = RequestDeliverTx{_RequestDeliverTx'tx =
                               Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message RequestDeliverTx where
        descriptor
          = let tx__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "tx"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional tx)
                      :: Data.ProtoLens.FieldDescriptor RequestDeliverTx
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList [(Data.ProtoLens.Tag 1, tx__field_descriptor)])
                (Data.Map.fromList [("tx", tx__field_descriptor)])

data RequestEcho = RequestEcho{_RequestEcho'message ::
                               !Data.Text.Text}
                 deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "message" f RequestEcho RequestEcho a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestEcho'message
              (\ x__ y__ -> x__{_RequestEcho'message = y__})

instance Data.Default.Class.Default RequestEcho where
        def
          = RequestEcho{_RequestEcho'message = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message RequestEcho where
        descriptor
          = let message__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "message"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional message)
                      :: Data.ProtoLens.FieldDescriptor RequestEcho
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, message__field_descriptor)])
                (Data.Map.fromList [("message", message__field_descriptor)])

data RequestEndBlock = RequestEndBlock{_RequestEndBlock'height ::
                                       !Data.Word.Word64}
                     deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "height" f RequestEndBlock RequestEndBlock a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestEndBlock'height
              (\ x__ y__ -> x__{_RequestEndBlock'height = y__})

instance Data.Default.Class.Default RequestEndBlock where
        def
          = RequestEndBlock{_RequestEndBlock'height =
                              Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message RequestEndBlock where
        descriptor
          = let height__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "height"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional height)
                      :: Data.ProtoLens.FieldDescriptor RequestEndBlock
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, height__field_descriptor)])
                (Data.Map.fromList [("height", height__field_descriptor)])

data RequestFlush = RequestFlush{}
                  deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default RequestFlush where
        def = RequestFlush{}

instance Data.ProtoLens.Message RequestFlush where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor (Data.Map.fromList [])
                (Data.Map.fromList [])

data RequestInfo = RequestInfo{}
                 deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default RequestInfo where
        def = RequestInfo{}

instance Data.ProtoLens.Message RequestInfo where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor (Data.Map.fromList [])
                (Data.Map.fromList [])

data RequestInitChain = RequestInitChain{_RequestInitChain'validators
                                         :: ![Validator]}
                      deriving (Prelude.Show, Prelude.Eq)

instance (a ~ [Validator], b ~ [Validator], Prelude.Functor f) =>
         Lens.Labels.HasLens "validators" f RequestInitChain
           RequestInitChain
           a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestInitChain'validators
              (\ x__ y__ -> x__{_RequestInitChain'validators = y__})

instance Data.Default.Class.Default RequestInitChain where
        def = RequestInitChain{_RequestInitChain'validators = []}

instance Data.ProtoLens.Message RequestInitChain where
        descriptor
          = let validators__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "validators"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Validator)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked validators)
                      :: Data.ProtoLens.FieldDescriptor RequestInitChain
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, validators__field_descriptor)])
                (Data.Map.fromList [("validators", validators__field_descriptor)])

data RequestQuery = RequestQuery{_RequestQuery'data' ::
                                 !Data.ByteString.ByteString,
                                 _RequestQuery'path :: !Data.Text.Text,
                                 _RequestQuery'height :: !Data.Word.Word64,
                                 _RequestQuery'prove :: !Prelude.Bool}
                  deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "data'" f RequestQuery RequestQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestQuery'data'
              (\ x__ y__ -> x__{_RequestQuery'data' = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f RequestQuery RequestQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestQuery'path
              (\ x__ y__ -> x__{_RequestQuery'path = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "height" f RequestQuery RequestQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestQuery'height
              (\ x__ y__ -> x__{_RequestQuery'height = y__})

instance (a ~ Prelude.Bool, b ~ Prelude.Bool, Prelude.Functor f) =>
         Lens.Labels.HasLens "prove" f RequestQuery RequestQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestQuery'prove
              (\ x__ y__ -> x__{_RequestQuery'prove = y__})

instance Data.Default.Class.Default RequestQuery where
        def
          = RequestQuery{_RequestQuery'data' = Data.ProtoLens.fieldDefault,
                         _RequestQuery'path = Data.ProtoLens.fieldDefault,
                         _RequestQuery'height = Data.ProtoLens.fieldDefault,
                         _RequestQuery'prove = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message RequestQuery where
        descriptor
          = let data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional data')
                      :: Data.ProtoLens.FieldDescriptor RequestQuery
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional path)
                      :: Data.ProtoLens.FieldDescriptor RequestQuery
                height__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "height"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional height)
                      :: Data.ProtoLens.FieldDescriptor RequestQuery
                prove__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "prove"
                      (Data.ProtoLens.BoolField ::
                         Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional prove)
                      :: Data.ProtoLens.FieldDescriptor RequestQuery
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, data'__field_descriptor),
                    (Data.ProtoLens.Tag 2, path__field_descriptor),
                    (Data.ProtoLens.Tag 3, height__field_descriptor),
                    (Data.ProtoLens.Tag 4, prove__field_descriptor)])
                (Data.Map.fromList
                   [("data", data'__field_descriptor),
                    ("path", path__field_descriptor),
                    ("height", height__field_descriptor),
                    ("prove", prove__field_descriptor)])

data RequestSetOption = RequestSetOption{_RequestSetOption'key ::
                                         !Data.Text.Text,
                                         _RequestSetOption'value :: !Data.Text.Text}
                      deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "key" f RequestSetOption RequestSetOption a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestSetOption'key
              (\ x__ y__ -> x__{_RequestSetOption'key = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "value" f RequestSetOption RequestSetOption a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _RequestSetOption'value
              (\ x__ y__ -> x__{_RequestSetOption'value = y__})

instance Data.Default.Class.Default RequestSetOption where
        def
          = RequestSetOption{_RequestSetOption'key =
                               Data.ProtoLens.fieldDefault,
                             _RequestSetOption'value = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message RequestSetOption where
        descriptor
          = let key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional key)
                      :: Data.ProtoLens.FieldDescriptor RequestSetOption
                value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional value)
                      :: Data.ProtoLens.FieldDescriptor RequestSetOption
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, key__field_descriptor),
                    (Data.ProtoLens.Tag 2, value__field_descriptor)])
                (Data.Map.fromList
                   [("key", key__field_descriptor),
                    ("value", value__field_descriptor)])

data Response = Response{_Response'exception ::
                         !(Prelude.Maybe ResponseException),
                         _Response'echo :: !(Prelude.Maybe ResponseEcho),
                         _Response'flush :: !(Prelude.Maybe ResponseFlush),
                         _Response'info :: !(Prelude.Maybe ResponseInfo),
                         _Response'setOption :: !(Prelude.Maybe ResponseSetOption),
                         _Response'deliverTx :: !(Prelude.Maybe ResponseDeliverTx),
                         _Response'checkTx :: !(Prelude.Maybe ResponseCheckTx),
                         _Response'commit :: !(Prelude.Maybe ResponseCommit),
                         _Response'query :: !(Prelude.Maybe ResponseQuery),
                         _Response'initChain :: !(Prelude.Maybe ResponseInitChain),
                         _Response'beginBlock :: !(Prelude.Maybe ResponseBeginBlock),
                         _Response'endBlock :: !(Prelude.Maybe ResponseEndBlock)}
              deriving (Prelude.Show, Prelude.Eq)

instance (a ~ ResponseException, b ~ ResponseException,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "exception" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'exception
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseException,
          b ~ Prelude.Maybe ResponseException, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'exception" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'exception
              (\ x__ y__ -> x__{_Response'exception = y__})

instance (a ~ ResponseEcho, b ~ ResponseEcho, Prelude.Functor f) =>
         Lens.Labels.HasLens "echo" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'echo
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseEcho,
          b ~ Prelude.Maybe ResponseEcho, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'echo" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'echo
              (\ x__ y__ -> x__{_Response'echo = y__})

instance (a ~ ResponseFlush, b ~ ResponseFlush,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "flush" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'flush
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseFlush,
          b ~ Prelude.Maybe ResponseFlush, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'flush" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'flush
              (\ x__ y__ -> x__{_Response'flush = y__})

instance (a ~ ResponseInfo, b ~ ResponseInfo, Prelude.Functor f) =>
         Lens.Labels.HasLens "info" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'info
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseInfo,
          b ~ Prelude.Maybe ResponseInfo, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'info" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'info
              (\ x__ y__ -> x__{_Response'info = y__})

instance (a ~ ResponseSetOption, b ~ ResponseSetOption,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "setOption" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'setOption
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseSetOption,
          b ~ Prelude.Maybe ResponseSetOption, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'setOption" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'setOption
              (\ x__ y__ -> x__{_Response'setOption = y__})

instance (a ~ ResponseDeliverTx, b ~ ResponseDeliverTx,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "deliverTx" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'deliverTx
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseDeliverTx,
          b ~ Prelude.Maybe ResponseDeliverTx, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'deliverTx" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'deliverTx
              (\ x__ y__ -> x__{_Response'deliverTx = y__})

instance (a ~ ResponseCheckTx, b ~ ResponseCheckTx,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "checkTx" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'checkTx
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseCheckTx,
          b ~ Prelude.Maybe ResponseCheckTx, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'checkTx" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'checkTx
              (\ x__ y__ -> x__{_Response'checkTx = y__})

instance (a ~ ResponseCommit, b ~ ResponseCommit,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "commit" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'commit
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseCommit,
          b ~ Prelude.Maybe ResponseCommit, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'commit" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'commit
              (\ x__ y__ -> x__{_Response'commit = y__})

instance (a ~ ResponseQuery, b ~ ResponseQuery,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "query" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'query
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseQuery,
          b ~ Prelude.Maybe ResponseQuery, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'query" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'query
              (\ x__ y__ -> x__{_Response'query = y__})

instance (a ~ ResponseInitChain, b ~ ResponseInitChain,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "initChain" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'initChain
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseInitChain,
          b ~ Prelude.Maybe ResponseInitChain, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'initChain" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'initChain
              (\ x__ y__ -> x__{_Response'initChain = y__})

instance (a ~ ResponseBeginBlock, b ~ ResponseBeginBlock,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "beginBlock" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'beginBlock
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseBeginBlock,
          b ~ Prelude.Maybe ResponseBeginBlock, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'beginBlock" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'beginBlock
              (\ x__ y__ -> x__{_Response'beginBlock = y__})

instance (a ~ ResponseEndBlock, b ~ ResponseEndBlock,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "endBlock" f Response Response a b
         where
        lensOf _
          = (Prelude..) maybe'endBlock
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe ResponseEndBlock,
          b ~ Prelude.Maybe ResponseEndBlock, Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'endBlock" f Response Response a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Response'endBlock
              (\ x__ y__ -> x__{_Response'endBlock = y__})

instance Data.Default.Class.Default Response where
        def
          = Response{_Response'exception = Prelude.Nothing,
                     _Response'echo = Prelude.Nothing,
                     _Response'flush = Prelude.Nothing,
                     _Response'info = Prelude.Nothing,
                     _Response'setOption = Prelude.Nothing,
                     _Response'deliverTx = Prelude.Nothing,
                     _Response'checkTx = Prelude.Nothing,
                     _Response'commit = Prelude.Nothing,
                     _Response'query = Prelude.Nothing,
                     _Response'initChain = Prelude.Nothing,
                     _Response'beginBlock = Prelude.Nothing,
                     _Response'endBlock = Prelude.Nothing}

instance Data.ProtoLens.Message Response where
        descriptor
          = let exception__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "exception"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseException)
                      (Data.ProtoLens.OptionalField maybe'exception)
                      :: Data.ProtoLens.FieldDescriptor Response
                echo__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "echo"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseEcho)
                      (Data.ProtoLens.OptionalField maybe'echo)
                      :: Data.ProtoLens.FieldDescriptor Response
                flush__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "flush"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseFlush)
                      (Data.ProtoLens.OptionalField maybe'flush)
                      :: Data.ProtoLens.FieldDescriptor Response
                info__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "info"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseInfo)
                      (Data.ProtoLens.OptionalField maybe'info)
                      :: Data.ProtoLens.FieldDescriptor Response
                setOption__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "set_option"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseSetOption)
                      (Data.ProtoLens.OptionalField maybe'setOption)
                      :: Data.ProtoLens.FieldDescriptor Response
                deliverTx__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "deliver_tx"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseDeliverTx)
                      (Data.ProtoLens.OptionalField maybe'deliverTx)
                      :: Data.ProtoLens.FieldDescriptor Response
                checkTx__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "check_tx"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseCheckTx)
                      (Data.ProtoLens.OptionalField maybe'checkTx)
                      :: Data.ProtoLens.FieldDescriptor Response
                commit__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "commit"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseCommit)
                      (Data.ProtoLens.OptionalField maybe'commit)
                      :: Data.ProtoLens.FieldDescriptor Response
                query__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "query"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseQuery)
                      (Data.ProtoLens.OptionalField maybe'query)
                      :: Data.ProtoLens.FieldDescriptor Response
                initChain__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "init_chain"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseInitChain)
                      (Data.ProtoLens.OptionalField maybe'initChain)
                      :: Data.ProtoLens.FieldDescriptor Response
                beginBlock__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "begin_block"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseBeginBlock)
                      (Data.ProtoLens.OptionalField maybe'beginBlock)
                      :: Data.ProtoLens.FieldDescriptor Response
                endBlock__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "end_block"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor ResponseEndBlock)
                      (Data.ProtoLens.OptionalField maybe'endBlock)
                      :: Data.ProtoLens.FieldDescriptor Response
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, exception__field_descriptor),
                    (Data.ProtoLens.Tag 2, echo__field_descriptor),
                    (Data.ProtoLens.Tag 3, flush__field_descriptor),
                    (Data.ProtoLens.Tag 4, info__field_descriptor),
                    (Data.ProtoLens.Tag 5, setOption__field_descriptor),
                    (Data.ProtoLens.Tag 6, deliverTx__field_descriptor),
                    (Data.ProtoLens.Tag 7, checkTx__field_descriptor),
                    (Data.ProtoLens.Tag 8, commit__field_descriptor),
                    (Data.ProtoLens.Tag 9, query__field_descriptor),
                    (Data.ProtoLens.Tag 10, initChain__field_descriptor),
                    (Data.ProtoLens.Tag 11, beginBlock__field_descriptor),
                    (Data.ProtoLens.Tag 12, endBlock__field_descriptor)])
                (Data.Map.fromList
                   [("exception", exception__field_descriptor),
                    ("echo", echo__field_descriptor),
                    ("flush", flush__field_descriptor),
                    ("info", info__field_descriptor),
                    ("set_option", setOption__field_descriptor),
                    ("deliver_tx", deliverTx__field_descriptor),
                    ("check_tx", checkTx__field_descriptor),
                    ("commit", commit__field_descriptor),
                    ("query", query__field_descriptor),
                    ("init_chain", initChain__field_descriptor),
                    ("begin_block", beginBlock__field_descriptor),
                    ("end_block", endBlock__field_descriptor)])

data ResponseBeginBlock = ResponseBeginBlock{}
                        deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default ResponseBeginBlock where
        def = ResponseBeginBlock{}

instance Data.ProtoLens.Message ResponseBeginBlock where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor (Data.Map.fromList [])
                (Data.Map.fromList [])

data ResponseCheckTx = ResponseCheckTx{_ResponseCheckTx'code ::
                                       !CodeType,
                                       _ResponseCheckTx'data' :: !Data.ByteString.ByteString,
                                       _ResponseCheckTx'log :: !Data.Text.Text}
                     deriving (Prelude.Show, Prelude.Eq)

instance (a ~ CodeType, b ~ CodeType, Prelude.Functor f) =>
         Lens.Labels.HasLens "code" f ResponseCheckTx ResponseCheckTx a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseCheckTx'code
              (\ x__ y__ -> x__{_ResponseCheckTx'code = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "data'" f ResponseCheckTx ResponseCheckTx a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseCheckTx'data'
              (\ x__ y__ -> x__{_ResponseCheckTx'data' = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "log" f ResponseCheckTx ResponseCheckTx a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseCheckTx'log
              (\ x__ y__ -> x__{_ResponseCheckTx'log = y__})

instance Data.Default.Class.Default ResponseCheckTx where
        def
          = ResponseCheckTx{_ResponseCheckTx'code = Data.Default.Class.def,
                            _ResponseCheckTx'data' = Data.ProtoLens.fieldDefault,
                            _ResponseCheckTx'log = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseCheckTx where
        descriptor
          = let code__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "code"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor CodeType)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional code)
                      :: Data.ProtoLens.FieldDescriptor ResponseCheckTx
                data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional data')
                      :: Data.ProtoLens.FieldDescriptor ResponseCheckTx
                log__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "log"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional log)
                      :: Data.ProtoLens.FieldDescriptor ResponseCheckTx
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, code__field_descriptor),
                    (Data.ProtoLens.Tag 2, data'__field_descriptor),
                    (Data.ProtoLens.Tag 3, log__field_descriptor)])
                (Data.Map.fromList
                   [("code", code__field_descriptor),
                    ("data", data'__field_descriptor), ("log", log__field_descriptor)])

data ResponseCommit = ResponseCommit{_ResponseCommit'code ::
                                     !CodeType,
                                     _ResponseCommit'data' :: !Data.ByteString.ByteString,
                                     _ResponseCommit'log :: !Data.Text.Text}
                    deriving (Prelude.Show, Prelude.Eq)

instance (a ~ CodeType, b ~ CodeType, Prelude.Functor f) =>
         Lens.Labels.HasLens "code" f ResponseCommit ResponseCommit a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseCommit'code
              (\ x__ y__ -> x__{_ResponseCommit'code = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "data'" f ResponseCommit ResponseCommit a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseCommit'data'
              (\ x__ y__ -> x__{_ResponseCommit'data' = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "log" f ResponseCommit ResponseCommit a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseCommit'log
              (\ x__ y__ -> x__{_ResponseCommit'log = y__})

instance Data.Default.Class.Default ResponseCommit where
        def
          = ResponseCommit{_ResponseCommit'code = Data.Default.Class.def,
                           _ResponseCommit'data' = Data.ProtoLens.fieldDefault,
                           _ResponseCommit'log = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseCommit where
        descriptor
          = let code__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "code"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor CodeType)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional code)
                      :: Data.ProtoLens.FieldDescriptor ResponseCommit
                data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional data')
                      :: Data.ProtoLens.FieldDescriptor ResponseCommit
                log__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "log"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional log)
                      :: Data.ProtoLens.FieldDescriptor ResponseCommit
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, code__field_descriptor),
                    (Data.ProtoLens.Tag 2, data'__field_descriptor),
                    (Data.ProtoLens.Tag 3, log__field_descriptor)])
                (Data.Map.fromList
                   [("code", code__field_descriptor),
                    ("data", data'__field_descriptor), ("log", log__field_descriptor)])

data ResponseDeliverTx = ResponseDeliverTx{_ResponseDeliverTx'code
                                           :: !CodeType,
                                           _ResponseDeliverTx'data' :: !Data.ByteString.ByteString,
                                           _ResponseDeliverTx'log :: !Data.Text.Text}
                       deriving (Prelude.Show, Prelude.Eq)

instance (a ~ CodeType, b ~ CodeType, Prelude.Functor f) =>
         Lens.Labels.HasLens "code" f ResponseDeliverTx ResponseDeliverTx a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseDeliverTx'code
              (\ x__ y__ -> x__{_ResponseDeliverTx'code = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "data'" f ResponseDeliverTx ResponseDeliverTx a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseDeliverTx'data'
              (\ x__ y__ -> x__{_ResponseDeliverTx'data' = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "log" f ResponseDeliverTx ResponseDeliverTx a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseDeliverTx'log
              (\ x__ y__ -> x__{_ResponseDeliverTx'log = y__})

instance Data.Default.Class.Default ResponseDeliverTx where
        def
          = ResponseDeliverTx{_ResponseDeliverTx'code =
                                Data.Default.Class.def,
                              _ResponseDeliverTx'data' = Data.ProtoLens.fieldDefault,
                              _ResponseDeliverTx'log = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseDeliverTx where
        descriptor
          = let code__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "code"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor CodeType)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional code)
                      :: Data.ProtoLens.FieldDescriptor ResponseDeliverTx
                data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional data')
                      :: Data.ProtoLens.FieldDescriptor ResponseDeliverTx
                log__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "log"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional log)
                      :: Data.ProtoLens.FieldDescriptor ResponseDeliverTx
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, code__field_descriptor),
                    (Data.ProtoLens.Tag 2, data'__field_descriptor),
                    (Data.ProtoLens.Tag 3, log__field_descriptor)])
                (Data.Map.fromList
                   [("code", code__field_descriptor),
                    ("data", data'__field_descriptor), ("log", log__field_descriptor)])

data ResponseEcho = ResponseEcho{_ResponseEcho'message ::
                                 !Data.Text.Text}
                  deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "message" f ResponseEcho ResponseEcho a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseEcho'message
              (\ x__ y__ -> x__{_ResponseEcho'message = y__})

instance Data.Default.Class.Default ResponseEcho where
        def
          = ResponseEcho{_ResponseEcho'message = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseEcho where
        descriptor
          = let message__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "message"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional message)
                      :: Data.ProtoLens.FieldDescriptor ResponseEcho
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, message__field_descriptor)])
                (Data.Map.fromList [("message", message__field_descriptor)])

data ResponseEndBlock = ResponseEndBlock{_ResponseEndBlock'diffs ::
                                         ![Validator]}
                      deriving (Prelude.Show, Prelude.Eq)

instance (a ~ [Validator], b ~ [Validator], Prelude.Functor f) =>
         Lens.Labels.HasLens "diffs" f ResponseEndBlock ResponseEndBlock a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseEndBlock'diffs
              (\ x__ y__ -> x__{_ResponseEndBlock'diffs = y__})

instance Data.Default.Class.Default ResponseEndBlock where
        def = ResponseEndBlock{_ResponseEndBlock'diffs = []}

instance Data.ProtoLens.Message ResponseEndBlock where
        descriptor
          = let diffs__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "diffs"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Validator)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked diffs)
                      :: Data.ProtoLens.FieldDescriptor ResponseEndBlock
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, diffs__field_descriptor)])
                (Data.Map.fromList [("diffs", diffs__field_descriptor)])

data ResponseException = ResponseException{_ResponseException'error
                                           :: !Data.Text.Text}
                       deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "error" f ResponseException ResponseException a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseException'error
              (\ x__ y__ -> x__{_ResponseException'error = y__})

instance Data.Default.Class.Default ResponseException where
        def
          = ResponseException{_ResponseException'error =
                                Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseException where
        descriptor
          = let error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional error)
                      :: Data.ProtoLens.FieldDescriptor ResponseException
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, error__field_descriptor)])
                (Data.Map.fromList [("error", error__field_descriptor)])

data ResponseFlush = ResponseFlush{}
                   deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default ResponseFlush where
        def = ResponseFlush{}

instance Data.ProtoLens.Message ResponseFlush where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor (Data.Map.fromList [])
                (Data.Map.fromList [])

data ResponseInfo = ResponseInfo{_ResponseInfo'data' ::
                                 !Data.Text.Text,
                                 _ResponseInfo'version :: !Data.Text.Text,
                                 _ResponseInfo'lastBlockHeight :: !Data.Word.Word64,
                                 _ResponseInfo'lastBlockAppHash :: !Data.ByteString.ByteString}
                  deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "data'" f ResponseInfo ResponseInfo a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseInfo'data'
              (\ x__ y__ -> x__{_ResponseInfo'data' = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "version" f ResponseInfo ResponseInfo a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseInfo'version
              (\ x__ y__ -> x__{_ResponseInfo'version = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "lastBlockHeight" f ResponseInfo ResponseInfo a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseInfo'lastBlockHeight
              (\ x__ y__ -> x__{_ResponseInfo'lastBlockHeight = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "lastBlockAppHash" f ResponseInfo ResponseInfo
           a
           b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseInfo'lastBlockAppHash
              (\ x__ y__ -> x__{_ResponseInfo'lastBlockAppHash = y__})

instance Data.Default.Class.Default ResponseInfo where
        def
          = ResponseInfo{_ResponseInfo'data' = Data.ProtoLens.fieldDefault,
                         _ResponseInfo'version = Data.ProtoLens.fieldDefault,
                         _ResponseInfo'lastBlockHeight = Data.ProtoLens.fieldDefault,
                         _ResponseInfo'lastBlockAppHash = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseInfo where
        descriptor
          = let data'__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "data"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional data')
                      :: Data.ProtoLens.FieldDescriptor ResponseInfo
                version__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "version"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional version)
                      :: Data.ProtoLens.FieldDescriptor ResponseInfo
                lastBlockHeight__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "last_block_height"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional lastBlockHeight)
                      :: Data.ProtoLens.FieldDescriptor ResponseInfo
                lastBlockAppHash__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "last_block_app_hash"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         lastBlockAppHash)
                      :: Data.ProtoLens.FieldDescriptor ResponseInfo
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, data'__field_descriptor),
                    (Data.ProtoLens.Tag 2, version__field_descriptor),
                    (Data.ProtoLens.Tag 3, lastBlockHeight__field_descriptor),
                    (Data.ProtoLens.Tag 4, lastBlockAppHash__field_descriptor)])
                (Data.Map.fromList
                   [("data", data'__field_descriptor),
                    ("version", version__field_descriptor),
                    ("last_block_height", lastBlockHeight__field_descriptor),
                    ("last_block_app_hash", lastBlockAppHash__field_descriptor)])

data ResponseInitChain = ResponseInitChain{}
                       deriving (Prelude.Show, Prelude.Eq)

instance Data.Default.Class.Default ResponseInitChain where
        def = ResponseInitChain{}

instance Data.ProtoLens.Message ResponseInitChain where
        descriptor
          = let in
              Data.ProtoLens.MessageDescriptor (Data.Map.fromList [])
                (Data.Map.fromList [])

data ResponseQuery = ResponseQuery{_ResponseQuery'code ::
                                   !CodeType,
                                   _ResponseQuery'index :: !Data.Int.Int64,
                                   _ResponseQuery'key :: !Data.ByteString.ByteString,
                                   _ResponseQuery'value :: !Data.ByteString.ByteString,
                                   _ResponseQuery'proof :: !Data.ByteString.ByteString,
                                   _ResponseQuery'height :: !Data.Word.Word64,
                                   _ResponseQuery'log :: !Data.Text.Text}
                   deriving (Prelude.Show, Prelude.Eq)

instance (a ~ CodeType, b ~ CodeType, Prelude.Functor f) =>
         Lens.Labels.HasLens "code" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'code
              (\ x__ y__ -> x__{_ResponseQuery'code = y__})

instance (a ~ Data.Int.Int64, b ~ Data.Int.Int64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "index" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'index
              (\ x__ y__ -> x__{_ResponseQuery'index = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "key" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'key
              (\ x__ y__ -> x__{_ResponseQuery'key = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "value" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'value
              (\ x__ y__ -> x__{_ResponseQuery'value = y__})

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "proof" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'proof
              (\ x__ y__ -> x__{_ResponseQuery'proof = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "height" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'height
              (\ x__ y__ -> x__{_ResponseQuery'height = y__})

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "log" f ResponseQuery ResponseQuery a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseQuery'log
              (\ x__ y__ -> x__{_ResponseQuery'log = y__})

instance Data.Default.Class.Default ResponseQuery where
        def
          = ResponseQuery{_ResponseQuery'code = Data.Default.Class.def,
                          _ResponseQuery'index = Data.ProtoLens.fieldDefault,
                          _ResponseQuery'key = Data.ProtoLens.fieldDefault,
                          _ResponseQuery'value = Data.ProtoLens.fieldDefault,
                          _ResponseQuery'proof = Data.ProtoLens.fieldDefault,
                          _ResponseQuery'height = Data.ProtoLens.fieldDefault,
                          _ResponseQuery'log = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseQuery where
        descriptor
          = let code__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "code"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor CodeType)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional code)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
                index__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "index"
                      (Data.ProtoLens.Int64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional index)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
                key__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "key"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional key)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
                value__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "value"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional value)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
                proof__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "proof"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional proof)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
                height__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "height"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional height)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
                log__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "log"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional log)
                      :: Data.ProtoLens.FieldDescriptor ResponseQuery
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, code__field_descriptor),
                    (Data.ProtoLens.Tag 2, index__field_descriptor),
                    (Data.ProtoLens.Tag 3, key__field_descriptor),
                    (Data.ProtoLens.Tag 4, value__field_descriptor),
                    (Data.ProtoLens.Tag 5, proof__field_descriptor),
                    (Data.ProtoLens.Tag 6, height__field_descriptor),
                    (Data.ProtoLens.Tag 7, log__field_descriptor)])
                (Data.Map.fromList
                   [("code", code__field_descriptor),
                    ("index", index__field_descriptor), ("key", key__field_descriptor),
                    ("value", value__field_descriptor),
                    ("proof", proof__field_descriptor),
                    ("height", height__field_descriptor),
                    ("log", log__field_descriptor)])

data ResponseSetOption = ResponseSetOption{_ResponseSetOption'log
                                           :: !Data.Text.Text}
                       deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "log" f ResponseSetOption ResponseSetOption a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _ResponseSetOption'log
              (\ x__ y__ -> x__{_ResponseSetOption'log = y__})

instance Data.Default.Class.Default ResponseSetOption where
        def
          = ResponseSetOption{_ResponseSetOption'log =
                                Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message ResponseSetOption where
        descriptor
          = let log__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "log"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional log)
                      :: Data.ProtoLens.FieldDescriptor ResponseSetOption
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList [(Data.ProtoLens.Tag 1, log__field_descriptor)])
                (Data.Map.fromList [("log", log__field_descriptor)])

data Validator = Validator{_Validator'pubKey ::
                           !Data.ByteString.ByteString,
                           _Validator'power :: !Data.Word.Word64}
               deriving (Prelude.Show, Prelude.Eq)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "pubKey" f Validator Validator a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Validator'pubKey
              (\ x__ y__ -> x__{_Validator'pubKey = y__})

instance (a ~ Data.Word.Word64, b ~ Data.Word.Word64,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "power" f Validator Validator a b
         where
        lensOf _
          = Lens.Family2.Unchecked.lens _Validator'power
              (\ x__ y__ -> x__{_Validator'power = y__})

instance Data.Default.Class.Default Validator where
        def
          = Validator{_Validator'pubKey = Data.ProtoLens.fieldDefault,
                      _Validator'power = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message Validator where
        descriptor
          = let pubKey__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "pubKey"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional pubKey)
                      :: Data.ProtoLens.FieldDescriptor Validator
                power__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "power"
                      (Data.ProtoLens.UInt64Field ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional power)
                      :: Data.ProtoLens.FieldDescriptor Validator
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, pubKey__field_descriptor),
                    (Data.ProtoLens.Tag 2, power__field_descriptor)])
                (Data.Map.fromList
                   [("pubKey", pubKey__field_descriptor),
                    ("power", power__field_descriptor)])

appHash ::
        forall f s t a b . (Lens.Labels.HasLens "appHash" f s t a b) =>
          Lens.Family2.LensLike f s t a b
appHash
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "appHash")

beginBlock ::
           forall f s t a b . (Lens.Labels.HasLens "beginBlock" f s t a b) =>
             Lens.Family2.LensLike f s t a b
beginBlock
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "beginBlock")

chainId ::
        forall f s t a b . (Lens.Labels.HasLens "chainId" f s t a b) =>
          Lens.Family2.LensLike f s t a b
chainId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "chainId")

checkTx ::
        forall f s t a b . (Lens.Labels.HasLens "checkTx" f s t a b) =>
          Lens.Family2.LensLike f s t a b
checkTx
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "checkTx")

code ::
     forall f s t a b . (Lens.Labels.HasLens "code" f s t a b) =>
       Lens.Family2.LensLike f s t a b
code
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "code")

commit ::
       forall f s t a b . (Lens.Labels.HasLens "commit" f s t a b) =>
         Lens.Family2.LensLike f s t a b
commit
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "commit")

data' ::
      forall f s t a b . (Lens.Labels.HasLens "data'" f s t a b) =>
        Lens.Family2.LensLike f s t a b
data'
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "data'")

dataHash ::
         forall f s t a b . (Lens.Labels.HasLens "dataHash" f s t a b) =>
           Lens.Family2.LensLike f s t a b
dataHash
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "dataHash")

deliverTx ::
          forall f s t a b . (Lens.Labels.HasLens "deliverTx" f s t a b) =>
            Lens.Family2.LensLike f s t a b
deliverTx
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "deliverTx")

diffs ::
      forall f s t a b . (Lens.Labels.HasLens "diffs" f s t a b) =>
        Lens.Family2.LensLike f s t a b
diffs
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "diffs")

echo ::
     forall f s t a b . (Lens.Labels.HasLens "echo" f s t a b) =>
       Lens.Family2.LensLike f s t a b
echo
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "echo")

endBlock ::
         forall f s t a b . (Lens.Labels.HasLens "endBlock" f s t a b) =>
           Lens.Family2.LensLike f s t a b
endBlock
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "endBlock")

error ::
      forall f s t a b . (Lens.Labels.HasLens "error" f s t a b) =>
        Lens.Family2.LensLike f s t a b
error
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")

exception ::
          forall f s t a b . (Lens.Labels.HasLens "exception" f s t a b) =>
            Lens.Family2.LensLike f s t a b
exception
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "exception")

flush ::
      forall f s t a b . (Lens.Labels.HasLens "flush" f s t a b) =>
        Lens.Family2.LensLike f s t a b
flush
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "flush")

hash ::
     forall f s t a b . (Lens.Labels.HasLens "hash" f s t a b) =>
       Lens.Family2.LensLike f s t a b
hash
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "hash")

header ::
       forall f s t a b . (Lens.Labels.HasLens "header" f s t a b) =>
         Lens.Family2.LensLike f s t a b
header
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "header")

height ::
       forall f s t a b . (Lens.Labels.HasLens "height" f s t a b) =>
         Lens.Family2.LensLike f s t a b
height
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "height")

index ::
      forall f s t a b . (Lens.Labels.HasLens "index" f s t a b) =>
        Lens.Family2.LensLike f s t a b
index
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "index")

info ::
     forall f s t a b . (Lens.Labels.HasLens "info" f s t a b) =>
       Lens.Family2.LensLike f s t a b
info
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "info")

initChain ::
          forall f s t a b . (Lens.Labels.HasLens "initChain" f s t a b) =>
            Lens.Family2.LensLike f s t a b
initChain
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "initChain")

key ::
    forall f s t a b . (Lens.Labels.HasLens "key" f s t a b) =>
      Lens.Family2.LensLike f s t a b
key
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "key")

lastBlockAppHash ::
                 forall f s t a b .
                   (Lens.Labels.HasLens "lastBlockAppHash" f s t a b) =>
                   Lens.Family2.LensLike f s t a b
lastBlockAppHash
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "lastBlockAppHash")

lastBlockHeight ::
                forall f s t a b .
                  (Lens.Labels.HasLens "lastBlockHeight" f s t a b) =>
                  Lens.Family2.LensLike f s t a b
lastBlockHeight
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "lastBlockHeight")

lastBlockId ::
            forall f s t a b . (Lens.Labels.HasLens "lastBlockId" f s t a b) =>
              Lens.Family2.LensLike f s t a b
lastBlockId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "lastBlockId")

lastCommitHash ::
               forall f s t a b .
                 (Lens.Labels.HasLens "lastCommitHash" f s t a b) =>
                 Lens.Family2.LensLike f s t a b
lastCommitHash
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "lastCommitHash")

log ::
    forall f s t a b . (Lens.Labels.HasLens "log" f s t a b) =>
      Lens.Family2.LensLike f s t a b
log
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "log")

maybe'beginBlock ::
                 forall f s t a b .
                   (Lens.Labels.HasLens "maybe'beginBlock" f s t a b) =>
                   Lens.Family2.LensLike f s t a b
maybe'beginBlock
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'beginBlock")

maybe'checkTx ::
              forall f s t a b .
                (Lens.Labels.HasLens "maybe'checkTx" f s t a b) =>
                Lens.Family2.LensLike f s t a b
maybe'checkTx
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'checkTx")

maybe'commit ::
             forall f s t a b .
               (Lens.Labels.HasLens "maybe'commit" f s t a b) =>
               Lens.Family2.LensLike f s t a b
maybe'commit
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'commit")

maybe'deliverTx ::
                forall f s t a b .
                  (Lens.Labels.HasLens "maybe'deliverTx" f s t a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'deliverTx
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'deliverTx")

maybe'echo ::
           forall f s t a b . (Lens.Labels.HasLens "maybe'echo" f s t a b) =>
             Lens.Family2.LensLike f s t a b
maybe'echo
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'echo")

maybe'endBlock ::
               forall f s t a b .
                 (Lens.Labels.HasLens "maybe'endBlock" f s t a b) =>
                 Lens.Family2.LensLike f s t a b
maybe'endBlock
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'endBlock")

maybe'exception ::
                forall f s t a b .
                  (Lens.Labels.HasLens "maybe'exception" f s t a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'exception
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'exception")

maybe'flush ::
            forall f s t a b . (Lens.Labels.HasLens "maybe'flush" f s t a b) =>
              Lens.Family2.LensLike f s t a b
maybe'flush
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'flush")

maybe'header ::
             forall f s t a b .
               (Lens.Labels.HasLens "maybe'header" f s t a b) =>
               Lens.Family2.LensLike f s t a b
maybe'header
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'header")

maybe'info ::
           forall f s t a b . (Lens.Labels.HasLens "maybe'info" f s t a b) =>
             Lens.Family2.LensLike f s t a b
maybe'info
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'info")

maybe'initChain ::
                forall f s t a b .
                  (Lens.Labels.HasLens "maybe'initChain" f s t a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'initChain
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'initChain")

maybe'lastBlockId ::
                  forall f s t a b .
                    (Lens.Labels.HasLens "maybe'lastBlockId" f s t a b) =>
                    Lens.Family2.LensLike f s t a b
maybe'lastBlockId
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'lastBlockId")

maybe'parts ::
            forall f s t a b . (Lens.Labels.HasLens "maybe'parts" f s t a b) =>
              Lens.Family2.LensLike f s t a b
maybe'parts
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'parts")

maybe'query ::
            forall f s t a b . (Lens.Labels.HasLens "maybe'query" f s t a b) =>
              Lens.Family2.LensLike f s t a b
maybe'query
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'query")

maybe'setOption ::
                forall f s t a b .
                  (Lens.Labels.HasLens "maybe'setOption" f s t a b) =>
                  Lens.Family2.LensLike f s t a b
maybe'setOption
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'setOption")

message ::
        forall f s t a b . (Lens.Labels.HasLens "message" f s t a b) =>
          Lens.Family2.LensLike f s t a b
message
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "message")

numTxs ::
       forall f s t a b . (Lens.Labels.HasLens "numTxs" f s t a b) =>
         Lens.Family2.LensLike f s t a b
numTxs
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "numTxs")

parts ::
      forall f s t a b . (Lens.Labels.HasLens "parts" f s t a b) =>
        Lens.Family2.LensLike f s t a b
parts
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parts")

path ::
     forall f s t a b . (Lens.Labels.HasLens "path" f s t a b) =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")

power ::
      forall f s t a b . (Lens.Labels.HasLens "power" f s t a b) =>
        Lens.Family2.LensLike f s t a b
power
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "power")

proof ::
      forall f s t a b . (Lens.Labels.HasLens "proof" f s t a b) =>
        Lens.Family2.LensLike f s t a b
proof
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "proof")

prove ::
      forall f s t a b . (Lens.Labels.HasLens "prove" f s t a b) =>
        Lens.Family2.LensLike f s t a b
prove
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "prove")

pubKey ::
       forall f s t a b . (Lens.Labels.HasLens "pubKey" f s t a b) =>
         Lens.Family2.LensLike f s t a b
pubKey
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "pubKey")

query ::
      forall f s t a b . (Lens.Labels.HasLens "query" f s t a b) =>
        Lens.Family2.LensLike f s t a b
query
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "query")

setOption ::
          forall f s t a b . (Lens.Labels.HasLens "setOption" f s t a b) =>
            Lens.Family2.LensLike f s t a b
setOption
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "setOption")

time ::
     forall f s t a b . (Lens.Labels.HasLens "time" f s t a b) =>
       Lens.Family2.LensLike f s t a b
time
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "time")

total ::
      forall f s t a b . (Lens.Labels.HasLens "total" f s t a b) =>
        Lens.Family2.LensLike f s t a b
total
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "total")

tx ::
   forall f s t a b . (Lens.Labels.HasLens "tx" f s t a b) =>
     Lens.Family2.LensLike f s t a b
tx
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "tx")

validators ::
           forall f s t a b . (Lens.Labels.HasLens "validators" f s t a b) =>
             Lens.Family2.LensLike f s t a b
validators
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "validators")

validatorsHash ::
               forall f s t a b .
                 (Lens.Labels.HasLens "validatorsHash" f s t a b) =>
                 Lens.Family2.LensLike f s t a b
validatorsHash
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "validatorsHash")

value ::
      forall f s t a b . (Lens.Labels.HasLens "value" f s t a b) =>
        Lens.Family2.LensLike f s t a b
value
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "value")

version ::
        forall f s t a b . (Lens.Labels.HasLens "version" f s t a b) =>
          Lens.Family2.LensLike f s t a b
version
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "version")