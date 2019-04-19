part of nem2_sdk_dart;

class BlockDTO {
  
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
  
  BlockDTO();

  @override
  String toString() {
    return 'BlockDTO[signature=$signature, signer=$signer, version=$version, type=$type, height=$height, timestamp=$timestamp, difficulty=$difficulty, feeMultiplier=$feeMultiplier, previousBlockHash=$previousBlockHash, blockTransactionsHash=$blockTransactionsHash, blockReceiptsHash=$blockReceiptsHash, stateHash=$stateHash, beneficiaryPublicKey=$beneficiaryPublicKey, ]';
  }

  BlockDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    signature =
        json['signature']
    ;
    signer =
        json['signer']
    ;
    version =
        json['version']
    ;
    type =
        json['type']
    ;
    height =
      
      
      new UInt64DTO.fromJson(json['height'])
;
    timestamp =
      
      
      new UInt64DTO.fromJson(json['timestamp'])
;
    difficulty =
      
      
      new UInt64DTO.fromJson(json['difficulty'])
;
    feeMultiplier =
        json['feeMultiplier']
    ;
    previousBlockHash =
        json['previousBlockHash']
    ;
    blockTransactionsHash =
        json['blockTransactionsHash']
    ;
    blockReceiptsHash =
        json['blockReceiptsHash']
    ;
    stateHash =
        json['stateHash']
    ;
    beneficiaryPublicKey =
        json['beneficiaryPublicKey']
    ;
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

  static List<BlockDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<BlockDTO>() : json.map((value) => new BlockDTO.fromJson(value)).toList();
  }

  static Map<String, BlockDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, BlockDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new BlockDTO.fromJson(value));
    }
    return map;
  }
}

