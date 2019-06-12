part of xpx_chain_sdk;

class _aliasDTO {
  int type = null;

  UInt64DTO mosaicId = null;

  String address = null;

  _aliasDTO();

  @override
  String toString() {
    return '{type:$type, mosaicId:$mosaicId, address:$address}';
  }

  _aliasDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    type = json['type'];
    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'mosaicId': mosaicId, 'address': address};
  }

  static List<_aliasDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_aliasDTO>()
        : json.map((value) => new _aliasDTO.fromJson(value)).toList();
  }

  static Map<String, _aliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _aliasDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _aliasDTO.fromJson(value));
    }
    return map;
  }
}
