part of xpx_chain_sdk;

class AccountRoutesApi {
  AccountRoutesApi([ApiClient _apiClient])
      : _apiClient = _apiClient ?? defaultApiClient;

  final ApiClient _apiClient;

  /// Get account information
  ///
  /// Returns the account information.
  Future<AccountInfo> GetAccountInfo(Address address) async {
    Object postBody;

    // verify required params are set
    if (address.address == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", address.address);

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp = _apiClient.deserialize(response.body, '_AccountInfoDTO')
          as _AccountInfoDTO;
      return AccountInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get accounts information
  ///
  /// Returns the account information for an List of accounts.
  Future<List<AccountInfo>> GetAccountsInfo(Addresses addresses) async {
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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp = (_apiClient.deserialize(
              response.body, 'List<_AccountInfoDTO>') as List)
          .map((dynamic item) => item as Object)
          .toList();
      return resp
          .map((t) => AccountInfo.fromDTO(t as _AccountInfoDTO))
          .toList();
    } else {
      return null;
    }
  }

  /// Get multisig account information
  ///
  /// Returns the [multisig account] information.
  Future<MultisigAccountInfo> GetAccountMultisig(Address address) async {
    Object postBody;

    // verify required params are set
    if (address == null) {
      throw new ApiException(400, "Missing required param: address");
    }

    // create path and map variables
    String path = "/account/{accountId}/multisig"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", address.address);

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      return _apiClient.deserialize(response.body, 'MultisigAccountInfo')
          as MultisigAccountInfo;
    } else {
      return null;
    }
  }

  /// Get multisig account graph information
  ///
  /// Returns the [multisig account] graph.
  Future<List<MultisigAccountGraphInfo>> GetAccountMultisigGraph(
      Address address) async {
    Object postBody;

    // verify required params are set
    if (address == null) {
      throw new ApiException(400, "Missing required param: accountId");
    }

    // create path and map variables
    String path = "/account/{accountId}/multisig/graph"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "accountId" + "}", address.address);

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
              response.body, 'List<MultisigAccountGraphInfo>') as List)
          .map((dynamic item) => item as MultisigAccountGraphInfo)
          .toList();
    } else {
      return null;
    }
  }

  /// Get account configurable properties information
  ///
  /// Returns the [configurable properties] for a given account.
  Future<_AccountPropertiesInfoDTO> _getAccountProperties(
      String accountId) async {
    Object postBody;

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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      return _apiClient.deserialize(response.body, '_AccountPropertiesInfoDTO')
          as _AccountPropertiesInfoDTO;
    } else {
      return null;
    }
  }

  /// Get account properties for given array of addresses
  ///
  /// Returns the [configurable properties] for a given array of addresses.
  Future<List<_AccountPropertiesInfoDTO>> _getAccountPropertiesFromAccounts(
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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
              response.body, 'List<_AccountPropertiesInfoDTO>') as List)
          .map((dynamic item) => item as _AccountPropertiesInfoDTO)
          .toList();
    } else {
      return null;
    }
  }

  /// Get incoming transactions
  ///
  /// Gets an List of incoming transactions.
  /// A transaction is said to be incoming with respect to an
  /// account if the account is the recipient of the transaction.
  Future<List<Transaction>> IncomingTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/incoming"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", account.publicKey.toString());

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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp =
          (_apiClient.deserialize(response.body, 'List<Transaction>') as List)
              .map((dynamic item) => item as Object)
              .toList();
      return resp.map((t) => deserializeDTO(t)).toList();
    } else {
      return null;
    }
  }

  /// Get outgoing transactions
  ///
  /// Gets an List of outgoing transactions.
  /// A transaction is said to be outgoing with respect to an
  /// account if the account is the sender of the transaction.
  Future<List<Transaction>> OutgoingTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/outgoing"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", account.publicKey.toString());

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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp =
          (_apiClient.deserialize(response.body, 'List<Transaction>') as List)
              .map((dynamic item) => item as Object)
              .toList();
      return resp.map((t) => deserializeDTO(t)).toList();
    } else {
      return null;
    }
  }

  /// Get aggregate bonded transactions information
  ///
  /// Gets an List of [aggregate bonded transactions] where the account is
  /// the sender or requires to cosign the transaction.
  Future<List<Transaction>> PartialTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/partial"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", account.publicKey.toString());

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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp =
          (_apiClient.deserialize(response.body, 'List<Transaction>') as List)
              .map((dynamic item) => item as Object)
              .toList();
      return resp.map((t) => deserializeDTO(t)).toList();
    } else {
      return null;
    }
  }

  /// Get confirmed transactions
  ///
  /// Gets an List of transactions for which an account is the sender or receiver.
  Future<List<Transaction>> Transactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", account.publicKey.toString());

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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp =
          (_apiClient.deserialize(response.body, 'List<Transaction>') as List)
              .map((dynamic item) => item as Object)
              .toList();
      return resp.map((t) => deserializeDTO(t)).toList();
    } else {
      return null;
    }
  }

  /// Get unconfirmed transactions
  ///
  /// Gets the List of transactions not included in a block where an account is the sender or receiver.
  Future<List<Transaction>> UnconfirmedTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw new ApiException(400, "Missing required param: publicKey");
    }

    // create path and map variables
    String path = "/account/{publicKey}/transactions/unconfirmed"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "publicKey" + "}", account.publicKey.toString());

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
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";

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
      final resp =
          (_apiClient.deserialize(response.body, 'List<Transaction>') as List)
              .map((dynamic item) => item as Object)
              .toList();
      return resp.map((t) => deserializeDTO(t)).toList();
    } else {
      return null;
    }
  }
}
