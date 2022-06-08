/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Create/ modify a [NamespaceMetadataTransaction] entry contains information about metadata .
///
class NamespaceMetadataTransaction extends BasicMetadataTransaction
    implements Transaction {
  NamespaceMetadataTransaction(
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

  NamespaceMetadataTransaction.fromDTO(MetaDataEntryTransactionInfoDTO dto)
      : targetNamespaceId =
            NamespaceId.fromId(dto.transaction!.targetNamespaceId!.toUint64()),
        super.fromDTO(dto);

  factory NamespaceMetadataTransaction.create(
      Deadline deadline,
      NamespaceId targetNamespaceId,
      PublicAccount targetAccount,
      String scopedMetadataKeyString,
      String value,
      String oldValue,
      NetworkType networkType,
      [Uint64? maxFee]) {
    if (value == oldValue) {
      throw ArgumentError('new value is the same');
    }

    final scopedMetadataKey = Uint64.fromString(scopedMetadataKeyString);

    final valueSizeDelta = (value.length - oldValue.length).toInt();
    final valueSize = [value.length, oldValue.length, 0].reduce(max).toInt();

    final Uint8List valueUint8List = Uint8List(valueSize);
    valueUint8List.setAll(0, HexUtils.hexToBytes(HexUtils.utf8ToHex(value)));
    final Uint8List oldValueUint8List = Uint8List(valueSize);
    oldValueUint8List.setAll(
        0, HexUtils.hexToBytes(HexUtils.utf8ToHex(oldValue)));
    final Uint8List valueDifferenceBytes = Uint8List(valueSize);

    for (var i = 0; i < valueSize; ++i) {
      valueDifferenceBytes[i] = valueUint8List[i] ^ oldValueUint8List[i];
    }

    return NamespaceMetadataTransaction(
        targetNamespaceId,
        targetAccount,
        scopedMetadataKey,
        valueSizeDelta,
        value,
        valueSize,
        oldValue,
        valueDifferenceBytes,
        networkType,
        deadline,
        maxFee);
  }

  NamespaceId? targetNamespaceId;

  @override
  Map<String, dynamic> toJson() {
    final val = super.toJson();
    val['targetNamespaceId'] = targetNamespaceId;
    return val;
  }

  @override
  int size() => metadataV2HeaderSize + value!.length;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final buffer = Uint8List(namespaceSize).buffer;
    final nonceB = ByteData.view(buffer);
    nonceB.setUint64(0, valueSize!, Endian.little);
    final targetIdOffset = builder.writeListUint8(buffer.asUint8List());

    return super.basicGenerateBytes(builder, targetIdOffset, size());
  }

  @override
  TransactionType entityType() => type;
}
