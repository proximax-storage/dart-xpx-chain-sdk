part of xpx_chain_sdk;

class _BlockDTO {
  _BlockDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _height = UInt64DTO.fromJson(json['height']);
    _timestamp = UInt64DTO.fromJson(json['timestamp']);
    _difficulty = UInt64DTO.fromJson(json['difficulty']);
    _feeMultiplier = json['feeMultiplier'];
    _previousBlockHash = json['previousBlockHash'];
    _blockTransactionsHash = json['blockTransactionsHash'];
    _blockReceiptsHash = json['blockReceiptsHash'];
    _stateHash = json['stateHash'];
    _beneficiaryPublicKey = json['beneficiaryPublicKey'];
  }

  String _signature;

  String _signer;

  num _version;

  num _type;

  UInt64DTO _height;

  UInt64DTO _timestamp;

  UInt64DTO _difficulty;

  int _feeMultiplier;

  String _previousBlockHash;

  String _blockTransactionsHash;

  String _blockReceiptsHash;

  String _stateHash;

  String _beneficiaryPublicKey;

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
    data['signature'] = _signature;
    data['signer'] = _signer;
    data['version'] = _version;
    data['type'] = _type;
    data['height'] = _height;
    data['timestamp'] = _timestamp;
    data['difficulty'] = _difficulty;
    data['feeMultiplier'] = _feeMultiplier;
    data['feeMultiplier'] = _feeMultiplier;
    data['blockTransactionsHash'] = _blockTransactionsHash;
    data['blockReceiptsHash'] = _blockReceiptsHash;
    data['stateHash'] = _stateHash;
    data['beneficiaryPublicKey'] = _beneficiaryPublicKey;

    return data;
  }
}

class _BlockInfoDTO {
  _BlockInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _meta = _BlockMetaDTO.fromJson(json['meta']);
    _block = _BlockDTO.fromJson(json['block']);
  }

  _BlockMetaDTO _meta;

  _BlockDTO _block;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = _meta;
    data['block'] = _block;

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
    _hash = json['hash'];
    _generationHash = json['generationHash'];
    _totalFee = UInt64DTO.fromJson(json['totalFee']);
    _numTransactions = json['numTransactions'];
  }

  String _hash;

  String _generationHash;

  UInt64DTO _totalFee;

  num _numTransactions;

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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hash'] = _hash;
    data['generationHash'] = _generationHash;
    data['totalFee'] = _totalFee;
    data['numTransactions'] = _numTransactions;

    return data;
  }
}

class _BlockchainScoreDTO {
  _BlockchainScoreDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _scoreHigh = UInt64DTO.fromJson(json['scoreHigh']);
    _scoreLow = UInt64DTO.fromJson(json['scoreLow']);
  }

  UInt64DTO _scoreHigh;

  UInt64DTO _scoreLow;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['scoreHigh'] = _scoreHigh;
    data['scoreLow'] = _scoreLow;

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
