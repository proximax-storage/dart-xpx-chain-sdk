part of xpx_chain_sdk.buffer.schema;

Schema lockFundsTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    arrayAttribute('mosaicId', _intSize),
    arrayAttribute('mosaicAmount', _intSize),
    arrayAttribute('duration', _intSize),
    arrayAttribute('hash', _byteSize),
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
