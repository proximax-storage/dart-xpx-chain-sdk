/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Create/ modify a [AccountMetadataTransaction] entry contains information about metadata .
///
class NamespaceMetadataTransaction extends BasicMetadataTransaction
    implements Transaction {
  NamespaceMetadataTransaction._(
      this.targetNamespaceId,
      PublicAccount targetAccount,
      Uint64 scopedMetadataKey,
      int valueSizeDelta,
      String value,
      int valueSize,
      String? oldValue,
      Uint8List? valueDifferences,
      NetworkType networkType,
      Deadline deadline,
      Uint64? maxFee)
      : super(
            targetAccount,
            scopedMetadataKey,
            valueSizeDelta,
            value,
            valueSize,
            oldValue,
            valueDifferences,
            networkType,
            deadline,
            TransactionType.namespaceMetadataV2,
            namespaceMetadataVersionV2,
            maxFee);

  NamespaceMetadataTransaction.fromDTO(MetaDataEntryTransactioInfoDTO dto)
      : super.fromDTO(dto);

  factory NamespaceMetadataTransaction.create(
      Deadline deadline,
      NamespaceId targetNamespaceId,
      PublicAccount targetAccount,
      scopedMetadataKey,
      String value,
      String oldValue,
      NetworkType networkType,
      [Uint64? maxFee]) {
    if (value == oldValue) {
      throw ArgumentError('new value is the same');
    }

    if (!(scopedMetadataKey is Uint64) && !(scopedMetadataKey is String)) {
      throw ArgumentError('invalid scopedMetadataKey type');
    }

    final scopedMetadataKeyValue = Uint64.fromString(scopedMetadataKey);

    final valueLength = HexUtils.utf8ToHex(value).length ~/ 2;
    final oldValueLength = HexUtils.utf8ToHex(oldValue).length ~/ 2;

    final valueSizeDelta = valueLength - oldValueLength;
    final valueSize = [valueLength, oldValueLength, 0].reduce(max);

    final Uint8List valueUint8List = Uint8List(valueSize);
    valueUint8List.setAll(0, HexUtils.hexToBytes(HexUtils.utf8ToHex(value)));
    final Uint8List oldValueUint8List = Uint8List(valueSize);
    oldValueUint8List.setAll(
        0, HexUtils.hexToBytes(HexUtils.utf8ToHex(oldValue)));
    final Uint8List valueDifferenceBytes = Uint8List(valueSize);

    for (var i = 0; i < valueSize; ++i) {
      valueDifferenceBytes[i] = valueUint8List[i] ^ oldValueUint8List[i];
    }

    return NamespaceMetadataTransaction._(
        targetNamespaceId,
        targetAccount,
        scopedMetadataKeyValue,
        valueSizeDelta,
        value,
        valueSize,
        oldValue,
        valueDifferenceBytes,
        networkType,
        deadline,
        maxFee);
  }

  factory NamespaceMetadataTransaction.createFromPayload(
      Deadline deadline,
      NamespaceId targetNamespaceId,
      PublicAccount targetAccount,
      scopedMetadataKey,
      int valueSize,
      int valueSizeDelta,
      Uint8List valueDifferences,
      NetworkType networkType,
      [Uint64? maxFee]) {
    if (!(scopedMetadataKey is Uint64) && !(scopedMetadataKey is String)) {
      throw ArgumentError('invalid scopedMetadataKey type');
    }

    final scopedMetadataKeyValue = Uint64.fromString(scopedMetadataKey);

    return NamespaceMetadataTransaction._(
        targetNamespaceId,
        targetAccount,
        scopedMetadataKeyValue,
        valueSizeDelta,
        '',
        valueSize,
        '',
        valueDifferences,
        networkType,
        deadline,
        maxFee);
  }

  late NamespaceId targetNamespaceId;

  @override
  int size() => metadataV2HeaderSize + namespaceSize + valueSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final targetIdOffset =
        builder.writeListUint8(targetNamespaceId.toBytes().toList());
    return super.basicGenerateBytes(builder, targetIdOffset, size());
  }

  @override
  TransactionType entityType() => type;
}
