/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.api;

import 'dart:async';
import 'dart:convert' show json;

import 'package:dio/dio.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

import 'dto.dart';

//     account_routes_api.dart: Contains API routes for working with accounts.
//     blockchain_routes_api.dart: Contains API routes for working with the blockchain.
//     exchange_routes_api.dart: Contains API routes for working with exchanges.
//     metadata_routes_api.dart: Contains API routes for working with metadata.
//     mosaic_routes_api.dart: Contains API routes for working with mosaics.
//     namespace_routes_api.dart: Contains API routes for working with namespaces.
//     network_routes_api.dart: Contains API routes for working with the network.
//     node_routes_api.dart: Contains API routes for working with nodes.
//     transaction_routes_api.dart: Contains API routes for working with transactions.

part 'api_account_routes.dart';
part 'api_blockchain_routes.dart';
part 'api_exception.dart';
part 'api_exchange_routes.dart';
part 'api_metadata_routes.dart';
part 'api_mosaic_routes.dart';
part 'api_namespace_routes.dart';
part 'api_network_routes.dart';
part 'api_node_routes.dart';
part 'api_transaction_routes.dart';
part 'http_client.dart';
part 'metadata_query_params.dart';
part 'page_query_params.dart';
part 'pagination.dart';
part 'query_params.dart';
part 'sirius_client.dart';
part 'timeout_options.dart';
part 'transaction_query_params.dart';

HttpClient defaultApiClient = HttpClient._([
  Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:3000',
      connectTimeout: const Duration(seconds: 5000),
      receiveTimeout: const Duration(seconds: 5000)))
]);
