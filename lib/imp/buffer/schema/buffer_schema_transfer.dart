part of xpx_chain_sdk.buffer;

Schema transferTransactionSchema() {
  List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", intSize),
    _newArrayAttribute("signature", byteSize),
    _newArrayAttribute("signer", byteSize),
    _newScalarAttribute("version", shortSize),
    _newScalarAttribute("type", shortSize),
    _newArrayAttribute("fee", intSize),
    _newArrayAttribute("deadline", intSize),
    _newArrayAttribute("recipient", byteSize),
    _newScalarAttribute("messageSize", shortSize),
    _newScalarAttribute("numMosaics", byteSize),
    _newTableAttribute(
        "message",
        Schema([
          _newScalarAttribute("type", byteSize),
          _newArrayAttribute("payload", byteSize)
        ]).schemaDefinition),
    _newTableArrayAttribute(
        "mosaics",
        Schema([
          _newArrayAttribute("id", intSize),
          _newArrayAttribute("amount", intSize),
        ]).schemaDefinition)
  ];
  return Schema(schemaDefinition);
}
