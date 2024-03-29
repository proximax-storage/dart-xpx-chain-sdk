/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class QueryParam {
  QueryParam(this.name, this.value);

  String name;
  String value;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class SiriusClient {
  SiriusClient._(this._apiClient, Dio? dio) : httpClient = dio ?? Dio();

  /// [Dio] httpClient
  /// It's been chosen because it's easy to use.
  final Dio httpClient;

  final ApiClient _apiClient;
  Future<NetworkType>? _networkType;
  BlockchainRoutesApi? _blockChain;
  AccountRoutesApi? _account;
  ExchangeRoutesApi? _exchange;
  MetadataRoutesApi? _metadata;
  MosaicRoutesApi? _mosaic;
  NamespaceRoutesApi? _namespace;
  NetworkRoutesApi? _network;
  NodeRoutesApi? _node;
  TransactionRoutesApi? _transaction;

  /// Api dedicated to users operations
  BlockchainRoutesApi get blockChain =>
      _blockChain ??= BlockchainRoutesApi(_apiClient);

  /// Api dedicated to users operations
  AccountRoutesApi get account => _account ??= AccountRoutesApi(_apiClient);

  /// Api dedicated to users operations
  ExchangeRoutesApi get exchange => _exchange ??= ExchangeRoutesApi(_apiClient);

  /// Api dedicated to users operations
  MetadataRoutesApi get metadata => _metadata ??= MetadataRoutesApi(_apiClient);

  /// Api dedicated to users operations
  MosaicRoutesApi get mosaic => _mosaic ??= MosaicRoutesApi(_apiClient);

  /// Api dedicated to users operations
  NamespaceRoutesApi get namespace =>
      _namespace ??= NamespaceRoutesApi(_apiClient);

  /// Api dedicated to users operations
  NetworkRoutesApi get network => _network ??= NetworkRoutesApi(_apiClient);

  /// Api dedicated to users operations
  NodeRoutesApi get node => _node ??= NodeRoutesApi(_apiClient);

  /// Api dedicated to users operations
  TransactionRoutesApi get transaction =>
      _transaction ??= TransactionRoutesApi(_apiClient);

  Future<String?> get generationHash => _getGenerationHash();

  Future<NetworkType> get networkType => _networkType ??= _getNetworkType();

  Future<String?> _getGenerationHash() async {
    final BlockInfo? hash = await blockChain.getBlockByHeight(1.toHeight);
    return hash!.generationHash;
  }

  Future<NetworkType> _getNetworkType() async {
    final NodeInfo? info = await node.getNodeInfo();
    return NetworkType.fromInt(info!.networkIdentifier!);
  }

  static SiriusClient fromUrl(String baseUrl, [http.Client? client]) {
    // ignore: parameter_assignments
    client ??= http.Client();

    final ApiClient apiClient = ApiClient(baseUrl, Dio());

    return SiriusClient._(apiClient, Dio());
  }
}

class ApiClient {
  ApiClient(this.baseUrl, this._client);

  String? baseUrl;

  final Dio? _client;

  final Map<String, String> _defaultHeaderMap = {};

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(value, String? targetType) {
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
        case 'MosaicRichListDTO':
          return MosaicRichListDTO.fromJson(value);
        case 'MosaicNameDTO':
          return MosaicNameDTO.fromJson(value);
        case 'MosaicLevyDTO':
          return MosaicLevyDTO.fromJson(value);
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
        case 'NetworkInfoDTO':
          return NetworkInfo.fromJson(value);
        case 'NodeInfo':
          return NodeInfo.fromJson(value);
        case 'NodeTime':
          return NodeTime.fromJson(value);
        case 'TransactionIds':
          return TransactionIds.fromJson(value);
        case 'TransactionStatus':
          return TransactionStatus.fromJson(value);
        case 'MetadataV2InfoDTO':
          return MetadataV2InfoDTO.fromJson(value);
        default:
          {
            final data = value is Map ? value['data'] : value;
            Match? match;
            if (data is List &&
                (match = regList.firstMatch(targetType!)) != null) {
              final newTargetType = match![1];
              return data.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (data is Map &&
                (match = regMap.firstMatch(targetType!)) != null) {
              final newTargetType = match![1];
              return Map.fromIterables(data.keys,
                  data.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    return null;
  }

  dynamic deserialize(jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    // ignore: parameter_assignments
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'Transaction' || targetType == 'List<Transaction>') {
      return txnDeserialize(jsonVal, targetType);
    }

    return _deserialize(jsonVal, targetType);
  }

  String serialize(Object? obj) {
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
  Future<Response> _invokeAPI(
      final String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object? body,
      final Map<String, String>? headerParams,
      final Map<String, String> formParams,
      final String contentType) async {
    final ps = queryParams
        .where((p) => p.value.isNotEmpty)
        .map((p) => '${p.name}=${p.value}');
    final String queryString = ps.isNotEmpty ? '?${ps.join('&')}' : '';

    final String url = '${baseUrl!}$path$queryString';

    final Options options = Options();
    options.receiveDataWhenStatusError = false;
    options.responseType = ResponseType.json;
    options.followRedirects = true;
    options.validateStatus = (status) => status! <= 503;
    options.headers = _defaultHeaderMap;
    options.headers!['Content-Type'] = contentType;

    if (headerParams != null) {
      options.headers!.addAll(headerParams);
    }

    final msgBody = contentType == 'application/x-www-form-urlencoded'
        ? formParams
        : serialize(body);

    switch (method) {
      case 'POST':
        return await _client!.post(url, options: options, data: msgBody);
      case 'PUT':
        return await _client!.put(url, options: options, data: msgBody);
      case 'DELETE':
        return await _client!.delete(url, options: options);
      case 'PATCH':
        return await _client!.patch(url, options: options, data: msgBody);
      default:
        final response = await _client!.get(url, options: options);

        return response;
    }
    // }
  }

  Future<Response> get(String path,
          [Object? postBody,
          List<QueryParam>? queryParams,
          Map<String, String>? headerParams,
          Map<String, String>? formParams]) async =>
      _response(path, 'GET', postBody, queryParams, headerParams, formParams);

  Future<Response> post(String path,
          [Object? postBody,
          List<QueryParam>? queryParams,
          Map<String, String>? headerParams,
          Map<String, String>? formParams]) async =>
      _response(path, 'POST', postBody, queryParams, headerParams, formParams);

  Future<Response> put(String path,
          [Object? postBody,
          List<QueryParam>? queryParams,
          Map<String, String>? headerParams,
          Map<String, String>? formParams]) async =>
      _response(path, 'PUT', postBody, queryParams, headerParams, formParams);

  Future<Response> _response(String path, String method,
      [Object? postBody,
      List<QueryParam>? queryParams,
      Map<String, String>? headerParams,
      Map<String, String>? formParams]) async {
    queryParams ??= [];
    headerParams ??= {};
    formParams ??= {};

    final List<String> contentTypes = [];

    final String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : 'application/json';

    try {
      return await _invokeAPI(path, method, queryParams, postBody, headerParams,
          formParams, contentType);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
