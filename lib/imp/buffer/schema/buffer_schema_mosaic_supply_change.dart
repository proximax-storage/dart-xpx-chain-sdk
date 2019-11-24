part of xpx_chain_sdk.buffer;

Schema mosaicSupplyChangeTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('size', _intSize),
    _newArrayAttribute('signature', _byteSize),
    _newArrayAttribute('signer', _byteSize),
    _newScalarAttribute('version', _intSize),
    _newScalarAttribute('type', _shortSize),
    _newArrayAttribute('maxFee', _intSize),
    _newArrayAttribute('deadline', _intSize),
    _newArrayAttribute('mosaicId', _intSize),
    _newScalarAttribute('direction', _byteSize),
    _newArrayAttribute('delta', _intSize)
  ];
  return Schema(schemaDefinition);
}
