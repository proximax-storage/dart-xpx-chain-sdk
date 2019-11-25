part of xpx_chain_sdk.buffer;

Schema mosaicDefinitionTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('size', _intSize),
    _newArrayAttribute('signature', _byteSize),
    _newArrayAttribute('signer', _byteSize),
    _newScalarAttribute('version', _intSize),
    _newScalarAttribute('type', _shortSize),
    _newArrayAttribute('maxFee', _intSize),
    _newArrayAttribute('deadline', _intSize),
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
  return Schema(schemaDefinition);
}
