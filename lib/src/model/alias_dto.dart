part of xpx_chain_sdk;

class _AliasDTO {
  _AliasDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    type = json['type'] as int;
    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    address = json['address'] as String;
  }

  int type;

  UInt64DTO mosaicId;

  String address;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['mosaicId'] = mosaicId;
    data['address'] = address;

    return data;
  }

  static List<_AliasDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_AliasDTO>()
        : json
            .map((dynamic value) =>
                new _AliasDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _AliasDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _AliasDTO.fromJson(value));
    }
    return map;
  }
}
