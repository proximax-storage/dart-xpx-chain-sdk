part of xpx_chain_sdk.buffer.schema;

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
