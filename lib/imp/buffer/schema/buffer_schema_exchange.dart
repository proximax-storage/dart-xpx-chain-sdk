part of xpx_chain_sdk.buffer;

Schema addExchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('offersCount', _byteSize),
    _newTableArrayAttribute(
        'offers',
        Schema([
          _newArrayAttribute('mosaicId', _intSize),
          _newArrayAttribute('mosaicAmount', _intSize),
          _newArrayAttribute('cost', _intSize),
          _newScalarAttribute('type', _byteSize),
          _newArrayAttribute('duration', _intSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}

Schema exchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('offersCount', _byteSize),
    _newTableArrayAttribute(
        'offers',
        Schema([
          _newArrayAttribute('mosaicId', _intSize),
          _newArrayAttribute('mosaicAmount', _intSize),
          _newArrayAttribute('cost', _intSize),
          _newScalarAttribute('type', _byteSize),
          _newArrayAttribute('owner', _byteSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}

Schema removeExchangeOfferTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('offersCount', _byteSize),
    _newTableArrayAttribute(
        'offers',
        Schema([
          _newArrayAttribute('mosaicId', _intSize),
          _newScalarAttribute('type', _byteSize),
        ]).schemaDefinition)
  ];

  schemaDefinition.insertAll(0, commonSchema());

  return Schema(schemaDefinition);
}
