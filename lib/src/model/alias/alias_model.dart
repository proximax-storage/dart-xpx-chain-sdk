part of xpx_chain_sdk.alias;

// AliasType enums
enum AliasType {
  noneAliasType,
  mosaicAliasType,
  addressAliasType,
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

  final AliasType type;

  final Address address;

  final MosaicId mosaicId;

  @override
  String toString() =>
      '{aliasAction:$type, mosaicId:$mosaicId, address:$address}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type.toInt;
    data['mosaicId'] = mosaicId;
    data['address'] = address;
    return data;
  }
}

class AddressAlias implements Alias {
  AddressAlias(this.address);

  @override
  final Address address;

  @override
  MosaicId get mosaicId => null;

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
