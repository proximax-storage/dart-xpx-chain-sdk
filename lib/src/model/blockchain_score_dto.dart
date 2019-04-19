part of nem2_sdk_dart;

class BlockchainScoreDTO {
  
  UInt64DTO scoreHigh = null;
  

  UInt64DTO scoreLow = null;
  
  BlockchainScoreDTO();

  @override
  String toString() {
    return 'BlockchainScoreDTO[scoreHigh=$scoreHigh, scoreLow=$scoreLow, ]';
  }

  BlockchainScoreDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    scoreHigh =
      
      
      new UInt64DTO.fromJson(json['scoreHigh'])
;
    scoreLow =
      
      
      new UInt64DTO.fromJson(json['scoreLow'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'scoreHigh': scoreHigh,
      'scoreLow': scoreLow
     };
  }

  static List<BlockchainScoreDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<BlockchainScoreDTO>() : json.map((value) => new BlockchainScoreDTO.fromJson(value)).toList();
  }

  static Map<String, BlockchainScoreDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, BlockchainScoreDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new BlockchainScoreDTO.fromJson(value));
    }
    return map;
  }
}

