part of xpx_chain_sdk;

class _AccountPropertiesDTO {
  _AccountPropertiesDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    address = json['address'] as String;
    properties =
        AccountPropertyDTO.listFromJson(json['properties'] as List<dynamic>);
  }

  String address;

  List<AccountPropertyDTO> properties = [];

  static List<_AccountPropertiesDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_AccountPropertiesDTO>()
        : json
            .map((dynamic value) => new _AccountPropertiesDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AccountPropertiesDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _AccountPropertiesDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _AccountPropertiesDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = address;
    data['properties'] = properties;

    return data;
  }
}
