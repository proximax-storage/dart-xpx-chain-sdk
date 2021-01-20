part of xpx_chain_sdk.api;

// routes for TransactionApi
const _transactionsRoute = '/transaction',
    _transactionRoute = '/transaction/{transactionId}',
    _transactionStatusRoute = '/transaction/{hash}/status',
    _transactionsStatusRoute = '/transaction/statuses',
    _announceAggregateRoute = '/transaction/partial',
    _announceAggregateCosignatureRoute = '/transaction/cosignature';

class TransactionRoutesApi {
  TransactionRoutesApi([_ApiClient _apiClient]) : _apiClient = _apiClient ?? defaultApiClient;

  final _ApiClient _apiClient;

  /// returns transaction hash after announcing passed SignedTransaction
  Future<Object> announce(SignedTransaction tx) async => _announceTransaction(tx, _transactionsRoute);

  /// returns transaction hash after announcing passed aggregate bounded SignedTransaction
  Future<Object> announceAggregateBonded(SignedTransaction tx) async =>
      _announceTransaction(tx, _announceAggregateRoute);

  /// returns transaction hash after announcing passed CosignatureSignedTransaction
  Future<Object> announceAggregateBondedCosignature(CosignatureSignedTransaction tx) async =>
      _announceTransaction(tx, _announceAggregateCosignatureRoute);

  /// Announce a  transaction
  ///
  /// Announces a transaction to the network.
  Future<Object> _announceTransaction(tx, String uri) async {
    final Object postBody = tx;

    // verify required params are set
    if (tx == null) {
      throw ApiException(400, 'Missing required param: payload');
    }

    // create path and map variables
    final String path = uri.replaceAll('{format}', 'json');

    final response = await _apiClient.put(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'String');
    } else {
      return null;
    }
  }

  /// Get transaction information
  ///
  /// Returns a [Transaction] information given a transactionId or hash.
  Future<Transaction> getTransaction(String transactionId) async {
    // verify required params are set
    if (transactionId == null) {
      throw ApiException(400, 'Missing required param: transactionId');
    }

    // create path and map variables
    final String path = _transactionRoute.replaceAll('{format}', 'json').replaceAll('{transactionId}', transactionId);

    final response = await _apiClient.get(path);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return deserializeDTO(_apiClient.deserialize(response.body, 'Transaction'));
    } else {
      return null;
    }
  }

  /// Get transactions information
  ///
  /// Returns a List of [Transaction] information for a given
  /// List of transactionIds.
  Future<List<Transaction>> getTransactions(List<String> transactionIds) async {
    final Object postBody = TransactionIds.fromList(transactionIds);

    // verify required params are set
    if (transactionIds == null) {
      throw ApiException(400, 'Missing required param: transactionIds');
    }

    // create path and map variables
    final String path = _transactionsRoute.replaceAll('{format}', 'json');

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = _apiClient.deserialize(response.body, 'List<Transaction>');
      return resp.map(deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get transaction status
  ///
  /// Returns the transaction status for a given hash.
  Future<TransactionStatus> getTransactionStatus(String hash) async {
    // verify required params are set
    if (hash == null) {
      throw ApiException(400, 'Missing required param: hash');
    }

    // create path and map variables
    final String path = _transactionStatusRoute.replaceAll('{format}', 'json').replaceAll('{hash}', hash.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'TransactionStatus');
    } else {
      return null;
    }
  }

  /// Get transactions status.
  ///
  /// Returns an List of transaction statuses for a given
  /// List of transaction hashes.
  Future<List<TransactionStatus>> getTransactionsStatuses(List<String> transactionHashes) async {
    final Object postBody = TransactionHashes.fromList(transactionHashes);

    // verify required params are set
    if (transactionHashes == null) {
      throw ApiException(400, 'Missing required param: transactionHashes');
    }

    // create path and map variables
    final String path = _transactionsStatusRoute.replaceAll('{format}', 'json');

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'List<TransactionStatus>').cast<TransactionStatus>();
    } else {
      return null;
    }
  }
}
