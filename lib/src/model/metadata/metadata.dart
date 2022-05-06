/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.metadata;

/// Metadata is an array of key/value pairs which can be associated with an address/namespace/mosaic.
class Metadata {
  Metadata(this.metadataType, this.fields);

  final MetadataType metadataType;
  final List<Field> fields;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() =>
      {'metadataType': metadataType, 'fields': fields};
}
