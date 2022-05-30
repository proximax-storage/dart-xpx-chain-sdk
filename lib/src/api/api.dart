/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.api;

import 'dart:async';
import 'dart:convert' show json;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

import 'dto.dart';

part 'api_account_routes.dart';
part 'api_blockchain_routes.dart';
part 'api_client.dart';
part 'api_conf.dart';
part 'api_exception.dart';
part 'api_exchange_routes.dart';
part 'api_metadata_routes.dart';
part 'api_mosaic_routes.dart';
part 'api_namespace_routes.dart';
part 'api_network_routes.dart';
part 'api_node_routes.dart';
part 'api_transaction_routes.dart';
part 'metadata_query_params.dart';
part 'page_query_params.dart';
part 'query_params.dart';
part 'transaction_query_params.dart';

ApiClient defaultApiClient = ApiClient(null, null);
