part of xpx_chain_sdk;

class _AliasDTO {
  _AliasDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _type = json['type'];
    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _address = json['address'];
  }

  int _type;

  UInt64DTO _mosaicId;

  String _address;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = _type;
    data['mosaicId'] = _mosaicId;
    data['address'] = _address;

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
