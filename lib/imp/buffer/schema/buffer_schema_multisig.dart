part of xpx_chain_sdk.buffer;

Schema modifyMultisigAccountTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('minRemovalDelta', _byteSize),
    _newScalarAttribute('minApprovalDelta', _byteSize),
    _newScalarAttribute('numModifications', _byteSize),
    _newTableArrayAttribute(
        'modification',
        Schema([
          _newScalarAttribute('type', _byteSize),
          _newArrayAttribute('cosignatoryPublicKey', _byteSize),
        ]).schemaDefinition)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
