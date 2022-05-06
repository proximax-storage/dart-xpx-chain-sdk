/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api;

class MetadataSortingField {
  MetadataSortingField(this.value);

  static MetadataSortingField VALUE =
      MetadataSortingField('metadataEntry.value');
  static MetadataSortingField VALUE_SIZE =
      MetadataSortingField('metadataEntry.valueSize');

  String value;

  @override
  String toString() => value;

  String toJson() => value;
}

class MetadataFieldOrder {
  MetadataFieldOrder(this.order, this.sortingField);

  static ascending(MetadataSortingField sortingField) =>
      MetadataFieldOrder(Order_v2.ASC, sortingField);

  static descending(MetadataSortingField sortingField) =>
      MetadataFieldOrder(Order_v2.DESC, sortingField);

  final Order_v2 order;
  final MetadataSortingField sortingField;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() =>
      {'order': order, 'sortingField': sortingField};
}

class MetadataQueryParams {
  int? pageSize;
  int? pageNumber;
  MetadataType? metadataType;
  Order_v2? order;
  MetadataSortingField? sortField;
  String? sourceAddress;
  AssetId? targetId; // mosaic/ namespace hex string
  String? targetKey; // public key
  Uint64? scopedMetadataKey; // hex string

  void updateFieldOrder(MetadataFieldOrder fieldOrder) {
    sortField = fieldOrder.sortingField;
    order = fieldOrder.order;
  }

  Iterable<QueryParam> toQueryParams() {
    final params = <QueryParam>[];
    toJson()
        .forEach((key, value) => params.add(QueryParam(key, value.toString())));
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

    if (metadataType != null) {
      val['metadataType'] = metadataType!.toInt;
    }
    if (scopedMetadataKey != null) {
      val['scopedMetadataKey'] = scopedMetadataKey!.toHexString();
    }

    writeNotNull('pageSize', pageSize);
    writeNotNull('order', order);
    writeNotNull('sortField', sortField);
    writeNotNull('pageNumber', pageNumber);
    writeNotNull('sortField', sortField);
    writeNotNull('sourceAddress', sourceAddress);
    writeNotNull('targetId', targetId);
    writeNotNull('targetKey', targetKey);

    return val;
  }
}
