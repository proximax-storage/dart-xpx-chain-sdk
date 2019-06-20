part of xpx_chain_sdk;

class TransactionRoutesApi {
  TransactionRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Announce a  transaction
  ///
  /// Announces a transaction to the network.
  Future<Object> AnnounceTransaction(SignedTransaction tx) async {
    Object postBody = tx;

    // verify required params are set
    if (tx == null) {
      throw  ApiException(400, "Missing required param: payload");
    }

    // create path and map variables
    String path = "/transaction".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp =  http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'PUT', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw  ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'String');
    } else {
      return null;
    }
  }

  /// Get transaction information
  ///
  /// Returns a [Transaction] information given a transactionId or hash.
  Future<Transaction> GetTransaction(String transactionId) async {
    Object postBody;

    // verify required params are set
    if (transactionId == null) {
      throw  ApiException(400, "Missing required param: transactionId");
    }

    // create path and map variables
    String path = "/transaction/{transactionId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "transactionId" + "}", transactionId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp =  http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);
    if (response.statusCode >= 400) {
      throw  ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return deserializeDTO(
          apiClient.deserialize(response.body, 'Transaction'));
    } else {
      return null;
    }
  }

  /// Get transactions information
  ///
  /// Returns a List of [Transaction] information for a given List of transactionIds.
  Future<List<Transaction>> GetTransactions(
      TransactionIds transactionIds) async {
    Object postBody = transactionIds;

    // verify required params are set
    if (transactionIds == null) {
      throw  ApiException(400, "Missing required param: transactionIds");
    }

    // create path and map variables
    String path = "/transaction".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp =  http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw  ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp =
          (apiClient.deserialize(response.body, 'List<Transaction>') as List)
              .map((dynamic item) => item as Object)
              .toList();
      return resp.map((t) => deserializeDTO(t)).toList();
    } else {
      return null;
    }
  }

  /// Get transaction status
  ///
  /// Returns the transaction status for a given hash.
  Future<TransactionStatus> GetTransactionStatus(String hash) async {
    Object postBody;

    // verify required params are set
    if (hash == null) {
      throw  ApiException(400, "Missing required param: hash");
    }

    // create path and map variables
    String path = "/transaction/{hash}/status"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "hash" + "}", hash.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp =  http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw  ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'TransactionStatus')
          as TransactionStatus;
    } else {
      return null;
    }
  }

  /// Get transactions status.
  ///
  /// Returns an List of transaction statuses for a given List of transaction hashes.
  Future<List<TransactionStatus>> GetTransactionsStatuses(
      List<String> transactionHashes) async {


    Object postBody = TransactionHashes.fromList(transactionHashes);

    // verify required params are set
    if (transactionHashes == null) {
      throw  ApiException(400, "Missing required param: transactionHashes");
    }

    // create path and map variables
    String path = "/transaction/statuses".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp =  http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw  ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(
              response.body, 'List<TransactionStatus>') as List)
          .map((dynamic item) => item as TransactionStatus)
          .toList();
    } else {
      return null;
    }
  }
}
