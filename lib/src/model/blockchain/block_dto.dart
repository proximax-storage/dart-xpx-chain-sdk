part of xpx_chain_sdk.blockchain;

class BlockDTO {
  BlockDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    _height = UInt64DTO.fromJson(json['height']);
    _timestamp = UInt64DTO.fromJson(json['timestamp']);
    _difficulty = UInt64DTO.fromJson(json['difficulty']);
    feeMultiplier = json['feeMultiplier'];
    _previousBlockHash = json['previousBlockHash'];
    _blockTransactionsHash = json['blockTransactionsHash'];
    _blockReceiptsHash = json['blockReceiptsHash'];
    _stateHash = json['stateHash'];
    _beneficiaryPublicKey = json['beneficiary'] != '0000000000000000000000000000000000000000000000000000000000000000'
        ? json['beneficiary']
        : null;
    feeInterest = json['feeInterest'];
    feeInterestDenominator = json['feeInterestDenominator'];
  }

  String signature;

  String signer;

  num version;

  num type;

  UInt64DTO _height;

  UInt64DTO _timestamp;

  UInt64DTO _difficulty;

  int feeMultiplier;

  int feeInterest;

  int feeInterestDenominator;

  String _previousBlockHash;

  String _blockTransactionsHash;

  String _blockReceiptsHash;

  String _stateHash;

  String _beneficiaryPublicKey;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['height'] = _height;
    data['timestamp'] = _timestamp;
    data['difficulty'] = _difficulty;
    data['feeMultiplier'] = feeMultiplier;
    data['feeMultiplier'] = feeMultiplier;
    data['blockTransactionsHash'] = _blockTransactionsHash;
    data['blockReceiptsHash'] = _blockReceiptsHash;
    data['stateHash'] = _stateHash;
    data['beneficiary'] = _beneficiaryPublicKey;

    return data;
  }
}

class BlockInfoDTO {
  BlockInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    meta = BlockMetaDTO.fromJson(json['meta']);
    _block = BlockDTO.fromJson(json['block']);
  }

  BlockMetaDTO meta;

  BlockDTO _block;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['block'] = _block;

    return data;
  }
}

class BlockMetaDTO {
  BlockMetaDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _hash = json['hash'];
    _generationHash = json['generationHash'];
    _totalFee = UInt64DTO.fromJson(json['totalFee']);
    _numTransactions = json['numTransactions'];
  }

  String _hash;

  String _generationHash;

  UInt64DTO _totalFee;

  num _numTransactions;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hash'] = _hash;
    data['generationHash'] = _generationHash;
    data['totalFee'] = _totalFee;
    data['numTransactions'] = _numTransactions;

    return data;
  }
}

class BlockchainScoreDTO {
  BlockchainScoreDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
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
}
