/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class AccountRoutesApi {
  AccountRoutesApi([HttpClient? _httpClient]) : _httpClient = _httpClient ?? defaultApiClient;

  final HttpClient _httpClient;

  static const _accountInfoRoute = '/account/{accountId}';
  static const _accountsInfoRoute = '/account';
  static const _accountMultisigRoute = '/account/{accountId}/multisig';
  static const _accountMultisigGraphRoute = '/account/{accountId}/multisig/graph';
  static const _transactionsRoute = '/transactions/confirmed';
  static const _unconfirmedTransactionsRoute = '/transactions/unconfirmed';
  static const _aggregateBondedTransactionsRoute = '/transactions/partial';
  static const _accountsNamesRoute = '/account/names';
  static const _accountPropertiesRoute = '/account/{address}/properties';
  static const _accountsPropertiesRoute = '/account/properties';

  /// Get account information
  ///
  /// Returns the account information.
  Future<AccountInfo?> getAccountInfo(Address address) async {
    // create path and map variables
    final String path = _accountInfoRoute.replaceAll('{accountId}', address.address);

    final response = await _httpClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _httpClient.deserialize(response.data, 'AccountInfoDTO');
      return AccountInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get accounts information
  ///
  /// Returns the account information for an List of accounts.
  Future<List<AccountInfo>> getAccountsInfo(List<Address> addresses) async {
    if (addresses.isEmpty) {
      throw ApiException(400, 'addresses must not be empty');
    }

    final Object postBody = {'addresses': addresses.map((a) => a.address).toList()};

    // create path and map variables
    const String path = _accountsInfoRoute;

    final response = await _httpClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _httpClient.deserialize(response.data, 'List<AccountInfoDTO>').cast<AccountInfoDTO>();
      return AccountInfo.listFromDTO(resp);
    } else {
      return [];
    }
  }

  /// Get multisig account information
  ///
  /// Returns the [MultisigAccountInfo] information.
  Future<MultisigAccountInfo?> getAccountMultisig(Address address) async {
    // create path and map variables
    final String path = _accountMultisigRoute.replaceAll('{accountId}', address.address);

    final response = await _httpClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _httpClient.deserialize(response.data, 'MultisigAccountInfo');
    } else {
      return null;
    }
  }

  /// Get multisig account graph information
  ///
  /// Returns list [MultisigAccountGraphInfo] graph.
  Future<List<MultisigAccountGraphInfo>> getAccountMultisigGraph(Address address) async {
    // create path and map variables
    final String path = _accountMultisigGraphRoute.replaceAll('{accountId}', address.address);

    final response = await _httpClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _httpClient.deserialize(response.data, 'List<MultisigAccountGraphInfo>').cast<MultisigAccountGraphInfo>();
    } else {
      return [];
    }
  }

  /// Get confirmed transactions
  ///
  /// Gets an List of transactions for which an account is the sender or receiver.
  ///
  /// param: address The [Address] of the account.
  /// param: pageSize The number of transactions to return for each request.
  /// param: id The transaction id up to which transactions are returned.
  /// param: ordering The ordering criteria: * -id - Descending order by id. * id - Ascending order by id.
  Future<List<Transaction>> transactions(PublicAccount account, [TransactionQueryParams? txnQueryParams]) async =>
      (await transactionsWithPagination(account, txnQueryParams)).transactions;

  Future<TransactionSearch> transactionsWithPagination(PublicAccount account,
      [TransactionQueryParams? txnQueryParams]) async {
    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      txnQueryParams.publicKey = account.publicKey;
      queryParams.addAll(txnQueryParams.toQueryParams());
    } else {
      queryParams.add(QueryParam('publicKey', account.publicKey));
    }

    bool firstLevel = true;
    if (txnQueryParams != null && !txnQueryParams.firstLevel) {
      firstLevel = false;
    }

    return await internalGetTransactionsWithPagination(_httpClient, _transactionsRoute, queryParams, null,
        firstLevel: firstLevel);
  }

  /// Get incoming transactions
  ///
  /// Gets an List of incoming transactions.
  /// A transaction is said to be incoming with respect to an
  /// account if the account is the recipient of the transaction.
  Future<List<Transaction>> incomingTransactions(PublicAccount account,
          [TransactionQueryParams? txnQueryParams]) async =>
      (await incomingTransactionsWithPagination(account, txnQueryParams)).transactions;

  Future<TransactionSearch> incomingTransactionsWithPagination(PublicAccount account,
      [TransactionQueryParams? txnQueryParams]) async {
    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    } else {
      queryParams.add(QueryParam('recipientAddress', account.address.address));
    }

    bool firstLevel = true;
    if (txnQueryParams != null && !txnQueryParams.firstLevel) {
      firstLevel = false;
    }
    return internalGetTransactionsWithPagination(_httpClient, _transactionsRoute, queryParams, null,
        firstLevel: firstLevel);
  }

  /// Get outgoing transactions
  ///
  /// Gets an List of outgoing transactions.
  /// A transaction is said to be outgoing with respect to an
  /// account if the account is the sender of the transaction.
  Future<List<Transaction>> outgoingTransactions(PublicAccount account,
          [TransactionQueryParams? txnQueryParams]) async =>
      (await outgoingTransactionsWithPagination(account, txnQueryParams)).transactions;

  Future<TransactionSearch> outgoingTransactionsWithPagination(PublicAccount account,
      [TransactionQueryParams? txnQueryParams]) async {
    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      txnQueryParams.signerPublicKey = account.publicKey;
      queryParams.addAll(txnQueryParams.toQueryParams());
    } else {
      queryParams.add(QueryParam('signerPublicKey', account.publicKey));
    }

    bool firstLevel = true;
    if (txnQueryParams != null && !txnQueryParams.firstLevel) {
      firstLevel = false;
    }
    return internalGetTransactionsWithPagination(_httpClient, _transactionsRoute, queryParams, null,
        firstLevel: firstLevel);
  }

  /// Get unconfirmed transactions
  ///
  /// Gets the List of transactions not included in a block where an account
  /// is the sender or receiver.
  Future<List<Transaction>> unconfirmedTransactions(PublicAccount account,
          [TransactionQueryParams? txnQueryParams]) async =>
      (await unconfirmedTransactionsWithPagination(account, txnQueryParams)).transactions;

  Future<TransactionSearch> unconfirmedTransactionsWithPagination(PublicAccount account,
      [TransactionQueryParams? txnQueryParams]) async {
    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      txnQueryParams.signerPublicKey = account.publicKey;
      queryParams.addAll(txnQueryParams.toQueryParams());
    } else {
      queryParams.add(QueryParam('signerPublicKey', account.publicKey));
    }

    bool firstLevel = true;
    if (txnQueryParams != null && !txnQueryParams.firstLevel) {
      firstLevel = false;
    }
    return internalGetTransactionsWithPagination(_httpClient, _unconfirmedTransactionsRoute, queryParams, null,
        firstLevel: firstLevel);
  }

  /// Get aggregate bonded transactions information
  ///
  /// Gets an List of [aggregate bonded transactions] where the account is
  /// the sender or requires to cosign the transaction.
  Future<List<AggregateTransaction>> partialTransactions(PublicAccount account,
      [TransactionQueryParams? txnQueryParams]) async {
    const String path = _aggregateBondedTransactionsRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      txnQueryParams.publicKey = account.publicKey;
      queryParams.addAll(txnQueryParams.toQueryParams());
    } else {
      queryParams.add(QueryParam('publicKey', account.publicKey));
    }

    final response = await _httpClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List resp = _httpClient.deserialize(response.data, 'List<Transaction>');

      final allTransaction = resp.map(mapTransactionDTO).toList().cast<Transaction>();

      var aggregateBondedTransactions = <AggregateTransaction>[];
      for (var transaction in allTransaction) {
        if (transaction.entityType() == TransactionType.aggregateBonded) {
          aggregateBondedTransactions.add(transaction as AggregateTransaction);
        }
      }

      for (var transaction in allTransaction) {
        if (transaction.entityType() != TransactionType.aggregateBonded) {
          final aggregateTransaction = aggregateBondedTransactions.firstWhere(
              (element) => element.absTransaction().transactionHash == transaction.absTransaction().aggregateHash);
          aggregateTransaction.innerTransactions.add(transaction);
        }
      }

      return aggregateBondedTransactions;
    } else {
      return [];
    }
  }

  /// Get readable names for a set of accountIds.
  Future<List<AccountNames>> getAccountsNames(List<Address> addresses) async {
    if (addresses.isEmpty) {
      throw ApiException(400, 'addresses must not be empty');
    }

    final Object postBody = {'addresses': addresses.map((a) => a.address).toList()};

    // create path and map variables
    const String path = _accountsNamesRoute;

    final response = await _httpClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _httpClient.deserialize(response.data, 'List<AccountNames>').cast<AccountNamesDTO>();
      return AccountNames.listFromJson(resp);
    } else {
      return [];
    }
  }

  Future<AccountProperties?> getAccountProperties(Address address) async {
    // create path and map variables
    final String path = _accountPropertiesRoute.replaceAll('{address}', address.address);

    final response = await _httpClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _httpClient.deserialize(response.data, 'AccountPropertiesDTO');

      return AccountProperties.fromDto(resp);
    } else {
      return null;
    }
  }

  Future<List<AccountProperties>> getAccountsProperties(List<Address> addresses) async {
    if (addresses.isEmpty) {
      throw ApiException(400, 'addresses must not be empty');
    }

    final Object postBody = {'addresses': addresses.map((a) => a.address).toList()};

    // create path and map variables
    const String path = _accountsPropertiesRoute;

    final response = await _httpClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _httpClient.deserialize(response.data, 'List<AccountPropertiesDTO>').cast<AccountPropertiesDTO>();
      return AccountProperties.listFromJson(resp);
    } else {
      return [];
    }
  }
}
