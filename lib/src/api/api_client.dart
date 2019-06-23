part of xpx_chain_sdk;

final _regList = RegExp(r'^List<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

class QueryParam {
  QueryParam(this.name, this.value);

  String name;
  String value;
}

class ApiClient {
  ApiClient._(this._apiClient)
      : blockChain = BlockchainRoutesApi(_apiClient),
        account = AccountRoutesApi(_apiClient),
        mosaic = MosaicRoutesApi(_apiClient),
        namespace = NamespaceRoutesApi(_apiClient),
        network = NetworkRoutesApi(_apiClient),
        node = NodeRoutesApi(_apiClient),
        transaction = TransactionRoutesApi(_apiClient);

  final _ApiClient _apiClient;
  final BlockchainRoutesApi blockChain;
  final AccountRoutesApi account;
  final MosaicRoutesApi mosaic;
  final NamespaceRoutesApi namespace;
  final NetworkRoutesApi network;
  final NodeRoutesApi node;
  final TransactionRoutesApi transaction;

  static ApiClient fromConf(Config conf, http.Client client) {
    // ignore: parameter_assignments
    conf ??= Config('http://127.0.0.1:3000', publicTest);

    // ignore: parameter_assignments
    client ??= http.Client();

    final _ApiClient apiClient = _ApiClient(conf, client);

    return ApiClient._(apiClient);
  }
}

class _ApiClient {
  _ApiClient(this.conf, this._client);

  Config conf;

  final http.Client _client;

  final Map<String, String> _defaultHeaderMap = {};

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(value, String targetType) {
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
          return _AccountDTO.fromJson(value);
        case '_AccountInfoDTO':
          return _AccountInfoDTO.fromJson(value);
        case '_AccountMetaDTO':
          return _AccountMetaDTO.fromJson(value);
        case '_AccountPropertiesDTO':
          return _AccountPropertiesDTO.fromJson(value);
        case '_AccountPropertiesInfoDTO':
          return _AccountPropertiesInfoDTO.fromJson(value);
        case '_AccountPropertiesMetaDTO':
          return _AccountPropertiesMetaDTO.fromJson(value);
        case 'AccountPropertyDTO':
          return AccountPropertyDTO.fromJson(value);
        case 'Addresses':
          return Addresses.fromJson(value);
        case '_AliasDTO':
          return _AliasDTO.fromJson(value);
        case 'AnnounceTransactionInfoDTO':
          return AnnounceTransactionInfoDTO.fromJson(value);
        case 'BlockDTO':
          return _BlockDTO.fromJson(value);
        case 'BlockInfoDTO':
          return _BlockInfoDTO.fromJson(value);
        case 'BlockMetaDTO':
          return _BlockMetaDTO.fromJson(value);
        case '_BlockchainScoreDTO':
          return _BlockchainScoreDTO.fromJson(value);
        case 'BlockchainStorageInfo':
          return BlockchainStorageInfo.fromJson(value);
        case 'CommunicationTimestamps':
          return CommunicationTimestamps.fromJson(value);
        case 'HeightDTO':
          return _HeightDTO.fromJson(value);
        case 'MerklePathItem':
          return MerklePathItem.fromJson(value);
        case '_MerkleProofInfoDTO':
          return _MerkleProofInfoDTO.fromJson(value);
        case 'MerkleProofInfoPayload':
          return MerkleProofInfoPayload.fromJson(value);
        case '_MosaicDTO':
          return _MosaicDTO.fromJson(value);
        case '_MosaicDefinitionDTO':
          return _MosaicDefinitionDTO.fromJson(value);
        case '_MosaicInfoDTO':
          return _MosaicInfoDTO.fromJson(value);
        case '_MosaicMetaDTO':
          return _MosaicMetaDTO.fromJson(value);
        case '_MosaicNameDTO':
          return _MosaicNameDTO.fromJson(value);
        case 'MultisigAccountGraphInfo':
          return MultisigAccountGraphInfo.fromJson(value);
        case 'MultisigAccountInfo':
          return MultisigAccountInfo.fromJson(value);
        case 'Multisig':
          return Multisig.fromJson(value);
        case '_NamespaceDTO':
          return _NamespaceDTO.fromJson(value);
        case '_NamespaceInfoDTO':
          return _NamespaceInfoDTO.fromJson(value);
        case '_NamespaceMetaDTO':
          return _NamespaceMetaDTO.fromJson(value);
        case '_NamespaceNameDTO':
          return _NamespaceNameDTO.fromJson(value);
        case 'NetworkTypeDTO':
          return NetworkType.fromJson(value);
        case 'NodeInfo':
          return NodeInfo.fromJson(value);
        case 'NodeTime':
          return NodeTime.fromJson(value);
        case 'TransactionHashes':
          return TransactionHashes.fromJson(value);
        case 'TransactionIds':
          return TransactionIds.fromJson(value);
        case 'TransactionPayload':
          return TransactionPayload.fromJson(value);
        case 'TransactionStatus':
          return TransactionStatus.fromJson(value);
        case 'UInt64DTO':
          return UInt64DTO.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _regList.firstMatch(targetType)) != null) {
              final newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _regMap.firstMatch(targetType)) != null) {
              final newTargetType = match[1];
              return Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    return null;
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    // ignore: parameter_assignments
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
      final String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object body,
      final Map<String, String> headerParams,
      final Map<String, String> formParams,
      final String contentType) async {
    final ps = queryParams
        .where((p) => p.value != null)
        .map((p) => '${p.name}=${p.value}');
    final String queryString = ps.isNotEmpty ? '?${ps.join('&')}' : '';

    final String url = conf.baseUrl + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if (body is http.MultipartRequest) {
      final request = http.MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      final response = await _client.send(request);
      return http.Response.fromStream(response);
    } else {
      final msgBody = contentType == 'application/x-www-form-urlencoded'
          ? formParams
          : serialize(body);

      switch (method) {
        case 'POST':
          return _client.post(url, headers: headerParams, body: msgBody);
        case 'PUT':
          return _client.put(url, headers: headerParams, body: msgBody);
        case 'DELETE':
          return _client.delete(url, headers: headerParams);
        case 'PATCH':
          return _client.patch(url, headers: headerParams, body: msgBody);
        default:
          final response = _client.get(url, headers: headerParams);
          return response;
      }
    }
  }
}

dynamic _txnDeserialize(value, String targetType) {
  if (targetType == 'List<Transaction>') {
    {
      Match match;
      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        final newTargetType = match[1];

        return value.map((v) => _txnDeserialize(v, newTargetType)).toList();
      } else if (value is Map &&
          (match = _regMap.firstMatch(targetType)) != null) {
        final newTargetType = match[1];
        return Map.fromIterables(value.keys,
            value.values.map((v) => _txnDeserialize(v, newTargetType)));
      }
    }
  }

  // ignore: parameter_assignments
  targetType = _mapTransaction(value);

  try {
    switch (targetType) {
      case 'Transfer':
        return _TransferTransactionInfoDTO.fromJson(value);
      case 'RegisterNamespace':
        return _RegisterNamespaceTransactionInfoDTO.fromJson(value);
      case 'MosaicDefinition':
        return _MosaicDefinitionTransactionInfoDTO.fromJson(value);
      case 'MosaicSupplyChange':
        return _MosaicSupplyChangeTransactionInfoDTO.fromJson(value);
      case 'AggregateCompleted':
        return _AggregateTransactionInfoDTO.fromJson(value);
      default:
        return null;
    }
  } on Exception catch (e, stack) {
    throw ApiException.withInner(
        500, 'Exception during deserialization.', e, stack);
  }
}
