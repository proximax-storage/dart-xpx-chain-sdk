/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

abstract class Transaction {
  AbstractTransaction absTransaction();

  TransactionType entityType();

  Map<String, dynamic> toJson();

  Uint8List generateBytes();

  int size();
}
