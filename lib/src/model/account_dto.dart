part of xpx_catapult_sdk ;

class _accountDTO {
  String address = null;

  UInt64DTO addressHeight = null;

  String publicKey = null;

  UInt64DTO publicKeyHeight = null;

  List<_mosaicDTO> mosaics = [];

  UInt64DTO importance = null;

  UInt64DTO importanceHeight = null;

  _accountDTO();

  @override
  String toString() {
    return '_accountDTO[address=$address, addressHeight=$addressHeight, publicKey=$publicKey, publicKeyHeight=$publicKeyHeight, mosaics=$mosaics, importance=$importance, importanceHeight=$importanceHeight, ]';
  }

  _accountDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    address = json['address'];
    addressHeight = new UInt64DTO.fromJson(json['addressHeight']);
    publicKey = json['publicKey'];
    publicKeyHeight = new UInt64DTO.fromJson(json['publicKeyHeight']);
    mosaics = _mosaicDTO.listFromJson(json['mosaics']);
    importance = new UInt64DTO.fromJson(json['importance']);
    importanceHeight = new UInt64DTO.fromJson(json['importanceHeight']);
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'addressHeight': addressHeight,
      'publicKey': publicKey,
      'publicKeyHeight': publicKeyHeight,
      'mosaics': mosaics,
      'importance': importance,
      'importanceHeight': importanceHeight
    };
  }

  static List<_accountDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_accountDTO>()
        : json.map((value) => new _accountDTO.fromJson(value)).toList();
  }

  static Map<String, _accountDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _accountDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _accountDTO.fromJson(value));
    }
    return map;
  }
}

class _accountInfoDTO {
  _accountMetaDTO meta = null;

  _accountDTO account = null;

  _accountInfoDTO();

  @override
  String toString() {
    return '_accountInfoDTO[meta=$meta, account=$account, ]';
  }

  _accountInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _accountMetaDTO.fromJson(json['meta']);
    account = new _accountDTO.fromJson(json['account']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'account': account};
  }

  static List<_accountInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_accountInfoDTO>()
        : json.map((value) => new _accountInfoDTO.fromJson(value)).toList();
  }

  static Map<String, _accountInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _accountInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new _accountInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _accountMetaDTO {
  _accountMetaDTO();

  @override
  String toString() {
    return '_accountMetaDTO[]';
  }

  _accountMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<_accountMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_accountMetaDTO>()
        : json.map((value) => new _accountMetaDTO.fromJson(value)).toList();
  }

  static Map<String, _accountMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _accountMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new _accountMetaDTO.fromJson(value));
    }
    return map;
  }
}
