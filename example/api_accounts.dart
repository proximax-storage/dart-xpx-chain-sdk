/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'dart:io';

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'https://api-2.testnet2.xpxsirius.io';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  final networkType = await client.networkType.catchError((err) {
    print('Get networkType Error: ${err.error}');
    // print('StackTrace: ${err.stackTrace}');
    exit(0);
  });

  /// Create an Address from a given public key.
  final accountOne =
      PublicAccount.fromPublicKey('1ECDEF5C126615B655B8A367A8B0063726B30F4B11894CA01E32A3A0482E0A4E', networkType);

  /// Create an Address from a given public key.
  final accountTwo =
      Address.fromPublicKey('F6A9951DDB2B9EF2C7EB5132654562FC6D2308B42AEAAFD11097B232F429AF70', networkType);

  // Returns the account information.
  try {
    final result = await client.account.getAccountInfo(accountTwo);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountInfo: $e\n');
  }

  // Returns the account information for an array of accounts.
  try {
    final result = await client.account.getAccountsInfo([accountOne.address, accountTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountsInfo: $e\n');
  }

  // Returns the [multisig account] information.
  try {
    final result = await client.account.getAccountMultisig(accountTwo);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountMultisig: $e\n');
  }

  // Returns the [multisig account] graph.
  try {
    final result = await client.account.getAccountMultisigGraph(accountTwo);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountMultisigGraph: $e\n');
  }

  // Gets an array of transactions for which an account is the sender or receiver.
  try {
    final result = await client.account.transactions(
        accountOne,
        TransactionQueryParams()
          ..embedded = true
          ..pageNumber = 2
          ..pageSize = 10
          ..type = [TransactionType.aggregateCompleted, TransactionType.transfer]
          ..firstLevel = false);

    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->Transactions: $e\n');
  }

  // Gets an array of transactions for which an account is the sender or receiver.
  try {
    final result = await client.account.transactionsWithPagination(accountOne);

    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->Transactions: $e\n');
  }

  // Gets an array of incoming transactions.
  // A transaction is said to be incoming with respect to an account if the account is the recipient of the transaction.
  try {
    final result = await client.account.incomingTransactions(accountOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->IncomingTransactions: $e\n');
  }

  // Gets an array of outgoing transactions.
  // A transaction is said to be outgoing with respect to an account if the account is the sender of the transaction.
  try {
    final result = await client.account.outgoingTransactions(accountOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->OutgoingTransactions: $e\n');
  }

  // Gets the array of transactions not included in a block where an account is the sender or receiver.
  try {
    final result = await client.account.unconfirmedTransactions(accountOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->UnconfirmedTransactions: $e\n');
  }

  // Gets an array of [aggregate bonded transactions] where the account is the sender or requires to cosign the transaction.
  try {
    final result = await client.account.partialTransactions(accountOne, TransactionQueryParams()..embedded = true);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->AggregateBondedTransactions: $e\n');
  }

  // Returns friendly names for accounts.
  try {
    final result = await client.account.getAccountsNames([accountOne.address, accountTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountsNames: $e\n');
  }

  // Returns the [configurable properties] for a given account.
  try {
    final result = await client.account.getAccountProperties(accountOne.address);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountProperties: $e\n');
  }

  // Returns the [configurable properties] for a given array of addresses.
  try {
    final result = await client.account.getAccountsProperties([accountOne.address, accountTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountsProperties: $e\n');
  }
}
