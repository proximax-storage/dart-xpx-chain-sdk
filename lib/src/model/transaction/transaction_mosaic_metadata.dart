/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Create/ modify a [AccountMetadataTransaction] entry contains information about metadata .
///
class MosaicMetadataTransaction extends BasicMetadataTransaction implements Transaction {
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
      : super(targetAccount, scopedMetadataKey, valueSizeDelta, value, valueSize, oldValue, valueDifferences,
            networkType, deadline, TransactionType.mosaicMetadataV2, mosaicMetadataVersionV2, maxFee);

  MosaicMetadataTransaction.fromDTO(MetaDataEntryTransactioInfoDTO dto, this.targetMosaicId) : super.fromDTO(dto);

  factory MosaicMetadataTransaction.create(Deadline deadline, MosaicId targetMosaicId, PublicAccount targetAccount,
      scopedMetadataKey, String value, String oldValue, NetworkType networkType,
      [Uint64? maxFee]) {
    if (value == oldValue) {
      throw ArgumentError('new value is the same');
    }

    if (!(scopedMetadataKey is Uint64) && !(scopedMetadataKey is String)) {
      throw ArgumentError('invalid scopedMetadataKey type');
    }

    final scopedMetadataKeyValue = scopedMetadataKey is Uint64 ? scopedMetadataKey : Uint64.fromUtf8(scopedMetadataKey);

    final valueLength = HexUtils.utf8ToHex(value).length ~/ 2;
    final oldValueLength = HexUtils.utf8ToHex(oldValue).length ~/ 2;

    final valueSizeDelta = valueLength - oldValueLength;
    final valueSize = [valueLength, oldValueLength, 0].reduce(max);

    final Uint8List valueUint8List = Uint8List(valueSize);
    valueUint8List.setAll(0, HexUtils.hexToBytes(HexUtils.utf8ToHex(value)));
    final Uint8List oldValueUint8List = Uint8List(valueSize);
    oldValueUint8List.setAll(0, HexUtils.hexToBytes(HexUtils.utf8ToHex(oldValue)));
    final Uint8List valueDifferenceBytes = Uint8List(valueSize);

    for (var i = 0; i < valueSize; ++i) {
      valueDifferenceBytes[i] = valueUint8List[i] ^ oldValueUint8List[i];
    }

    return MosaicMetadataTransaction._(targetMosaicId, targetAccount, scopedMetadataKeyValue, valueSizeDelta, value,
        valueSize, oldValue, valueDifferenceBytes, networkType, deadline, maxFee);
  }

  final MosaicId targetMosaicId;

  @override
  int size() => metadataV2HeaderSize + mosaicIdSize + valueSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    print(targetMosaicId.toBytes());
    final targetIdOffset = builder.writeListUint8(targetMosaicId.toBytes().toList());
    return super.basicGenerateBytes(builder, targetIdOffset, size());
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(super.toJson());

    val['targetMosaicId'] = targetMosaicId;

    return val;
  }

  @override
  TransactionType entityType() => type;
}
