part of nem2_sdk_dart;

// GenerateNamespacePath create list NamespaceId from string
List<BigInt> GenerateNamespacePath(String name) {
  var parts = name.split(".");
  if (parts.length == 0) {
    return null;
  }
  if (parts.length > 3) {
    return null;
  }

//  var namespaceId = new BigInt.from(0);
//  List<BigInt> path;
//  for (final x in parts) {
//    result.add(converter(x));
//  }
}

UInt64DTO generateId(String name, BigInt parentId) {
  var b = new Uint8List(8);
  if (parentId.toInt() != 0) {
    b = crypto.encodeBigInt(parentId);
  }

  b.reversed;

  var result = sha3.New256();
  result.process(b);

  var t = result.process(name.codeUnits);

  Map<String, dynamic> algo() {
    return {'l': t.getRange(0, 4), 'h': t.getRange(4, 8)};
  }

  return new UInt64DTO.fromJson(algo());
}
