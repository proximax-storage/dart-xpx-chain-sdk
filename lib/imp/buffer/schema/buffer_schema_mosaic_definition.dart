part of xpx_chain_sdk.buffer.schema;

Schema mosaicDefinitionTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('mosaicNonce', _intSize),
    _newArrayAttribute('mosaicId', _intSize),
    _newScalarAttribute('numOptionalProperties', _byteSize),
    _newScalarAttribute('flags', _byteSize),
    _newScalarAttribute('divisibility', _byteSize),
    _newTableArrayAttribute(
        'modifications',
        Schema([
          _newScalarAttribute('mosaicPropertyId', _byteSize),
          _newArrayAttribute('value', _intSize),
        ]).schemaDefinition)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
