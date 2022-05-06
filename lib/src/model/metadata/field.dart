/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.metadata;

/// Key value storage for metadata fields.
class Field {
  Field(this.key, this.value);

  final String key;
  final String value;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}
