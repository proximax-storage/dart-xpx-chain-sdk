/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

// Transaction Info
mixin TransactionInfo {
  Uint64? height;
  int? index;
  String? id;
  String? transactionHash;
  String? merkleComponentHash;
  String? aggregateHash;
  String? aggregateId;

  TransactionInfo get getTransactionInfo => this;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => _transactionInfoToJson();

  Map<String, dynamic> _transactionInfoToJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', id);
    writeNotNull('index', index);
    writeNotNull('height', height);
    writeNotNull('transactionHash', transactionHash);
    writeNotNull('merkleComponentHash', merkleComponentHash);
    writeNotNull('aggregateHash', aggregateHash);
    writeNotNull('aggregateId', aggregateId);

    return val;
  }
}
