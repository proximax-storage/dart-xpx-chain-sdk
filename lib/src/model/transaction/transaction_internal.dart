/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

final regList = RegExp(r'^List<(.*)>$');

final regMap = RegExp(r'^Map<String,(.*)>$');

// TransactionVersion enums
const

    /// Account Restriction address transaction version.
    accountRestrictionAddressVersion = 1,

    /// Account Restriction mosaic transaction version.
    accountRestrictionMosaicVersion = 1,

    /// Account Restriction operation transaction version.
    accountRestrictionEntityTypeVersion = 1,

    /// Address Alias transaction version.
    addressAliasVersion = 1,

    /// Register namespace transaction version.
    registerNamespaceVersion = 2,

    /// Transfer Transaction transaction version.
    transferVersion = 3,

    /// Aggregate complete transaction version.
    aggregateCompletedVersion = 2, // TODO: implement new version 3

    /// Aggregate bonded transaction version.
    aggregateBondedVersion = 2, // TODO: implement new version 3

    /// Add exchange transaction version.
    addExchangeOfferVersion = 1, // TODO: implement new version 4

    /// Exchange transaction version.
    exchangeOfferVersion = 1, // TODO: implement new version 2

    /// Remove exchange transaction version.
    removeExchangeOfferVersion = 1, // TODO: implement new version 2

    /// Mosaic Alias transaction version.
    mosaicAliasVersion = 1,

    /// Mosaic definition transaction version.
    mosaicDefinitionVersion = 3,

    /// Mosaic supply change transaction.
    mosaicSupplyChangeVersion = 2,

    /// Modify multisig account transaction version.
    modifyMultisigAccountVersion = 3,

    /// Lock transaction version.
    lockVersion = 1,
    metadataAddressVersion = 1, // TODO: remove
    metadataMosaicVersion = 1, // TODO: remove
    metadataNamespaceVersion = 1, // TODO: remove

    /// Modify metadata transactions version.
    modifyMetadataVersion = 1, // TODO: unimplemented

    /// Modify account metadata nem transactions version.
    accountMetadataVersionV2 = 1,

    /// Modify mosaic metadata nem transactions version.
    mosaicMetadataVersionV2 = 1,

    /// Modify namespace metadata nem transactions version.
    namespaceMetadataVersionV2 = 1, // TODO: unimplemented

    /// Secret Lock transaction version.
    secretLockVersion = 1, // TODO: unimplemented

    /// Secret Proof transaction version.
    secretProofVersion = 1, // TODO: unimplemented

    /// Link account transaction version.
    linkAccountVersion = 2, // TODO: unimplemented

    /// Modify mosaic modify levy transactions version.
    mosaicModifyLevyVersion = 1, // TODO: unimplemented

    /// Modify remove mosaic levy transactions version.
    mosaicRemoveLevyVersion = 1, // TODO: unimplemented

    /// Chain configuration transaction version.
    chainConfigVersion = 1, // TODO: unimplemented

    /// Chain upgrade transaction version.
    chainUpgradeVersion = 1; // TODO: unimplemented

var timestampNemesisBlock = DateTime.fromMillisecondsSinceEpoch(1459468800000);

dynamic txnDeserialize(value, String targetType) {
  if (targetType == 'List<Transaction>') {
    final data = value is Map ? value['data'] : value;
    final match = regList.firstMatch(targetType);
    final newTargetType = match![1];
    return data
        .map((v) => txnDeserialize(v, newTargetType!))
        .where((element) => element != null)
        .toList();
  }

  try {
    switch (TransactionType.fromInt(value['transaction']['type'])) {
      case TransactionType.transfer:
        return TransferTransactionInfoDTO.fromJson(value);
      case TransactionType.accountPropertyAddress:
        return AccountPropertiesAddressTransactionInfoDTO.fromJson(value);
      case TransactionType.accountPropertyMosaic:
        return AccountPropertiesMosaicTransactionInfoDTO.fromJson(value);
      case TransactionType.accountPropertyEntityType:
        return AccountPropertiesEntityTypeTransactionInfoDTO.fromJson(value);
      case TransactionType.addExchangeOffer:
        return AddExchangeOfferTransactionInfoDTO.fromJson(value);
      case TransactionType.removeExchangeOffer:
        return RemoveExchangeOfferTransactionInfoDTO.fromJson(value);
      case TransactionType.exchangeOffer:
        return ExchangeOfferTransactionInfoDTO.fromJson(value);
      case TransactionType.registerNamespace:
        return RegisterNamespaceTransactionInfoDTO.fromJson(value);
      case TransactionType.mosaicDefinition:
        return MosaicDefinitionTransactionInfoDTO.fromJson(value);
      case TransactionType.mosaicSupplyChange:
        return MosaicSupplyChangeTransactionInfoDTO.fromJson(value);
      case TransactionType.mosaicAlias:
        return MosaicAliasTransactionInfoDTO.fromJson(value);
      case TransactionType.aggregateCompleted:
        return AggregateTransactionInfoDTO.fromJson(value);
      case TransactionType.aggregateBonded:
        return AggregateTransactionInfoDTO.fromJson(value);
      case TransactionType.addressAlias:
        return AddressAliasTransactionInfoDTO.fromJson(value);
      case TransactionType.modifyMultisig:
        return ModifyMultisigAccountTransactionInfoDTO.fromJson(value);
      case TransactionType.lock:
        return LockFundsTransactionInfoDTO.fromJson(value);
      case TransactionType.networkConfigEntityType:
        return; // TODO: missing implementation
      case TransactionType.blockchainUpgrade:
        return; // TODO: missing implementation
      case TransactionType.accountMetadataV2:
        return MetaDataEntryTransactionInfoDTO.fromJson(value);
      case TransactionType.mosaicMetadataV2:
        return MetaDataEntryTransactionInfoDTO.fromJson(value);
      case TransactionType.namespaceMetadataV2:
        return MetaDataEntryTransactionInfoDTO.fromJson(value);
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

Future<SignedTransaction> signTransactionWith(
    Transaction tx, Account a, String generationHash) async {
  final s = a.account;
  final b = tx.generateBytes();
  var sb = Uint8List.fromList(b.skip(100).take(b.length).toList());

  sb = Uint8List.fromList(hex.decode(generationHash) + sb);

  final signature = await s.sign(sb);

  final p = <int>[]
    ..insertAll(0, b.skip(0).take(4))
    ..insertAll(4, signature.bytes)
    ..insertAll(4 + 64, a.account.publicKey)
    ..insertAll(100, b.skip(100).take(b.length));

  final String pHex = hex.encode(p);

  final hash = _createTransactionHash(pHex, generationHash);

  return Future.value(
      SignedTransaction(tx.absTransaction().type, pHex.toUpperCase(), hash));
}

Future<SignedTransaction> signTransactionWithCosignatures(Transaction tx,
    Account a, List<Account> cosignatories, String generationHash) async {
  final stx = await signTransactionWith(tx, a, generationHash);

  final p = StringBuffer(stx.payload);

  for (final cos in cosignatories) {
    final s = cos.account;
    final sb = await s.sign(hexDecodeStringOdd(stx.hash));
    p.write(cos.publicAccount.publicKey + hex.encode(sb.bytes));
  }

  final List<int> i = <int>[];
  i.addAll(hex.decode(p.toString()));

  final buffer = Uint8List(4).buffer;
  final s = ByteData.view(buffer);

  s.setInt32(0, i.length, Endian.little);

  i.replaceRange(0, s.lengthInBytes, s.buffer.asUint8List());

  return SignedTransaction(
      tx.absTransaction().type, hex.encode(i).toUpperCase(), stx.hash);
}

Future<CosignatureSignedTransaction> signCosignatureTransactionRwa(
    CosignatureTransaction tx, Account a) async {
  if (tx._transactionToCosign.getTransactionInfo.transactionHash!.isEmpty) {
    throw errCosignatureTxHash;
  }

  final signer = a.account;

  final List<int> hashByte =
      hex.decode(tx._transactionToCosign.getTransactionInfo.transactionHash!);

  final signatureByte = await signer.sign(Uint8List.fromList(hashByte));

  return CosignatureSignedTransaction(
      tx._transactionToCosign.getTransactionInfo.transactionHash,
      hex.encode(signatureByte.bytes),
      signer.publicKey.toString());
}

String _createTransactionHash(String pHex, String generationHash) {
  final List<int> p = hex.decode(pHex);

  final generationHashBytes = hexDecodeStringOdd(generationHash);

  final sb = <int>[]
    ..insertAll(0, p.skip(4).take(32))
    ..insertAll(32, p.skip(68).take(32))
    ..insertAll(64, generationHashBytes)
    ..addAll(p.skip(100));

  final r = SHA3(256, SHA3_PADDING, 256).update(sb);
  return hex.encode(r.digest()).toUpperCase();
}

Uint8List toAggregateTransactionBytes(Transaction tx) {
  if (tx.absTransaction().signer == null) {
    throw errTransactionSigner;
  }

  final List<int> sb = hex.decode(tx.absTransaction().signer!.publicKey);

  final b = tx.generateBytes();

  final List<int> rB = <int>[0, 0, 0, 0];
  rB.insertAll(4, sb.take(32));

  rB.insertAll(rB.length, b.skip(100).take(versionSize + typeSize));

  rB.insertAll(signerSize + sizeSize + versionSize + typeSize,
      b.skip(transactionHeaderSize));

  final buffer = Uint8List(4).buffer;
  final s = ByteData.view(buffer);

  s.setInt32(0, b.length - 64 - 16, Endian.little);

  rB.replaceRange(0, s.lengthInBytes, s.buffer.asUint8List());

  return Uint8List.fromList(rB);
}

int cosignatoryModificationArrayToBuffer(
    fb.Builder builder, List<MultisigCosignatoryModification> modifications) {
  final msb = <int>[];
  for (final m in modifications) {
    final b = hexDecodeStringOdd(m.publicAccount!.publicKey);
    final pV = builder.writeListUint8(b);

    final txnBuilder = $buffer.CosignatoryModificationBufferBuilder(builder)
      ..begin()
      ..addType(m.type!.index)
      ..addCosignatoryPublicKeyOffset(pV);
    msb.add(txnBuilder.finish());
  }
  return builder.writeList(msb);
}

Transaction? deserializeDTO(value) {
  switch (TransactionType.fromInt(value.transaction.type)) {
    case TransactionType.accountPropertyAddress:
      return AccountPropertiesAddressTransaction.fromDTO(value);
    case TransactionType.accountPropertyMosaic:
      return AccountPropertiesMosaicTransaction.fromDTO(value);
    case TransactionType.accountPropertyEntityType:
      return AccountPropertiesEntityTypeTransaction.fromDTO(value);
    case TransactionType.transfer:
      return TransferTransaction.fromDTO(value);
    case TransactionType.registerNamespace:
      return RegisterNamespaceTransaction.fromDTO(value);
    case TransactionType.exchangeOffer:
      return ExchangeOfferTransaction.fromDTO(value);
    case TransactionType.addExchangeOffer:
      return AddExchangeOfferTransaction.fromDTO(value);
    case TransactionType.removeExchangeOffer:
      return RemoveExchangeOfferTransaction.fromDTO(value);
    case TransactionType.mosaicDefinition:
      return MosaicDefinitionTransaction.fromDTO(value);
    case TransactionType.mosaicSupplyChange:
      return MosaicSupplyChangeTransaction.fromDTO(value);
    case TransactionType.mosaicAlias:
      return MosaicAliasTransaction.fromDTO(value);
    case TransactionType.aggregateCompleted:
      return AggregateTransaction.fromDTO(value);
    case TransactionType.aggregateBonded:
      return AggregateTransaction.fromDTO(value);
    case TransactionType.addressAlias:
      return AddressAliasTransaction.fromDTO(value);
    case TransactionType.modifyMultisig:
      return ModifyMultisigAccountTransaction.fromDTO(value);
    case TransactionType.lock:
      return LockFundsTransaction.fromDTO(value);
    case TransactionType.accountMetadataV2:
      return AccountMetadataTransaction.fromDTO(value);
    case TransactionType.mosaicMetadataV2:
      return MosaicMetadataTransaction.fromDTO(value);
    case TransactionType.namespaceMetadataV2:
      return NamespaceMetadataTransaction.fromDTO(value);
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

List<Transaction> fixAggregate(List<Transaction> allTransaction) {
  final containsAggregate = allTransaction.firstWhereOrNull((element) =>
      element.entityType() == TransactionType.aggregateCompleted ||
      element.entityType() == TransactionType.aggregateBonded);

  if (containsAggregate != null) {
    for (var transaction in allTransaction) {
      if (transaction.entityType() != TransactionType.aggregateCompleted &&
          transaction.entityType() != TransactionType.aggregateBonded) {
        final aggregateTransaction = allTransaction.firstWhere((element) =>
            element.absTransaction().transactionHash ==
            transaction.absTransaction().aggregateHash) as AggregateTransaction;
        aggregateTransaction.innerTransactions.add(transaction);
        final indexATx = allTransaction.indexOf(aggregateTransaction);
        allTransaction[indexATx] = aggregateTransaction;
      }
    }

    final respAll = <Transaction>[];
    for (var transaction in allTransaction) {
      if (transaction.absTransaction().aggregateHash == null)
        respAll.add(transaction);
    }
    return respAll;
  }
  return allTransaction;
}

Future<List<Transaction>> internalGetTransactions(ApiClient client, String path,
    List<QueryParam> queryParams, Object? postBody,
    {bool firstLevel = true}) async {
  final response = await client.get(path, postBody, queryParams);

  if (response.statusCode! >= 299) {
    throw ApiException(response.statusCode!, response.data);
  } else if (response.data != null) {
    final List resp = client.deserialize(response.data, 'List<Transaction>');
    final allTransaction =
        resp.map(deserializeDTO).toList().cast<Transaction>();

    if (firstLevel) {
      return allTransaction;
    } else
      return fixAggregate(allTransaction);
  } else {
    return [];
  }
}
