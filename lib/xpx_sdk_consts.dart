part of xpx_catapult_sdk;

final PrxNamespaceId =
    new UInt64DTO(Int64(2339353534), Int64(2976741373)).toBigInt();

final XpxMosaicId =
    new UInt64DTO(Int64(481110499), Int64(231112638)).toBigInt();

enum NamespaceType { Root, Sub }

enum MosaicSupplyType { Decrease, Increase }

enum MultisigCosignatoryModificationType { Add, Remove }

const Decrease = MosaicSupplyType.Decrease,
    Increase = MosaicSupplyType.Increase;

const Add = MultisigCosignatoryModificationType.Add,
    Remove = MultisigCosignatoryModificationType.Remove;

const AddressSize = 25,
    AmountSize = 8,
    KeySize = 32,
    Hash256 = 32,
    MosaicSize = 8,
    NamespaceSize = 8,
    SizeSize = 4,
    SignerSize = KeySize,
    SignatureSize = 64,
    VersionSize = 2,
    TypeSize = 2,
    MaxFeeSize = 8,
    DeadLineSize = 8,
    DurationSize = 8,
    TransactionHeaderSize = SizeSize +
        SignerSize +
        SignatureSize +
        VersionSize +
        TypeSize +
        MaxFeeSize +
        DeadLineSize,
    PropertyTypeSize = 2,
    PropertyModificationTypeSize = 1,
    AccountPropertiesAddressModificationSize =
        PropertyModificationTypeSize + AddressSize,
    AccountPropertiesMosaicModificationSize =
        PropertyModificationTypeSize + MosaicSize,
    AccountPropertiesEntityModificationSize =
        PropertyModificationTypeSize + TypeSize,
    AccountPropertyAddressHeader = TransactionHeaderSize + PropertyTypeSize,
    AccountPropertyMosaicHeader = TransactionHeaderSize + PropertyTypeSize,
    AccountPropertyEntityTypeHeader = TransactionHeaderSize + PropertyTypeSize,
    LinkActionSize = 1,
    AccountLinkTransactionSize =
        TransactionHeaderSize + KeySize + LinkActionSize,
    AliasActionSize = 1,
    AliasTransactionHeader =
        TransactionHeaderSize + NamespaceSize + AliasActionSize,
    AggregateBondedHeader = TransactionHeaderSize + SizeSize,
    HashTypeSize = 1,
    LockSize = TransactionHeaderSize +
        MosaicSize +
        AmountSize +
        DurationSize +
        Hash256,
    MetadataTypeSize = 1,
    MetadataHeaderSize = TransactionHeaderSize + MetadataTypeSize,
    ModificationsSizeSize = 1,
    ModifyContractHeaderSize = TransactionHeaderSize +
        DurationSize +
        Hash256 +
        3 * ModificationsSizeSize,
    MinApprovalSize = 1,
    MinRemovalSize = 1,
    ModifyMultisigHeaderSize = TransactionHeaderSize +
        MinApprovalSize +
        MinRemovalSize +
        ModificationsSizeSize,
    MosaicNonceSize = 4,
    MosaicPropertySize = 4,
    MosaicDefinitionTransactionSize = TransactionHeaderSize +
        MosaicNonceSize +
        MosaicSize +
        DurationSize +
        MosaicPropertySize,
    MosaicSupplyDirectionSize = 1,
    MosaicSupplyChangeTransactionSize = TransactionHeaderSize +
        MosaicSize +
        AmountSize +
        MosaicSupplyDirectionSize,
    NamespaceTypeSize = 1,
    NamespaceNameSizeSize = 1,
    RegisterNamespaceHeaderSize = TransactionHeaderSize +
        NamespaceTypeSize +
        DurationSize +
        NamespaceSize +
        NamespaceNameSizeSize,
    SecretLockSize = TransactionHeaderSize +
        MosaicSize +
        AmountSize +
        DurationSize +
        HashTypeSize +
        Hash256 +
        AddressSize,
    ProofSizeSize = 2,
    SecretProofHeaderSize =
        TransactionHeaderSize + HashTypeSize + Hash256 + ProofSizeSize,
    MosaicsSizeSize = 1,
    MessageSizeSize = 2,
    TransferHeaderSize =
        TransactionHeaderSize + AddressSize + MosaicsSizeSize + MessageSizeSize;
