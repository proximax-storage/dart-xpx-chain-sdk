part of xpx_chain_sdk.api;

class QueryParam {
  QueryParam(this.name, this.value);

  String name;
  String value;
}

class SiriusClient {
  SiriusClient._(this._apiClient) {
    blockChain = BlockchainRoutesApi(_apiClient);
    node = NodeRoutesApi(_apiClient);
    account = AccountRoutesApi(_apiClient);
    exchange = ExchangeRoutesApi(_apiClient);
    mosaic = MosaicRoutesApi(_apiClient);
    namespace = NamespaceRoutesApi(_apiClient);
    network = NetworkRoutesApi(_apiClient);
    transaction = TransactionRoutesApi(_apiClient);
  }

  final _ApiClient _apiClient;
  BlockchainRoutesApi blockChain;
  AccountRoutesApi account;
  ExchangeRoutesApi exchange;
  MosaicRoutesApi mosaic;
  NamespaceRoutesApi namespace;
  NetworkRoutesApi network;
  NodeRoutesApi node;
  TransactionRoutesApi transaction;

  Future<String> get generationHash => _getGenerationHash();

  Future<int> get networkType => _getNetworkType();

  Future<String> _getGenerationHash() async {
    final BlockInfo hash = await blockChain.getBlockByHeight(BigInt.from(1));
    return hash.generationHash;
  }

  Future<int> _getNetworkType() async {
    final NodeInfo info = await node.getNodeInfo();
    return NetworkType.getType(info.networkIdentifier);
  }

  static SiriusClient fromUrl(String baseUrl, http.Client client) {
    // ignore: parameter_assignments
    baseUrl ??= 'http://127.0.0.1:3000';

    // ignore: parameter_assignments
    client ??= http.Client();

    final _ApiClient apiClient = _ApiClient(baseUrl, client);

    return SiriusClient._(apiClient);
  }
}

class _ApiClient {
  _ApiClient(this.baseUrl, this._client);

  String baseUrl;

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
        case 'AccountDTO':
          return AccountDTO.fromJson(value);
        case 'AccountInfoDTO':
          return AccountInfoDTO.fromJson(value);
        case 'AccountNames':
          return AccountNamesDTO.fromJson(value);
        case 'AccountPropertiesDTO':
          return AccountPropertiesDTO.fromJson(value);
        case 'AccountPropertiesInfoDTO':
          return AccountPropertiesInfoDTO.fromJson(value);
        case 'AccountPropertiesMetaDTO':
          return AccountPropertiesMetaDTO.fromJson(value);
        case 'AccountPropertyDTO':
          return AccountPropertyDTO.fromJson(value);
        case 'Addresses':
          return Addresses.fromJson(value);
        case 'AddressAliasDTO':
          return AddressAliasTransactionInfoDTO.fromJson(value);
        case 'AnnounceTransactionInfoDTO':
          return AnnounceTransactionInfoDTO.fromJson(value);
        case 'BlockDTO':
          return BlockDTO.fromJson(value);
        case 'BlockInfoDTO':
          return BlockInfoDTO.fromJson(value);
        case 'BlockMetaDTO':
          return BlockMetaDTO.fromJson(value);
        case 'BlockchainScoreDTO':
          return BlockchainScoreDTO.fromJson(value);
        case 'BlockchainStorageInfo':
          return BlockchainStorageInfo.fromJson(value);
        case 'CommunicationTimestamps':
          return CommunicationTimestamps.fromJson(value);
        case 'ExchangeDTO':
          return ExchangeDTO.fromJson(value);
        case 'OfferInfoDTO':
          return OfferInfoDTO.fromJson(value);
        case 'HeightDTO':
          return HeightDTO.fromJson(value);
        case 'MerklePathItem':
          return MerklePathItem.fromJson(value);
        case 'MerkleProofInfoDTO':
          return MerkleProofInfoDTO.fromJson(value);
        case 'MerkleProofInfoPayload':
          return MerkleProofInfoPayload.fromJson(value);
        case 'MosaicDTO':
          return MosaicDTO.fromJson(value);
        case 'MosaicDefinitionDTO':
          return MosaicDefinitionDTO.fromJson(value);
        case 'MosaicInfoDTO':
          return MosaicInfoDTO.fromJson(value);
        case 'MosaicMetaDTO':
          return MosaicMetaDTO.fromJson(value);
        case 'MosaicNameDTO':
          return MosaicNameDTO.fromJson(value);
        case 'MultisigAccountGraphInfo':
          return MultisigAccountGraphInfo.fromJson(value);
        case 'MultisigAccountInfo':
          return MultisigAccountInfo.fromJson(value);
        case 'Multisig':
          return Multisig.fromJson(value);
        case 'NamespaceDTO':
          return NamespaceDTO.fromJson(value);
        case 'NamespaceInfoDTO':
          return NamespaceInfoDTO.fromJson(value);
        case 'NamespaceMetaDTO':
          return NamespaceMetaDTO.fromJson(value);
        case 'NamespaceNameDTO':
          return NamespaceNameDTO.fromJson(value);
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
        case 'TransactionStatus':
          return TransactionStatus.fromJson(value);
        case 'UInt64DTO':
          return UInt64DTO.fromJson(value);
        default:
          {
            Match match;
            if (value is List && (match = regList.firstMatch(targetType)) != null) {
              final newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map && (match = regMap.firstMatch(targetType)) != null) {
              final newTargetType = match[1];
              return Map.fromIterables(value.keys, value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(500, 'Exception during deserialization.', e, stack);
    }
    return null;
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    // ignore: parameter_assignments
    targetType = targetType.replaceAll(' ', '');

    final dynamic decodedJson = json.decode(jsonVal);

    if (targetType == 'Transaction' || targetType == 'List<Transaction>') {
      return txnDeserialize(decodedJson, targetType);
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
  Future<http.Response> _invokeAPI(final String path, String method, Iterable<QueryParam> queryParams, Object body,
      final Map<String, String> headerParams, final Map<String, String> formParams, final String contentType) async {
    final ps = queryParams.where((p) => p.value != null).map((p) => '${p.name}=${p.value}');
    final String queryString = ps.isNotEmpty ? '?${ps.join('&')}' : '';

    final String url = baseUrl + path + queryString;

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
      final msgBody = contentType == 'application/x-www-form-urlencoded' ? formParams : serialize(body);

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

  Future<http.Response> get(String path,
          [Object postBody,
          List<QueryParam> queryParams,
          Map<String, String> headerParams,
          Map<String, String> formParams]) async =>
      _response(path, 'GET', postBody, queryParams, headerParams, formParams);

  Future<http.Response> post(String path,
          [Object postBody,
          List<QueryParam> queryParams,
          Map<String, String> headerParams,
          Map<String, String> formParams]) async =>
      _response(path, 'POST', postBody, queryParams, headerParams, formParams);

  Future<http.Response> put(String path,
          [Object postBody,
          List<QueryParam> queryParams,
          Map<String, String> headerParams,
          Map<String, String> formParams]) async =>
      _response(path, 'PUT', postBody, queryParams, headerParams, formParams);

  Future<http.Response> _response(String path, String method,
      [Object postBody,
      List<QueryParam> queryParams,
      Map<String, String> headerParams,
      Map<String, String> formParams]) async {
    queryParams ??= [];
    headerParams ??= {};
    formParams ??= {};

    final List<String> contentTypes = [];

    final String contentType = contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    return await _invokeAPI(path, method, queryParams, postBody, headerParams, formParams, contentType);
  }
}
