/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class NetworkRoutesApi {
  NetworkRoutesApi([HttpClient? apiClient]) : _httpClient = apiClient ?? defaultApiClient;

  final HttpClient _httpClient;

  /// Get the current network type of the chain
  ///
  /// Returns the current network type.
  Future<NetworkInfo?> getNetworkType() async {
    // create path and map variables
    const String path = '/network';

    final response = await _httpClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data != null) {
      return _httpClient.deserialize(response.data, 'NetworkInfoDTO');
    } else {
      return null;
    }
  }
}
