part of xpx_chain_sdk.transaction;

// AliasTransaction
class AliasTransaction extends AbstractTransaction implements Transaction {
  AliasTransaction._(int version, Deadline deadline, this.actionType, this.namespaceId, TransactionType transactionType,
      int networkType)
      : super() {
    this.version = version;
    this.deadline = deadline;
    type = transactionType;
    this.networkType = networkType;
  }

  AliasTransaction._fromAddressAliasDTO(AddressAliasTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    actionType =
        dto.transaction.aliasAction == 0 ? actionType = AliasActionType.aliasLink : AliasActionType.aliasUnlink;
    namespaceId =
        dto.transaction.namespaceId != null ? NamespaceId.fromId(dto.transaction.namespaceId.toUint64()) : null;
  }

  AliasTransaction._fromMosaicAliasDTO(MosaicAliasTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    actionType =
        dto.transaction.aliasAction == 0 ? actionType = AliasActionType.aliasLink : AliasActionType.aliasUnlink;
    namespaceId =
        dto.transaction.namespaceId != null ? NamespaceId.fromId(dto.transaction.namespaceId.toUint64()) : null;
  }

  AliasActionType actionType;
  NamespaceId namespaceId;

  int get size => _size();

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  String _aliasTransactionToString() {
    final String _actionType = actionType.toInt == 0 ? 'link' : 'unlink';
    return '{\n'
        '\t"abstractTransaction": ${_absToString()}\n'
        '\t"aliasActionType": $_actionType,\n'
        '\t"namespaceId": ${namespaceId.toHex()},\n';
  }

  @override
  String toString() => _aliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _aliasTransactionToJson();

  Map<String, dynamic> _aliasTransactionToJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    if (actionType != null) {
      data['aliasActionType'] = actionType.toInt;
    }
    data['namespaceId'] = namespaceId.toHex();
    return data;
  }

  @override
  int _size() => aliasTransactionHeader;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() => null;

  Uint8List _generateAliasAbsBytes(fb.Builder builder, int aliasV) {
    final nV = builder.writeListUint32(namespaceId.toIntArray());

    final vectors = _generateVector(builder);

    final txnBuilder = AliasTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addActionType(actionType.toInt)
      ..addNamespaceIdOffset(nV)
      ..addAliasIdOffset(aliasV);
    _buildVector(builder, vectors);

    final codedAlias = txnBuilder.finish();

    return aliasTransactionSchema().serialize(builder.finish(codedAlias));
  }
}

class AddressAliasTransaction extends AliasTransaction {
  AddressAliasTransaction(
      Deadline deadline, this.address, NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(addressAliasVersion, deadline, actionType, namespaceId, TransactionType.addressAlias, networkType);

  AddressAliasTransaction.fromDTO(AddressAliasTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super._fromAddressAliasDTO(dto) {
    address = Address.fromEncoded(dto.transaction.address);
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
  int _size() => super._size() + addressSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final a = base32.decode(address.address);

    final aV = builder.writeListUint8(a);

    return _generateAliasAbsBytes(builder, aV);
  }
}

class MosaicAliasTransaction extends AliasTransaction {
  MosaicAliasTransaction(
      Deadline deadline, this.mosaicId, NamespaceId namespaceId, AliasActionType actionType, int networkType)
      : super._(mosaicAliasVersion, deadline, actionType, namespaceId, TransactionType.mosaicAlias, networkType);

  MosaicAliasTransaction.fromDTO(
    MosaicAliasTransactionInfoDTO value,
  )   : assert(value != null, 'dto must not be null'),
        super._fromMosaicAliasDTO(value) {
    mosaicId = MosaicId.fromUint64(value.transaction.mosaicId.toUint64());
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
  int _size() => super._size() + mosaicIdSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint8(mosaicId.toBytes());

    return _generateAliasAbsBytes(builder, mV);
  }
}
