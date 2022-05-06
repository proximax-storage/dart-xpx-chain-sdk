/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema mosaicDefinitionTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    arrayAttribute('mosaicNonce', _byteSize),
    arrayAttribute('mosaicId', _intSize),
    scalarAttribute('numOptionalProperties', _byteSize),
    scalarAttribute('flags', _byteSize),
    scalarAttribute('divisibility', _byteSize),
    tableArrayAttribute(
        'modifications',
        Schema([
          scalarAttribute('mosaicPropertyId', _byteSize),
          arrayAttribute('value', _intSize),
        ]).schemaDefinition)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
