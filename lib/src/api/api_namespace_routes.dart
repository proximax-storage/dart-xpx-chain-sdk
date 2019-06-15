part of xpx_chain_sdk;

class NamespaceRoutesApi {
  final ApiClient apiClient;

  NamespaceRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  Future<List<NamespaceInfo>> buildNamespacesHierarchy(
      List<NamespaceInfo> namespaceIds) async {
    for (int i = 0; i < namespaceIds.length; i++)
      if (namespaceIds[i].parent != null) {
        namespaceIds[i].parent = await buildNamespaceHierarchy(namespaceIds[i]);
      }

    return namespaceIds;
  }

  Future<NamespaceInfo> buildNamespaceHierarchy(NamespaceInfo namespaceId) =>
      GetNamespace(namespaceId.parent.namespaceId);

  /// Get namespace information
  ///
  /// Gets a [NamespaceInfo] for a given namespaceId.
  Future<NamespaceInfo> GetNamespace(BigInt namespaceId) async {
    Object postBody = null;

    // verify required params are set
    if (namespaceId == null) {
      throw new ApiException(400, "Missing required param: namespaceId");
    }

    var nsId = bigIntegerToHex(namespaceId);

    // create path and map variables
    String path = "/namespace/{namespaceId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "namespaceId" + "}", nsId);
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
      var resp = apiClient.deserialize(response.body, '_namespaceInfoDTO')
          as _namespaceInfoDTO;
      var ns = new NamespaceInfo.fromDTO(resp);

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
  Future<List<NamespaceInfo>> GetNamespacesFromAccount(Address accountIds,
      {int pageSize, String id}) async {
    Object postBody = null;

    // verify required params are set
    if (accountIds == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}/namespaces"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", accountIds.address);

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
      var resp = (apiClient.deserialize(
              response.body, 'List<_namespaceInfoDTO>') as List)
          .map((item) => item as _namespaceInfoDTO)
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
  Future<List<NamespaceInfo>> GetNamespacesFromAccounts(Addresses addresses,
      {int pageSize, String id}) async {
    Object postBody = addresses;

    // verify required params are set
    if (addresses == null) {
      throw new ApiException(400, "Missing required param: addresses");
    }

    // create path and map variables
    String path = "/account/namespaces".replaceAll("{format}", "json");

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

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      var resp = (apiClient.deserialize(
              response.body, 'List<_namespaceInfoDTO>') as List)
          .map((item) => item as _namespaceInfoDTO)
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
  Future<List<NamespaceName>> GetNamespacesNames(NamespaceIds nsIds) async {
    Object postBody = nsIds;

    // verify required params are set
    if (nsIds == null) {
      throw new ApiException(400, "Missing required param: namespaceIds");
    }

    if (nsIds.namespaceIds.length == 0) {
      throw errEmptyNamespaceIds;
    }
    // create path and map variables
    String path = "/namespace/names".replaceAll("{format}", "json");

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

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = (apiClient.deserialize(
              response.body, 'List<_namespaceNameDTO>') as List)
          .map((item) => item as _namespaceNameDTO)
          .toList();
      return NamespaceName.listFromDTO(resp);
    } else {
      return null;
    }
  }
}
