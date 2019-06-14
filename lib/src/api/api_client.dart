part of xpx_chain_sdk;

final _RegList = new RegExp(r'^List<(.*)>$');
final _RegMap = new RegExp(r'^Map<String,(.*)>$');

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

  ApiClient(this.conf, this.client);

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
        case '_aliasDTO':
          return new _aliasDTO.fromJson(value);
        case 'AnnounceTransactionInfoDTO':
          return new AnnounceTransactionInfoDTO.fromJson(value);
        case 'BlockDTO':
          return new _blockDTO.fromJson(value);
        case 'BlockInfoDTO':
          return new _blockInfoDTO.fromJson(value);
        case 'BlockMetaDTO':
          return new _BlockMetaDTO.fromJson(value);
        case '_blockchainScoreDTO':
          return new _blockchainScoreDTO.fromJson(value);
        case 'BlockchainStorageInfo':
          return new BlockchainStorageInfo.fromJson(value);
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
        case '_mosaicDefinitionDTO':
          return new _mosaicDefinitionDTO.fromJson(value);
        case '_mosaicInfoDTO':
          return new _mosaicInfoDTO.fromJson(value);
        case '_mosaicMetaDTO':
          return new _mosaicMetaDTO.fromJson(value);
        case '_mosaicNameDTO':
          return new _mosaicNameDTO.fromJson(value);
        case 'MultisigAccountGraphInfoDTO':
          return new MultisigAccountGraphInfoDTO.fromJson(value);
        case 'MultisigAccountInfoDTO':
          return new MultisigAccountInfoDTO.fromJson(value);
        case 'MultisigDTO':
          return new MultisigDTO.fromJson(value);
        case '_namespaceDTO':
          return new _namespaceDTO.fromJson(value);
        case '_namespaceInfoDTO':
          return new _namespaceInfoDTO.fromJson(value);
        case '_namespaceMetaDTO':
          return new _namespaceMetaDTO.fromJson(value);
        case '_namespaceNameDTO':
          return new _namespaceNameDTO.fromJson(value);
        case 'NetworkTypeDTO':
          return new NetworkType.fromJson(value);
        case 'NodeInfo':
          return new NodeInfo.fromJson(value);
        case 'NodeTime':
          return new NodeTime.fromJson(value);
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
    return null;
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    var decodedJson = json.decode(jsonVal);

     if (targetType == 'Transaction' || targetType == 'List<Transaction>') {
      return _txnDeserialize(decodedJson, targetType);
    }

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
      String contentType) async {
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
}

dynamic _txnDeserialize(dynamic value, String targetType) {
  if (targetType == 'List<Transaction>' ){
    {
      Match match;
      if (value is List &&
          (match = _RegList.firstMatch(targetType)) != null) {
        var newTargetType = match[1];

        return value.map((v) => _txnDeserialize(v, newTargetType)).toList();
      } else if (value is Map &&
          (match = _RegMap.firstMatch(targetType)) != null) {
        var newTargetType = match[1];
        return new Map.fromIterables(value.keys,
            value.values.map((v) => _txnDeserialize(v, newTargetType)));
      }
    }
  }

  targetType = mapTransaction(value);

  try {
    switch (targetType) {
      case 'Transfer':
        return new _transferTransactionInfoDTO.fromJson(value);
      case 'RegisterNamespace':
        return new _registerNamespaceTransactionInfoDTO.fromJson(value);
      case 'MosaicDefinition':
        return new _mosaicDefinitionTransactionInfoDTO.fromJson(value);
      case 'MosaicSupplyChange':
        return new _mosaicSupplyChangeTransactionInfoDTO.fromJson(value);
      case 'AggregateCompleted':
        return new _aggregateTransactionInfoDTO.fromJson(value);
      default:
        return null;
    }
  } catch (e, stack) {
    throw new ApiException.withInner(
        500, 'Exception during deserialization.', e, stack);
  }
}
