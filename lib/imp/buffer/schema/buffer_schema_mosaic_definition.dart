part of xpx_chain_sdk.buffer;

schema mosaicDefinitionTransactionSchema() {
  List<schemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", IntSize),
    _newArrayAttribute("signature", ByteSize),
    _newArrayAttribute("signer", ByteSize),
    _newScalarAttribute("version", ShortSize),
    _newScalarAttribute("type", ShortSize),
    _newArrayAttribute("fee", IntSize),
    _newArrayAttribute("deadline", IntSize),
    _newScalarAttribute("mosaicNonce", IntSize),
    _newArrayAttribute("mosaicId", IntSize),
    _newScalarAttribute("numOptionalProperties", ByteSize),
    _newScalarAttribute("flags", ByteSize),
    _newScalarAttribute("divisibility", ByteSize),
    _newScalarAttribute("indicateDuration", ByteSize),
  _newArrayAttribute("duration", IntSize)
  ];
  return schema(schemaDefinition);
}
