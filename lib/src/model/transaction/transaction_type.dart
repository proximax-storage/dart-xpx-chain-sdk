/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class TransactionType {
  const TransactionType._internal(this.value);

  static const TransactionType aggregateCompleted =
      TransactionType._internal(0x4141);

  static const TransactionType aggregateBonded =
      TransactionType._internal(0x4241); // 4241

  static const TransactionType addressAlias = TransactionType._internal(0x424E);

  static const TransactionType metadataAddress =
      TransactionType._internal(0x413d);

  static const TransactionType metadataMosaic =
      TransactionType._internal(0x423d);

  static const TransactionType metadataNamespace =
      TransactionType._internal(0x433d);

  /// Modify account metadata transaction type - NEM
  static const TransactionType accountMetadataV2 =
      TransactionType._internal(0x413F); // 16703

  /// Modify mosaic metadata transaction type - NEM
  static const TransactionType mosaicMetadataV2 =
      TransactionType._internal(0x423F);

  /// Modify namespace metadata transaction type - NEM
  static const TransactionType namespaceMetadataV2 =
      TransactionType._internal(0x433F);

  static const TransactionType mosaicDefinition =
      TransactionType._internal(0x414d);

  static const TransactionType mosaicAlias = TransactionType._internal(0x434e);

  static const TransactionType mosaicSupplyChange =
      TransactionType._internal(0x424d);

  static const TransactionType modifyMultisig =
      TransactionType._internal(0x4155);

  static const TransactionType modifyContract =
      TransactionType._internal(0x4157);

  static const TransactionType registerNamespace =
      TransactionType._internal(0x414e);

  static const TransactionType transfer = TransactionType._internal(0x4154);

  static const TransactionType lock = TransactionType._internal(0x4148);

  static const TransactionType secretLock = TransactionType._internal(0x4152);

  static const TransactionType secretProof = TransactionType._internal(0x4252);

  static const TransactionType addExchangeOffer =
      TransactionType._internal(0x415D);

  static const TransactionType exchangeOffer =
      TransactionType._internal(0x425D);

  static const TransactionType removeExchangeOffer =
      TransactionType._internal(0x435D);

  static const TransactionType accountPropertyAddress =
      TransactionType._internal(0x4150);

  static const TransactionType accountPropertyMosaic =
      TransactionType._internal(0x4250);

  static const TransactionType accountPropertyEntityType =
      TransactionType._internal(0x4350);

  static const TransactionType networkConfigEntityType =
      TransactionType._internal(0x4159);

  static const TransactionType blockchainUpgrade =
      TransactionType._internal(0x4158);

  final int value;

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
    print(value);

    throw errUnknownTransactionType;
  }

  Uint8List toBytes() {
    final buffer = Uint8List(2).buffer;
    final s = ByteData.view(buffer);

    s.setInt16(0, TransactionType.addExchangeOffer.value, Endian.little);
    return buffer.asUint8List();
  }

  @override
  String toString() => encoder.convert(this);

  int toJson() => value;
}
