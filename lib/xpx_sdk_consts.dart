part of xpx_chain_sdk;

final prxNamespaceId =
    new UInt64DTO(Int64(2339353534), Int64(2976741373)).toBigInt();

final xpxMosaicId = MosaicId.fromBigInt(
    new UInt64DTO(Int64(481110499), Int64(231112638)).toBigInt());

enum NamespaceType { Root, Sub }

enum MosaicSupplyType { decrease, increase }

enum MultisigCosignatoryModificationType { Add, Remove }

const decrease = MosaicSupplyType.decrease,
    increase = MosaicSupplyType.increase;

const add = MultisigCosignatoryModificationType.Add,
    remove = MultisigCosignatoryModificationType.Remove;

const numChecksumBytes = 4,
    addressDecodeSize = 25,
    addressEncodeSize = 40,
    amountSize = 8,
    keySize = 32,
    privateKeySize = 64,
    publicKeySize = 64,
    hash256 = 32,
    mosaicSize = 8,
    namespaceSize = 8,
    sizeSize = 4,
    signerSize = keySize,
    signatureSize = 64,
    versionSize = 2,
    typeSize = 2,
    maxFeeSize = 8,
    deadLineSize = 8,
    durationSize = 8,
    transactionHeaderSize = sizeSize +
        signerSize +
        signatureSize +
        versionSize +
        typeSize +
        maxFeeSize +
        deadLineSize,
    propertyTypeSize = 2,
    propertyModificationTypeSize = 1,
    accountPropertiesAddressModificationSize =
        propertyModificationTypeSize + addressDecodeSize,
    accountPropertiesMosaicModificationSize =
        propertyModificationTypeSize + mosaicSize,
    accountPropertiesEntityModificationSize =
        propertyModificationTypeSize + typeSize,
    accountPropertyAddressHeader = transactionHeaderSize + propertyTypeSize,
    accountPropertyMosaicHeader = transactionHeaderSize + propertyTypeSize,
    accountPropertyEntityTypeHeader = transactionHeaderSize + propertyTypeSize,
    linkActionSize = 1,
    accountLinkTransactionSize =
        transactionHeaderSize + keySize + linkActionSize,
    aliasActionSize = 1,
    aliasTransactionHeader =
        transactionHeaderSize + namespaceSize + aliasActionSize,
    aggregateBondedHeader = transactionHeaderSize + sizeSize,
    hashTypeSize = 1,
    lockSize = transactionHeaderSize +
        mosaicSize +
        amountSize +
        durationSize +
        hash256,
    metadataTypeSize = 1,
    metadataHeaderSize = transactionHeaderSize + metadataTypeSize,
    modificationsSizeSize = 1,
    modifyContractHeaderSize = transactionHeaderSize +
        durationSize +
        hash256 +
        3 * modificationsSizeSize,
    minApprovalSize = 1,
    minRemovalSize = 1,
    modifyMultisigHeaderSize = transactionHeaderSize +
        minApprovalSize +
        minRemovalSize +
        modificationsSizeSize,
    mosaicNonceSize = 4,
    mosaicPropertySize = 4,
    mosaicDefinitionTransactionSize = transactionHeaderSize +
        mosaicNonceSize +
        mosaicSize +
        durationSize +
        mosaicPropertySize,
    mosaicSupplyDirectionSize = 1,
    mosaicSupplyChangeTransactionSize = transactionHeaderSize +
        mosaicSize +
        amountSize +
        mosaicSupplyDirectionSize,
    namespaceTypeSize = 1,
    namespaceNameSizeSize = 1,
    registerNamespaceHeaderSize = transactionHeaderSize +
        namespaceTypeSize +
        durationSize +
        namespaceSize +
        namespaceNameSizeSize,
    secretLockSize = transactionHeaderSize +
        mosaicSize +
        amountSize +
        durationSize +
        hashTypeSize +
        hash256 +
        addressDecodeSize,
    proofSizeSize = 2,
    secretProofHeaderSize =
        transactionHeaderSize + hashTypeSize + hash256 + proofSizeSize,
    mosaicsSizeSize = 1,
    messageSizeSize = 2,
    transferHeaderSize =
        transactionHeaderSize + addressDecodeSize + mosaicsSizeSize + messageSizeSize;
