/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'https://api-2.testnet2.xpxsirius.io';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  const hashOne = 'BA539AB351D0E0DFE062A28ECC9F062E3BCA8237F8116F914739643D3A56EAFD';
  const hashTwo = '57376F52D2CE59E12F70607AF9DA8868A9193D72D02DED09BFF45CC73DF7A1B9';

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
    ..signerPublicKey = '2CF9BC23414B5A465EA9F331F5912627666E1AF348B96910B5F32D54AB43A05C';

  // Returns a [Transaction] information given a transactionId or hash.
  try {
    /// Get a transaction information given a transactionId or hash.
    final result = await client.transaction.getTransactionsByGroup(TransactionGroupType.confirmed, txnQueryParams);
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

  // try {
  //   final result = await client.transaction.getTransactionsCount([TransactionType.transfer]);
  //   print(result);
  // } on Exception catch (e) {
  //   print('Exception when calling Transaction->GetTransactionsCount: $e\n');
  // }
}
