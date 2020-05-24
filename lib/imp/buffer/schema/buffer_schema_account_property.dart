part of xpx_chain_sdk.buffer.schema;

Schema accountPropertyTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('propertyType', _byteSize),
    scalarAttribute('modificationCount', _byteSize),
    tableArrayAttribute(
        'modifications',
        Schema([
          scalarAttribute('modificationType', _byteSize),
          arrayAttribute('value', _byteSize),
        ]).schemaDefinition)
  ];
  schemaDefinition.insertAll(0, commonSchema());
  return Schema(schemaDefinition);
}
