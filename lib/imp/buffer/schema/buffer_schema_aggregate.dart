part of xpx_chain_sdk.buffer;

Schema aggregateTransactionSchema() {
  final List<SchemaAttribute> schemaDefinition = [
    _newScalarAttribute('size', _intSize),
    _newArrayAttribute('signature', _byteSize),
    _newArrayAttribute('signer', _byteSize),
    _newScalarAttribute('version', _intSize),
    _newScalarAttribute('type', _shortSize),
    _newArrayAttribute('maxFee', _intSize),
    _newArrayAttribute('deadline', _intSize),
    _newScalarAttribute('transactionsSize', _intSize),
    _newArrayAttribute('transactions', _byteSize),
  ];
  return Schema(schemaDefinition);
}
