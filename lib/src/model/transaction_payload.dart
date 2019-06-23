part of xpx_chain_sdk;

class TransactionPayload {
  TransactionPayload.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    payload = json['payload'];
  }

  String payload;

  Map<String, dynamic> toJson() => {'payload': payload};

  static List<TransactionPayload> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => TransactionPayload.fromJson(value)).toList();

  static Map<String, TransactionPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, TransactionPayload>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = TransactionPayload.fromJson(value));
    }
    return map;
  }
}
