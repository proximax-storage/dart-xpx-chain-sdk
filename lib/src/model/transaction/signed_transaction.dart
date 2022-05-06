/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class SignedTransaction {
  SignedTransaction(this.transactionType, this.payload, this.hash);

  factory SignedTransaction.fromJson(Map<String, dynamic> json) {
    final transactionType = TransactionType.fromInt(json['transactionType']);
    return SignedTransaction(transactionType, json['payload'], json['hash']);
  }

  final TransactionType transactionType;
  final String payload;
  final String hash;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionType'] = transactionType;
    data['payload'] = payload;
    data['hash'] = hash;
    return data;
  }
}
