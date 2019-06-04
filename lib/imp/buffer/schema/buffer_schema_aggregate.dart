part of xpx_catapult_sdk.buffer;

schema aggregateTransactionSchema() {
  List<schemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", IntSize),
    _newArrayAttribute("signature", ByteSize),
    _newArrayAttribute("signer", ByteSize),
    _newScalarAttribute("version", ShortSize),
    _newScalarAttribute("type", ShortSize),
    _newArrayAttribute("fee", IntSize),
    _newArrayAttribute("deadline", IntSize),
    _newScalarAttribute("transactionsSize", IntSize),
    _newArrayAttribute("transactions", ByteSize),
  ];
  return schema(schemaDefinition);
}