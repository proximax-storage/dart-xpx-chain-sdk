part of xpx_chain_sdk.namespace;

enum NamespaceType { root, sub }

// namespace id for XPX mosaic
final NamespaceId xpxNamespaceId = NamespaceId.fromName('prx.xpx');

// namespace id for storage mosaic
final NamespaceId storageNamespaceId = NamespaceId.fromName('prx.storage');

// namespace id for streaming mosaic
final NamespaceId streamingNamespaceId = NamespaceId.fromName('prx.streaming');

final prxNamespaceId =
    UInt64DTO(Int32(2339353534), Int32(2976741373)).toUint64();

/// GenerateNamespacePath create list NamespaceId from string
List<Uint64> generateNamespacePath(String name) {
  final parts = name.split('.');
  if (parts.isEmpty) {
    throw errInvalidNamespaceName;
  }
  if (parts.length > 3) {
    throw errInvalidNamespaceName;
  }

  var namespaceId = Uint64.zero;
  final List<Uint64> path = [];

  for (final i in parts) {
    if (!regValidNamespace.hasMatch('$i')) {
      throw errInvalidNamespaceName;
    }
    namespaceId = generateId('$i', namespaceId);

    path.add(namespaceId);
  }

  return path;
}

List<Uint64> extractLevels(NamespaceInfoDTO ref) {
  final List<Uint64> levels = [];

  if (ref._namespace.level0.higher != null) {
    final nsName = ref._namespace.level0.toUint64();
    levels.add(nsName);
  }

  if (ref._namespace.level1.higher != null) {
    final nsName = ref._namespace.level1.toUint64();
    levels.add(nsName);
  }

  if (ref._namespace.level2.higher != null) {
    final nsName = ref._namespace.level2.toUint64();
    levels.add(nsName);
  }

  return levels;
}

Uint64 generateId(String name, Uint64 parentId) {
  var b = Uint8List(8);
  if (parentId.toInt() != 0) {
    b = crypto.encodeBigInt(parentId.toBigInt());
  }

  b = Uint8List.fromList(b.reversed.toList());

  final result = sha3.New256()..update(b, 0, b.length);

  final p = Uint8List(name.length);
  for (int i = 0; i < name.length; i++) {
    p[i] = name.codeUnits[i];
  }

  final t = result.process(p);

  return Uint64.fromBytes(t) | 0x80000000;
}

/// generateNamespaceId create NamespaceId from namespace string name
/// (ex: prx or domain.subdom.subdome)
Uint64 _generateNamespaceId(String namespaceName) {
  final list = generateNamespacePath(namespaceName);
  return list[list.length - 1];
}

final RegExp regValidNamespace = RegExp(
  r'^[a-zA-Z0-9]+$',
  caseSensitive: false,
  multiLine: false,
);
