part of xpx_chain_sdk;

class _AccountPropertyDTO {
  _AccountPropertyDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _propertyType = json['propertyType'];
    _values = json['values'];
  }

  int _propertyType;

  List<Object> _values = [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['propertyType'] = _propertyType;
    data['values'] = _values;

    return data;
  }

  static List<_AccountPropertyDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _AccountPropertyDTO.fromJson(value)).toList();

  static Map<String, _AccountPropertyDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _AccountPropertyDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _AccountPropertyDTO.fromJson(value));
    }
    return map;
  }
}
