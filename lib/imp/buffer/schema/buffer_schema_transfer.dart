part of xpx_chain_sdk.buffer;

schema transferTransactionSchema() {
  List<schemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", IntSize),
    _newArrayAttribute("signature", ByteSize),
    _newArrayAttribute("signer", ByteSize),
    _newScalarAttribute("version", ShortSize),
    _newScalarAttribute("type", ShortSize),
    _newArrayAttribute("fee", IntSize),
    _newArrayAttribute("deadline", IntSize),
    _newArrayAttribute("recipient", ByteSize),
    _newScalarAttribute("messageSize", ShortSize),
    _newScalarAttribute("numMosaics", ByteSize),
    _newTableAttribute(
        "message",
        schema([
          _newScalarAttribute("type", ByteSize),
          _newArrayAttribute("payload", ByteSize)
        ]).schemaDefinition),
    _newTableArrayAttribute(
        "mosaics",
        schema([
          _newArrayAttribute("id", IntSize),
          _newArrayAttribute("amount", IntSize),
        ]).schemaDefinition)
  ];
  return schema(schemaDefinition);
}
