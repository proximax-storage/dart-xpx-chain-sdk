/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class TransactionRoutesApi {
  TransactionRoutesApi([HttpClient? _apiClient]) : _apiClient = _apiClient ?? defaultApiClient;

  final HttpClient _apiClient;

  // routes for TransactionApi.
  static const _announceTransactionRoute = '/transactions';
  static const _transactionsRoute = '/transactions/{group}';
  static const _transactionRoute = '/transactions/{group}/{transactionId}';
  static const _transactionStatusRoute = '/transactionStatus/{hash}';
  static const _transactionsStatusRoute = '/transactionStatus';
  static const _announcePartialRoute = '/transactions/partial';
  static const _announceAggregateCosignatureRoute = '/transaction/cosignature';
  static const _transactionsCounteRoute = '/transactions/count';

  /// returns transaction hash after announcing passed SignedTransaction.
  Future<Object?> announce(SignedTransaction tx) async => _announceTransaction(tx, _announceTransactionRoute);

  /// returns transaction hash after announcing passed aggregate bounded SignedTransaction.
  Future<Object?> announcePartialTransaction(SignedTransaction tx) async =>
      _announceTransaction(tx, _announcePartialRoute);

  /// returns transaction hash after announcing passed CosignatureSignedTransaction.
  Future<Object?> announceAggregateBondedCosignature(CosignatureSignedTransaction tx) async =>
      _announceTransaction(tx, _announceAggregateCosignatureRoute);

  /// Announce a  transaction
  ///
  /// Announces a transaction to the network.
  Future<Object?> _announceTransaction(tx, String path) async {
    final Object postBody = tx;

    // verify required params are set
    if (tx == null) {
      throw ApiException(400, 'Missing required param: payload');
    }

    final response = await _apiClient.put(path, postBody);

    if (response.statusCode! >= 400) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'String');
    } else {
      return null;
    }
  }

  /// Get transaction information
  ///
  /// Returns a [Transaction] information given a transactionId or hash.
  Future<Transaction?> getTransaction(TransactionGroupType group, String transactionId) async {
    // verify required params are set
    if (transactionId.isEmpty) {
      throw ApiException(400, 'transactionId must not be empty');
    }

    // create path and map variables
    final String path =
        _transactionRoute.replaceAll('{group}', group.name).replaceAll('{transactionId}', transactionId);

    final response = await _apiClient.get(path);
    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return mapTransactionDTO(_apiClient.deserialize(response.data, 'Transaction'));
    } else {
      return null;
    }
  }

  /// GetAnyTransaction returns Transaction for passed transaction id or hash.
  ///
  Future<Transaction?> getAnyTransaction(String transactionId) async {
    // verify required params are set
    if (transactionId.isEmpty) {
      throw ApiException(400, 'transactionId must not be empty');
    }

    try {
      final txnStatus = await getTransactionStatus(transactionId);

      if (txnStatus!.group!.toTransactionGroupType == TransactionGroupType.failed) {
        throw ApiException(400, txnStatus.status);
      }

      return await getTransaction(txnStatus.group!.toTransactionGroupType!, transactionId);
    } on DioError catch (_) {
      rethrow;
    }
  }

  /// GetTransactionsByGroup returns an array of Transaction's for passed TransactionGroupType.
  Future<List<Transaction>> getTransactionsByGroup(TransactionGroupType groupType,
          [TransactionQueryParams? txnQueryParams]) async =>
      (await getTransactionsByGroupWithPagination(groupType, txnQueryParams)).transactions;

  Future<TransactionSearch> getTransactionsByGroupWithPagination(TransactionGroupType groupType,
      [TransactionQueryParams? txnQueryParams]) async {
    // create path and map variables
    final String path = _transactionsRoute.replaceAll('{group}', groupType.name);

    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      queryParams.addAll(txnQueryParams.toQueryParams());
    }

    bool firstLevel = true;
    if (txnQueryParams != null && !txnQueryParams.firstLevel) {
      firstLevel = false;
    }
    return internalGetTransactionsWithPagination(_apiClient, path, queryParams, null, firstLevel: firstLevel);
  }

  /// Get transactions information
  ///
  /// Returns a List of [Transaction] information for a given
  /// List of transactionIds.
  Future<List<Transaction>> getTransactions(List<String> transactionIds, TransactionGroupType groupType) async {
    // verify required params are set
    if (transactionIds.isEmpty) {
      throw ApiException(400, 'transactionIds must not be empty');
    }

    // final Object postBody = TransactionIds.fromList(transactionIds);
    final Object postBody = {'transactionIds': transactionIds};

    // create path and map variables
    final String path = _transactionsRoute.replaceAll('{group}', groupType.name);

    return internalGetTransactions(_apiClient, path, [], postBody);
  }

  /// Get transaction status
  ///
  /// Returns the transaction status for a given hash.
  Future<TransactionStatus?> getTransactionStatus(String hash) async {
    // verify required params are set
    if (hash.isEmpty) {
      throw ApiException(400, 'hash must not be empty');
    }

    // create path and map variables
    final String path = _transactionStatusRoute.replaceAll('{hash}', hash.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'TransactionStatus');
    } else {
      return null;
    }
  }

  /// Get transactions status.
  ///
  /// Returns an List of transaction statuses for a given
  /// List of transaction hashes.
  Future<List<TransactionStatus>> getTransactionsStatuses(List<String> transactionHashes) async {
    // verify required params are set
    if (transactionHashes.isEmpty) {
      throw ApiException(400, 'transactionHashes must not be empty');
    }

    final Object postBody = {'hashes': transactionHashes};

    // create path and map variables
    const String path = _transactionsStatusRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'List<TransactionStatus>').cast<TransactionStatus>();
    } else {
      return [];
    }
  }

  /// GetTransactionEffectiveFee.
  ///
  /// GetTransactionEffectiveFee gets a transaction's effective paid fee.
  Future<int> getTransactionEffectiveFee(String transactionId) async {
    // verify required params are set
    if (transactionId.isEmpty) {
      throw ApiException(400, 'transactionId must not be empty');
    }

    try {
      final tx = await getTransaction(TransactionGroupType.confirmed, transactionId);

      final block = await BlockchainRoutesApi(_apiClient).getBlockByHeight(tx!.absTransaction().height!);

      return block!.feeMultiplier! * tx.size();
    } on DioError catch (_) {
      rethrow;
    }
  }

  /// Get transactionTypes count.
  ///
  /// Returns transactions count separate by type for a given array of transactionTypes.
  Future<List> getTransactionsCount(List<TransactionType> transactionTypes) async {
    // verify required params are set
    if (transactionTypes.isEmpty) {
      throw ApiException(400, 'transactionTypes must not be empty');
    }

    final Object postBody = {'transactionTypes': transactionTypes};

    // create path and map variables
    const String path = _transactionsCounteRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else {
      if (response.data != null) {
        // final _resp = _apiClient.deserialize(response.data, 'List<TransactionCountDTO>').cast<TransactionCountDTO>();
        throw UnimplementedError();
      } else {
        return [];
      }
    }
  }
}
