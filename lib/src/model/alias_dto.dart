part of xpx_chain_sdk;

class _AliasDTO {
  _AliasDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    type = json['type'];
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    address = json['address'];
  }

  int type;

  UInt64DTO mosaicId;

  String address;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['mosaicId'] = mosaicId;
    data['address'] = address;

    return data;
  }

  static List<_AliasDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _AliasDTO.fromJson(value)).toList();

  static Map<String, _AliasDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _AliasDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _AliasDTO.fromJson(value));
    }
    return map;
  }
}
