part of xpx_catapult_sdk;

class BlockchainRoutesApi {
  ApiClient apiClient;

  BlockchainRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// Get the current height of the chain
  ///
  /// Returns the current height of the blockchain.
  Future<Height> GetBlockchainHeight() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/chain/height".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await this.apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      var resp =
          this.apiClient.deserialize(response.body, 'HeightDTO') as _HeightDTO;
      return new Height.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get block information
  ///
  /// Gets a block from the chain that has the given height.
  Future<BlockInfo> GetBlockByHeight(BigInt height) async {
    Object postBody = null;

    // verify required params are set
    if (height == null) {
      throw new ApiException(400, "Missing required param: height");
    }

    // create path and map variables
    String path = "/block/{height}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "height" + "}", height.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      var resp =
          apiClient.deserialize(response.body, 'BlockInfoDTO') as _blockInfoDTO;
      return new BlockInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get the current score of the chain
  ///
  /// Gets the current score of the blockchain.
  /// The higher the score, the better the chain.
  /// During synchronization, nodes try to get the best blockchain in the network.
  /// The score for a block is derived from its difficulty and the time (in seconds)
  /// that has elapsed since the last block:
  /// block score &#x3D; difficulty − time elasped since last block
  Future<BlockchainScore> GetBlockchainScore() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/chain/score".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = apiClient.deserialize(response.body, '_blockchainScoreDTO')
          as _blockchainScoreDTO;
      return BlockchainScore.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get the storage information
  ///
  /// Returns statistical information about the blockchain.
  Future<BlockchainStorageInfo> GetDiagnosticStorage() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/diagnostic/storage".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'BlockchainStorageInfo')
          as BlockchainStorageInfo;
    } else {
      return null;
    }
  }

  /// Get transactions from a block
  ///
  /// Returns an array of [transactions](https://nemtech.github.io/concepts/transaction.html) included in a block for a given block height.
  Future<List<Object>> GetBlockTransactions(int height,
      {int pageSize, String id}) async {
    Object postBody = null;

    // verify required params are set
    if (height == null) {
      throw new ApiException(400, "Missing required param: height");
    }

    // create path and map variables
    String path = "/block/{height}/transactions"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "height" + "}", height.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "pageSize", pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "id", id));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(response.body, 'List<Object>') as List)
          .map((item) => item as Object)
          .toList();
    } else {
      return null;
    }
  }

  /// Get blocks information
  ///
  /// Gets up to limit number of blocks after given block height.
  Future<List<BlockInfo>> GetBlocksByHeightWithLimit(
      BigInt height, limit) async {
    Object postBody = null;

    // verify required params are set
    if (height == null) {
      throw ErrNilOrZeroHeight;
    }
    if (limit == null) {
      throw ErrNilOrZeroLimit;
    }

    // create path and map variables
    String path = "/blocks/{height}/limit/{limit}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "height" + "}", height.toString())
        .replaceAll("{" + "limit" + "}", limit.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp =
          (apiClient.deserialize(response.body, 'List<BlockInfoDTO>') as List)
              .map((item) => item as _blockInfoDTO)
              .toList();
      return BlockInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }
}
