part of nem2_sdk_dart;

//NewNamespaceIdFromName generate Id from namespaceName
BigInt NewNamespaceIdFromName(String namespaceName) {
  var id = _generateNamespaceId(namespaceName);

  return id;
}

// GenerateNamespacePath create list NamespaceId from string
List<BigInt> GenerateNamespacePath(String name) {
  var parts = name.split(".");
  if (parts.length == 0) {
    throw ErrInvalidNamespaceName;
  }
  if (parts.length > 3) {
    throw ErrInvalidNamespaceName;
  }

  var namespaceId = BigInt.zero;
  List<BigInt> path = [];

  for (final i in parts) {
    if (!regValidNamespace.hasMatch('$i')) {
      throw ErrInvalidNamespaceName;
    }
    ;
    namespaceId = _generateId('$i', BigInt.zero);
    path.add(namespaceId);
  }
  return path;
}

BigInt _generateId(String name, BigInt parentId) {
  var b = new Uint8List(8);
  if (parentId.toInt() != 0) {
    b = crypto.encodeBigInt(parentId);
  }

  b.reversed;

  var result = sha3.New256();

  result.update(b, 0, b.length);
  var p = new Uint8List(name.length);
  for (int i = 0; i < name.codeUnits.length; i++) p[i] = name.codeUnits[i];

  var t = result.process(p);

  List<dynamic> raw() {
    return [
      EndianLittleUint32(t.getRange(0, 4).toList()),
      EndianLittleUint32(t.getRange(4, 8).toList())
    ];
  }

  return new UInt64DTO.fromJson(raw()).toBigInt();
}

// generateNamespaceId create NamespaceId from namespace string name (ex: nem or domain.subdom.subdome)
BigInt _generateNamespaceId(namespaceName) {
  var list = GenerateNamespacePath(namespaceName);
  return list[list.length - 1];
}

int bytesToInteger(List<int> bytes) {
  num value = 0;
  bytes = bytes.sublist(0, 32);
  for (var i = 0; i < bytes.length; i++) {
    value += bytes[i] * pow(256, i);
  }
  ;
  return value.toInt();
}
