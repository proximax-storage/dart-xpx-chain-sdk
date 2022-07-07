/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class TransactionSearch {
  TransactionSearch(this.transactions, this.pagination);

  final List<Transaction> transactions;
  final Pagination pagination;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'transactions': transactions, 'pagination': pagination};
}
