part of nem2_sdk_dart;

class AliasDTO {
  int type = null;

  UInt64DTO mosaicId = null;

  String address = null;

  AliasDTO();

  @override
  String toString() {
    return 'AliasDTO[type=$type, mosaicId=$mosaicId, address=$address, ]';
  }

  AliasDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    type = json['type'];
    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'mosaicId': mosaicId, 'address': address};
  }

  static List<AliasDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AliasDTO>()
        : json.map((value) => new AliasDTO.fromJson(value)).toList();
  }

  static Map<String, AliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AliasDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AliasDTO.fromJson(value));
    }
    return map;
  }
}
