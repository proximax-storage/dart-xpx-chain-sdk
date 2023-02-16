/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

/// Represents the timeout options for the HTTP client.
class TimeoutOptions {
  TimeoutOptions({required this.connectTimeout, required this.receiveTimeout});

  final Duration connectTimeout;
  final Duration receiveTimeout;
}
