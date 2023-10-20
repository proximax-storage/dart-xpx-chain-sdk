/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class TransactionIds {
  TransactionIds();

  TransactionIds.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    transactionIds = json['transactionIds'].map((item) => item).toList();
  }

  TransactionIds.fromList(List<String> list)
      : assert(list.isNotEmpty, 'list must not be null') {
    transactionIds = list.map((item) => item).toList();
  }

  List<String>? transactionIds = [];

  @override
  String toString() => '{\n'
      '\ttransactionIds: $transactionIds\n'
      '}\n';

  Map<String, dynamic> toJson() => {'transactionIds': transactionIds};

  static List<TransactionIds> listFromJson(List<Map> json) => json.isEmpty
      ? <TransactionIds>[]
      : json.map(TransactionIds.fromJson).toList();

  static Map<String, TransactionIds> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, TransactionIds>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = TransactionIds.fromJson(value));
    }
    return map;
  }
}
