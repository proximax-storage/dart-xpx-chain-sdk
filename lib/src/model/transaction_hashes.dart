part of xpx_chain_sdk;

class TransactionHashes {
  TransactionHashes.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    hashes =
        (json['hashes'] as List).map((dynamic item) => item as String).toList();
  }

  List<String> hashes = [];

  @override
  String toString() {
    return '{hashes=$hashes}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['hashes'] = this.hashes;

    return data;
  }

  static List<TransactionHashes> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<TransactionHashes>()
        : json
            .map((dynamic value) =>
                 TransactionHashes.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, TransactionHashes> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, TransactionHashes>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  TransactionHashes.fromJson(value));
    }
    return map;
  }
}
