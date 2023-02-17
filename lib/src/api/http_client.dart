/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

/// This is a Dart programming language code for a class called `HttpClient`. It is part of the xpx_chain_sdk.api package.
/// Here is what this class does:
///
/// * It has a list of Dio clients, and a method client that returns one of the clients in a round-robin fashion.
/// It has a factory constructor balanceList that takes a list of node URLs, creates a Dio client for each node,
/// and shuffles the list of clients before returning an instance of `HttpClient`.
/// * It has a private method _invokeAPI that takes a path, an HTTP method, a list of query parameters, a request body, and a content type.
/// It constructs a URL from the path and query parameters, sets the content type header of the client to the given content type,
/// and makes an HTTP request with the given method and body. It returns a Response object.
/// * It has public methods get, post, and put that take a path, an optional request body, and an optional list of query parameters.
/// They call _response with the given parameters and the HTTP method as an argument.
/// * It has a private method _response that takes a path, an HTTP method, a request body, and a list of query parameters.
/// It calls _invokeAPI with the given parameters and the content type header. If the request fails, it throws a DioError.
/// * It has a private method _deserialize that takes a value and a target type, and deserializes the value into an object of the target type.
/// The target type is a string that indicates the name of the type. This method is used to deserialize JSON responses into Dart objects.
/// The method uses a switch statement to select the appropriate deserialization method for the target type.
///
/// This code appears to be part of a SDK for interacting with the Sirius blockchain.
/// The Dio package is used for making HTTP requests.
class HttpClient {
  HttpClient._(this._clients);

  final List<Dio> _clients;

  int _nextHttpClient = 0;

  factory HttpClient.balanceList(List<String> nodes) {
    final existing = <String>{};
    final unique = nodes.where(existing.add).toList();

    final clients = <Dio>[];
    for (String node in unique) {
      clients.add(_createDio(node));
    }
    return HttpClient._(clients..shuffle());
  }

  factory HttpClient.fromUrl(String baseUrl, [TimeoutOptions? timeOptions]) {
    final node = _createDio(baseUrl, timeOptions);
    return HttpClient._([node]);
  }

  Dio get client {
    var channel = _clients[_nextHttpClient];
    _nextHttpClient = (_nextHttpClient + 1) % _clients.length;
    return channel;
  }

  static Dio _createDio(String url, [TimeoutOptions? timeOptions]) {
    timeOptions ??= TimeoutOptions(
      connectTimeout: const Duration(seconds: 30000),
      receiveTimeout: const Duration(seconds: 30000),
    );

    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: timeOptions.connectTimeout,
      receiveTimeout: timeOptions.receiveTimeout,
      receiveDataWhenStatusError: false,
      responseType: ResponseType.json,
      followRedirects: true,
      validateStatus: (status) => status! <= 503,
      headers: {'user-agent': 'Dart Sirius/0.0.7+17', 'content-type': 'application/json'},
    );
    return Dio(options);
  }

  /// Function to perform a GET request on the given path.
  Future<Response> get(String path, [Object? postBody, List<QueryParam>? queryParams]) async =>
      _response(path, 'GET', postBody, queryParams);

  /// Function to perform a POST request on the given path.
  Future<Response> post(String path, [Object? postBody, List<QueryParam>? queryParams]) async =>
      _response(path, 'POST', postBody, queryParams);

  /// Function to perform a PUT request on the given path.
  Future<Response> put(String path, [Object? postBody]) async => _response(path, 'PUT', postBody);

  /// Private function that performs the actual HTTP request based on the method, path, and query parameters.
  Future<Response> _response(String path, String method, [Object? postBody, List<QueryParam>? queryParams]) async {
    queryParams ??= [];
    final ps = queryParams.where((p) => p.name.isNotEmpty).map((p) => '${p.name}=${p.value}');
    final String queryString = ps.isNotEmpty ? '?${ps.join('&')}' : '';

    final String url = '${client.options.baseUrl}$path$queryString';

    final msgBody = serialize(postBody);

    try {
      switch (method) {
        case 'POST':
          return await client.post(url, data: msgBody);
        case 'PUT':
          return await client.put(url, data: msgBody);
        default:
          return await client.get(url);
      }
    } on DioError catch (_) {
      rethrow;
    }
  }

  /// Private function used to deserialize the response data.
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
            if (data is List && (match = regList.firstMatch(targetType!)) != null) {
              final newTargetType = match![1];
              return data.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (data is Map && (match = regMap.firstMatch(targetType!)) != null) {
              final newTargetType = match![1];
              return Map.fromIterables(data.keys, data.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } on Exception catch (e, stack) {
      throw ApiException.withInner(500, 'Exception during deserialization.', e, stack);
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
}
