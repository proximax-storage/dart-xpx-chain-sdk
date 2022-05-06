/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

enum TransactionGroupType { confirmed, unconfirmed, partial, failed }

extension TransactionGroupTypeStringExt on String {
  TransactionGroupType? get toTransactionGroupType {
    switch (toLowerCase()) {
      case 'confirmed':
        return TransactionGroupType.confirmed;
      case 'unconfirmed':
        return TransactionGroupType.unconfirmed;
      case 'partial':
        return TransactionGroupType.partial;
      default:
        return TransactionGroupType.failed;
    }
  }
}

extension TransactionGroupTypeExt on TransactionGroupType {
  int get toInt => index;

  String get name {
    switch (this) {
      case TransactionGroupType.confirmed:
        return 'confirmed';
      case TransactionGroupType.unconfirmed:
        return 'unconfirmed';
      case TransactionGroupType.partial:
        return 'partial';
      default:
        return 'failed';
    }
  }
}
