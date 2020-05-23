part of xpx_chain_sdk.buffer.schema;

Schema mosaicSupplyChangeTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    arrayAttribute('mosaicId', _intSize),
    scalarAttribute('direction', _byteSize),
    arrayAttribute('delta', _intSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
