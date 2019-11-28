part of xpx_chain_sdk;

class NamespaceRoutesApi {
  NamespaceRoutesApi([_ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final _ApiClient apiClient;

  Future<List<NamespaceInfo>> buildNamespacesHierarchy(
      List<NamespaceInfo> namespaceIds) async {
    for (int i = 0; i < namespaceIds.length; i++) {
      if (namespaceIds[i].parent != null) {
        namespaceIds[i].parent = await buildNamespaceHierarchy(namespaceIds[i]);
      }
    }
    return namespaceIds;
  }

  Future<NamespaceInfo> buildNamespaceHierarchy(NamespaceInfo namespaceId) =>
      getNamespace(namespaceId.parent.namespaceId);

  /// Get namespace information
  ///
  /// Gets a [NamespaceInfo] for a given namespaceId.
  Future<NamespaceInfo> getNamespace(NamespaceId namespaceId) async {
    // verify required params are set
    if (namespaceId == null) {
      throw ApiException(400, 'Missing required param: namespaceId');
    }

    final nsId = namespaceId.toHex();

    // create path and map variables
    final String path = '/namespace/{namespaceId}'
        .replaceAll('{format}', 'json')
        .replaceAll('{namespaceId}', nsId);

    final response = await apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = apiClient.deserialize(response.body, '_NamespaceInfoDTO');
      final ns = NamespaceInfo._fromDTO(resp);

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
  Future<List<NamespaceInfo>> getNamespacesFromAccount(Address accountIds,
      {int pageSize, String id}) async {
    // verify required params are set
    if (accountIds == null) {
      throw ApiException(400, 'Missing required param: accountId');
    }

    // create path and map variables
    final String path = '/account/{accountId}/namespaces'
        .replaceAll('{format}', 'json')
        .replaceAll('{accountId}', accountIds.address);

    // query params
    final List<QueryParam> queryParams = [];
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }

    final response = await apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = apiClient
          .deserialize(response.body, 'List<_NamespaceInfoDTO>')
          .map((item) => item)
          .toList();
      final nss = NamespaceInfo.listFromDTO(resp);

      return buildNamespacesHierarchy(nss);
    } else {
      return null;
    }
  }

  /// Get namespaces for given List of addresses
  ///
  /// Gets namespaces for a given List of addresses.
  Future<List<NamespaceInfo>> getNamespacesFromAccounts(List<Address> addresses,
      {int pageSize, String id}) async {
    final Object postBody = Addresses.fromList(addresses);

    // verify required params are set
    if (addresses == null) {
      throw ApiException(400, 'Missing required param: addresses');
    }

    // create path and map variables
    final String path = '/account/namespaces'.replaceAll('{format}', 'json');

    // query params
    final List<QueryParam> queryParams = [];
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }

    final response = await apiClient.post(path, postBody, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = apiClient
          .deserialize(response.body, 'List<_NamespaceInfoDTO>')
          .map((item) => item)
          .toList();

      final nss = NamespaceInfo.listFromDTO(resp);

      return buildNamespacesHierarchy(nss);
    } else {
      return null;
    }
  }

  /// Get readable names for a set of namespaces
  ///
  /// Returns a [NamespaceName] friendly names for mosaics.
  Future<List<NamespaceName>> getNamespacesNames(
      List<NamespaceId> nsIds) async {
    final Object postBody = NamespaceIds.fromList(nsIds);

    // verify required params are set
    if (nsIds == null) {
      throw ApiException(400, 'Missing required param: namespaceIds');
    }

    if (nsIds.isEmpty) {
      throw _errEmptyNamespaceIds;
    }
    // create path and map variables
    final String path = '/namespace/names'.replaceAll('{format}', 'json');

    final response = await apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = List<_NamespaceNameDTO>.from(apiClient
          .deserialize(response.body, 'List<_NamespaceNameDTO>')
          .map((item) => item)
          .toList());

      final g = NamespaceName.listFromDTO(resp);
      return g;
    } else {
      return null;
    }
  }
}
