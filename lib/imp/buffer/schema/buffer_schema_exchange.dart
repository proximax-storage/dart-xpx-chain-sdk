part of xpx_chain_sdk.buffer.schema;

Schema addExchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('offersCount', _byteSize),
    tableArrayAttribute(
        'offers',
        Schema([
          arrayAttribute('mosaicId', _intSize),
          arrayAttribute('mosaicAmount', _intSize),
          arrayAttribute('cost', _intSize),
          scalarAttribute('type', _byteSize),
          arrayAttribute('duration', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}

Schema exchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('offersCount', _byteSize),
    tableArrayAttribute(
        'offers',
        Schema([
          arrayAttribute('mosaicId', _intSize),
          arrayAttribute('mosaicAmount', _intSize),
          arrayAttribute('cost', _intSize),
          scalarAttribute('type', _byteSize),
          arrayAttribute('owner', _byteSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}

Schema removeExchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    scalarAttribute('offersCount', _byteSize),
    tableArrayAttribute(
        'offers',
        Schema([
          arrayAttribute('mosaicId', _intSize),
          scalarAttribute('type', _byteSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
