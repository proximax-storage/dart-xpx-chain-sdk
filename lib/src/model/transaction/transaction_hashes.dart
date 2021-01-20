part of xpx_chain_sdk.transaction;

class TransactionHashes {
  TransactionHashes.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    hashes = (json['hashes']).map((item) => item).toList();
  }

  TransactionHashes.fromList(List<String> list) : assert(list != null, 'json must not be null') {
    hashes = list.map((item) => item).toList();
  }

  List<String> hashes = [];

  @override
  String toString() => '{hashes=$hashes}';

  Map<String, dynamic> toJson() => {'hashes': hashes};

  static List<TransactionHashes> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => TransactionHashes.fromJson(value)).toList();

  static Map<String, TransactionHashes> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, TransactionHashes>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = TransactionHashes.fromJson(value));
    }
    return map;
  }
}
