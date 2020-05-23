part of xpx_chain_sdk.buffer.schema;

Schema aliasTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('actionType', _byteSize),
    arrayAttribute('namespaceId', _intSize),
    arrayAttribute('aliasId', _byteSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
