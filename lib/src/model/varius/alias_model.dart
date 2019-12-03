part of xpx_chain_sdk;

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

class Alias {
  Alias._({this.type, this.address, this.mosaicId});

  final AliasType type;

  final Address address;

  final MosaicId mosaicId;

  @override
  String toString() =>
      '{aliasAction:$type, mosaicId:$mosaicId, address:$address}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
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
    data['aliasAction'] = type;
    data['address'] = address;
    return data;
  }

  @override
  AliasType get type => AliasType.addressAliasType;
}
