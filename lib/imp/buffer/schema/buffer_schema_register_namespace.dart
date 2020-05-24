part of xpx_chain_sdk.buffer.schema;

Schema registerNamespaceTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('namespaceType', _byteSize),
    arrayAttribute('durationParentId', _intSize),
    arrayAttribute('namespaceId', _intSize),
    scalarAttribute('namespaceNameSize', _byteSize),
    arrayAttribute('name', _byteSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
