part of xpx_chain_sdk.buffer;

Schema registerNamespaceTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('namespaceType', _byteSize),
    _newArrayAttribute('durationParentId', _intSize),
    _newArrayAttribute('namespaceId', _intSize),
    _newScalarAttribute('namespaceNameSize', _byteSize),
    _newArrayAttribute('name', _byteSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
