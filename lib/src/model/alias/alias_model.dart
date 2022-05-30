/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.alias;

// AliasType enums
enum AliasType {
  noneAliasType,
  mosaicAliasType,
  addressAliasType,
}

AliasType getAliasType(int value) {
  switch (value) {
    case 1:
      return AliasType.mosaicAliasType;
    case 0:
      return AliasType.addressAliasType;
    default:
      return AliasType.noneAliasType;
  }
}

enum AliasActionType { aliasLink, aliasUnlink }

extension AliasTypeToInt on AliasType {
  int get toInt => index;
}

extension AliasActionTypeToInt on AliasActionType {
  int get toInt => index;
}

class Alias {
  Alias({this.type, this.address, this.mosaicId});

  final AliasType? type;

  final Address? address;

  final MosaicId? mosaicId;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (type != null) {
      data['type'] = type!.toInt;
    }
    if (mosaicId != null) {
      data['mosaicId'] = mosaicId!.toHex();
    }
    if (address != null) {
      data['address'] = address;
    }
    return data;
  }
}

class AddressAlias implements Alias {
  AddressAlias(this.address);

  @override
  final Address address;

  @override
  MosaicId? get mosaicId => null;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = type.toInt;
    data['address'] = address;
    return data;
  }

  @override
  AliasType get type => AliasType.addressAliasType;
}
