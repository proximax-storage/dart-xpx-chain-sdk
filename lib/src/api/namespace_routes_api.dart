part of nem2_sdk_dart;

class NamespaceRoutesApi {
  final ApiClient apiClient;

  NamespaceRoutesApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// Get namespace information
  ///
  /// Gets the namespace for a given namespaceId.
  Future<NamespaceInfoDTO> getNamespace(String namespaceId) async {
    Object postBody = null;

    // verify required params are set
    if (namespaceId == null) {
      throw new ApiException(400, "Missing required param: namespaceId");
    }

    // create path and map variables
    String path = "/namespace/{namespaceId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "namespaceId" + "}", namespaceId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'NamespaceInfoDTO')
          as NamespaceInfoDTO;
    } else {
      return null;
    }
  }

  /// Get namespaces owned by an account
  ///
  /// Gets an array of namespaces for a given account address.
  Future<List<NamespaceInfoDTO>> getNamespacesFromAccount(String accountId,
      {int pageSize, String id}) async {
    Object postBody = null;

    // verify required params are set
    if (accountId == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}/namespaces"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", accountId.toString());

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
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(response.body, 'List<NamespaceInfoDTO>')
              as List)
          .map((item) => item as NamespaceInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get namespaces for given array of addresses
  ///
  /// Gets namespaces for a given array of addresses.
  Future<List<NamespaceInfoDTO>> getNamespacesFromAccounts(Addresses addresses,
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
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(response.body, 'List<NamespaceInfoDTO>')
              as List)
          .map((item) => item as NamespaceInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get readable names for a set of namespaces
  ///
  /// Returns friendly names for mosaics.
  Future<List<NamespaceNameDTO>> getNamespacesNames(
      NamespaceIds namespaceIds) async {
    Object postBody = namespaceIds;

    // verify required params are set
    if (namespaceIds == null) {
      throw new ApiException(400, "Missing required param: namespaceIds");
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
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (apiClient.deserialize(response.body, 'List<NamespaceNameDTO>')
              as List)
          .map((item) => item as NamespaceNameDTO)
          .toList();
    } else {
      return null;
    }
  }
}
