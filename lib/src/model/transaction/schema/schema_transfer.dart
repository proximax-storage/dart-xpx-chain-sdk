/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema transferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    arrayAttribute('recipient', _byteSize),
    scalarAttribute('messageSize', _shortSize),
    scalarAttribute('numMosaics', _byteSize),
    tableAttribute(
        'message',
        Schema([
          scalarAttribute('type', _byteSize),
          arrayAttribute('payload', _byteSize)
        ]).schemaDefinition),
    tableArrayAttribute(
        'mosaics',
        Schema([
          arrayAttribute('id', _intSize),
          arrayAttribute('amount', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
