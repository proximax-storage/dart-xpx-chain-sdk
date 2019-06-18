part of xpx_chain_sdk.buffer;

Schema mosaicSupplyChangeTransactionSchema() {
  List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", intSize),
    _newArrayAttribute("signature", byteSize),
    _newArrayAttribute("signer", byteSize),
    _newScalarAttribute("version", shortSize),
    _newScalarAttribute("type", shortSize),
    _newArrayAttribute("fee", intSize),
    _newArrayAttribute("deadline", intSize),
    _newArrayAttribute("mosaicId", intSize),
    _newScalarAttribute("direction", byteSize),
    _newArrayAttribute("delta", intSize)
  ];
  return Schema(schemaDefinition);
}
