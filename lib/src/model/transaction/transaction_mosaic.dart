part of xpx_chain_sdk.transaction;

/// Register a new mosaic.
/// Announce a [MosaicDefinitionTransaction] to create a new [Mosaic].
///
class MosaicDefinitionTransaction extends AbstractTransaction
    implements Transaction {
  MosaicDefinitionTransaction(Deadline deadline, int nonce,
      String ownerPublicKey, MosaicProperties mosaicProps, int networkType)
      : super() {
    if (ownerPublicKey.length != 64) {
      throw errInvalidOwnerPublicKey;
    } else if (mosaicProps == null) {
      throw errNullMosaicProperties;
    } else {
      version = mosaicDefinitionVersion;
      this.deadline = deadline;
      type = TransactionType.mosaicDefinition;
      this.networkType = networkType;
      mosaicNonce = nonce;
      mosaicProperties = mosaicProps;
      // Signer of transaction must be the same with ownerPublicKey
      mosaicId = MosaicId.fromNonceAndOwner(nonce, ownerPublicKey);
    }
  }

  MosaicDefinitionTransaction.fromDTO(MosaicDefinitionTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super.fromDto(value.transaction, value.meta) {
    mosaicProperties = MosaicProperties.fromDTO(value.transaction.properties);
    mosaicNonce = value.transaction.mosaicNonce.toUnsigned(32);
    mosaicId = MosaicId.fromId(value.transaction.mosaicId.toUint64());
  }

  MosaicProperties mosaicProperties;
  int mosaicNonce;
  MosaicId mosaicId;

  int get size => _size();
  AbstractTransaction get abstractTransaction => _abstractTransaction();

  static List<MosaicDefinitionTransaction> listFromDTO(
          List<MosaicDefinitionTransactionInfoDTO> json) =>
      json == null
          ? null
          : json
              .map((value) => MosaicDefinitionTransaction.fromDTO(value))
              .toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_absToString()}')
      ..writeln('\t"mosaicProperties": $mosaicProperties')
      ..writeln('\t"mosaicNonce": ${mosaicNonce.toSigned(64)},')
      ..writeln('\t"assetId": $mosaicId,')
      ..write('\t}\n');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['mosaicProperties'] = mosaicProperties;
    data['mosaicNonce'] = mosaicNonce;
    data['mosaicId'] = mosaicId;
    return data;
  }

  @override
  int _size() => mosaicDefinitionTransactionHeaderSize;

  @override
  AbstractTransaction _abstractTransaction() => _absTransaction();

  int _buildMosaicPropertyBuffer(
      fb.Builder builder, List<MosaicProperty> properties) {
    if (properties == null) return 0;
    final List<int> pBuffer = List(properties.length);

    int i = 0;
    for (final p in properties) {
      final valueV = builder.writeListUint32(p.value.toIntArray());

      final mosaicBuilder = MosaicPropertyBuilder(builder)
        ..begin()
        ..addMosaicPropertyId(p.id.index)
        ..addValueOffset(valueV);
      pBuffer[i] = mosaicBuilder.finish();
      i++;
    }
    return builder.writeList(pBuffer);
  }

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    int f = 0;
    if (mosaicProperties.supplyMutable) {
      f += getSupplyMutable;
    }
    if (mosaicProperties.transferable) {
      f += getTransferable;
    }

    final mV = builder.writeListUint32(mosaicId.toIntArray());

    final pV = _buildMosaicPropertyBuffer(
        builder, mosaicProperties.optionalProperties);

    final vector = _generateVector(builder);

    final txnBuilder = MosaicDefinitionTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMosaicNonce(mosaicNonce)
      ..addMosaicIdOffset(mV)
      ..addFlags(f)
      ..addDivisibility(mosaicProperties.divisibility)
      ..addNumOptionalProperties(mosaicProperties.optionalProperties.length)
      ..addOptionalPropertiesOffset(pV);

    _buildVector(builder, vector);

    final codedMosaicDefinition = txnBuilder.finish();

    return mosaicDefinitionTransactionSchema()
        .serialize(builder.finish(codedMosaicDefinition));
  }
}

/// Change an existent mosaic supply.
/// Announce a [MosaicSupplyChangeTransaction] to increase or decrease a mosaic’s supply.
///
class MosaicSupplyChangeTransaction extends AbstractTransaction
    implements Transaction {
  MosaicSupplyChangeTransaction(Deadline deadline, MosaicSupplyType supplyType,
      MosaicId mosaicId, Uint64 delta, int networkType)
      : super() {
    if (mosaicId == null) {
      throw errNullMosaicId;
    } else if (supplyType == null) {
      throw errNullSupplyType;
    } else {
      version = mosaicSupplyChangeVersion;
      this.deadline = deadline;
      type = TransactionType.mosaicSupplyChange;
      this.networkType = networkType;
      this.mosaicId = mosaicId;
      mosaicSupplyType = supplyType;
      this.delta = delta;
    }
  }

  MosaicSupplyChangeTransaction.fromDTO(
      MosaicSupplyChangeTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super.fromDto(value.transaction, value.meta) {
    mosaicSupplyType = value.transaction.direction == 0 ? decrease : increase;
    mosaicId = MosaicId.fromId(value.transaction.mosaicId.toUint64());
    delta = value.transaction.delta.toUint64();
  }

  MosaicSupplyType mosaicSupplyType;
  Uint64 delta;
  MosaicId mosaicId;

  int get size => _size();
  AbstractTransaction get abstractTransaction => _abstractTransaction();

  static List<MosaicSupplyChangeTransaction> listFromDTO(
          List<MosaicSupplyChangeTransactionInfoDTO> json) =>
      json == null
          ? null
          : json
              .map((value) => MosaicSupplyChangeTransaction.fromDTO(value))
              .toList();

  @override
  String toString() {
    final String _supplyType =
        mosaicSupplyType.index == 0 ? 'decrease' : 'increase';
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_absToString()}')
      ..writeln('\t"assetId": $mosaicId')
      ..writeln('\t"mosaicSupplyType": $_supplyType,')
      ..writeln('\t"delta": $delta')
      ..write('\t}');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['mosaicId'] = mosaicId;
    data['mosaicSupplyType'] = mosaicSupplyType.index;
    data['delta'] = delta;
    return data;
  }

  @override
  int _size() => mosaicSupplyChangeTransactionSize;

  @override
  AbstractTransaction _abstractTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint32(mosaicId.toIntArray());

    final dV = builder.writeListUint32(delta.toIntArray());

    final vector = _generateVector(builder);

    final txnBuilder = MosaicSupplyChangeTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMosaicIdOffset(mV)
      ..addDirection(mosaicSupplyType.index)
      ..addDeltaOffset(dV);
    _buildVector(builder, vector);

    final codedMosaicSupply = txnBuilder.finish();

    return mosaicSupplyChangeTransactionSchema()
        .serialize(builder.finish(codedMosaicSupply));
  }
}
