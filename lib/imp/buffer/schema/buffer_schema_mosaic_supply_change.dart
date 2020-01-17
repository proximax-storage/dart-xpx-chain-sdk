part of xpx_chain_sdk.buffer.schema;

Schema mosaicSupplyChangeTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newArrayAttribute('mosaicId', _intSize),
    _newScalarAttribute('direction', _byteSize),
    _newArrayAttribute('delta', _intSize)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
