part of xpx_chain_sdk.buffer.schema;

Schema aggregateTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('transactionsSize', _intSize),
    _newArrayAttribute('transactions', _byteSize),
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
