/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class TransactionType {
  const TransactionType._internal(this.value, this.name);

  static const TransactionType aggregateCompleted =
      TransactionType._internal(0x4141, 'aggregateCompleted'); // 16705

  static const TransactionType aggregateBonded =
      TransactionType._internal(0x4241, 'aggregateBonded'); // 16961

  static const TransactionType addressAlias =
      TransactionType._internal(0x424E, 'addressAlias'); // 16974

  static const TransactionType metadataAddress =
      TransactionType._internal(0x413d, 'metadataAddress'); // 16701

  static const TransactionType metadataMosaic =
      TransactionType._internal(0x423d, 'metadataMosaic'); // 16957

  static const TransactionType metadataNamespace =
      TransactionType._internal(0x433d, 'metadataNamespace'); // 17213

  /// Modify account metadata transaction type - NEM
  static const TransactionType accountMetadataV2 =
      TransactionType._internal(0x413F, 'accountMetadataV2'); // 16703

  /// Modify mosaic metadata transaction type - NEM
  static const TransactionType mosaicMetadataV2 =
      TransactionType._internal(0x423F, 'mosaicMetadataV2'); // 16959

  /// Modify namespace metadata transaction type - NEM
  static const TransactionType namespaceMetadataV2 =
      TransactionType._internal(0x433F, 'namespaceMetadataV2'); // 17215

  static const TransactionType mosaicDefinition =
      TransactionType._internal(0x414d, 'mosaicDefinition'); // 16717

  static const TransactionType mosaicAlias =
      TransactionType._internal(0x434e, 'mosaicAlias');

  static const TransactionType mosaicSupplyChange =
      TransactionType._internal(0x424d, 'mosaicSupplyChange'); // 16973

  static const TransactionType modifyMultisig =
      TransactionType._internal(0x4155, 'modifyMultisig'); // 16725

  static const TransactionType modifyContract =
      TransactionType._internal(0x4157, 'modifyContract'); // 16727

  static const TransactionType registerNamespace =
      TransactionType._internal(0x414e, 'registerNamespace'); // 16718

  static const TransactionType transfer =
      TransactionType._internal(0x4154, 'transfer'); // 16724

  static const TransactionType lock =
      TransactionType._internal(0x4148, 'lock'); // 16712

  static const TransactionType secretLock =
      TransactionType._internal(0x4152, 'secretLock'); // 16722

  static const TransactionType secretProof =
      TransactionType._internal(0x4252, 'secretProof'); // 16978

  static const TransactionType addExchangeOffer =
      TransactionType._internal(0x415D, 'addExchangeOffer'); // 16733

  static const TransactionType exchangeOffer =
      TransactionType._internal(0x425D, 'exchangeOffer'); // 16989

  static const TransactionType removeExchangeOffer =
      TransactionType._internal(0x435D, 'removeExchangeOffer'); // 17245

  static const TransactionType accountPropertyAddress =
      TransactionType._internal(0x4150, 'accountPropertyAddress'); // 16720

  static const TransactionType accountPropertyMosaic =
      TransactionType._internal(0x4250, 'accountPropertyMosaic'); // 16976

  static const TransactionType accountPropertyEntityType =
      TransactionType._internal(0x4350, 'accountPropertyEntityType'); // 17232

  static const TransactionType networkConfigEntityType =
      TransactionType._internal(0x4159, 'networkConfigEntityType'); // 16729

  static const TransactionType blockchainUpgrade =
      TransactionType._internal(0x4158, 'blockchainUpgrade'); // 16728

  final int value;

  /// This TransactionType's name.
  final String name;

  static final List<TransactionType> list = <TransactionType>[
    accountPropertyAddress,
    accountPropertyMosaic,
    accountPropertyEntityType,
    aggregateCompleted,
    aggregateBonded,
    addressAlias,
    metadataAddress,
    metadataMosaic,
    metadataNamespace,
    mosaicDefinition,
    mosaicAlias,
    mosaicSupplyChange,
    modifyMultisig,
    modifyContract,
    registerNamespace,
    transfer,
    lock,
    secretLock,
    secretProof,
    addExchangeOffer,
    exchangeOffer,
    removeExchangeOffer,
    accountMetadataV2,
    mosaicMetadataV2,
    namespaceMetadataV2,
    networkConfigEntityType,
    blockchainUpgrade
  ];

  static TransactionType fromInt(int? value) {
    for (var type in list) {
      if (type.value == value) {
        return type;
      }
    }
    throw errUnknownTransactionType;
  }

  Uint8List toBytes() {
    final buffer = Uint8List(2).buffer;
    final s = ByteData.view(buffer);

    s.setInt16(0, value, Endian.little);
    return buffer.asUint8List();
  }

  /// Returns this TransactionType's [name].
  @override
  String toString() => name;

  int toJson() => value;

  // Subclasses will typically have a private constructor and a fixed set of
  // instances, so `Object.operator==()` will work, and does not need to
  // be overridden explicitly.
  @override
  bool operator ==(Object other);

  @override
  int get hashCode => value;
}
