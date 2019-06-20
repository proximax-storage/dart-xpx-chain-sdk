part of xpx_chain_sdk;

class _BlockDTO {
  _BlockDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    signature = json['signature'] as String;
    signer = json['signer'] as String;
    version = json['version'] as num;
    type = json['type'] as num;
    height =  UInt64DTO.fromJson(json['height']);
    timestamp =  UInt64DTO.fromJson(json['timestamp']);
    difficulty =  UInt64DTO.fromJson(json['difficulty']);
    feeMultiplier = json['feeMultiplier'] as int;
    previousBlockHash = json['previousBlockHash'] as String;
    blockTransactionsHash = json['blockTransactionsHash'] as String;
    blockReceiptsHash = json['blockReceiptsHash'] as String;
    stateHash = json['stateHash'] as String;
    beneficiaryPublicKey = json['beneficiaryPublicKey'] as String;
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

  static List<_BlockDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_BlockDTO>()
        : json
            .map((dynamic value) =>
                 _BlockDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _BlockDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _BlockDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _BlockDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  _BlockInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta =  _BlockMetaDTO.fromJson(json['meta'] as Map<String, dynamic>);
    block =  _BlockDTO.fromJson(json['block'] as Map<String, dynamic>);
  }

  _BlockMetaDTO meta;

  _BlockDTO block;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['meta'] = meta;
    data['block'] = block;

    return data;
  }

  static List<_BlockInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_BlockInfoDTO>()
        : json
            .map((dynamic value) =>
                 _BlockInfoDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _BlockInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _BlockInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _BlockInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _BlockMetaDTO {
  _BlockMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash = json['hash'] as String;
    generationHash = json['generationHash'] as String;
    totalFee =  UInt64DTO.fromJson(json['totalFee']);
    numTransactions = json['numTransactions'] as num;
  }

  String hash;

  String generationHash;

  UInt64DTO totalFee;

  num numTransactions;

  static List<_BlockMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_BlockMetaDTO>()
        : json
            .map((dynamic value) =>
                 _BlockMetaDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _BlockMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _BlockMetaDTO>();
    if (json != null && json.isEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _BlockMetaDTO.fromJson(value));
    }
    return map;
  }
}

class _BlockchainScoreDTO {
  _BlockchainScoreDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    scoreHigh =  UInt64DTO.fromJson(json['scoreHigh']);
    scoreLow =  UInt64DTO.fromJson(json['scoreLow']);
  }

  UInt64DTO scoreHigh;

  UInt64DTO scoreLow;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['scoreHigh'] = scoreHigh;
    data['scoreLow'] = scoreLow;

    return data;
  }

  static List<_BlockchainScoreDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_BlockchainScoreDTO>()
        : json
            .map((dynamic value) =>
                 _BlockchainScoreDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _BlockchainScoreDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _BlockchainScoreDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _BlockchainScoreDTO.fromJson(value));
    }
    return map;
  }
}
