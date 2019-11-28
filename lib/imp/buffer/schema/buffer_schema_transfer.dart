part of xpx_chain_sdk.buffer;

Schema transferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newArrayAttribute('recipient', _byteSize),
    _newScalarAttribute('messageSize', _shortSize),
    _newScalarAttribute('numMosaics', _byteSize),
    _newTableAttribute(
        'message',
        Schema([
          _newScalarAttribute('type', _byteSize),
          _newArrayAttribute('payload', _byteSize)
        ]).schemaDefinition),
    _newTableArrayAttribute(
        'mosaics',
        Schema([
          _newArrayAttribute('id', _intSize),
          _newArrayAttribute('amount', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
