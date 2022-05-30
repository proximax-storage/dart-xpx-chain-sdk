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

  final networkType = await client.networkType;

  /// Create an Address from a given public key.
  final accountOne = PublicAccount.fromPublicKey(
      '785b6edd55934391c4c0cbfcf5ecdcbc5104cb781178616a99167480418282bd',
      networkType);

  /// Create an Address from a given public key.
  final accountTwo = Address.fromPublicKey(
      'F6A9951DDB2B9EF2C7EB5132654562FC6D2308B42AEAAFD11097B232F429AF70',
      networkType);

  // Returns the account information.
  try {
    final result = await client.account.getAccountInfo(accountOne.address);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountInfo: $e\n');
  }

  // Returns the account information for an array of accounts.
  try {
    final result =
        await client.account.getAccountsInfo([accountOne.address, accountTwo]);
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
    final result = await client.account
        .transactions(accountOne, TransactionQueryParams()..embedded = true);
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
    final result = await client.account.partialTransactions(
        accountOne, TransactionQueryParams()..embedded = true);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->AggregateBondedTransactions: $e\n');
  }

  // Returns friendly names for accounts.
  try {
    final result =
        await client.account.getAccountsNames([accountOne.address, accountTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountsNames: $e\n');
  }

  // Returns the [configurable properties] for a given account.
  try {
    final result =
        await client.account.getAccountProperties(accountOne.address);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountProperties: $e\n');
  }

  // Returns the [configurable properties] for a given array of addresses.
  try {
    final result = await client.account
        .getAccountsProperties([accountOne.address, accountTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Account->GetAccountsProperties: $e\n');
  }
}
