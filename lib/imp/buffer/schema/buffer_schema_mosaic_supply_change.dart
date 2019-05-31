part of xpx_catapult_sdk.buffer;

schema mosaicSupplyChangeTransactionSchema() {
  List<schemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", IntSize),
    _newArrayAttribute("signature", ByteSize),
    _newArrayAttribute("signer", ByteSize),
    _newScalarAttribute("version", ShortSize),
    _newScalarAttribute("type", ShortSize),
    _newArrayAttribute("fee", IntSize),
    _newArrayAttribute("deadline", IntSize),
    _newArrayAttribute("mosaicId", IntSize),
    _newScalarAttribute("direction", ByteSize),
    _newArrayAttribute("delta", IntSize)
  ];
  return schema(schemaDefinition);
}
