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
    final String path = '/network'.replaceAll('{format}', 'json');

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        postBody = mp;
      }
    } else {}

    final response = await apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'NetworkTypeDTO');
    } else {
      return null;
    }
  }
}
