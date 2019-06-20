part of xpx_chain_sdk;

final _RegList = new RegExp(r'^List<(.*)>$');
final _RegMap = new RegExp(r'^Map<String,(.*)>$');

class QueryParam {
  QueryParam(this.name, this.value);

  String name;
  String value;
}

Client NewClient(NewConfig conf, http.Client client) {
  if (conf == null) {
    conf = new NewConfig("http://127.0.0.1:3000", mijinTest);
  }

  if (client == null) {
    client = new http.Client();
  }

  ApiClient apiClient = new ApiClient(conf, client);

  return new Client(apiClient);
}

class Client {
  Client(this._apiClient)
      : BlockChain = new BlockchainRoutesApi(_apiClient),
        Account = new AccountRoutesApi(_apiClient),
        Mosaic = new MosaicRoutesApi(_apiClient),
        Namespace = new NamespaceRoutesApi(_apiClient),
        Network = new NetworkRoutesApi(_apiClient),
        Node = new NodeRoutesApi(_apiClient),
        Transaction = new TransactionRoutesApi(_apiClient);

  final ApiClient _apiClient;
  final BlockchainRoutesApi BlockChain;
  final AccountRoutesApi Account;
  final MosaicRoutesApi Mosaic;
  final NamespaceRoutesApi Namespace;
  final NetworkRoutesApi Network;
  final NodeRoutesApi Node;
  final TransactionRoutesApi Transaction;
}

class ApiClient {
  ApiClient(this.conf, this.client);

  NewConfig conf;
  var client = new http.Client();

  Map<String, String> _defaultHeaderMap = {};

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
        case '_AccountDTO':
          return new _AccountDTO.fromJson(value as Map<String, dynamic>);
        case '_AccountInfoDTO':
          return new _AccountInfoDTO.fromJson(value as Map<String, dynamic>);
        case '_AccountMetaDTO':
          return new _AccountMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_AccountPropertiesDTO':
          return new _AccountPropertiesDTO.fromJson(
              value as Map<String, dynamic>);
        case '_AccountPropertiesInfoDTO':
          return new _AccountPropertiesInfoDTO.fromJson(
              value as Map<String, dynamic>);
        case '_AccountPropertiesMetaDTO':
          return new _AccountPropertiesMetaDTO.fromJson(
              value as Map<String, dynamic>);
        case 'AccountPropertyDTO':
          return new AccountPropertyDTO.fromJson(value as Map<String, dynamic>);
        case 'Addresses':
          return new Addresses.fromJson(value as Map<String, dynamic>);
        case '_AliasDTO':
          return new _AliasDTO.fromJson(value as Map<String, dynamic>);
        case 'AnnounceTransactionInfoDTO':
          return new AnnounceTransactionInfoDTO.fromJson(
              value as Map<String, dynamic>);
        case 'BlockDTO':
          return new _BlockDTO.fromJson(value as Map<String, dynamic>);
        case 'BlockInfoDTO':
          return new _BlockInfoDTO.fromJson(value as Map<String, dynamic>);
        case 'BlockMetaDTO':
          return new _BlockMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_BlockchainScoreDTO':
          return new _BlockchainScoreDTO.fromJson(
              value as Map<String, dynamic>);
        case 'BlockchainStorageInfo':
          return new BlockchainStorageInfo.fromJson(
              value as Map<String, dynamic>);
        case 'CommunicationTimestamps':
          return new CommunicationTimestamps.fromJson(
              value as Map<String, dynamic>);
        case 'HeightDTO':
          return new _HeightDTO.fromJson(value as Map<String, dynamic>);
        case 'MerklePathItem':
          return new MerklePathItem.fromJson(value as Map<String, dynamic>);
        case '_MerkleProofInfoDTO':
          return new _MerkleProofInfoDTO.fromJson(
              value as Map<String, dynamic>);
        case 'MerkleProofInfoPayload':
          return new MerkleProofInfoPayload.fromJson(
              value as Map<String, dynamic>);
        case '_MosaicDTO':
          return new _MosaicDTO.fromJson(value as Map<String, dynamic>);
        case '_MosaicDefinitionDTO':
          return new _MosaicDefinitionDTO.fromJson(
              value as Map<String, dynamic>);
        case '_MosaicInfoDTO':
          return new _MosaicInfoDTO.fromJson(value as Map<String, dynamic>);
        case '_MosaicMetaDTO':
          return new _MosaicMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_MosaicNameDTO':
          return new _MosaicNameDTO.fromJson(value as Map<String, dynamic>);
        case 'MultisigAccountGraphInfo':
          return new MultisigAccountGraphInfo.fromJson(
              value as Map<String, dynamic>);
        case 'MultisigAccountInfo':
          return new MultisigAccountInfo.fromJson(
              value as Map<String, dynamic>);
        case 'Multisig':
          return new Multisig.fromJson(value as Map<String, dynamic>);
        case '_NamespaceDTO':
          return new _NamespaceDTO.fromJson(value as Map<String, dynamic>);
        case '_NamespaceInfoDTO':
          return new _NamespaceInfoDTO.fromJson(value as Map<String, dynamic>);
        case '_NamespaceMetaDTO':
          return new _NamespaceMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_NamespaceNameDTO':
          return new _NamespaceNameDTO.fromJson(value as Map<String, dynamic>);
        case 'NetworkTypeDTO':
          return new NetworkType.fromJson(value as Map<String, dynamic>);
        case 'NodeInfo':
          return new NodeInfo.fromJson(value as Map<String, dynamic>);
        case 'NodeTime':
          return new NodeTime.fromJson(value as Map<String, dynamic>);
        case 'TransactionHashes':
          return new TransactionHashes.fromJson(value as Map<String, dynamic>);
        case 'TransactionIds':
          return new TransactionIds.fromJson(value as Map<String, dynamic>);
        case 'TransactionPayload':
          return new TransactionPayload.fromJson(value as Map<String, dynamic>);
        case '_TransactionStatusDTO':
          return new _TransactionStatusDTO.fromJson(
              value as Map<String, dynamic>);
        case 'UInt64DTO':
          return new UInt64DTO.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value
                  .map((dynamic v) => _deserialize(v, newTargetType))
                  .toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(
                  value.keys,
                  value.values
                      .map((dynamic v) => _deserialize(v, newTargetType)));
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

    final dynamic decodedJson = json.decode(jsonVal);

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
  if (targetType == 'List<Transaction>') {
    {
      Match match;
      if (value is List && (match = _RegList.firstMatch(targetType)) != null) {
        var newTargetType = match[1];

        return value
            .map((dynamic v) => _txnDeserialize(v, newTargetType))
            .toList();
      } else if (value is Map &&
          (match = _RegMap.firstMatch(targetType)) != null) {
        var newTargetType = match[1];
        return new Map.fromIterables(value.keys,
            value.values.map((dynamic v) => _txnDeserialize(v, newTargetType)));
      }
    }
  }

  targetType = mapTransaction(value);

  try {
    switch (targetType) {
      case 'Transfer':
        return new _TransferTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'RegisterNamespace':
        return new _RegisterNamespaceTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'MosaicDefinition':
        return new _MosaicDefinitionTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'MosaicSupplyChange':
        return new _MosaicSupplyChangeTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'AggregateCompleted':
        return new _AggregateTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      default:
        return null;
    }
  } catch (e, stack) {
    throw new ApiException.withInner(
        500, 'Exception during deserialization.', e as Exception, stack);
  }
}
