/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

// AliasTransaction
class AccountPropertiesMosaicTransaction extends AbstractTransaction
    implements Transaction {
  AccountPropertiesMosaicTransaction(Deadline deadline, this.propertyType,
      this.modifications, NetworkType networkType, [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.accountPropertyMosaic,
            accountRestrictionMosaicVersion, maxFee);

  AccountPropertiesMosaicTransaction.fromDTO(
      AccountPropertiesMosaicTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    propertyType = AccountPropertyType.fromInt(dto.transaction!.propertyType);
    modifications = AccountPropertiesMosaicModification.listFromJson(
        dto.transaction!.modifications!);
  }

  AccountPropertyType? propertyType;
  List<AccountPropertiesMosaicModification>? modifications;

  AbstractTransaction get abstractTransaction => absTransaction();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    val['propertyType'] = propertyType;
    val['modifications'] = modifications;

    return val;
  }

  @override
  int size() =>
      accountPropertyMosaicHeader +
      (accountPropertiesMosaicModificationSize * modifications!.length);

  @override
  TransactionType entityType() => type;

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics
    final List<int?> msb =
        List.filled(modifications!.length, null, growable: false);
    int i = 0;
    for (final modification in modifications!) {
      final assetId = modification.assetId!.toBytes();
      final aV = builder.writeListUint8(assetId);

      final ms = $buffer.PropertyModificationBufferBuilder(builder)
        ..begin()
        ..addModificationType(modification.modificationType!.index)
        ..addValueOffset(aV);
      msb[i] = ms.finish();
      i++;
    }

    final mV = builder.writeList(msb as List<int>);

    final vectors = _generateCommonVector(builder);

    final txnBuilder =
        $buffer.AccountPropertiesTransactionBufferBuilder(builder)
          ..begin()
          ..addSize(size())
          ..addPropertyType(propertyType!.value)
          ..addModificationCount(modifications!.length)
          ..addModificationsOffset(mV);
    _buildCommonVector(builder, vectors);

    final codedAccountProperty = txnBuilder.finish();
    builder.finish(codedAccountProperty);
    return accountPropertyTransactionSchema().serialize(builder.buffer);
  }
}
