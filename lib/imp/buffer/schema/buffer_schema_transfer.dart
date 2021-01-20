part of xpx_chain_sdk.buffer.schema;

Schema transferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    arrayAttribute('recipient', _byteSize),
    scalarAttribute('messageSize', _shortSize),
    scalarAttribute('numMosaics', _byteSize),
    tableAttribute(
        'message', Schema([scalarAttribute('type', _byteSize), arrayAttribute('payload', _byteSize)]).schemaDefinition),
    tableArrayAttribute(
        'mosaics',
        Schema([
          arrayAttribute('id', _intSize),
          arrayAttribute('amount', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
