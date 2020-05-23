part of xpx_chain_sdk.buffer.schema;

Schema mosaicDefinitionTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('mosaicNonce', _intSize),
    arrayAttribute('mosaicId', _intSize),
    scalarAttribute('numOptionalProperties', _byteSize),
    scalarAttribute('flags', _byteSize),
    scalarAttribute('divisibility', _byteSize),
    tableArrayAttribute(
        'modifications',
        Schema([
          scalarAttribute('mosaicPropertyId', _byteSize),
          arrayAttribute('value', _intSize),
        ]).schemaDefinition)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
