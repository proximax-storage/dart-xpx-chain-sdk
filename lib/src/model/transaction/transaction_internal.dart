part of xpx_chain_sdk.transaction;

final regList = RegExp(r'^List<(.*)>$');

final regMap = RegExp(r'^Map<String,(.*)>$');

var _transactionTypes = <_TransactionTypeClass>{
  _TransactionTypeClass(TransactionType.aggregateCompleted, 16705, 0x4141),
  _TransactionTypeClass(TransactionType.aggregateBonded, 16961, 0x4241),
  _TransactionTypeClass(TransactionType.addressAlias, 16974, 0x424E),
  _TransactionTypeClass(TransactionType.metadataAddress, 16701, 0x413d),
  _TransactionTypeClass(TransactionType.metadataMosaic, 16957, 0x423d),
  _TransactionTypeClass(TransactionType.metadataNamespace, 17213, 0x433d),
  _TransactionTypeClass(TransactionType.mosaicDefinition, 16717, 0x414d),
  _TransactionTypeClass(TransactionType.mosaicAlias, 17230, 0x434e),
  _TransactionTypeClass(TransactionType.mosaicSupplyChange, 16973, 0x424d),
  _TransactionTypeClass(TransactionType.modifyMultisig, 16725, 0x4155),
  _TransactionTypeClass(TransactionType.modifyContract, 16727, 0x4157),
  _TransactionTypeClass(TransactionType.registerNamespace, 16718, 0x414e),
  _TransactionTypeClass(TransactionType.transfer, 16724, 0x4154),
  _TransactionTypeClass(TransactionType.lock, 16712, 0x4148),
  _TransactionTypeClass(TransactionType.secretLock, 16722, 0x4152),
  _TransactionTypeClass(TransactionType.secretProof, 16978, 0x4252),
  _TransactionTypeClass(TransactionType.addExchangeOffer, 16733, 0x415D),
  _TransactionTypeClass(TransactionType.exchangeOffer, 16989, 0x425D),
  _TransactionTypeClass(TransactionType.removeExchangeOffer, 17245, 0x435D)
};

// TransactionVersion enums
const aggregateCompletedVersion = 2,
    aggregateBondedVersion = 2,
    addressAliasVersion = 1,
    registerNamespaceVersion = 2,
    transferVersion = 3,
    addExchangeOfferVersion = 1,
    exchangeOfferVersion = 1,
    removeExchangeOfferVersion = 1,
    mosaicAliasVersion = 1,
    mosaicDefinitionVersion = 3,
    mosaicSupplyChangeVersion = 2,
    modifyMultisigVersion = 3,
    lockVersion = 1,
    modifyContractVersion = 3,
    metadataAddressVersion = 1,
    metadataMosaicVersion = 1,
    metadataNamespaceVersion = 1,
    secretLockVersion = 1,
    secretProofVersion = 1;

// TransactionType enums
enum TransactionType {
  aggregateCompleted,
  aggregateBonded,
  addressAlias,
  metadataAddress,
  metadataMosaic,
  metadataNamespace,
  mosaicDefinition,
  mosaicSupplyChange,
  modifyMultisig,
  modifyContract,
  registerNamespace,
  transfer,
  lock,
  secretLock,
  secretProof,
  mosaicAlias,
  addExchangeOffer,
  exchangeOffer,
  removeExchangeOffer
}

var timestampNemesisBlock = DateTime.fromMillisecondsSinceEpoch(1459468800000);

_TransactionTypeClass transactionTypeFromRaw(int value) {
  for (final t in _transactionTypes) {
    if (t.raw == value) {
      return t;
    }
  }
  return null;
}

String _mapTransaction(decodedJson) {
  final rawT = decodedJson['transaction']['type'];

  final t = transactionTypeFromRaw(rawT).transactionType;

  switch (t) {
    case TransactionType.aggregateCompleted:
      return 'AggregateCompleted';
    case TransactionType.aggregateBonded:
      return 'AggregateBonded';
    case TransactionType.metadataAddress:
      return 'MetadataAddress';
    case TransactionType.addressAlias:
      return 'AddressAlias';
    case TransactionType.metadataMosaic:
      return 'MetadataMosaic';
    case TransactionType.metadataNamespace:
      return 'MetadataNamespace';
    case TransactionType.mosaicDefinition:
      return 'MosaicDefinition';
    case TransactionType.mosaicAlias:
      return 'MosaicAlias';
    case TransactionType.mosaicSupplyChange:
      return 'MosaicSupplyChange';
    case TransactionType.modifyMultisig:
      return 'ModifyMultisig';
    case TransactionType.modifyContract:
      return 'ModifyContract';
    case TransactionType.registerNamespace:
      return 'RegisterNamespace';
    case TransactionType.transfer:
      return 'Transfer';
    case TransactionType.lock:
      return 'Lock';
    case TransactionType.secretLock:
      return 'SecretLock';
    case TransactionType.secretProof:
      return 'SecretProof';
    default:
      return 'NULL';
  }
}

dynamic txnDeserialize(value, String targetType) {
  if (targetType == 'List<Transaction>') {
    {
      Match match;
      if (value is List && (match = regList.firstMatch(targetType)) != null) {
        final newTargetType = match[1];

        return value.map((v) => txnDeserialize(v, newTargetType)).toList();
      } else if (value is Map &&
          (match = regMap.firstMatch(targetType)) != null) {
        final newTargetType = match[1];
        return Map.fromIterables(value.keys,
            value.values.map((v) => txnDeserialize(v, newTargetType)));
      }
    }
  }

  // ignore: parameter_assignments
  targetType = _mapTransaction(value);

  try {
    switch (targetType) {
      case 'Transfer':
        return _TransferTransactionInfoDTO.fromJson(value);
      case 'RegisterNamespace':
        return RegisterNamespaceTransactionInfoDTO.fromJson(value);
      case 'MosaicDefinition':
        return MosaicDefinitionTransactionInfoDTO.fromJson(value);
      case 'MosaicSupplyChange':
        return MosaicSupplyChangeTransactionInfoDTO.fromJson(value);
      case 'MosaicAlias':
        return MosaicAliasTransactionInfoDTO.fromJson(value);
      case 'AggregateCompleted':
        return _AggregateTransactionInfoDTO.fromJson(value);
      case 'AggregateBonded':
        return _AggregateTransactionInfoDTO.fromJson(value);
      case 'AddressAlias':
        return AddressAliasTransactionInfoDTO.fromJson(value);
      case 'ModifyMultisig':
        return ModifyMultisigAccountTransactionInfoDTO.fromJson(value);
      case 'Lock':
        return _LockFundsTransactionInfoDTO.fromJson(value);
      default:
        return null;
    }
  } on Exception catch (e, stack) {
    throw ApiException.withInner(
        500, 'Exception during deserialization.', e, stack);
  }
}

// extractNetworkType return networkType from version
int extractNetworkType(int version) => version.toUnsigned(32) >> 24;

int extractVersion(int version) {
  final buffer = Uint8List(8).buffer;
  final bufferData = ByteData.view(buffer)
    ..setUint64(0, version, Endian.little);
  return bufferData.getUint8(0);
}

SignedTransaction signTransactionWith(
    Transaction tx, Account a, String generationHash) {
  final s = a.account;
  final b = tx.generateBytes();
  var sb = Uint8List.fromList(b.skip(100).take(b.length).toList());

  sb = Uint8List.fromList(hex.decode(generationHash) + sb);

  final signature = s.sign(sb);

  final p = <int>[]
    ..insertAll(0, b.skip(0).take(4))
    ..insertAll(4, signature)
    ..insertAll(4 + 64, a.account.publicKey.raw)
    ..insertAll(100, b.skip(100).take(b.length));

  final pHex = hex.encode(p);

  final hash = _createTransactionHash(pHex, generationHash);

  return SignedTransaction(
      tx.getAbstractTransaction().type.raw, pHex.toUpperCase(), hash);
}

SignedTransaction signTransactionWithCosignatures(Transaction tx, Account a,
    List<Account> cosignatories, String generationHash) {
  final stx = signTransactionWith(tx, a, generationHash);

  final p = StringBuffer(stx.payload);

  for (final cos in cosignatories) {
    final s = cos.account;
    final sb = s.sign(hexDecodeStringOdd(stx.hash));
    p.write(cos.publicAccount.publicKey + hex.encode(sb));
  }

  final List<int> i = <int>[];
  i.addAll(hex.decode(p.toString()));

  final s = Buffer.littleEndian(4)..writeInt32(i.length);

  i.replaceRange(0, s.out.length, s.out);

  return SignedTransaction(tx.getAbstractTransaction().type.raw,
      hex.encode(i).toUpperCase(), stx.hash);
}

CosignatureSignedTransaction signCosignatureTransactionRwa(
    CosignatureTransaction tx, Account a) {
  if (tx._transactionToCosign.getTransactionInfo == null ||
      tx._transactionToCosign.getTransactionInfo.transactionHash == '') {
    throw errCosignatureTxHash;
  }

  final signer = a.account;

  final hashByte =
      hex.decode(tx._transactionToCosign.getTransactionInfo.transactionHash);

  final signatureByte = signer.sign(hashByte);

  return CosignatureSignedTransaction(
      tx._transactionToCosign.getTransactionInfo.transactionHash,
      hex.encode(signatureByte),
      signer.publicKey.toString());
}

String _createTransactionHash(String pHex, String generationHash) {
  final p = hex.decode(pHex);

  final generationHashBytes = hexDecodeStringOdd(generationHash);

  final sb = <int>[]
    ..insertAll(0, p.skip(4).take(32))
    ..insertAll(32, p.skip(68).take(32))
    ..insertAll(64, generationHashBytes)
    ..addAll(p.skip(100));

  final r = crypto.HashesSha3_256(Uint8List.fromList(sb));

  return hex.encode(r).toUpperCase();
}

Uint8List toAggregateTransactionBytes(Transaction tx) {
  if (tx.getAbstractTransaction().signer == null) {
    throw errTransactionSigner;
  }

  final sb = hex.decode(tx.getAbstractTransaction().signer.publicKey);

  final b = tx.generateBytes();

  final List<int> rB = <int>[0, 0, 0, 0];
  rB.insertAll(4, sb.take(32));

  rB.insertAll(rB.length, b.skip(100).take(versionSize + typeSize));

  rB.insertAll(signerSize + sizeSize + versionSize + typeSize,
      b.skip(transactionHeaderSize));
  final s = Buffer.littleEndian(4)..writeInt32(b.length - 64 - 16);

  rB.replaceRange(0, s.out.length, s.out);

  return Uint8List.fromList(rB);
}

int cosignatoryModificationArrayToBuffer(
    fb.Builder builder, List<MultisigCosignatoryModification> modifications) {
  final msb = <int>[];
  for (final m in modifications) {
    final b = hexDecodeStringOdd(m.publicAccount.publicKey);
    final pV = builder.writeListUint8(b);

    final txnBuilder = CosignatoryModificationBufferBuilder(builder)
      ..begin()
      ..addType(m.type.index)
      ..addCosignatoryPublicKeyOffset(pV);
    msb.add(txnBuilder.finish());
  }
  return builder.writeList(msb);
}

Transaction deserializeDTO(value) {
  switch (value.runtimeType) {
    case _TransferTransactionInfoDTO:
      return TransferTransaction.fromDTO(value);
    case RegisterNamespaceTransactionInfoDTO:
      return RegisterNamespaceTransaction.fromDTO(value);
    case MosaicDefinitionTransactionInfoDTO:
      return MosaicDefinitionTransaction.fromDTO(value);
    case MosaicSupplyChangeTransactionInfoDTO:
      return MosaicSupplyChangeTransaction.fromDTO(value);
    case MosaicAliasTransactionInfoDTO:
      return MosaicAliasTransaction.fromDTO(value);
    case _AggregateTransactionInfoDTO:
      return AggregateTransaction.fromDTO(value);
    case AddressAliasTransactionInfoDTO:
      return AddressAliasTransaction.fromDTO(value);
    case ModifyMultisigAccountTransactionInfoDTO:
      return ModifyMultisigAccountTransaction.fromDTO(value);
    case _LockFundsTransactionInfoDTO:
      return LockFundsTransaction.fromDTO(value);
    default:
      if (value is List) {
        value.map(deserializeDTO).toList();
      }
      return null;
  }
}

// hexDecodeStringOdd return padding hex representation of string
Uint8List hexDecodeStringOdd(final String s) {
  String data = s;
  if (s.length % 2 != 0) {
    data = '0$s';
  }
  return Uint8List.fromList(hex.decode(data));
}

List<int> bigIntToArray(BigInt v) {
  if (v == null) {
    return [0, 0];
  }
  final l = v.toUnsigned(32);
  final r = (v >> 32).toUnsigned(32);

  return List<int>.from([l.toInt(), r.toInt()]);
}
