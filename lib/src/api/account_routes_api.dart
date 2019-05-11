part of xpx_catapult_sdk;

class AccountRoutesApi {
  final ApiClient _apiClient;

  AccountRoutesApi([ApiClient _apiClient])
      : _apiClient = _apiClient ?? defaultApiClient;

  /// Get account information
  ///
  /// Returns the account information.
  Future<AccountInfo> GetAccountInfo(Address address) async {
    Object postBody = null;

    // verify required params are set
    if (address.address == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", address.address);

    print(path);
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

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, '_accountInfoDTO')
          as _accountInfoDTO;
      return AccountInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get multisig account information
  ///
  /// Returns the [multisig account](https://nemtech.github.io/concepts/multisig-account.html) information.
  Future<MultisigAccountInfoDTO> getAccountMultisig(String accountId) async {
    Object postBody = null;

    // verify required params are set
    if (accountId == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}/multisig"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", accountId.toString());

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

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'MultisigAccountInfoDTO')
          as MultisigAccountInfoDTO;
    } else {
      return null;
    }
  }

  /// Get multisig account graph information
  ///
  /// Returns the [multisig account](https://nemtech.github.io/concepts/multisig-account.html) graph.
  Future<List<MultisigAccountGraphInfoDTO>> getAccountMultisigGraph(
      String accountId) async {
    Object postBody = null;

    // verify required params are set
    if (accountId == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}/multisig/graph"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", accountId.toString());

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

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(
              response.body, 'List<MultisigAccountGraphInfoDTO>') as List)
          .map((item) => item as MultisigAccountGraphInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get account configurable properties information
  ///
  /// Returns the [configurable properties](https://nemtech.github.io/concepts/account-filter.html) for a given account.
  Future<AccountPropertiesInfoDTO> getAccountProperties(
      String accountId) async {
    Object postBody = null;

    // verify required params are set
    if (accountId == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/properties/{accountId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", accountId.toString());

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

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'AccountPropertiesInfoDTO')
          as AccountPropertiesInfoDTO;
    } else {
      return null;
    }
  }

  /// Get account properties for given array of addresses
  ///
  /// Returns the [configurable properties](https://nemtech.github.io/concepts/account-filter.html) for a given array of addresses.
  Future<List<AccountPropertiesInfoDTO>> getAccountPropertiesFromAccounts(
      Addresses addresses) async {
    Object postBody = addresses;

    // verify required params are set
    if (addresses == null) {
      throw new ApiException(400, "Missing required param: addresses");
    }

    // create path and map variables
    String path = "/account/properties".replaceAll("{format}", "json");

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

    var response = await _apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(
              response.body, 'List<AccountPropertiesInfoDTO>') as List)
          .map((item) => item as AccountPropertiesInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get accounts information
  ///
  /// Returns the account information for an array of accounts.
  Future<List<_accountInfoDTO>> getAccountsInfo(Addresses addresses) async {
    Object postBody = addresses;

    // verify required params are set
    if (addresses == null) {
      throw new ApiException(400, "Missing required param: addresses");
    }

    // create path and map variables
    String path = "/account".replaceAll("{format}", "json");

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

    var response = await _apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(response.body, 'List<_accountInfoDTO>')
              as List)
          .map((item) => item as _accountInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get incoming transactions
  ///
  /// Gets an array of incoming transactions. A transaction is said to be incoming with respect to an account if the account is the recipient of the transaction.
  Future<List<Object>> incomingTransactions(String publicKey,
      {int pageSize, String id, String ordering}) async {
    Object postBody = null;

    // verify required params are set
    if (publicKey == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/incoming"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", publicKey.toString());

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
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "ordering", ordering));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(response.body, 'List<Object>') as List)
          .map((item) => item as Object)
          .toList();
    } else {
      return null;
    }
  }

  /// Get outgoing transactions
  ///
  /// Gets an array of outgoing transactions. A transaction is said to be outgoing with respect to an account if the account is the sender of the transaction.
  Future<List<Object>> outgoingTransactions(String publicKey,
      {int pageSize, String id, String ordering}) async {
    Object postBody = null;

    // verify required params are set
    if (publicKey == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/outgoing"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", publicKey.toString());

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
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "ordering", ordering));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(response.body, 'List<Object>') as List)
          .map((item) => item as Object)
          .toList();
    } else {
      return null;
    }
  }

  /// Get aggregate bonded transactions information
  ///
  /// Gets an array of [aggregate bonded transactions](https://nemtech.github.io/concepts/aggregate-transaction.html) where the account is the sender or requires to cosign the transaction.
  Future<List<Object>> partialTransactions(String publicKey,
      {int pageSize, String id, String ordering}) async {
    Object postBody = null;

    // verify required params are set
    if (publicKey == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/partial"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", publicKey.toString());

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
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "ordering", ordering));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(response.body, 'List<Object>') as List)
          .map((item) => item as Object)
          .toList();
    } else {
      return null;
    }
  }

  /// Get confirmed transactions
  ///
  /// Gets an array of transactions for which an account is the sender or receiver.
  Future<List<Object>> transactions(String publicKey,
      {int pageSize, String id, String ordering}) async {
    Object postBody = null;

    // verify required params are set
    if (publicKey == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", publicKey.toString());

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
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "ordering", ordering));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(response.body, 'List<Object>') as List)
          .map((item) => item as Object)
          .toList();
    } else {
      return null;
    }
  }

  /// Get unconfirmed transactions
  ///
  /// Gets the array of transactions not included in a block where an account is the sender or receiver.
  Future<List<Object>> unconfirmedTransactions(String publicKey,
      {int pageSize, String id, String ordering}) async {
    Object postBody = null;

    // verify required params are set
    if (publicKey == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/unconfirmed"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", publicKey.toString());

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
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "ordering", ordering));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      http.MultipartRequest mp = new http.MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(response.body, 'List<Object>') as List)
          .map((item) => item as Object)
          .toList();
    } else {
      return null;
    }
  }
}
