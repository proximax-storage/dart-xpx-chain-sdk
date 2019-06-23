part of xpx_chain_sdk.buffer;

Schema registerNamespaceTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('size', _intSize),
    _newArrayAttribute('signature', _byteSize),
    _newArrayAttribute('signer', _byteSize),
    _newScalarAttribute('version', _shortSize),
    _newScalarAttribute('type', _shortSize),
    _newArrayAttribute('fee', _intSize),
    _newArrayAttribute('deadline', _intSize),
    _newScalarAttribute('namespaceType', _byteSize),
    _newArrayAttribute('durationParentId', _intSize),
    _newArrayAttribute('namespaceId', _intSize),
    _newScalarAttribute('namespaceNameSize', _byteSize),
    _newArrayAttribute('name', _byteSize)
  ];
  return Schema(schemaDefinition);
}
