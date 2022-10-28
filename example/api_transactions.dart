/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'https://api-2.testnet2.xpxsirius.io:443';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  const hashOne = '6FE85BD05964E38143E4B1599880156522B8E058588357AD7C0C047723037892';
  const hashTwo = '47dec094a3379d9cfb1ed100c843da5f5578af7ad16bb2ef3d5d0ab0f6493c8d';

  // Returns a [Transaction] information given a transactionId or hash.
  try {
    /// Get a transaction information given a transactionId or hash.
    final result = await client.transaction.getAnyTransaction(hashOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransaction: $e\n');
  }

  // Returns a [Transaction] information given a transactionId or hash.
  try {
    /// Get a transaction information given a transactionId or hash.
    final result = await client.transaction.getTransaction(TransactionGroupType.confirmed, hashOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransaction: $e\n');
  }

  final txnQueryParams = TransactionQueryParams()
    ..embedded = true
    ..type = [TransactionType.transfer]
    ..signerPublicKey = 'C2F93346E27CE6AD1A9F8F5E3066F8326593A406BDF357ACB041E2F9AB402EFE';

  // Returns a [Transaction] information given a transactionId or hash.
  try {
    /// Get a transaction information given a transactionId or hash.
    final result = await client.transaction.getTransactionsByGroupWithPagination(TransactionGroupType.confirmed, txnQueryParams);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransaction: $e\n');
  }

  //Returns a List of [Transaction] information for a given List of transactionIds.
  try {
    /// Get a transaction information given a transactionId or hash.
    final result = await client.transaction.getTransactions([hashOne, hashTwo], TransactionGroupType.confirmed);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransactions: $e\n');
  }

  // Returns the transaction status for a given hash.
  try {
    final result = await client.transaction.getTransactionStatus(hashOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransactionStatus: $e\n');
  }

  // Returns an List of transaction statuses for a given List of transaction hashes.
  try {
    final result = await client.transaction.getTransactionsStatuses([hashOne, hashTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransactionsStatuses: $e\n');
  }

  try {
    final result = await client.transaction.getTransactionEffectiveFee(hashOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransactionEffectiveFee: $e\n');
  }

  try {
    final result = await client.transaction.getTransactionsCount([TransactionType.transfer]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransactionsCount: $e\n');
  }
}
