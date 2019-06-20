part of xpx_chain_sdk;

class TransactionIds {
  TransactionIds();

  TransactionIds.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    transactionIds = (json['transactionIds'] as List)
        .map((dynamic item) => item as String)
        .toList();
  }

  List<String> transactionIds = [];

  @override
  String toString() {
    return '{\n'
        '\ttransactionIds: $transactionIds\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['transactionIds'] = this.transactionIds;

    return data;
  }

  static List<TransactionIds> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<TransactionIds>()
        : json
            .map((dynamic value) =>  TransactionIds.fromJson(
                value as Map<String, TransactionIds>))
            .toList();
  }

  static Map<String, TransactionIds> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, TransactionIds>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  TransactionIds.fromJson(value));
    }
    return map;
  }
}
