part of xpx_chain_sdk;

final _RegList =  RegExp(r'^List<(.*)>$');
final _RegMap =  RegExp(r'^Map<String,(.*)>$');

class QueryParam {
  QueryParam(this.name, this.value);

  String name;
  String value;
}

Client NewClient(NewConfig conf, http.Client client) {
  if (conf == null) {
    conf =  NewConfig("http://127.0.0.1:3000", mijinTest);
  }

  if (client == null) {
    client =  http.Client();
  }

  ApiClient apiClient =  ApiClient(conf, client);

  return  Client(apiClient);
}

class Client {
  Client(this._apiClient)
      : BlockChain =  BlockchainRoutesApi(_apiClient),
        Account =  AccountRoutesApi(_apiClient),
        Mosaic =  MosaicRoutesApi(_apiClient),
        Namespace =  NamespaceRoutesApi(_apiClient),
        Network =  NetworkRoutesApi(_apiClient),
        Node =  NodeRoutesApi(_apiClient),
        Transaction =  TransactionRoutesApi(_apiClient);

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
  var client =  http.Client();

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
          return  _AccountDTO.fromJson(value as Map<String, dynamic>);
        case '_AccountInfoDTO':
          return  _AccountInfoDTO.fromJson(value as Map<String, dynamic>);
        case '_AccountMetaDTO':
          return  _AccountMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_AccountPropertiesDTO':
          return  _AccountPropertiesDTO.fromJson(
              value as Map<String, dynamic>);
        case '_AccountPropertiesInfoDTO':
          return  _AccountPropertiesInfoDTO.fromJson(
              value as Map<String, dynamic>);
        case '_AccountPropertiesMetaDTO':
          return  _AccountPropertiesMetaDTO.fromJson(
              value as Map<String, dynamic>);
        case 'AccountPropertyDTO':
          return  AccountPropertyDTO.fromJson(value as Map<String, dynamic>);
        case 'Addresses':
          return  Addresses.fromJson(value as Map<String, dynamic>);
        case '_AliasDTO':
          return  _AliasDTO.fromJson(value as Map<String, dynamic>);
        case 'AnnounceTransactionInfoDTO':
          return  AnnounceTransactionInfoDTO.fromJson(
              value as Map<String, dynamic>);
        case 'BlockDTO':
          return  _BlockDTO.fromJson(value as Map<String, dynamic>);
        case 'BlockInfoDTO':
          return  _BlockInfoDTO.fromJson(value as Map<String, dynamic>);
        case 'BlockMetaDTO':
          return  _BlockMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_BlockchainScoreDTO':
          return  _BlockchainScoreDTO.fromJson(
              value as Map<String, dynamic>);
        case 'BlockchainStorageInfo':
          return  BlockchainStorageInfo.fromJson(
              value as Map<String, dynamic>);
        case 'CommunicationTimestamps':
          return  CommunicationTimestamps.fromJson(
              value as Map<String, dynamic>);
        case 'HeightDTO':
          return  _HeightDTO.fromJson(value as Map<String, dynamic>);
        case 'MerklePathItem':
          return  MerklePathItem.fromJson(value as Map<String, dynamic>);
        case '_MerkleProofInfoDTO':
          return  _MerkleProofInfoDTO.fromJson(
              value as Map<String, dynamic>);
        case 'MerkleProofInfoPayload':
          return  MerkleProofInfoPayload.fromJson(
              value as Map<String, dynamic>);
        case '_MosaicDTO':
          return  _MosaicDTO.fromJson(value as Map<String, dynamic>);
        case '_MosaicDefinitionDTO':
          return  _MosaicDefinitionDTO.fromJson(
              value as Map<String, dynamic>);
        case '_MosaicInfoDTO':
          return  _MosaicInfoDTO.fromJson(value as Map<String, dynamic>);
        case '_MosaicMetaDTO':
          return  _MosaicMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_MosaicNameDTO':
          return  _MosaicNameDTO.fromJson(value as Map<String, dynamic>);
        case 'MultisigAccountGraphInfo':
          return  MultisigAccountGraphInfo.fromJson(
              value as Map<String, dynamic>);
        case 'MultisigAccountInfo':
          return  MultisigAccountInfo.fromJson(
              value as Map<String, dynamic>);
        case 'Multisig':
          return  Multisig.fromJson(value as Map<String, dynamic>);
        case '_NamespaceDTO':
          return  _NamespaceDTO.fromJson(value as Map<String, dynamic>);
        case '_NamespaceInfoDTO':
          return  _NamespaceInfoDTO.fromJson(value as Map<String, dynamic>);
        case '_NamespaceMetaDTO':
          return  _NamespaceMetaDTO.fromJson(value as Map<String, dynamic>);
        case '_NamespaceNameDTO':
          return  _NamespaceNameDTO.fromJson(value as Map<String, dynamic>);
        case 'NetworkTypeDTO':
          return  NetworkType.fromJson(value as Map<String, dynamic>);
        case 'NodeInfo':
          return  NodeInfo.fromJson(value as Map<String, dynamic>);
        case 'NodeTime':
          return  NodeTime.fromJson(value as Map<String, dynamic>);
        case 'TransactionHashes':
          return  TransactionHashes.fromJson(value as Map<String, dynamic>);
        case 'TransactionIds':
          return  TransactionIds.fromJson(value as Map<String, dynamic>);
        case 'TransactionPayload':
          return  TransactionPayload.fromJson(value as Map<String, dynamic>);
        case 'TransactionStatus':
          return  TransactionStatus.fromJson(
              value as Map<String, dynamic>);
        case 'UInt64DTO':
          return  UInt64DTO.fromJson(value);
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
              return  Map.fromIterables(
                  value.keys,
                  value.values
                      .map((dynamic v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw  ApiException.withInner(
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
      var request =  http.MultipartRequest(method, Uri.parse(url));
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
        return  Map.fromIterables(value.keys,
            value.values.map((dynamic v) => _txnDeserialize(v, newTargetType)));
      }
    }
  }

  targetType = mapTransaction(value);

  try {
    switch (targetType) {
      case 'Transfer':
        return  _TransferTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'RegisterNamespace':
        return  _RegisterNamespaceTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'MosaicDefinition':
        return  _MosaicDefinitionTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'MosaicSupplyChange':
        return  _MosaicSupplyChangeTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      case 'AggregateCompleted':
        return  _AggregateTransactionInfoDTO.fromJson(
            value as Map<String, dynamic>);
      default:
        return null;
    }
  } catch (e, stack) {
    throw  ApiException.withInner(
        500, 'Exception during deserialization.', e as Exception, stack);
  }
}
