/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class TransactionSearchMosaic {
  TransactionSearchMosaic(this.transferMosaicId);

  final String transferMosaicId;
  Uint64? toTransferAmount;
  Uint64? fromTransferAmount;

  Iterable<QueryParam> toQueryParams() {
    final params = <QueryParam>[];
    toJson().forEach((key, value) => params.add(QueryParam(key, value)));
    return params;
  }

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {'transferMosaicId': transferMosaicId};

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('toTransferAmount', toTransferAmount);
    writeNotNull('fromTransferAmount', fromTransferAmount);

    return val;
  }
}

class TransactionSortingField {
  TransactionSortingField(this.value);

  static TransactionSortingField BLOCK = TransactionSortingField('meta.height');

  String value;

  @override
  String toString() => encoder.convert(this);

  String toJson() => value;
}

class TransactionFieldOrder {
  TransactionFieldOrder(this.order, this.sortingField);

  Order_v2 order;
  TransactionSortingField sortingField;

  static setAscending(TransactionSortingField sortingField) => TransactionFieldOrder(Order_v2.ASC, sortingField);

  static setDescending(TransactionSortingField sortingField) => TransactionFieldOrder(Order_v2.DESC, sortingField);
}

class TransactionQueryParams {
  int? pageSize;
  int? pageNumber;
  List<TransactionType>? type;
  bool embedded = false;
  Order_v2? order;
  TransactionSortingField? sortField;
  Height? toHeight;
  Height? fromHeight;
  Height? height;
  String? signerPublicKey;
  String? recipientAddress;
  String? address;
  String? publicKey;
  bool firstLevel = true;

  void updateFieldOrder(TransactionFieldOrder transactionFieldOrder) {
    sortField = transactionFieldOrder.sortingField;
    order = transactionFieldOrder.order;
  }

  Iterable<QueryParam> toQueryParams() {
    final params = <QueryParam>[];
    toJson().forEach((key, value) {
      if (value is List) {
        for (var element in value) {
          params.add(QueryParam('$key%5B%5D', element.toJson()));
        }
      } else {
        params.add(QueryParam(key, value));
      }
    });
    return params;
  }

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {};

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('pageSize', pageSize);
    writeNotNull('pageNumber', pageNumber);
    writeNotNull('type', type);
    writeNotNull('embedded', embedded);
    writeNotNull('order', order);
    writeNotNull('sortField', sortField);
    writeNotNull('toHeight', toHeight?.toInt());
    writeNotNull('fromHeight', fromHeight?.toInt());
    writeNotNull('height', height?.toInt());
    writeNotNull('signerPublicKey', signerPublicKey);
    writeNotNull('recipientAddress', recipientAddress);
    writeNotNull('address', address);
    writeNotNull('firstLevel', firstLevel);
    writeNotNull('publicKey', publicKey);

    return val;
  }
}
