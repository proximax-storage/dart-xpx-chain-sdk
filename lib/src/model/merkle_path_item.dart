part of nem2_sdk_dart;

class MerklePathItem {
  
  int position = null;
  

  String hash = null;
  
  MerklePathItem();

  @override
  String toString() {
    return 'MerklePathItem[position=$position, hash=$hash, ]';
  }

  MerklePathItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    position =
        json['position']
    ;
    hash =
        json['hash']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'hash': hash
     };
  }

  static List<MerklePathItem> listFromJson(List<dynamic> json) {
    return json == null ? new List<MerklePathItem>() : json.map((value) => new MerklePathItem.fromJson(value)).toList();
  }

  static Map<String, MerklePathItem> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MerklePathItem>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MerklePathItem.fromJson(value));
    }
    return map;
  }
}

