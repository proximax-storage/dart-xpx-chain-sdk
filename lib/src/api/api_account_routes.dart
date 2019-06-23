part of xpx_chain_sdk;

class AccountRoutesApi {
  AccountRoutesApi([ApiClient _apiClient])
      : _apiClient = _apiClient ?? defaultApiClient;

  final ApiClient _apiClient;

  /// Get account information
  ///
  /// Returns the account information.
  Future<AccountInfo> getAccountInfo(Address address) async {
    Object postBody;

    // verify required params are set
    if (address.address == null) {
      throw ApiException(400, 'Missing required param: accountId');
    }

    // create path and map variables
    final String path = '/account/{accountId}'
        .replaceAll('{format}', 'json')
        .replaceAll('{accountId}', address.address);

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
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, '_AccountInfoDTO');
      return AccountInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get accounts information
  ///
  /// Returns the account information for an List of accounts.
  Future<List<AccountInfo>> getAccountsInfo(List<String> addresses) async {
    // verify required params are set
    if (addresses == null) {
      throw ApiException(400, 'Missing required param: addresses');
    }

    Object postBody = Addresses.fromList(addresses);

    // create path and map variables
    final String path = '/account'.replaceAll('{format}', 'json');

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
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = _apiClient
          .deserialize(response.body, 'List<_AccountInfoDTO>')
          .map((item) => item)
          .toList();
      return resp.map((t) => AccountInfo.fromDTO(t)).toList();
    } else {
      return null;
    }
  }

  /// Get multisig account information
  ///
  /// Returns the [MultisigAccountInfo] information.
  Future<MultisigAccountInfo> getAccountMultisig(Address address) async {
    Object postBody;

    // verify required params are set
    if (address == null) {
      throw ApiException(400, 'Missing required param: address');
    }

    // create path and map variables
    final String path = '/account/{accountId}/multisig'
        .replaceAll('{format}', 'json')
        .replaceAll('{accountId}', address.address);

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
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'MultisigAccountInfo');
    } else {
      return null;
    }
  }

  /// Get multisig account graph information
  ///
  /// Returns list [MultisigAccountGraphInfo] graph.
  Future<List<MultisigAccountGraphInfo>> getAccountMultisigGraph(
      Address address) async {
    Object postBody;

    // verify required params are set
    if (address == null) {
      throw ApiException(400, 'Missing required param: accountId');
    }

    // create path and map variables
    final String path = '/account/{accountId}/multisig/graph'
        .replaceAll('{format}', 'json')
        .replaceAll('{accountId}', address.address);

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
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return (_apiClient.deserialize(
              response.body, 'List<MultisigAccountGraphInfo>'))
          .map((item) => item)
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
  Future<List<Transaction>> incomingTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw ApiException(400, 'Missing required param: publicKey');
    }

    // create path and map variables
    final String path = '/account/{publicKey}/transactions/incoming'
        .replaceAll('{format}', 'json')
        .replaceAll('{publicKey}', account.publicKey.toString());

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = (_apiClient.deserialize(response.body, 'List<Transaction>'))
          .map((item) => item)
          .toList();
      return resp.map(_deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get outgoing transactions
  ///
  /// Gets an List of outgoing transactions.
  /// A transaction is said to be outgoing with respect to an
  /// account if the account is the sender of the transaction.
  Future<List<Transaction>> outgoingTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw ApiException(400, 'Missing required param: publicKey');
    }

    // create path and map variables
    final String path = '/account/{publicKey}/transactions/outgoing'
        .replaceAll('{format}', 'json')
        .replaceAll('{publicKey}', account.publicKey.toString());

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = (_apiClient.deserialize(response.body, 'List<Transaction>'))
          .map((item) => item)
          .toList();
      return resp.map(_deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get aggregate bonded transactions information
  ///
  /// Gets an List of [aggregate bonded transactions] where the account is
  /// the sender or requires to cosign the transaction.
  Future<List<Transaction>> partialTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw ApiException(400, 'Missing required param: publicKey');
    }

    // create path and map variables
    final String path = '/account/{publicKey}/transactions/partial'
        .replaceAll('{format}', 'json')
        .replaceAll('{publicKey}', account.publicKey.toString());

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = (_apiClient.deserialize(response.body, 'List<Transaction>'))
          .map((item) => item)
          .toList();
      return resp.map(_deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get confirmed transactions
  ///
  /// Gets an List of transactions for which an account
  /// is the sender or receiver.
  Future<List<Transaction>> transactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw ApiException(400, 'Missing required param: publicKey');
    }

    // create path and map variables
    final String path = '/account/{publicKey}/transactions'
        .replaceAll('{format}', 'json')
        .replaceAll('{publicKey}', account.publicKey.toString());

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = (_apiClient.deserialize(response.body, 'List<Transaction>'))
          .map((item) => item)
          .toList();
      return resp.map(_deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get unconfirmed transactions
  ///
  /// Gets the List of transactions not included in a block where an account
  /// is the sender or receiver.
  Future<List<Transaction>> unconfirmedTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
    Object postBody;

    // verify required params are set
    if (account == null) {
      throw ApiException(400, 'Missing required param: publicKey');
    }

    // create path and map variables
    final String path = '/account/{publicKey}/transactions/unconfirmed'
        .replaceAll('{format}', 'json')
        .replaceAll('{publicKey}', account.publicKey.toString());

    // query params
    final List<QueryParam> queryParams = [];
    final Map<String, String> headerParams = {};
    final Map<String, String> formParams = {};
    if (pageSize != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    if (contentType.startsWith('multipart/form-data')) {
      const bool hasFields = false;
      final http.MultipartRequest mp = http.MultipartRequest(null, null);

      if (hasFields) {
        {
          postBody = mp;
        }
      }
    } else {}

    final response = await _apiClient.invokeAPI(path, 'GET', queryParams,
        postBody, headerParams, formParams, contentType);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = (_apiClient.deserialize(response.body, 'List<Transaction>'))
          .map((item) => item)
          .toList();
      return resp.map(_deserializeDTO).toList();
    } else {
      return null;
    }
  }
}
