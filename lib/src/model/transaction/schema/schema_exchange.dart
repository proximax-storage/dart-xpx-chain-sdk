/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema addExchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('offersCount', _byteSize),
    tableArrayAttribute(
        'offers',
        Schema([
          arrayAttribute('mosaicId', _intSize),
          arrayAttribute('mosaicAmount', _intSize),
          arrayAttribute('cost', _intSize),
          scalarAttribute('type', _byteSize),
          arrayAttribute('duration', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}

Schema exchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('offersCount', _byteSize),
    tableArrayAttribute(
        'offers',
        Schema([
          arrayAttribute('mosaicId', _intSize),
          arrayAttribute('mosaicAmount', _intSize),
          arrayAttribute('cost', _intSize),
          scalarAttribute('type', _byteSize),
          arrayAttribute('owner', _byteSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}

Schema removeExchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('offersCount', _byteSize),
    tableArrayAttribute(
        'offers',
        Schema([
          arrayAttribute('mosaicId', _intSize),
          scalarAttribute('type', _byteSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
