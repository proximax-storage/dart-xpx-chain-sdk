part of nem2_sdk_dart;

class BlockMetaDTO {
  
  String hash = null;
  

  String generationHash = null;
  

  UInt64DTO totalFee = null;
  

  num numTransactions = null;
  
  BlockMetaDTO();

  @override
  String toString() {
    return 'BlockMetaDTO[hash=$hash, generationHash=$generationHash, totalFee=$totalFee, numTransactions=$numTransactions, ]';
  }

  BlockMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hash =
        json['hash']
    ;
    generationHash =
        json['generationHash']
    ;
    totalFee =
      
      
      new UInt64DTO.fromJson(json['totalFee'])
;
    numTransactions =
        json['numTransactions']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'generationHash': generationHash,
      'totalFee': totalFee,
      'numTransactions': numTransactions
     };
  }

  static List<BlockMetaDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<BlockMetaDTO>() : json.map((value) => new BlockMetaDTO.fromJson(value)).toList();
  }

  static Map<String, BlockMetaDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, BlockMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new BlockMetaDTO.fromJson(value));
    }
    return map;
  }
}

