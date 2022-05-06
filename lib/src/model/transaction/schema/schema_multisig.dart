/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction.schema;

Schema modifyMultisigAccountTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('minRemovalDelta', _byteSize),
    scalarAttribute('minApprovalDelta', _byteSize),
    scalarAttribute('numModifications', _byteSize),
    tableArrayAttribute(
        'modification',
        Schema([
          scalarAttribute('type', _byteSize),
          arrayAttribute('cosignatoryPublicKey', _byteSize),
        ]).schemaDefinition)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
