part of xpx_chain_sdk;

class _AccountDTO {
  _AccountDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    address = json['address'];
    addressHeight = UInt64DTO.fromJson(json['addressHeight']);
    publicKey = json['publicKey'];
    publicKeyHeight = UInt64DTO.fromJson(json['publicKeyHeight']);
    mosaics = _MosaicDTO.listFromJson(json['mosaics']);
    accountType = json['accountType'];
    linkedAccountKey = json['linkedAccountKey'];
  }

  String address;

  UInt64DTO addressHeight;

  String publicKey;

  UInt64DTO publicKeyHeight;

  List<_MosaicDTO> mosaics = [];

  int accountType;

  String linkedAccountKey;

  Map<String, dynamic> toJson() => {
        'address': address,
        'addressHeight': addressHeight,
        'publicKey': publicKey,
        'publicKeyHeight': publicKeyHeight,
        'mosaics': mosaics,
        'accountType': accountType,
        'linkedAccountKey': linkedAccountKey
      };

  static List<_AccountDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _AccountDTO.fromJson(value)).toList();

  static Map<String, _AccountDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, _AccountDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _AccountDTO.fromJson(value));
    }
    return map;
  }
}

class _AccountInfoDTO {
  _AccountInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    meta = _AccountMetaDTO.fromJson(json['meta']);
    account = _AccountDTO.fromJson(json['account']);
  }

  _AccountMetaDTO meta;

  _AccountDTO account;

  Map<String, dynamic> toJson() => {'meta': meta, 'account': account};

  static List<_AccountInfoDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _AccountInfoDTO.fromJson(value)).toList();

  static Map<String, _AccountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, _AccountInfoDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _AccountInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _AccountMetaDTO {
  _AccountMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null');

  static List<_AccountMetaDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _AccountMetaDTO.fromJson(value)).toList();

  static Map<String, _AccountMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final Map<String, _AccountMetaDTO> map = {};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _AccountMetaDTO.fromJson(value));
    }
    return map;
  }
}
