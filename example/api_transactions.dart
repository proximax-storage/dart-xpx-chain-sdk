/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'http://bctestnet3.brimstone.xpxsirius.io:3000';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  const hashOne = '8454782DB6B2BC5764A9EB74C8A7AE4A4024A83BBC7E37626663C21F5C7F5B8C';
  const hashTwo = 'BF9B3AF29569A17B2FC72204A793A3984FB14022AD597D4D5E997D0965F97E02';

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
    ..type = [TransactionType.transfer, TransactionType.aggregateCompleted]
    ..signerPublicKey = "785B6EDD55934391C4C0CBFCF5ECDCBC5104CB781178616A99167480418282BD";

  // Returns a [Transaction] information given a transactionId or hash.
  try {
    /// Get a transaction information given a transactionId or hash.
    final result = await client.transaction.getTransactionsByGroup(TransactionGroupType.confirmed, txnQueryParams);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Transaction->GetTransaction: $e\n');
  }

  // //Returns a List of [Transaction] information for a given List of transactionIds.
  // try {
  //   /// Get a transaction information given a transactionId or hash.
  //   final result = await client.transaction
  //       .getTransactions([hashOne, hashTwo], TransactionGroupType.confirmed);
  //   print(result);
  // } on Exception catch (e) {
  //   print('Exception when calling Transaction->GetTransactions: $e\n');
  // }
  //
  // // Returns the transaction status for a given hash.
  // try {
  //   final result = await client.transaction.getTransactionStatus(hashOne);
  //   print(result);
  // } on Exception catch (e) {
  //   print('Exception when calling Transaction->GetTransactionStatus: $e\n');
  // }
  //
  // // Returns an List of transaction statuses for a given List of transaction hashes.
  // try {
  //   final result =
  //       await client.transaction.getTransactionsStatuses([hashOne, hashTwo]);
  //   print(result);
  // } on Exception catch (e) {
  //   print('Exception when calling Transaction->GetTransactionsStatuses: $e\n');
  // }
  //
  // try {
  //   final result = await client.transaction.getTransactionEffectiveFee(hashOne);
  //   print(result);
  // } on Exception catch (e) {
  //   print(
  //       'Exception when calling Transaction->GetTransactionEffectiveFee: $e\n');
  // }
  //
  // try {
  //   final result = await client.transaction
  //       .getTransactionsCount([TransactionType.transfer]);
  //   print(result);
  // } on Exception catch (e) {
  //   print('Exception when calling Transaction->GetTransactionsCount: $e\n');
  // }
}
