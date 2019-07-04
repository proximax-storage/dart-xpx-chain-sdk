part of xpx_chain_sdk.buffer;

Schema aliasTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('size', _intSize),
    _newArrayAttribute('signature', _byteSize),
    _newArrayAttribute('signer', _byteSize),
    _newScalarAttribute('version', _shortSize),
    _newScalarAttribute('type', _shortSize),
    _newArrayAttribute('fee', _intSize),
    _newArrayAttribute('deadline', _intSize),
    _newScalarAttribute('actionType', _byteSize),
    _newArrayAttribute('namespaceId', _intSize),
    _newArrayAttribute('aliasId', _byteSize)
  ];
  return Schema(schemaDefinition);
}