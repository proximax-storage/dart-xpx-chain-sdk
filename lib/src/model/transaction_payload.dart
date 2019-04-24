part of nem2_sdk_dart;

class TransactionPayload {
  String payload = null;

  TransactionPayload();

  @override
  String toString() {
    return 'TransactionPayload[payload=$payload, ]';
  }

  TransactionPayload.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    return {'payload': payload};
  }

  static List<TransactionPayload> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TransactionPayload>()
        : json.map((value) => new TransactionPayload.fromJson(value)).toList();
  }

  static Map<String, TransactionPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TransactionPayload>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TransactionPayload.fromJson(value));
    }
    return map;
  }
}
