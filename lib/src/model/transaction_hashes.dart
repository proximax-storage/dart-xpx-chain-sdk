part of nem2_sdk_dart;

class TransactionHashes {
  
  List<String> hashes = [];
  
  TransactionHashes();

  @override
  String toString() {
    return 'TransactionHashes[hashes=$hashes, ]';
  }

  TransactionHashes.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hashes =
        (json['hashes'] as List).map((item) => item as String).toList()
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'hashes': hashes
     };
  }

  static List<TransactionHashes> listFromJson(List<dynamic> json) {
    return json == null ? new List<TransactionHashes>() : json.map((value) => new TransactionHashes.fromJson(value)).toList();
  }

  static Map<String, TransactionHashes> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TransactionHashes>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TransactionHashes.fromJson(value));
    }
    return map;
  }
}

