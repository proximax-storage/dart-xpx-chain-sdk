part of xpx_chain_sdk;

AliasType getAliasType(int value) {
  switch (value) {
    case 1:
      return AliasType.mosaicAliasType;
    case 2:
      return AliasType.addressAliasType;
    default:
      return AliasType.noneAliasType;
  }
}

class Alias {
  Alias.fromDTO(_AliasDTO value) {
    if (value.type != 0) return;

    mosaicId = value.mosaicId.toBigInt();
    type = getAliasType(value.type);
    address = value.address;
  }

  AliasType type;

  BigInt mosaicId;

  String address;

  @override
  String toString() {
    final int aliasType = type != null ? type.index : 0;
    return '{type:$aliasType, mosaicId:$mosaicId, address:$address}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['mosaicId'] = mosaicId;
    data['address'] = address;

    return data;
  }

  static List<Alias> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Alias>()
        : json
            .map((dynamic value) => new Alias.fromDTO(value as _AliasDTO))
            .toList();
  }
}
