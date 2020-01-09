part of xpx_chain_sdk.buffer.schema;

Schema lockFundsTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newArrayAttribute('mosaicId', _intSize),
    _newArrayAttribute('mosaicAmount', _intSize),
    _newArrayAttribute('duration', _intSize),
    _newArrayAttribute('hash', _byteSize),
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
