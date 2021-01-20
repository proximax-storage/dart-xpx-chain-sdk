part of xpx_chain_sdk.api;

class NodeRoutesApi {
  NodeRoutesApi([_ApiClient _apiClient]) : _apiClient = _apiClient ?? defaultApiClient;

  final _ApiClient _apiClient;

  /// Get the node information
  ///
  /// Supplies additional information about the application running on a node.
  Future<NodeInfo> getNodeInfo() async {
    // create path and map variables
    final String path = '/node/info'.replaceAll('{format}', 'json');

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'NodeInfo');
    } else {
      return null;
    }
  }

  /// Get the node time
  ///
  /// Supplies additional information about the application running on a node.
  Future<NodeTime> getNodeTime() async {
    // create path and map variables
    final String path = '/node/time'.replaceAll('{format}', 'json');

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'NodeTime');
    } else {
      return null;
    }
  }
}
