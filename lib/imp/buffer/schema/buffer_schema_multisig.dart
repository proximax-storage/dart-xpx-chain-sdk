part of xpx_chain_sdk.buffer;

Schema modifyMultisigAccountTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('size', _intSize),
    _newArrayAttribute('signature', _byteSize),
    _newArrayAttribute('signer', _byteSize),
    _newScalarAttribute('version', _shortSize),
    _newScalarAttribute('type', _shortSize),
    _newArrayAttribute('fee', _intSize),
    _newArrayAttribute('deadline', _intSize),
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
  return Schema(schemaDefinition);
}
