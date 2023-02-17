/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class ApiException implements Exception {
  ApiException(this.code, this.message);

  ApiException.withInner(this.code, this.message, this.innerException, this.stackTrace);

  ApiException.withNode(this.code, this.message, this.node);

  int code = 0;
  dynamic message;
  Exception? innerException;
  StackTrace? stackTrace;
  String? node;

  @override
  String toString() {
    if (message == null) {
      return 'ApiException';
    }

    if (innerException == null) {
      return '$message statusCode: $code';
    }

    return '$code: $message '
            '(Inner exception: $innerException)\n\n' +
        stackTrace.toString();
  }
}
