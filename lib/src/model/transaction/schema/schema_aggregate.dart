/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema aggregateTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('transactionsSize', _intSize),
    arrayAttribute('transactions', _byteSize),
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
