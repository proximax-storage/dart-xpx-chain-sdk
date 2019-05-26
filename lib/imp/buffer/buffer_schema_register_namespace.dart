part of xpx_catapult_sdk.buffer;

schema registerNamespaceTransactionSchema() {
  List<schemaAttribute> schemaDefinition = [
    _newScalarAttribute("size", IntSize),
    _newArrayAttribute("signature", ByteSize),
    _newArrayAttribute("signer", ByteSize),
    _newScalarAttribute("version", ShortSize),
    _newScalarAttribute("type", ShortSize),
    _newArrayAttribute("fee", IntSize),
    _newArrayAttribute("deadline", IntSize),
    _newScalarAttribute("namespaceType", ByteSize),
    _newArrayAttribute("durationParentId", IntSize),
    _newArrayAttribute("namespaceId", IntSize),
    _newScalarAttribute("namespaceNameSize", ByteSize),
    _newArrayAttribute("name", ByteSize)
  ];
  return schema(schemaDefinition);
}
