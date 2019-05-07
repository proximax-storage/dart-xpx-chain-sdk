part of xpx_catapult_sdk;

class NamespaceInfo {
  bool active = null;

  int index = null;

  BigInt namespaceId = null;

  String fullName = null;

  String metaId = null;

  int typeSpace = null;

  int depth = null;

  List<BigInt> levels = null;

  NamespaceInfo parent = null;

  PublicAccount owner = null;

  BigInt startHeight = null;

  BigInt endHeight = null;

  AliasDTO alias = null;

  NamespaceInfo();

  @override
  String toString() {
    return '{\n'
        '\tNamespaceId: $namespaceId,\n'
        '\tActive: $active,\n'
        '\tIndex: $index,\n'
        '\tMetaId: $metaId,\n'
        '\tTypeSpace: $typeSpace,\n'
        '\tDepth: $depth,\n'
        '\tLevels: $levels,\n'
        '\tParent: $parent,\n'
        '\tAlias: $alias,\n'
        '\tOwner:$owner,\n'
        '\tStartHeight: $startHeight,\n'
        '\tEndHeight: $endHeight\n'
        '}\n';
  }

  NamespaceInfo.fromDTO(_namespaceInfoDTO value) {
    if (json == null) return;

    metaId = value.meta.id;
    active = value.meta.active;
    index = value.meta.index;
    owner = NewAccountFromPublicKey(value.namespace.owner, value.namespace.type);
    startHeight = value.namespace.startHeight.toBigInt();
    endHeight = value.namespace.endHeight.toBigInt();
    depth = value.namespace.depth;
    levels = extractLevels(value);
    typeSpace = value.namespace.type;
    alias = null;
    if (value.namespace.parentId.higher != 0) {
      final p = new NamespaceInfo();
      p.namespaceId = value.namespace.parentId.toBigInt();
      parent = p;
    }
  }
}

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
      EndianLittleUint32(t.getRange(4, 8).toList()) | 0x80000000
    ];
  }

  return new UInt64DTO.fromJson(raw()).toBigInt();
}

// generateNamespaceId create NamespaceId from namespace string name (ex: nem or domain.subdom.subdome)
BigInt _generateNamespaceId(namespaceName) {
  var list = GenerateNamespacePath(namespaceName);
  return list[list.length - 1];
}

List<BigInt> extractLevels(_namespaceInfoDTO ref) {
  List<BigInt> levels = [];

  if (ref.namespace.level0.higher != null) {
    final nsName = ref.namespace.level0.toBigInt();
    levels.add(nsName);
  }

  if (ref.namespace.level1.higher != null) {
    final nsName = ref.namespace.level1.toBigInt();
    levels.add(nsName);
  }

  if (ref.namespace.level2.higher != null) {
    final nsName = ref.namespace.level2.toBigInt();
    levels.add(nsName);
  }

  return levels;
}
