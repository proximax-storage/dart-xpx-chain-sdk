/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Create/ modify a [BasicMetadataTransaction] entry contains information about metadata .
///
class BasicMetadataTransaction extends AbstractTransaction {
  BasicMetadataTransaction(
      this.targetPublicAccount,
      this.scopedMetadataKey,
      this.valueSizeDelta,
      this.value,
      this.valueSize,
      this.oldValue,
      this.valueDifferences,
      NetworkType networkType,
      Deadline deadline,
      TransactionType type,
      int version,
      Uint64? maxFee)
      : super(networkType, deadline, type, version, maxFee);

  BasicMetadataTransaction.fromDTO(MetaDataEntryTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    targetPublicAccount =
        PublicAccount.fromPublicKey(dto.transaction!.targetKey, networkType);
    scopedMetadataKey = dto.transaction!.scopedMetadataKey!.toUint64()!;
    valueSizeDelta = dto.transaction!.valueSizeDelta!;
    value = ByteUtils.bytesToUtf8String(
        HexUtils.hexToBytes(dto.transaction!.value!));
  }

  PublicAccount? targetPublicAccount;
  Uint64? scopedMetadataKey;
  int? valueSizeDelta;
  String? value;
  String? oldValue;
  int? valueSize;
  Uint8List? valueDifferences;

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    val['targetPublicKey'] = targetPublicAccount;
    val['scopedMetadataKey'] = scopedMetadataKey;
    val['valueSizeDelta'] = valueSizeDelta;

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('value', value);

    return val;
  }

  int size() => metadataV2HeaderSize + value!.length;

  AbstractTransaction absTransaction() => _absTransaction();

  Uint8List basicGenerateBytes(
      fb.Builder builder, int targetIdOffset, int size) {
    final targetKeyOffset = builder
        .writeListUint8(HexUtils.hexToBytes(targetPublicAccount!.publicKey));

    final scopedMetadataKeyOffset =
        builder.writeListUint32(scopedMetadataKey!.toIntArray());

    final valueOffset = builder.writeListUint8(valueDifferences!);

    final buffer = Uint8List(2).buffer;
    final nonceB = ByteData.view(buffer);

    nonceB.setUint16(0, valueSize!, Endian.little);
    final valueSizeOffset = builder.writeListUint8(buffer.asUint8List());

    nonceB.setUint16(0, valueSizeDelta!, Endian.little);
    final valueSizeDeltaOffset = builder.writeListUint8(buffer.asUint8List());

    final vectors = _generateCommonVector(builder);

    final txnBuilder = $buffer.MetadataV2transactionBufferBuilder(builder)
      ..begin()
      ..addSize(size)
      ..addTargetKeyOffset(targetKeyOffset)
      ..addScopedMetadataKeyOffset(scopedMetadataKeyOffset)
      ..addTargetIdOffset(targetIdOffset)
      ..addValueSizeDeltaOffset(valueSizeDeltaOffset)
      ..addValueSizeOffset(valueSizeOffset)
      ..addValueOffset(valueOffset);
    _buildCommonVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();
    builder.finish(codedTransfer);
    return metadataTransactionSchema().serialize(builder.buffer);
  }
}
