part of xpx_chain_sdk.account;

class AccountPropertiesDTO {
  AccountPropertiesDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    final jsonRaw = json['accountProperties'];

    address = jsonRaw['address'];

    properties = AccountPropertyDTO.listFromJson(jsonRaw['properties']);
  }

  String address;

  List<AccountPropertyDTO> properties = [];

  static List<AccountPropertiesDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertiesDTO.fromJson(value)).toList();

  static Map<String, AccountPropertiesDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final Map<String, AccountPropertiesDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AccountPropertiesDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() => {'address': address, 'properties': properties};
}

class AccountPropertiesInfoDTO {
  AccountPropertiesInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    meta = AccountPropertiesMetaDTO.fromJson(json['meta']);
    _accountProperties = AccountPropertiesDTO.fromJson(json['accountProperties']);
  }

  AccountPropertiesMetaDTO meta;

  AccountPropertiesDTO _accountProperties;

  static List<AccountPropertiesInfoDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertiesInfoDTO.fromJson(value)).toList();

  static Map<String, AccountPropertiesInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final Map<String, AccountPropertiesInfoDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AccountPropertiesInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() => {'meta': meta, 'accountProperties': _accountProperties};
}

class AccountPropertiesMetaDTO {
  AccountPropertiesMetaDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _id = json['id'];
  }

  String _id;

  Map<String, dynamic> toJson() => {'id': _id};

  static List<AccountPropertiesMetaDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertiesMetaDTO.fromJson(value)).toList();

  static Map<String, AccountPropertiesMetaDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final Map<String, AccountPropertiesMetaDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AccountPropertiesMetaDTO.fromJson(value));
    }
    return map;
  }
}
