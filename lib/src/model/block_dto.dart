part of xpx_chain_sdk;

class _BlockDTO {
  _BlockDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    height = UInt64DTO.fromJson(json['height']);
    timestamp = UInt64DTO.fromJson(json['timestamp']);
    difficulty = UInt64DTO.fromJson(json['difficulty']);
    feeMultiplier = json['feeMultiplier'];
    previousBlockHash = json['previousBlockHash'];
    blockTransactionsHash = json['blockTransactionsHash'];
    blockReceiptsHash = json['blockReceiptsHash'];
    stateHash = json['stateHash'];
    beneficiaryPublicKey = json['beneficiaryPublicKey'];
  }

  String signature;

  String signer;

  num version;

  num type;

  UInt64DTO height;

  UInt64DTO timestamp;

  UInt64DTO difficulty;

  int feeMultiplier;

  String previousBlockHash;

  String blockTransactionsHash;

  String blockReceiptsHash;

  String stateHash;

  String beneficiaryPublicKey;

  static List<_BlockDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _BlockDTO.fromJson(value)).toList();

  static Map<String, _BlockDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _BlockDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _BlockDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['height'] = height;
    data['timestamp'] = timestamp;
    data['difficulty'] = difficulty;
    data['feeMultiplier'] = feeMultiplier;
    data['feeMultiplier'] = feeMultiplier;
    data['blockTransactionsHash'] = blockTransactionsHash;
    data['blockReceiptsHash'] = blockReceiptsHash;
    data['stateHash'] = stateHash;
    data['beneficiaryPublicKey'] = beneficiaryPublicKey;

    return data;
  }
}

class _BlockInfoDTO {
  _BlockInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    meta = _BlockMetaDTO.fromJson(json['meta']);
    block = _BlockDTO.fromJson(json['block']);
  }

  _BlockMetaDTO meta;

  _BlockDTO block;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['block'] = block;

    return data;
  }

  static List<_BlockInfoDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _BlockInfoDTO.fromJson(value)).toList();

  static Map<String, _BlockInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _BlockInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _BlockInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _BlockMetaDTO {
  _BlockMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    hash = json['hash'];
    generationHash = json['generationHash'];
    totalFee = UInt64DTO.fromJson(json['totalFee']);
    numTransactions = json['numTransactions'];
  }

  String hash;

  String generationHash;

  UInt64DTO totalFee;

  num numTransactions;

  static List<_BlockMetaDTO> listFromJson(List<dynamic> json) => json == null
          ? null
      : json.map((value) => _BlockMetaDTO.fromJson(value)).toList();

  static Map<String, _BlockMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _BlockMetaDTO>{};
    if (json != null && json.isEmpty) {
      json.forEach((key, value) => map[key] = _BlockMetaDTO.fromJson(value));
    }
    return map;
  }
}

class _BlockchainScoreDTO {
  _BlockchainScoreDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    scoreHigh = UInt64DTO.fromJson(json['scoreHigh']);
    scoreLow = UInt64DTO.fromJson(json['scoreLow']);
  }

  UInt64DTO scoreHigh;

  UInt64DTO scoreLow;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['scoreHigh'] = scoreHigh;
    data['scoreLow'] = scoreLow;

    return data;
  }

  static List<_BlockchainScoreDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _BlockchainScoreDTO.fromJson(value)).toList();

  static Map<String, _BlockchainScoreDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _BlockchainScoreDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _BlockchainScoreDTO.fromJson(value));
    }
    return map;
  }
}
