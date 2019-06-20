part of xpx_chain_sdk;

class TransactionPayload {
  TransactionPayload.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    payload = json['payload'] as String;
  }

  String payload;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['payload'] = this.payload;

    return data;
  }

  static List<TransactionPayload> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<TransactionPayload>()
        : json
            .map((dynamic value) =>
                 TransactionPayload.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, TransactionPayload> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, TransactionPayload>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  TransactionPayload.fromJson(value));
    }
    return map;
  }
}
