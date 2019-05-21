part of xpx_catapult_sdk;

schema transferTransactionSchema() {
  List<schemaAttribute> schemaDefinition = [
    newScalarAttribute("size", IntSize),
    newArrayAttribute("signature", ByteSize),
    newArrayAttribute("signer", ByteSize),
    newScalarAttribute("version", ShortSize),
    newScalarAttribute("type", ShortSize),
    newArrayAttribute("fee", IntSize),
    newArrayAttribute("deadline", IntSize),
    newArrayAttribute("recipient", ByteSize),
    newScalarAttribute("messageSize", ShortSize),
    newScalarAttribute("numMosaics", ByteSize),
    newTableAttribute(
        "message",
        schema([
          newScalarAttribute("type", ByteSize),
          newArrayAttribute("payload", ByteSize)
        ]).schemaDefinition),
    newTableArrayAttribute(
        "mosaics",
        schema([
          newArrayAttribute("id", IntSize),
          newArrayAttribute("amount", IntSize),
        ]).schemaDefinition)
  ];
  return schema(schemaDefinition);
}
