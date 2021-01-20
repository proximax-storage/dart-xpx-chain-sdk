part of xpx_chain_sdk.api;

class AccountRoutesApi {
  AccountRoutesApi([_ApiClient _apiClient]) : _apiClient = _apiClient ?? defaultApiClient;

  final _ApiClient _apiClient;

  /// Get account information
  ///
  /// Returns the account information.
  Future<AccountInfo> getAccountInfo(Address address) async {
    // verify required params are set
    if (address.address == null) {
      throw ApiException(400, 'Missing required param: accountId');
    }

    // create path and map variables
    final String path =
        '/account/{accountId}'.replaceAll('{format}', 'json').replaceAll('{accountId}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'AccountInfoDTO');
      return AccountInfo.fromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get accounts information
  ///
  /// Returns the account information for an List of accounts.
  Future<List<AccountInfo>> getAccountsInfo(List<Address> addresses) async {
    // verify required params are set
    if (addresses == null) {
      throw ApiException(400, 'Missing required param: addresses');
    }

    final Object postBody = Addresses.fromList(addresses);

    // create path and map variables
    final String path = '/account'.replaceAll('{format}', 'json');

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<AccountInfoDTO>').cast<AccountInfoDTO>();
      return AccountInfo.listFromDTO(resp);
    } else {
      return null;
    }
  }

  /// Get multisig account information
  ///
  /// Returns the [MultisigAccountInfo] information.
  Future<MultisigAccountInfo> getAccountMultisig(Address address) async {
    // verify required params are set
    if (address == null) {
      throw ApiException(400, 'Missing required param: address');
    }

    // create path and map variables
    final String path =
        '/account/{accountId}/multisig'.replaceAll('{format}', 'json').replaceAll('{accountId}', address.address);

    final response = await _apiClient.get(path);

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
  Future<List<MultisigAccountGraphInfo>> getAccountMultisigGraph(Address address) async {
    // verify required params are set
    if (address == null) {
      throw ApiException(400, 'Missing required param: accountId');
    }

    // create path and map variables
    final String path =
        '/account/{accountId}/multisig/graph'.replaceAll('{format}', 'json').replaceAll('{accountId}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return _apiClient.deserialize(response.body, 'List<MultisigAccountGraphInfo>').cast<MultisigAccountGraphInfo>();
    } else {
      return null;
    }
  }

  /// Get confirmed transactions
  ///
  /// Gets an List of transactions for which an account
  /// is the sender or receiver.
  Future<List<Transaction>> transactions(PublicAccount account, {int pageSize, String id, String ordering}) async {
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
    if (pageSize != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final response = await _apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = _apiClient.deserialize(response.body, 'List<Transaction>');
      return resp.map(deserializeDTO).toList();
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
    if (pageSize != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final response = await _apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<Transaction>');
      return resp.map(deserializeDTO).toList();
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
    if (pageSize != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final response = await _apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = _apiClient.deserialize(response.body, 'List<Transaction>');
      return resp.map(deserializeDTO).toList();
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
    if (pageSize != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final response = await _apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final List resp = _apiClient.deserialize(response.body, 'List<Transaction>');
      return resp.map(deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get aggregate bonded transactions information
  ///
  /// Gets an List of [aggregate bonded transactions] where the account is
  /// the sender or requires to cosign the transaction.
  Future<List<Transaction>> aggregateBondedTransactions(PublicAccount account,
      {int pageSize, String id, String ordering}) async {
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
    if (pageSize != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'pageSize', pageSize));
    }
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'id', id));
    }
    if (ordering != null) {
      queryParams.addAll(_convertParametersForCollectionFormat('', 'ordering', ordering));
    }

    final response = await _apiClient.get(path, queryParams);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<Transaction>').cast<Transaction>();
      return resp.map(deserializeDTO).toList();
    } else {
      return null;
    }
  }

  /// Get readable names for a set of accountIds.
  Future<List<AccountNames>> getAccountsNames(List<Address> addresses,
      {int pageSize, String id, String ordering}) async {
    final Object postBody = Addresses.fromList(addresses);

    // verify required params are set
    if (addresses.isEmpty) {
      throw ApiException(400, 'Missing required param: addresses');
    }

    // create path and map variables
    final String path = '/account/names'.replaceAll('{format}', 'json');

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<AccountNames>').cast<AccountNamesDTO>();
      return AccountNames.listFromJson(resp);
    } else {
      return null;
    }
  }

  Future<AccountProperties> getAccountProperties(Address address) async {
    // verify required params are set
    if (address == null) {
      throw ApiException(400, 'Missing required param: address');
    }

    // create path and map variables
    final String path =
        '/account/{address}/properties'.replaceAll('{format}', 'json').replaceAll('{address}', address.address);

    final response = await _apiClient.get(path);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'AccountPropertiesDTO');

      return AccountProperties.fromDto(resp);
    } else {
      return null;
    }
  }

  Future<List<AccountProperties>> getAccountsProperties(List<Address> addresses) async {
    final Object postBody = Addresses.fromList(addresses);

    // verify required params are set
    if (addresses.isEmpty) {
      throw ApiException(400, 'Missing required param: addresses');
    }

    // create path and map variables
    final String path = '/account/properties'.replaceAll('{format}', 'json');

    final response = await _apiClient.post(path, postBody);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      final resp = _apiClient.deserialize(response.body, 'List<AccountPropertiesDTO>').cast<AccountPropertiesDTO>();
      return AccountProperties.listFromJson(resp);
    } else {
      return null;
    }
  }
}
