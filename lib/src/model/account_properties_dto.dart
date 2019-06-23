part of xpx_chain_sdk;

class _AccountPropertiesDTO {
  _AccountPropertiesDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    address = json['address'];
    properties = AccountPropertyDTO.listFromJson(json['properties']);
  }

  String address;

  List<AccountPropertyDTO> properties = [];

  static List<_AccountPropertiesDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _AccountPropertiesDTO.fromJson(value)).toList();

  static Map<String, _AccountPropertiesDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, _AccountPropertiesDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _AccountPropertiesDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() =>
      {'address': address, 'properties': properties};
}
