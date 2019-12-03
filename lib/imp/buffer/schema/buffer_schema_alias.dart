part of xpx_chain_sdk.buffer;

Schema aliasTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('actionType', _byteSize),
    _newArrayAttribute('namespaceId', _intSize),
    _newArrayAttribute('aliasId', _byteSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
