part of xpx_chain_sdk.buffer;

Schema aggregateTransactionSchema() {
  List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", intSize),
    _newArrayAttribute("signature", byteSize),
    _newArrayAttribute("signer", byteSize),
    _newScalarAttribute("version", shortSize),
    _newScalarAttribute("type", shortSize),
    _newArrayAttribute("fee", intSize),
    _newArrayAttribute("deadline", intSize),
    _newScalarAttribute("transactionsSize", intSize),
    _newArrayAttribute("transactions", byteSize),
  ];
  return Schema(schemaDefinition);
}