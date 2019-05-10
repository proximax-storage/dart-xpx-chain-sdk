part of xpx_catapult_sdk;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

Client NewClient(NewConfig conf, http.Client client) {
  if (conf == null) {
    conf = new NewConfig("http://127.0.0.1:3000", MijinTest);
  }

  if (client == null) {
    client = new http.Client();
  }

  ApiClient apiClient = new ApiClient(conf, client);

  return new Client(apiClient);
}

class Client {
  final ApiClient _apiClient;
  final BlockchainRoutesApi BlockChain;
  final AccountRoutesApi Account;
  final MosaicRoutesApi Mosaic;
  final NamespaceRoutesApi Namespace;
  final NetworkRoutesApi Network;
  final NodeRoutesApi Node;
  final TransactionRoutesApi Transaction;

  Client(this._apiClient)
      : BlockChain = new BlockchainRoutesApi(_apiClient),
        Account = new AccountRoutesApi(_apiClient),
        Mosaic = new MosaicRoutesApi(_apiClient),
        Namespace = new NamespaceRoutesApi(_apiClient),
        Network = new NetworkRoutesApi(_apiClient),
        Node = new NodeRoutesApi(_apiClient),
        Transaction = new TransactionRoutesApi(_apiClient);
}

class ApiClient {
  NewConfig conf;
  var client = new http.Client();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient(this.conf, this.client) {
    // Setup authentications (key: authentication name, value: authentication).
  }

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case '_accountDTO':
          return new _accountDTO.fromJson(value);
        case '_accountInfoDTO':
          return new _accountInfoDTO.fromJson(value);
        case '_accountMetaDTO':
          return new _accountMetaDTO.fromJson(value);
        case 'AccountPropertiesDTO':
          return new AccountPropertiesDTO.fromJson(value);
        case 'AccountPropertiesInfoDTO':
          return new AccountPropertiesInfoDTO.fromJson(value);
        case 'AccountPropertiesMetaDTO':
          return new AccountPropertiesMetaDTO.fromJson(value);
        case 'AccountPropertyDTO':
          return new AccountPropertyDTO.fromJson(value);
        case 'Addresses':
          return new Addresses.fromJson(value);
        case 'AliasDTO':
          return new AliasDTO.fromJson(value);
        case 'AnnounceTransactionInfoDTO':
          return new AnnounceTransactionInfoDTO.fromJson(value);
        case 'BlockDTO':
          return new _BlockDTO.fromJson(value);
        case 'BlockInfoDTO':
          return new _BlockInfoDTO.fromJson(value);
        case 'BlockMetaDTO':
          return new _BlockMetaDTO.fromJson(value);
        case 'BlockchainScoreDTO':
          return new BlockchainScoreDTO.fromJson(value);
        case 'BlockchainStorageInfoDTO':
          return new BlockchainStorageInfoDTO.fromJson(value);
        case 'CommunicationTimestamps':
          return new CommunicationTimestamps.fromJson(value);
        case 'HeightDTO':
          return new _HeightDTO.fromJson(value);
        case 'MerklePathItem':
          return new MerklePathItem.fromJson(value);
        case 'MerkleProofInfoDTO':
          return new MerkleProofInfoDTO.fromJson(value);
        case 'MerkleProofInfoPayload':
          return new MerkleProofInfoPayload.fromJson(value);
        case '_mosaicDTO':
          return new _mosaicDTO.fromJson(value);
        case 'MosaicDefinitionDTO':
          return new MosaicDefinitionDTO.fromJson(value);
        case 'MosaicIds':
          return new MosaicIds.fromJson(value);
        case 'MosaicInfoDTO':
          return new MosaicInfoDTO.fromJson(value);
        case 'MosaicMetaDTO':
          return new MosaicMetaDTO.fromJson(value);
        case 'MosaicNameDTO':
          return new MosaicNameDTO.fromJson(value);
        case 'MosaicPropertiesDTO':
          return new MosaicPropertiesDTO.fromJson(value);
        case 'MultisigAccountGraphInfoDTO':
          return new MultisigAccountGraphInfoDTO.fromJson(value);
        case 'MultisigAccountInfoDTO':
          return new MultisigAccountInfoDTO.fromJson(value);
        case 'MultisigDTO':
          return new MultisigDTO.fromJson(value);
        case '_namespaceDTO':
          return new _namespaceDTO.fromJson(value);
        case 'NamespaceIds':
          return new NamespaceIds.fromJson(value);
        case '_namespaceInfoDTO':
          return new _namespaceInfoDTO.fromJson(value);
        case '_namespaceMetaDTO':
          return new _namespaceMetaDTO.fromJson(value);
        case 'NamespaceNameDTO':
          return new NamespaceNameDTO.fromJson(value);
        case 'NetworkTypeDTO':
          return new NetworkTypeDTO.fromJson(value);
        case 'NodeInfoDTO':
          return new NodeInfoDTO.fromJson(value);
        case 'NodeTimeDTO':
          return new NodeTimeDTO.fromJson(value);
        case 'TransactionHashes':
          return new TransactionHashes.fromJson(value);
        case 'TransactionIds':
          return new TransactionIds.fromJson(value);
        case 'TransactionPayload':
          return new TransactionPayload.fromJson(value);
        case 'TransactionStatusDTO':
          return new TransactionStatusDTO.fromJson(value);
        case 'UInt64DTO':
          return new UInt64DTO.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw new ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    throw new ApiException(
        500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return jsonVal;

    var decodedJson = json.decode(jsonVal);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<http.Response> invokeAPI(
      String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object body,
      Map<String, String> headerParams,
      Map<String, String> formParams,
      String contentType,
      List<String> authNames) async {
    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams
        .where((p) => p.value != null)
        .map((p) => '${p.name}=${p.value}');
    String queryString = ps.isNotEmpty ? '?' + ps.join('&') : '';

    String url = conf.baseUrl + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if (body is http.MultipartRequest) {
      var request = new http.MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return http.Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded"
          ? formParams
          : serialize(body);

      switch (method) {
        case "POST":
          return client.post(url, headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: headerParams);
        case "PATCH":
          return client.patch(url, headers: headerParams, body: msgBody);
        default:
          var response = client.get(url, headers: headerParams);
          return response;
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames,
      List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null)
        throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }
}
