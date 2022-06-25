/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.blockchain;

class BlockchainStorageInfo {
  BlockchainStorageInfo.fromJson(Map<String, dynamic> json) : assert(json.isNotEmpty, 'json must not be empty') {
    numBlocks = json['numBlocks'];
    numTransactions = json['numTransactions'];
    numAccounts = json['numAccounts'];
  }

  int? numBlocks;

  int? numTransactions;

  int? numAccounts;

  @override
  String toString() => '{numBlocks:$numBlocks,'
      ' numTransactions:$numTransactions,'
      ' numAccounts:$numAccounts}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['numBlocks'] = numBlocks;
    data['numTransactions'] = numTransactions;
    data['numAccounts'] = numAccounts;

    return data;
  }
}
