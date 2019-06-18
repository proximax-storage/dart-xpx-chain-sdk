part of xpx_chain_sdk;

class TransactionPayload {
  TransactionPayload.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    payload = json['payload'] as String;
  }

  String payload;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payload'] = this.payload;

    return data;
  }

  static List<TransactionPayload> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<TransactionPayload>()
        : json
            .map((dynamic value) =>
                new TransactionPayload.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, TransactionPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TransactionPayload>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new TransactionPayload.fromJson(value));
    }
    return map;
  }
}
