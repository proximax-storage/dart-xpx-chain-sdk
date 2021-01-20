part of xpx_chain_sdk.transaction;

class TransactionIds {
  TransactionIds();

  TransactionIds.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    transactionIds = (json['transactionIds']).map((item) => item).toList();
  }

  TransactionIds.fromList(List<String> list) : assert(list != null, 'list must not be null') {
    transactionIds = list.map((item) => item).toList();
  }

  List<String> transactionIds = [];

  @override
  String toString() => '{\n'
      '\ttransactionIds: $transactionIds\n'
      '}\n';

  Map<String, dynamic> toJson() => {'transactionIds': transactionIds};

  static List<TransactionIds> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => TransactionIds.fromJson(value)).toList();

  static Map<String, TransactionIds> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, TransactionIds>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = TransactionIds.fromJson(value));
    }
    return map;
  }
}
