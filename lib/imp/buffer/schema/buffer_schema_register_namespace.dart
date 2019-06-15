part of xpx_chain_sdk.buffer;

Schema registerNamespaceTransactionSchema() {
  List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", intSize),
    _newArrayAttribute("signature", byteSize),
    _newArrayAttribute("signer", byteSize),
    _newScalarAttribute("version", shortSize),
    _newScalarAttribute("type", shortSize),
    _newArrayAttribute("fee", intSize),
    _newArrayAttribute("deadline", intSize),
    _newScalarAttribute("namespaceType", byteSize),
    _newArrayAttribute("durationParentId", intSize),
    _newArrayAttribute("namespaceId", intSize),
    _newScalarAttribute("namespaceNameSize", byteSize),
    _newArrayAttribute("name", byteSize)
  ];
  return Schema(schemaDefinition);
}
