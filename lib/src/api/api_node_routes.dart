/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class NodeRoutesApi {
  NodeRoutesApi(this._apiClient);

  final _ApiClient _apiClient;

  static const _nodeInfoRoute = '/node/info';
  static const _nodeTimeRoute = '/node/time';
  static const _nodePeersRoute = '/node/peers';

  /// Get the node information
  ///
  /// Supplies additional information about the application running on a node.
  Future<NodeInfo?> getNodeInfo() async {
    // create path and map variables
    const String path = _nodeInfoRoute;

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'NodeInfo');
    } else {
      return null;
    }
  }

  /// Get the node time
  ///
  /// Supplies additional information about the application running on a node.
  Future<NodeTime?> getNodeTime() async {
    // create path and map variables
    const String path = _nodeTimeRoute;

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient.deserialize(response.data, 'NodeTime');
    } else {
      return null;
    }
  }

  Future<List<NodeInfo>> getNodePeers() async {
    // create path and map variables
    const String path = _nodePeersRoute;

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _apiClient
          .deserialize(response.data, 'List<NodeInfo>')
          .cast<NodeInfo>();
    } else {
      return [];
    }
  }
}
