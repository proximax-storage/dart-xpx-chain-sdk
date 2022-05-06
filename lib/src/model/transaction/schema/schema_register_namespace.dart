/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema registerNamespaceTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('namespaceType', _byteSize),
    arrayAttribute('durationParentId', _intSize),
    arrayAttribute('namespaceId', _intSize),
    scalarAttribute('namespaceNameSize', _byteSize),
    arrayAttribute('name', _byteSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
