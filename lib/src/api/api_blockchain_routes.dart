/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class BlockchainRoutesApi {
  BlockchainRoutesApi([ApiClient? apiClient])
      : _apiClient = apiClient ?? defaultApiClient;

  final ApiClient _apiClient;

  static const _blockchainHeightRoute = '/chain/height';
  static const _blockByHeightRoute = '/block/{height}';

  // static const _blockReceiptsRoute = '/block/{height}/receipts';
  static const _blockchainScoreRoute = '/chain/score';
  static const _diagnosticStorageRoute = '/diagnostic/storage';
  static const _blockTransactionsRoute = '/transactions/confirmed';
  static const _blocksByHeightWithLimitRoute = '/blocks/{height}/limit/{limit}';

  /// Get block information
  ///
  /// Gets a [BlockInfo] from the chain that has the given height.
  Future<BlockInfo?> getBlockByHeight(Height height) async {
    // create path and map variables
    final String path =
        _blockByHeightRoute.replaceAll('{height}', height.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'BlockInfoDTO');
      return BlockInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get the current height of the chain
  ///
  /// Returns the current height of the blockchain.
  Future<Height> getBlockchainHeight() async {
    const String path = _blockchainHeightRoute;

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final HeightDTO resp = _apiClient.deserialize(response.data, 'HeightDTO');
      return Height.fromDto(resp.height!);
    } else {
      return Height.zero;
    }
  }

  /// Get the current score of the chain
  ///
  /// Gets the current [BlockchainScore].
  /// The higher the score, the better the chain.
  /// During synchronization, nodes try to get the best blockchain
  /// in the network.
  /// The score for a block is derived from its difficulty and
  /// the time (in seconds)
  /// that has elapsed since the last block:
  /// block score &#x3D; difficulty − time elasped since last block
  Future<BlockchainScore?> getBlockchainScore() async {
    // create path and map variables
    const String path = _blockchainScoreRoute;

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient.deserialize(response.data, 'BlockchainScoreDTO');
      return BlockchainScore.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get the storage information
  ///
  /// Returns a [BlockchainStorageInfo] statistical information about
  /// the blockchain.
  Future<BlockchainStorageInfo?> getDiagnosticStorage() async {
    // create path and map variables
    const String path = _diagnosticStorageRoute;

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'BlockchainStorageInfo');
    } else {
      return null;
    }
  }

  /// Get transactions from a block
  ///
  /// Returns an List of [Transaction] included in a block for a given block height.
  Future<List<Transaction>> getBlockTransactions(Height height,
      {TransactionQueryParams? txnQueryParams}) async {
    // create path and map variables
    const String path = _blockTransactionsRoute;

    // query params
    // query params
    final List<QueryParam> queryParams = [];
    if (txnQueryParams != null) {
      txnQueryParams.height = height;
      queryParams.addAll(txnQueryParams.toQueryParams());
    } else {
      queryParams.add(QueryParam('height', '${height.toInt()}'));
    }
    queryParams.add(QueryParam('embedded', 'true'));

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

  /// Get blocks information
  ///
  /// Gets up to limit number of blocks after given block height.
  Future<List<BlockInfo>?> getBlocksByHeightWithLimit(
      int height, int limit) async {
    // create path and map variables
    final String path = _blocksByHeightWithLimitRoute
        .replaceAll('{height}', height.toString())
        .replaceAll('{limit}', limit.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      final resp = _apiClient
          .deserialize(response.data, 'List<BlockInfoDTO>')
          .cast<BlockInfoDTO>();
      return BlockInfo.listFromDTO(resp);
    } else {
      return [];
    }
  }

  /// Get receipts from a block.
  ///
  Future<void> getBlockReceipts(Height height, String hash) async {
    UnimplementedError('Unimplemented getBlockReceipts');
  }

  /// Get the merkle path for a given a transaction and block.
  ///
  Future<void> getMerkleTransaction(Height height, String hash) async {
    UnimplementedError('Unimplemented getMerkleTransaction');
  }
}
