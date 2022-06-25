/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.metadata;

/// Metadata specialization for address/account.
class AddressMetadata extends Metadata {
  AddressMetadata(List<Field> fields, this.metadataId) : super(MetadataType.metadataAccount, fields);

  final Address metadataId;

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};
    val.addAll(super.toJson());
    val['metadataId'] = metadataId;
    return val;
  }
}
