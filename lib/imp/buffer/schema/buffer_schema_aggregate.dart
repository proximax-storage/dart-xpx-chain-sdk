part of xpx_chain_sdk.buffer.schema;

Schema aggregateTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('transactionsSize', _intSize),
    arrayAttribute('transactions', _byteSize),
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
