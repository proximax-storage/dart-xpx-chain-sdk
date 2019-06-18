part of xpx_chain_sdk;

class _AccountDTO {
  _AccountDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    address = json['address'] as String;
    addressHeight = new UInt64DTO.fromJson(json['addressHeight']);
    publicKey = json['publicKey'] as String;
    publicKeyHeight = new UInt64DTO.fromJson(json['publicKeyHeight']);
    mosaics = _MosaicDTO.listFromJson(json['mosaics'] as List<dynamic>);
    accountType = json['accountType'] as int;
    linkedAccountKey = json['linkedAccountKey'] as String;
  }

  String address;

  UInt64DTO addressHeight;

  String publicKey;

  UInt64DTO publicKeyHeight;

  List<_MosaicDTO> mosaics = [];

  int accountType;

  String linkedAccountKey;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = address;
    data['addressHeight'] = addressHeight;
    data['publicKey'] = publicKey;
    data['publicKeyHeight'] = publicKeyHeight;
    data['mosaics'] = mosaics;
    data['accountType'] = accountType;
    data['linkedAccountKey'] = linkedAccountKey;
    return data;
  }

  static List<_AccountDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_AccountDTO>()
        : json
            .map((dynamic value) =>
                new _AccountDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AccountDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _AccountDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _AccountDTO.fromJson(value));
    }
    return map;
  }
}

class _AccountInfoDTO {
  _AccountInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _AccountMetaDTO.fromJson(json['meta'] as Map<String, dynamic>);
    account = new _AccountDTO.fromJson(json['account'] as Map<String, dynamic>);
  }

  _AccountMetaDTO meta;

  _AccountDTO account;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meta'] = this.meta;
    data['account'] = this.account;

    return data;
  }

  static List<_AccountInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_AccountInfoDTO>()
        : json
            .map((dynamic value) =>
                new _AccountInfoDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AccountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _AccountInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _AccountInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _AccountMetaDTO {
  _AccountMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  static List<_AccountMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_AccountMetaDTO>()
        : json
            .map((dynamic value) =>
                new _AccountMetaDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _AccountMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _AccountMetaDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _AccountMetaDTO.fromJson(value));
    }
    return map;
  }
}
