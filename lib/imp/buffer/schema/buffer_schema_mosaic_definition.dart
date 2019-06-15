part of xpx_chain_sdk.buffer;

Schema mosaicDefinitionTransactionSchema() {
  List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", intSize),
    _newArrayAttribute("signature", byteSize),
    _newArrayAttribute("signer", byteSize),
    _newScalarAttribute("version", shortSize),
    _newScalarAttribute("type", shortSize),
    _newArrayAttribute("fee", intSize),
    _newArrayAttribute("deadline", intSize),
    _newScalarAttribute("mosaicNonce", intSize),
    _newArrayAttribute("mosaicId", intSize),
    _newScalarAttribute("numOptionalProperties", byteSize),
    _newScalarAttribute("flags", byteSize),
    _newScalarAttribute("divisibility", byteSize),
    _newScalarAttribute("indicateDuration", byteSize),
  _newArrayAttribute("duration", intSize)
  ];
  return Schema(schemaDefinition);
}
