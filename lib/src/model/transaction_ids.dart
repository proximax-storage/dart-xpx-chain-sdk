part of xpx_chain_sdk;

class TransactionIds {
  List<String> transactionIds = [];

  TransactionIds();

  @override
  String toString() {
    return 'TransactionIds[transactionIds=$transactionIds, ]';
  }

  TransactionIds.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    transactionIds =
        (json['transactionIds'] as List).map((item) => item as String).toList();
  }

  Map<String, dynamic> toJson() {
    return {'transactionIds': transactionIds};
  }

  static List<TransactionIds> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TransactionIds>()
        : json.map((value) => new TransactionIds.fromJson(value)).toList();
  }

  static Map<String, TransactionIds> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TransactionIds>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TransactionIds.fromJson(value));
    }
    return map;
  }
}
