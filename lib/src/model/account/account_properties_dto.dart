part of xpx_chain_sdk;

class _AccountPropertiesDTO {
  _AccountPropertiesDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _address = json['address'];
    _properties = _AccountPropertyDTO.listFromJson(json['properties']);
  }

  String _address;

  List<_AccountPropertyDTO> _properties = [];

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
      {'address': _address, 'properties': _properties};
}

class _AccountPropertiesInfoDTO {
  _AccountPropertiesInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _meta = _AccountPropertiesMetaDTO.fromJson(json['meta']);
    _accountProperties =
        _AccountPropertiesDTO.fromJson(json['accountProperties']);
  }

  _AccountPropertiesMetaDTO _meta;

  _AccountPropertiesDTO _accountProperties;

  static List<_AccountPropertiesInfoDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json
          .map((value) => _AccountPropertiesInfoDTO.fromJson(value))
          .toList();

  static Map<String, _AccountPropertiesInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, _AccountPropertiesInfoDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach(
              (key, value) => map[key] = _AccountPropertiesInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() =>
      {'meta': _meta, 'accountProperties': _accountProperties};
}

class _AccountPropertiesMetaDTO {
  _AccountPropertiesMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _id = json['id'];
  }

  String _id;

  Map<String, dynamic> toJson() => {'id': _id};

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
