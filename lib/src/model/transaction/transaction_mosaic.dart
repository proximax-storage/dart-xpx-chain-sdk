/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Register a new mosaic.
/// Announce a [MosaicDefinitionTransaction] to create a new [Mosaic].
///
class MosaicDefinitionTransaction extends AbstractTransaction
    implements Transaction {
  MosaicDefinitionTransaction.create(
      Deadline deadline,
      MosaicNonce nonce,
      PublicAccount ownerPublicAccount,
      MosaicProperties mosaicProps,
      NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.mosaicDefinition,
            mosaicDefinitionVersion, maxFee) {
    mosaicNonce = nonce;
    mosaicProperties = mosaicProps;
    // Signer of transaction must be the same with ownerPublicKey
    mosaicId = MosaicId.fromNonceAndOwner(nonce, ownerPublicAccount);
  }

  MosaicDefinitionTransaction.fromDTO(MosaicDefinitionTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    mosaicProperties = MosaicProperties.fromDTO(dto.transaction!.properties!);
    mosaicNonce = MosaicNonce.fromInt(dto.transaction!.mosaicNonce!);
    mosaicId = MosaicId.fromId(dto.transaction!.mosaicId!.toUint64());
  }

  MosaicProperties? mosaicProperties;
  MosaicNonce? mosaicNonce;
  MosaicId? mosaicId;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('mosaicProperties', mosaicProperties);
    writeNotNull('mosaicNonce', mosaicNonce);
    writeNotNull('mosaicId', mosaicId!.toHex());
    return val;
  }

  @override
  int size() =>
      mosaicDefinitionTransactionHeaderSize +
      mosaicProperties!.optionalProperties.length * mosaicOptionalPropertySize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  int _buildMosaicPropertyBuffer(
      fb.Builder builder, List<MosaicProperty?>? properties) {
    if (properties == null) return 0;
    final List<int> pBuffer =
        List.filled(properties.length, 0, growable: false);

    int i = 0;
    for (final p in properties) {
      final valueV = builder.writeListUint32(p!.value!.toIntArray());

      final mosaicBuilder = $buffer.MosaicPropertyBuilder(builder)
        ..begin()
        ..addMosaicPropertyId(p.id!.index)
        ..addValueOffset(valueV);
      pBuffer[i] = mosaicBuilder.finish();
      i++;
    }
    return builder.writeList(pBuffer);
  }

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    int flags = 0;
    if (mosaicProperties!.supplyMutable!) {
      flags += getSupplyMutable;
    }
    if (mosaicProperties!.transferable!) {
      flags += getTransferable;
    }

    final mosaicIdOffset = builder.writeListUint32(mosaicId!.toIntArray());
    final mosaicNonceOffset = builder.writeListUint8(mosaicNonce!.nonce);
    final optionalPropertiesOffset = _buildMosaicPropertyBuffer(
        builder, mosaicProperties!.optionalProperties);
    final commonVector = _generateCommonVector(builder);

    final txnBuilder = $buffer.MosaicDefinitionTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addMosaicNonceOffset(mosaicNonceOffset)
      ..addMosaicIdOffset(mosaicIdOffset)
      ..addFlags(flags)
      ..addDivisibility(mosaicProperties!.divisibility!)
      ..addNumOptionalProperties(mosaicProperties!.optionalProperties.length)
      ..addOptionalPropertiesOffset(optionalPropertiesOffset);

    _buildCommonVector(builder, commonVector);

    final codedMosaicDefinition = txnBuilder.finish();
    builder.finish(codedMosaicDefinition);
    return mosaicDefinitionTransactionSchema().serialize(builder.buffer);
  }
}

/// Change an existent mosaic supply.
/// Announce a [MosaicSupplyChangeTransaction] to increase or decrease a mosaic’s supply.
///
class MosaicSupplyChangeTransaction extends AbstractTransaction
    implements Transaction {
  MosaicSupplyChangeTransaction.create(Deadline deadline, this.mosaicSupplyType,
      this.mosaicId, this.delta, NetworkType networkType, [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.mosaicSupplyChange,
            mosaicSupplyChangeVersion, maxFee);

  MosaicSupplyChangeTransaction.fromDTO(
      MosaicSupplyChangeTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    mosaicSupplyType = dto.transaction!.direction == 0 ? decrease : increase;
    mosaicId = MosaicId.fromId(dto.transaction!.mosaicId!.toUint64());
    delta = dto.transaction!.delta!.toUint64();
  }

  MosaicSupplyType? mosaicSupplyType;
  Uint64? delta;
  MosaicId? mosaicId;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {
      'mosaicSupplyType': mosaicSupplyType.toString(),
    }..addAll(_absToJson());

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('mosaicId', mosaicId!.toHex());
    writeNotNull('delta', delta);
    return val;
  }

  @override
  int size() => mosaicSupplyChangeTransactionSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mosaicIdOffset = builder.writeListUint32(mosaicId!.toIntArray());
    final deltaOffset = builder.writeListUint32(delta!.toIntArray());
    final commonVector = _generateCommonVector(builder);

    final txnBuilder =
        $buffer.MosaicSupplyChangeTransactionBufferBuilder(builder)
          ..begin()
          ..addSize(size())
          ..addMosaicIdOffset(mosaicIdOffset)
          ..addDirection(mosaicSupplyType!.index)
          ..addDeltaOffset(deltaOffset);
    _buildCommonVector(builder, commonVector);

    final codedMosaicSupply = txnBuilder.finish();
    builder.finish(codedMosaicSupply);
    return mosaicSupplyChangeTransactionSchema().serialize(builder.buffer);
  }
}
