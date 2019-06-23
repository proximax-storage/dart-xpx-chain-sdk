part of xpx_chain_sdk;

class _AccountPropertiesMetaDTO {
  _AccountPropertiesMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    id = json['id'];
  }

  String id;

  Map<String, dynamic> toJson() => {'id': id};

  static List<_AccountPropertiesMetaDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json
              .map((value) => _AccountPropertiesMetaDTO.fromJson(value))
              .toList();

  static Map<String, _AccountPropertiesMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, _AccountPropertiesMetaDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _AccountPropertiesMetaDTO.fromJson(value));
    }
    return map;
  }
}
