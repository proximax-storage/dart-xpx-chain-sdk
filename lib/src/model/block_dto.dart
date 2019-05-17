part of xpx_catapult_sdk;

class _blockDTO {
  String signature = null;

  String signer = null;

  num version = null;

  num type = null;

  UInt64DTO height = null;

  UInt64DTO timestamp = null;

  UInt64DTO difficulty = null;

  int feeMultiplier = null;

  String previousBlockHash = null;

  String blockTransactionsHash = null;

  String blockReceiptsHash = null;

  String stateHash = null;

  String beneficiaryPublicKey = null;

  _blockDTO();

  _blockDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    height = new UInt64DTO.fromJson(json['height']);
    timestamp = new UInt64DTO.fromJson(json['timestamp']);
    difficulty = new UInt64DTO.fromJson(json['difficulty']);
    feeMultiplier = json['feeMultiplier'];
    previousBlockHash = json['previousBlockHash'];
    blockTransactionsHash = json['blockTransactionsHash'];
    blockReceiptsHash = json['blockReceiptsHash'];
    stateHash = json['stateHash'];
    beneficiaryPublicKey = json['beneficiaryPublicKey'];
  }

  Map<String, dynamic> toJson() {
    return {
      'signature': signature,
      'signer': signer,
      'version': version,
      'type': type,
      'height': height,
      'timestamp': timestamp,
      'difficulty': difficulty,
      'feeMultiplier': feeMultiplier,
      'previousBlockHash': previousBlockHash,
      'blockTransactionsHash': blockTransactionsHash,
      'blockReceiptsHash': blockReceiptsHash,
      'stateHash': stateHash,
      'beneficiaryPublicKey': beneficiaryPublicKey
    };
  }

  static List<_blockDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_blockDTO>()
        : json.map((value) => new _blockDTO.fromJson(value)).toList();
  }

  static Map<String, _blockDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _blockDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _blockDTO.fromJson(value));
    }
    return map;
  }
}

class _blockInfoDTO {
  _BlockMetaDTO meta = null;

  _blockDTO block = null;

  _blockInfoDTO();

  _blockInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _BlockMetaDTO.fromJson(json['meta']);
    block = new _blockDTO.fromJson(json['block']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'block': block};
  }

  static List<_blockInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_blockInfoDTO>()
        : json.map((value) => new _blockInfoDTO.fromJson(value)).toList();
  }

  static Map<String, _blockInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _blockInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _blockInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _BlockMetaDTO {
  String hash = null;

  String generationHash = null;

  UInt64DTO totalFee = null;

  num numTransactions = null;

  _BlockMetaDTO();

  _BlockMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash = json['hash'];
    generationHash = json['generationHash'];
    totalFee = new UInt64DTO.fromJson(json['totalFee']);
    numTransactions = json['numTransactions'];
  }

  static List<_BlockMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_BlockMetaDTO>()
        : json.map((value) => new _BlockMetaDTO.fromJson(value)).toList();
  }

  static Map<String, _BlockMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _BlockMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _BlockMetaDTO.fromJson(value));
    }
    return map;
  }
}

class _blockchainScoreDTO {
  UInt64DTO scoreHigh;

  UInt64DTO scoreLow;

  _blockchainScoreDTO();

  @override
  String toString() {
    return '_blockchainScoreDTO[scoreHigh=$scoreHigh, scoreLow=$scoreLow, ]';
  }

  _blockchainScoreDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    scoreHigh = new UInt64DTO.fromJson(json['scoreHigh']);
    scoreLow = new UInt64DTO.fromJson(json['scoreLow']);
  }

  Map<String, dynamic> toJson() {
    return {'scoreHigh': scoreHigh, 'scoreLow': scoreLow};
  }

  static List<_blockchainScoreDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_blockchainScoreDTO>()
        : json.map((value) => new _blockchainScoreDTO.fromJson(value)).toList();
  }

  static Map<String, _blockchainScoreDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _blockchainScoreDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new _blockchainScoreDTO.fromJson(value));
    }
    return map;
  }
}