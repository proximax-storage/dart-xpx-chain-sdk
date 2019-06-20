part of xpx_chain_sdk;

class NetworkRoutesApi {
  NetworkRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get the current network type of the chain
  ///
  /// Returns the current network type.
  Future<NetworkType> getNetworkType() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/network".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'NetworkTypeDTO')
          as NetworkType;
    } else {
      return null;
    }
  }
}
