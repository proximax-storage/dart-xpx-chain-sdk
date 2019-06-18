part of xpx_chain_sdk;

class NodeRoutesApi {

  NodeRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get the node information
  ///
  /// Supplies additional information about the application running on a node.
  Future<NodeInfo> GetNodeInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/node/info".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      return apiClient.deserialize(response.body, 'NodeInfo') as NodeInfo;
    } else {
      return null;
    }
  }

  /// Get the node time
  ///
  /// Supplies additional information about the application running on a node.
  Future<NodeTime> GetNodeTime() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/node/time".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      return apiClient.deserialize(response.body, 'NodeTime') as NodeTime;
    } else {
      return null;
    }
  }
}
