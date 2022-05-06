/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class Order {
  Order(this.value);

  static Order ASC = Order('id');
  static Order DESC = Order('-id');

  String value;

  @override
  String toString() => value;

  String toJson() => value;
}

class Order_v2 {
  Order_v2(this.value);

  static Order_v2 ASC = Order_v2('asc');
  static Order_v2 DESC = Order_v2('desc');

  String value;

  @override
  String toString() => value;

  Object toJson() => value;
}

/// The query params structure describes pagination params for requests.
class QueryParams {
  QueryParams(this.id, int pageSize, this.order) {
    this.pageSize = (pageSize >= 10 && pageSize <= 100) ? pageSize : 10;
  }

  String? id;
  int? pageSize = 10;

  /// Order of transactions.
  /// DESC. Newer to older.
  ///  ASC. Older to newer.
  Order order = Order.DESC;

  Iterable<QueryParam> toQueryParams() {
    final params = <QueryParam>[];
    toJson().forEach((key, value) => params.add(QueryParam(key, value)));
    return params;
  }

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {'pageSize': pageSize, 'order': order};
    if (id != null) {
      val['id'] = id;
    }

    return val;
  }
}
