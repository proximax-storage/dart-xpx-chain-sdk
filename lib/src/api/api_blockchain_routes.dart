part of xpx_chain_sdk.api;

class BlockchainRoutesApi {
  BlockchainRoutesApi([_ApiClient apiClient]) : _apiClient = apiClient ?? defaultApiClient;

  final _ApiClient _apiClient;

  /// Get the current height of the chain
  ///
  /// Returns the current height of the blockchain.
  Future<Height> getBlockchainHeight() async {
    // create path and map variables
    final String path = '/chain/height'.replaceAll('{format}', 'json');

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'HeightDTO');
      return Height.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get block information
  ///
  /// Gets a [BlockInfo] from the chain that has the given height.
  Future<BlockInfo> getBlockByHeight(BigInt height) async {
    // verify required params are set
    if (height == null) {
      throw ApiException(400, 'Missing required param: height');
    }

    // create path and map variables
    final String path = '/block/{height}'.replaceAll('{format}', 'json').replaceAll('{height}', height.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'BlockInfoDTO');
      return BlockInfo.fromDTO(resp);
    } else {
      return null;
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
  Future<BlockchainScore> getBlockchainScore() async {
    // create path and map variables
    final String path = '/chain/score'.replaceAll('{format}', 'json');

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'BlockchainScoreDTO');
      return BlockchainScore.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get the storage information
  ///
  /// Returns a [BlockchainStorageInfo] statistical information about
  /// the blockchain.
  Future<BlockchainStorageInfo> getDiagnosticStorage() async {
    // create path and map variables
    final String path = '/diagnostic/storage'.replaceAll('{format}', 'json');

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'BlockchainStorageInfo');
    } else {
      return null;
    }
  }

  /// Get transactions from a block
  ///
  /// Returns an List of [Transaction] included in a block for a given
  /// block height.
  Future<List<Transaction>> getBlockTransactions(BigInt height, {int pageSize, String id}) async {
    // verify required params are set
    if (height == null) {
      throw ApiException(400, 'Missing required param: height');
    }

    // create path and map variables
    final String path =
        '/block/{height}/transactions'.replaceAll('{format}', 'json').replaceAll('{height}', height.toString());

    // query params
    final List<QueryParam> queryParams = [];
    if (pageSize != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }

    final response = await _apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = _apiClient.deserialize(response.body, 'List<Transaction>');
      return resp.map(deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get blocks information
  ///
  /// Gets up to limit number of blocks after given block height.
  Future<List<BlockInfo>> getBlocksByHeightWithLimit(BigInt height, int limit) async {
    // verify required params are set
    if (height == null) {
      throw errNullOrZeroHeight;
    }
    if (limit == null) {
      throw errNullOrZeroLimit;
    }

    // create path and map variables
    final String path = '/blocks/{height}/limit/{limit}'
        .replaceAll('{format}', 'json')
        .replaceAll('{height}', height.toString())
        .replaceAll('{limit}', limit.toString());

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<BlockInfoDTO>').cast<BlockInfoDTO>();
      return BlockInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }
}
