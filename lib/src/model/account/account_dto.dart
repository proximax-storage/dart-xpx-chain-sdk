part of xpx_chain_sdk;

class _AccountDTO {
  _AccountDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _address = json['address'];
    _addressHeight = UInt64DTO.fromJson(json['addressHeight']);
    _publicKey = json['publicKey'];
    _publicKeyHeight = UInt64DTO.fromJson(json['publicKeyHeight']);
    _mosaics = _MosaicDTO.listFromJson(json['mosaics']);
    _accountType = json['accountType'];
    _linkedAccountKey = json['linkedAccountKey'];
  }

  String _address;

  UInt64DTO _addressHeight;

  String _publicKey;

  UInt64DTO _publicKeyHeight;

  List<_MosaicDTO> _mosaics = [];

  int _accountType;

  String _linkedAccountKey;

  Map<String, dynamic> toJson() => {
        'address': _address,
        'addressHeight': _addressHeight,
        'publicKey': _publicKey,
        'publicKeyHeight': _publicKeyHeight,
        'mosaics': _mosaics,
        'accountType': _accountType,
        'linkedAccountKey': _linkedAccountKey
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
    _meta = _AccountMetaDTO.fromJson(json['meta']);
    _account = _AccountDTO.fromJson(json['account']);
  }

  _AccountMetaDTO _meta;

  _AccountDTO _account;

  Map<String, dynamic> toJson() => {'meta': _meta, 'account': _account};

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
