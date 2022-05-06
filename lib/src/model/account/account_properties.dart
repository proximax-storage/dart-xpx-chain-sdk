/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

// PropertyModificationType enums
enum PropertyModificationType {
  addProperty,
  removeProperty,
}

class AccountProperties {
  AccountProperties.fromDto(AccountPropertiesDTO? dto) {
    if (dto == null) return;
    address = Address.fromEncoded(dto.address!);

    for (var v in dto.properties!) {
      switch (v.propertyType) {
        case 0x01:
          allowedAddresses.addAll(v.addresses!.map(Address.fromEncoded));
          continue;

        case 0x02:
          allowedMosaicId
              .addAll(v.mosaicIds!.map((m) => MosaicId.fromId(m.toUint64())));
          continue;

        case 0x04:
          allowedEntityTypes
              .addAll(v.entityTypes!.map(TransactionType.fromInt));
          continue;

        case 0x80 + 0x01:
          blockedAddresses.addAll(v.addresses!.map(Address.fromEncoded));
          continue;

        case 0x80 + 0x02:
          blockedMosaicId
              .addAll(v.mosaicIds!.map((m) => MosaicId.fromId(m.toUint64())));
          continue;

        case 0x80 + 0x04:
          blockedEntityTypes
              .addAll(v.entityTypes!.map(TransactionType.fromInt));
          continue;
      }
    }
  }

  Address? address;
  List<Address> allowedAddresses = [];
  List<MosaicId> allowedMosaicId = [];
  List<TransactionType> allowedEntityTypes = [];
  List<Address> blockedAddresses = [];
  List<MosaicId> blockedMosaicId = [];
  List<TransactionType> blockedEntityTypes = [];

  static List<AccountProperties> listFromJson(
          List<AccountPropertiesDTO>? json) =>
      json == null
          ? <AccountProperties>[]
          : json.map(AccountProperties.fromDto).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['allowedAddresses'] = allowedAddresses;
    data['allowedMosaicId'] = allowedMosaicId;
    data['allowedEntityTypes'] = allowedEntityTypes;
    data['blockedAddresses'] = blockedAddresses;
    data['blockedMosaicId'] = blockedMosaicId;
    data['blockedEntityTypes'] = blockedEntityTypes;

    return data;
  }
}

class AccountPropertiesMosaicModification {
  AccountPropertiesMosaicModification(this.modificationType, this.assetId);

  AccountPropertiesMosaicModification.fromDto(dto) {
    assetId = MosaicId.fromId(dto.assetId!.toUint64());
    modificationType = dto.modificationType == 0
        ? PropertyModificationType.addProperty
        : PropertyModificationType.removeProperty;
  }

  PropertyModificationType? modificationType;
  AssetId? assetId;

  static List<AccountPropertiesMosaicModification> listFromJson(
          List<dynamic>? json) =>
      json == null
          ? []
          : json.map(AccountPropertiesMosaicModification.fromDto).toList();

  @override
  String toString() => '${toJson()}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modificationType'] =
        modificationType == PropertyModificationType.removeProperty
            ? 'removeProperty'
            : 'addProperty';
    data['assetId'] = assetId;

    return data;
  }
}

class AccountPropertiesAddressModification {
  AccountPropertiesAddressModification(this.modificationType, this.address);

  AccountPropertiesAddressModification.fromDto(dto) {
    address = Address.fromEncoded(dto.address!);
    modificationType = dto.modificationType == 0
        ? PropertyModificationType.addProperty
        : PropertyModificationType.removeProperty;
  }

  PropertyModificationType? modificationType;
  Address? address;

  static List<AccountPropertiesAddressModification> listFromJson(
          List<dynamic>? json) =>
      json == null
          ? []
          : json.map(AccountPropertiesAddressModification.fromDto).toList();

  @override
  String toString() => '${toJson()}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modificationType'] =
        modificationType == PropertyModificationType.removeProperty
            ? 'removeProperty'
            : 'addProperty';
    data['address'] = address;

    return data;
  }
}

class AccountPropertiesEntityTypeModification {
  AccountPropertiesEntityTypeModification(
      this.modificationType, this.transactionType);

  AccountPropertiesEntityTypeModification.fromDto(dto) {
    transactionType = TransactionType.fromInt(dto.entityType);
    modificationType = dto.modificationType == 0
        ? PropertyModificationType.addProperty
        : PropertyModificationType.removeProperty;
  }

  PropertyModificationType? modificationType;
  TransactionType? transactionType;

  static List<AccountPropertiesEntityTypeModification> listFromJson(
          List<dynamic>? json) =>
      json == null
          ? []
          : json.map(AccountPropertiesEntityTypeModification.fromDto).toList();

  @override
  String toString() => '${toJson()}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modificationType'] =
        modificationType == PropertyModificationType.removeProperty
            ? 'removeProperty'
            : 'addProperty';
    data['transactionType'] = transactionType;

    return data;
  }
}
