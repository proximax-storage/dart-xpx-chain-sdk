/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class AccountRoutesApi {
  AccountRoutesApi([_ApiClient? _apiClient])
      : _apiClient = _apiClient ?? defaultApiClient;

  final _ApiClient _apiClient;

  static const _accountInfoRoute = '/account/{accountId}';
  static const _accountsInfoRoute = '/account';
  static const _accountMultisigRoute = '/account/{accountId}/multisig';
  static const _accountMultisigGraphRoute =
      '/account/{accountId}/multisig/graph';
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
    final String path =
        _accountInfoRoute.replaceAll('{accountId}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'AccountInfoDTO');
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

    final Object postBody = {
      'addresses': addresses.map((a) => a.address).toList()
    };

    // create path and map variables
    const String path = _accountsInfoRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<AccountInfoDTO>')
          .cast<AccountInfoDTO>();
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
    final String path =
        _accountMultisigRoute.replaceAll('{accountId}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'MultisigAccountInfo');
    } else {
      return null;
    }
  }

  /// Get multisig account graph information
  ///
  /// Returns list [MultisigAccountGraphInfo] graph.
  Future<List<MultisigAccountGraphInfo>> getAccountMultisigGraph(
      Address address) async {
    // create path and map variables
    final String path =
        _accountMultisigGraphRoute.replaceAll('{accountId}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient
          .deserialize(response.data, 'List<MultisigAccountGraphInfo>')
          .cast<MultisigAccountGraphInfo>();
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
  Future<List<Transaction>> transactions(Address address,
      {TransactionQueryParams? txnQueryParams}) async {
    // create path and map variables
    const String path = _transactionsRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    }

    queryParams.add(QueryParam('address', address.address));

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List resp =
          _apiClient.deserialize(response.data, 'List<Transaction>');
      return resp.map(deserializeDTO).toList().cast<Transaction>();
    } else {
      return [];
    }
  }

  /// Get incoming transactions
  ///
  /// Gets an List of incoming transactions.
  /// A transaction is said to be incoming with respect to an
  /// account if the account is the recipient of the transaction.
  Future<List<Transaction>> incomingTransactions(Address address,
      {TransactionQueryParams? txnQueryParams}) async {
    // create path and map variables
    const String path = _transactionsRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    }
    queryParams.add(QueryParam('recipientAddress', address.address));

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List resp =
          _apiClient.deserialize(response.data, 'List<Transaction>');
      return resp.map(deserializeDTO).toList().cast<Transaction>();
    } else {
      return [];
    }
  }

  /// Get outgoing transactions
  ///
  /// Gets an List of outgoing transactions.
  /// A transaction is said to be outgoing with respect to an
  /// account if the account is the sender of the transaction.
  Future<List<Transaction>> outgoingTransactions(PublicAccount account,
      {TransactionQueryParams? txnQueryParams}) async {
    const String path = _transactionsRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    }
    queryParams.add(QueryParam('signerPublicKey', account.publicKey));

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List resp =
          _apiClient.deserialize(response.data, 'List<Transaction>');
      return resp.map(deserializeDTO).toList().cast<Transaction>();
    } else {
      return [];
    }
  }

  /// Get unconfirmed transactions
  ///
  /// Gets the List of transactions not included in a block where an account
  /// is the sender or receiver.
  Future<List<Transaction>> unconfirmedTransactions(Address address,
      {TransactionQueryParams? txnQueryParams}) async {
    // create path and map variables
    const String path = _unconfirmedTransactionsRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    }
    queryParams.add(QueryParam('address', address.address));

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List resp =
          _apiClient.deserialize(response.data, 'List<Transaction>');
      return resp.map(deserializeDTO).toList().cast<Transaction>();
    } else {
      return [];
    }
  }

  /// Get aggregate bonded transactions information
  ///
  /// Gets an List of [aggregate bonded transactions] where the account is
  /// the sender or requires to cosign the transaction.
  Future<List<Transaction>> partialTransactions(Address address,
      {TransactionQueryParams? txnQueryParams}) async {
    const String path = _aggregateBondedTransactionsRoute;

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    }
    queryParams.add(QueryParam('address', address.address));

    final response = await _apiClient.get(path, null, queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final List resp =
          _apiClient.deserialize(response.data, 'List<Transaction>');
      return resp.map(deserializeDTO).toList().cast<Transaction>();
    } else {
      return [];
    }
  }

  /// Get readable names for a set of accountIds.
  Future<List<AccountNames>> getAccountsNames(List<Address> addresses) async {
    if (addresses.isEmpty) {
      throw ApiException(400, 'addresses must not be empty');
    }

    final Object postBody = {
      'addresses': addresses.map((a) => a.address).toList()
    };

    // create path and map variables
    const String path = _accountsNamesRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<AccountNames>')
          .cast<AccountNamesDTO>();
      return AccountNames.listFromJson(resp);
    } else {
      return [];
    }
  }

  Future<AccountProperties?> getAccountProperties(Address address) async {
    // create path and map variables
    final String path =
        _accountPropertiesRoute.replaceAll('{address}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp =
          _apiClient.deserialize(response.data, 'AccountPropertiesDTO');

      return AccountProperties.fromDto(resp);
    } else {
      return null;
    }
  }

  Future<List<AccountProperties>> getAccountsProperties(
      List<Address> addresses) async {
    if (addresses.isEmpty) {
      throw ApiException(400, 'addresses must not be empty');
    }

    final Object postBody = {
      'addresses': addresses.map((a) => a.address).toList()
    };

    // create path and map variables
    const String path = _accountsPropertiesRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<AccountPropertiesDTO>')
          .cast<AccountPropertiesDTO>();
      return AccountProperties.listFromJson(resp);
    } else {
      return [];
    }
  }
}
