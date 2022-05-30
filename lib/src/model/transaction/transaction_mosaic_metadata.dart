/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Create/ modify a [AccountMetadataTransaction] entry contains information about metadata .
///
class MosaicMetadataTransaction extends BasicMetadataTransaction
    implements Transaction {
  MosaicMetadataTransaction._(
      this.targetMosaicId,
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
            TransactionType.mosaicMetadataV2,
            mosaicMetadataVersionV2,
            maxFee);

  MosaicMetadataTransaction.fromDTO(MetaDataEntryTransactioInfoDTO dto)
      : super.fromDTO(dto) {
    targetPublicAccount =
        PublicAccount.fromPublicKey(dto.transaction!.targetKey, networkType);
    scopedMetadataKey = dto.transaction!.scopedMetadataKey!.toUint64()!;
    valueSizeDelta = dto.transaction!.valueSizeDelta!;
    value = ByteUtils.bytesToUtf8String(
        HexUtils.hexToBytes(dto.transaction!.value!));
  }

  factory MosaicMetadataTransaction.create(
      Deadline deadline,
      MosaicId targetMosaicId,
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

    return MosaicMetadataTransaction._(
        targetMosaicId,
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

  MosaicId? targetMosaicId;

  @override
  int size() => metadataV2HeaderSize + value!.length;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final buffer = Uint8List(mosaicIdSize).buffer;
    final nonceB = ByteData.view(buffer);
    nonceB.setUint64(0, valueSize!, Endian.little);
    final targetIdOffset = builder.writeListUint8(buffer.asUint8List());

    return super.basicGenerateBytes(builder, targetIdOffset, size());
  }

  @override
  TransactionType entityType() => type;
}
