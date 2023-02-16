/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

/// This code defines a client for interacting with the Sirius blockchain API, which is part of the xpx_chain_sdk package.
/// The client provides methods for interacting with different parts of the blockchain API, such as blockchain routes, account routes,
/// exchange routes, metadata routes, mosaic routes, namespace routes, network routes, node routes, and transaction routes.
/// The client uses the Dio library to make HTTP requests to the API server, and caches frequently used data to improve performance.
/// It also provides a couple of factory methods for creating instances of the client using different configurations,
/// such as a list of API nodes or a base URL for the API server.

/// A client for interacting with the Sirius blockchain API.
class SiriusClient {
  // ----- Constructor and factory methods -----

  // The private constructor used to initialize the _apiClient field.
  SiriusClient._(this._apiClient);

  /// A factory method that creates a new SiriusClient instance that communicates with the specified API server.
  static SiriusClient fromUrl(String baseUrl, [TimeoutOptions? timeOptions]) {
    timeOptions ??= TimeoutOptions(
      connectTimeout: const Duration(seconds: 30000),
      receiveTimeout: const Duration(seconds: 30000),
    );

    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeOptions.connectTimeout,
      receiveTimeout: timeOptions.receiveTimeout,
      receiveDataWhenStatusError: false,
      responseType: ResponseType.json,
      followRedirects: true,
      validateStatus: (status) => status! <= 503,
    );

    final HttpClient apiClient = HttpClient([Dio(options)]);

    return SiriusClient._(apiClient);
  }

  /// A factory method that creates a new SiriusClient instance using the list of nodes specified.
  factory SiriusClient.balanceList(List<String> nodes) => SiriusClient._(HttpClient.balanceList(nodes));

  /// An instance of HttpClient which is responsible for performing API requests.
  final HttpClient _apiClient;

  // ----- Fields for caching frequently used data -----

  // A cache for storing the network type, to prevent the need for multiple API requests.
  Future<NetworkType>? _networkType;

  // A cache for storing an instance of BlockchainRoutesApi for interacting with the blockchain.
  BlockchainRoutesApi? _blockChain;

  // A cache for storing an instance of AccountRoutesApi for interacting with accounts.
  AccountRoutesApi? _account;

  // A cache for storing an instance of ExchangeRoutesApi for interacting with exchanges.
  ExchangeRoutesApi? _exchange;

  // A cache for storing an instance of MetadataRoutesApi for interacting with metadata.
  MetadataRoutesApi? _metadata;

  // A cache for storing an instance of MosaicRoutesApi for interacting with mosaics.
  MosaicRoutesApi? _mosaic;

  // A cache for storing an instance of NamespaceRoutesApi for interacting with namespaces.
  NamespaceRoutesApi? _namespace;

  // A cache for storing an instance of NetworkRoutesApi for interacting with the network.
  NetworkRoutesApi? _network;

  // A cache for storing an instance of NodeRoutesApi for interacting with nodes.
  NodeRoutesApi? _node;

  // A cache for storing an instance of TransactionRoutesApi for interacting with transactions.
  TransactionRoutesApi? _transaction;

  // ----- Getters -----

  /// Returns an API client for interacting with the blockchain.
  BlockchainRoutesApi get blockChain => _blockChain ??= BlockchainRoutesApi(_apiClient);

  /// Returns an API client for interacting with accounts.
  AccountRoutesApi get account => _account ??= AccountRoutesApi(_apiClient);

  /// Returns an API client for interacting with exchanges.
  ExchangeRoutesApi get exchange => _exchange ??= ExchangeRoutesApi(_apiClient);

  /// Returns an API client for interacting with metadata.
  MetadataRoutesApi get metadata => _metadata ??= MetadataRoutesApi(_apiClient);

  /// Returns an API client for interacting with mosaics.
  MosaicRoutesApi get mosaic => _mosaic ??= MosaicRoutesApi(_apiClient);

  /// Returns an API client for interacting with namespaces.
  NamespaceRoutesApi get namespace => _namespace ??= NamespaceRoutesApi(_apiClient);

  /// Returns an API client for interacting with the network.
  NetworkRoutesApi get network => _network ??= NetworkRoutesApi(_apiClient);

  /// Returns an API client for interacting with nodes.
  NodeRoutesApi get node => _node ??= NodeRoutesApi(_apiClient);

  /// Returns an API client for interacting with transactions.
  TransactionRoutesApi get transaction => _transaction ??= TransactionRoutesApi(_apiClient);

  /// Returns the number of nodes in the API client's client list.
  int get nodesLength => _apiClient._clients.length;

  /// Returns a Future<String?> that resolves to the generationHash of the blockchain.
  Future<String?> get generationHash => _getGenerationHash();

  /// Returns a Future<NetworkType> that resolves to the network type of the blockchain.
  Future<NetworkType> get networkType => _networkType ??= _getNetworkType();

  // ----- Private methods -----

  /// Gets the `generationHash` for the blockchain by querying the first block.
  Future<String?> _getGenerationHash() async {
    final BlockInfo? hash = await blockChain.getBlockByHeight(1.toHeight);
    return hash!.generationHash;
  }

  /// Gets the `NetworkType` for the blockchain by querying the node information.
  Future<NetworkType> _getNetworkType() async {
    final NodeInfo? info = await node.getNodeInfo();
    return NetworkType.fromInt(info!.networkIdentifier!);
  }
}
