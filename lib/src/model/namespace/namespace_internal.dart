part of xpx_chain_sdk.namespace;

enum NamespaceType { root, sub }

final prxNamespaceId =
    UInt64DTO(Int32(2339353534), Int32(2976741373)).toBigInt();

/// GenerateNamespacePath create list NamespaceId from string
List<BigInt> generateNamespacePath(String name) {
  final parts = name.split('.');
  if (parts.isEmpty) {
    throw errInvalidNamespaceName;
  }
  if (parts.length > 3) {
    throw errInvalidNamespaceName;
  }

  var namespaceId = BigInt.zero;
  final List<BigInt> path = [];

  for (final i in parts) {
    if (!regValidNamespace.hasMatch('$i')) {
      throw errInvalidNamespaceName;
    }
    namespaceId = _generateId('$i', namespaceId);

    path.add(namespaceId);
  }

  return path;
}

List<BigInt> extractLevels(NamespaceInfoDTO ref) {
  final List<BigInt> levels = [];

  if (ref._namespace.level0.higher != null) {
    final nsName = ref._namespace.level0.toBigInt();
    levels.add(nsName);
  }

  if (ref._namespace.level1.higher != null) {
    final nsName = ref._namespace.level1.toBigInt();
    levels.add(nsName);
  }

  if (ref._namespace.level2.higher != null) {
    final nsName = ref._namespace.level2.toBigInt();
    levels.add(nsName);
  }

  return levels;
}

BigInt _generateId(String name, BigInt parentId) {
  var b = Uint8List(8);
  if (parentId.toInt() != 0) {
    b = crypto.encodeBigInt(parentId);
  }

  b = Uint8List.fromList(b.reversed.toList());

  final result = sha3.New256()..update(b, 0, b.length);

  final p = Uint8List(name.length);
  for (int i = 0; i < name.length; i++) {
    p[i] = name.codeUnits[i];
  }

  final t = result.process(p);

  List<dynamic> raw() => <dynamic>[
        endianLittleUint32(t.getRange(0, 4).toList()),
        endianLittleUint32(t.getRange(4, 8).toList()) | 0x80000000
      ];

  return UInt64DTO.fromJson(raw()).toBigInt();
}

/// generateNamespaceId create NamespaceId from namespace string name
/// (ex: prx or domain.subdom.subdome)
BigInt _generateNamespaceId(String namespaceName) {
  final list = generateNamespacePath(namespaceName);
  return list[list.length - 1];
}

final RegExp regValidNamespace = RegExp(
  r'^[a-zA-Z0-9]+$',
  caseSensitive: false,
  multiLine: false,
);
