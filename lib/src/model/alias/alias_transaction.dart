part of xpx_chain_sdk.alias;

// AliasTransaction
class AliasTransaction extends AbstractTransaction implements Transaction {
  AliasTransaction._(int version, Deadline deadline, this.actionType,
      this.namespaceId, int networkType)
      : super() {
    this.version = version;
    this.deadline = deadline;
    type = transactionTypeFromRaw(17230);
    this.networkType = networkType;
  }

  AliasTransaction._fromAddressAliasDTO(AddressAliasTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super.fromDto(value._transaction, value.meta) {
    actionType = value._transaction.aliasAction == 0
        ? actionType = AliasActionType.aliasLink
        : AliasActionType.aliasUnlink;
    namespaceId = value._transaction.namespaceId != null
        ? NamespaceId.fromId(value._transaction.namespaceId.toBigInt())
        : null;
  }

  AliasTransaction._fromMosaicAliasDTO(MosaicAliasTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super.fromDto(value.transaction, value.meta) {
    actionType = value.transaction.aliasAction == 0
        ? actionType = AliasActionType.aliasLink
        : AliasActionType.aliasUnlink;
    namespaceId = value.transaction.namespaceId != null
        ? NamespaceId.fromId(value.transaction.namespaceId.toBigInt())
        : null;
  }

  AliasActionType actionType;
  NamespaceId namespaceId;

  String _aliasTransactionToString() {
    final String _actionType = actionType.index == 0 ? 'link' : 'unlink';
    return '{\n'
        '\t"abstractTransaction": ${abstractTransactionToString()}\n'
        '\t"aliasActionType": $_actionType,\n'
        '\t"namespaceId": ${namespaceId.toHex()},\n';
  }

  @override
  String toString() => _aliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _aliasTransactionToJson();

  Map<String, dynamic> _aliasTransactionToJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = abstractTransactionToJson();
    if (actionType != null) {
      data['aliasActionType'] = actionType.index;
    }
    data['namespaceId'] = namespaceId.toHex();
    return data;
  }

  @override
  int size() => aliasTransactionHeader;

  @override
  AbstractTransaction getAbstractTransaction() => getAbstractTransaction();

  @override
  Uint8List generateBytes() => null;

  Uint8List _generateAbstractBytes(fb.Builder builder, int aliasV) {
    final nV = builder.writeListUint32(namespaceId.toArray());

    final vectors = generateVector(builder);

    final txnBuilder = AliasTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addActionType(actionType.index)
      ..addNamespaceIdOffset(nV)
      ..addAliasIdOffset(aliasV);
    buildVector(builder, vectors);

    final codedAlias = txnBuilder.finish();

    return aliasTransactionSchema().serialize(builder.finish(codedAlias));
  }
}

class AddressAliasTransaction extends AliasTransaction {
  AddressAliasTransaction._(Deadline deadline, this.address,
      NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(addressAliasVersion, deadline, actionType, namespaceId,
            networkType);

  AddressAliasTransaction.fromDTO(AddressAliasTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super._fromAddressAliasDTO(value) {
    address = Address.fromEncoded(value._transaction.address);
  }

  Address address;

  String addressAliasTransactionToString() => '${super.toString()}'
      '\t"address": $address\n'
      '}\n';

  @override
  String toString() => addressAliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => addressAliasTransactionToJson();

  Map<String, dynamic> addressAliasTransactionToJson() {
    final data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (actionType != null) {
      data['address'] = address;
    }
    return data;
  }

  @override
  int size() => super.size() + mosaicIdSize;

  @override
  AbstractTransaction getAbstractTransaction() => getAbstractTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final a = base32.decode(address.address);

    final aV = builder.writeListUint8(a);

    return _generateAbstractBytes(builder, aV);
  }
}

class MosaicAliasTransaction extends AliasTransaction {
  MosaicAliasTransaction(Deadline deadline, this.mosaicId,
      NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(
            mosaicAliasVersion, deadline, actionType, namespaceId, networkType);

  MosaicAliasTransaction.fromDTO(
    MosaicAliasTransactionInfoDTO value,
  )   : assert(value != null, 'value must not be null'),
        super._fromMosaicAliasDTO(value) {
    mosaicId = MosaicId.fromBigInt(value.transaction.mosaicId.toBigInt());
  }

  MosaicId mosaicId;

  String _mosaicAliasTransactionToString() => '${super.toString()}'
      '\t"mosaicId": ${mosaicId.toHex()}\n'
      '}\n';

  @override
  String toString() => _mosaicAliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _mosaicAliasTransactionToJson();

  Map<String, dynamic> _mosaicAliasTransactionToJson() {
    final data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (actionType != null) {
      data['mosaicId'] = mosaicId.toHex();
    }
    return data;
  }

  @override
  int size() => super.size() + mosaicIdSize;

  @override
  AbstractTransaction getAbstractTransaction() => getAbstractTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final buffer = Uint8List(mosaicIdSize).buffer;
    final bufferData = ByteData.view(buffer)
      ..setUint64(0, mosaicId.toIn(), Endian.little);

    final mV = builder.writeListUint8(bufferData.buffer.asUint8List());

    return _generateAbstractBytes(builder, mV);
  }
}
