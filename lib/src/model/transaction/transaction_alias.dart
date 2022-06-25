/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

// AliasTransaction
class AliasTransaction extends AbstractTransaction implements Transaction {
  AliasTransaction._(
      int version,
      Deadline deadline,
      this.actionType,
      this.namespaceId,
      TransactionType transactionType,
      NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, transactionType, version, maxFee);

  AliasTransaction._fromAddressAliasDTO(AddressAliasTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    actionType = dto.transaction!.aliasAction == 0
        ? actionType = AliasActionType.aliasLink
        : AliasActionType.aliasUnlink;
    namespaceId = dto.transaction!.namespaceId != null
        ? NamespaceId(dto.transaction!.namespaceId!.toUint64()!)
        : null;
  }

  AliasTransaction._fromMosaicAliasDTO(MosaicAliasTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    actionType = dto.transaction!.aliasAction == 0
        ? actionType = AliasActionType.aliasLink
        : AliasActionType.aliasUnlink;
    namespaceId = dto.transaction!.namespaceId != null
        ? NamespaceId(dto.transaction!.namespaceId!.toUint64()!)
        : null;
  }

  AliasActionType? actionType;
  NamespaceId? namespaceId;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  String _aliasTransactionToString() {
    final String _actionType = actionType!.toInt == 0 ? 'link' : 'unlink';
    return '{\n'
        '\t"abstractTransaction": ${_absToString()}\n'
        '\t"aliasActionType": $_actionType,\n'
        '\t"namespaceId": ${namespaceId!.toHex()},\n';
  }

  @override
  String toString() => _aliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _aliasTransactionToJson();

  Map<String, dynamic> _aliasTransactionToJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    if (actionType != null) {
      data['aliasActionType'] = actionType!.toInt;
    }
    data['namespaceId'] = namespaceId!.toHex();
    return data;
  }

  @override
  int size() => aliasTransactionHeader;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() => Uint8List(0);

  Uint8List _generateAliasAbsBytes(fb.Builder builder, int aliasV) {
    final nV = builder.writeListUint32(namespaceId!.toIntArray());

    final vectors = _generateCommonVector(builder);

    final txnBuilder = $buffer.AliasTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addActionType(actionType!.toInt)
      ..addNamespaceIdOffset(nV)
      ..addAliasIdOffset(aliasV);
    _buildCommonVector(builder, vectors);

    final codedAlias = txnBuilder.finish();
    builder.finish(codedAlias);
    return aliasTransactionSchema().serialize(builder.buffer);
  }
}

class AddressAliasTransaction extends AliasTransaction {
  AddressAliasTransaction(
      Deadline deadline,
      this.address,
      NamespaceId namespaceId,
      AliasActionType actionType,
      NetworkType networkType)
      : super._(addressAliasVersion, deadline, actionType, namespaceId,
            TransactionType.addressAlias, networkType);

  AddressAliasTransaction.fromDTO(AddressAliasTransactionInfoDTO dto)
      : super._fromAddressAliasDTO(dto) {
    address = Address.fromEncoded(dto.transaction!.address!);
  }

  Address? address;

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
  int size() => super.size() + addressSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);
    final a = base32.decode(address!.address);

    final aV = builder.writeListUint8(a);

    return _generateAliasAbsBytes(builder, aV);
  }
}

class MosaicAliasTransaction extends AliasTransaction {
  MosaicAliasTransaction(
      Deadline deadline,
      this.mosaicId,
      NamespaceId namespaceId,
      AliasActionType actionType,
      NetworkType networkType)
      : super._(mosaicAliasVersion, deadline, actionType, namespaceId,
            TransactionType.mosaicAlias, networkType);

  MosaicAliasTransaction.fromDTO(
    MosaicAliasTransactionInfoDTO value,
  ) : super._fromMosaicAliasDTO(value) {
    mosaicId = MosaicId(value.transaction!.mosaicId!.toUint64());
  }

  MosaicId? mosaicId;

  String _mosaicAliasTransactionToString() => '${super.toString()}'
      '\t"mosaicId": ${mosaicId!.toHex()}\n'
      '}\n';

  @override
  String toString() => _mosaicAliasTransactionToString();

  @override
  Map<String, dynamic> toJson() => _mosaicAliasTransactionToJson();

  Map<String, dynamic> _mosaicAliasTransactionToJson() {
    final data = <String, dynamic>{};
    data.addAll(super.toJson());
    if (actionType != null) {
      data['mosaicId'] = mosaicId!.toHex();
    }
    return data;
  }

  @override
  int size() => super.size() + mosaicIdSize;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = builder.writeListUint8(mosaicId!.toBytes());

    return _generateAliasAbsBytes(builder, mV);
  }
}
