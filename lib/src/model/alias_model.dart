part of xpx_catapult_sdk;

class Alias {
  int type = 0;

  BigInt mosaicId;

  String address;

  Alias();

  @override
  String toString() {
    return '{type:$type, mosaicId:$mosaicId, address:$address}';
  }

  Alias.fromDTO(_aliasDTO value) {
    if (json == null) return;
    if (value.type != 0) {
      mosaicId = value.mosaicId.toBigInt();
      type = value.type;
      address = value.address;
    }
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'mosaicId': mosaicId, 'address': address};
  }

  static List<Alias> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_aliasDTO>()
        : json.map((value) => new Alias.fromDTO(value)).toList();
  }
}
