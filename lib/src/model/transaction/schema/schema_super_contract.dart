/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema manualCallTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    arrayAttribute('contractKey', _byteSize),
    arrayAttribute('fileNameSize', _byteSize),
    arrayAttribute('functionNameSize', _byteSize),
    arrayAttribute('actualArgumentsSize', _byteSize),
    arrayAttribute('executionCallPayment', _intSize),
    arrayAttribute('downloadCallPayment', _intSize),
    scalarAttribute('servicePaymentsCount', _byteSize),
    arrayAttribute('fileName', _byteSize),
    arrayAttribute('functionName', _byteSize),
    arrayAttribute('actualArguments', _byteSize),
    tableArrayAttribute(
        'servicePayments',
        Schema([
          arrayAttribute('id', _intSize),
          arrayAttribute('amount', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
