/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

/// The query params structure describes pagination by page number and page size.
class PageQueryParams {
  PageQueryParams(int? page, int? pageSize) {
    this.pageSize = (pageSize != null && pageSize >= 10 && pageSize <= 100) ? pageSize : 25;
    this.page = (page != null && page >= 0) ? page : 0;
  }

  // Page number should be non negative number, otherwise 0 (first page).
  int page = 0;

  // Page size between 10 and 100, otherwise 25.
  int pageSize = 25;

  Iterable<QueryParam> toQueryParams() {
    final params = <QueryParam>[];
    toJson().forEach((key, value) => params.add(QueryParam(key, value)));
    return params;
  }

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {'pageSize': pageSize, 'page': page};

    return val;
  }
}
