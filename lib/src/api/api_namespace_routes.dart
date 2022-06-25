/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class NamespaceRoutesApi {
  NamespaceRoutesApi([ApiClient? _apiClient]) : _apiClient = _apiClient ?? defaultApiClient;

  final ApiClient _apiClient;

  static const _namespaceRoute = '/namespace/{namespaceId}';
  static const _namespacesFromAccountRoute = '/account/{accountId}/namespaces';
  static const _namespacesFromAccountsRoute = '/account/namespaces';
  static const _namespacesNamesRoute = '/namespace/names';

  Future<List<NamespaceInfo>> buildNamespacesHierarchy(List<NamespaceInfo> namespaceIds) async {
    for (int i = 0; i < namespaceIds.length; i++) {
      if (namespaceIds[i].parent != null) {
        namespaceIds[i].parent = await buildNamespaceHierarchy(namespaceIds[i]);
      }
    }
    return namespaceIds;
  }

  Future<NamespaceInfo?> buildNamespaceHierarchy(NamespaceInfo namespaceId) =>
      getNamespace(namespaceId.parent!.namespaceId);

  /// Get namespace information
  ///
  /// Gets a [NamespaceInfo] for a given namespaceId.
  Future<NamespaceInfo?> getNamespace(NamespaceId namespaceId) async {
    final String path = _namespaceRoute.replaceAll('{namespaceId}', namespaceId.toHex()!);

    final response = await _apiClient.get(path);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data.isNotEmpty) {
      final resp = _apiClient.deserialize(response.data, 'NamespaceInfoDTO');
      final ns = NamespaceInfo.fromDTO(resp);

      if (ns.parent != null) {
        ns.parent = await buildNamespaceHierarchy(ns);
      }
      return ns;
    } else {
      return null;
    }
  }

  /// Get namespaces owned by an account
  ///
  /// Gets an List of [NamespaceInfo] for a given account address.
  Future<List<NamespaceInfo>> getNamespacesFromAccount(Address account, {QueryParams? queryParams}) async {
    // create path and map variables
    final String path = _namespacesFromAccountRoute.replaceAll('{accountId}', account.address);

    // query params
    final List<QueryParam> _queryParams = [];
    if (queryParams != null) {
      _queryParams.addAll(queryParams.toQueryParams());
    }

    final response = await _apiClient.get(path, null, _queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data.isNotEmpty) {
      final resp = _apiClient.deserialize(response.data, 'List<NamespaceInfoDTO>').cast<NamespaceInfoDTO>();

      final nss = NamespaceInfo.listFromDTO(resp);

      return buildNamespacesHierarchy(nss);
    } else {
      return [];
    }
  }

  /// Get namespaces for given List of addresses
  ///
  /// Gets namespaces for a given List of addresses.
  Future<List<NamespaceInfo>> getNamespacesFromAccounts(List<Address> addresses, {QueryParams? queryParams}) async {
    if (addresses.isEmpty) {
      throw ApiException(400, 'addresses must not be empty');
    }

    final Object postBody = {'addresses': addresses.map((a) => a.address).toList()};

    // create path and map variables
    const String path = _namespacesFromAccountsRoute;

    final List<QueryParam> _queryParams = [];
    if (queryParams != null) {
      _queryParams.addAll(queryParams.toQueryParams());
    }

    final response = await _apiClient.post(path, postBody, _queryParams);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data.isNotEmpty) {
      final resp = _apiClient.deserialize(response.data, 'List<NamespaceInfoDTO>').cast<NamespaceInfoDTO>();

      final nss = NamespaceInfo.listFromDTO(resp);

      return buildNamespacesHierarchy(nss);
    } else {
      return [];
    }
  }

  /// Get readable names for a set of namespaces
  ///
  /// Returns a [NamespaceName] friendly names for mosaics.
  Future<List<NamespaceName>> getNamespacesNames(List<NamespaceId> nsIds) async {
    if (nsIds.isEmpty) {
      throw ApiException(400, 'nsIds must not be empty');
    }

    final Object postBody = {'namespaceIds': nsIds.map((a) => a.toHex()).toList()};

    if (nsIds.isEmpty) {
      throw errEmptyNamespaceIds;
    }
    // create path and map variables
    const String path = _namespacesNamesRoute;

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode! >= 299) {
      throw ApiException(response.statusCode!, response.data);
    } else if (response.data.isNotEmpty) {
      final resp = _apiClient.deserialize(response.data, 'List<NamespaceNameDTO>').cast<NamespaceNameDTO>();

      return NamespaceName.listFromDTO(resp);
    } else {
      return [];
    }
  }
}
