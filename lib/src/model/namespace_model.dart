part of xpx_catapult_sdk;

class NamespaceInfo {
  bool active;

  int index;

  BigInt namespaceId;

  String fullName;

  String metaId;

  int typeSpace;

  int depth;

  List<BigInt> levels;

  NamespaceInfo parent;

  PublicAccount owner;

  BigInt startHeight;

  BigInt endHeight;

  Alias alias;

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

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'index': index,
      'namespaceId': namespaceId,
      'fullName': fullName,
      'metaId': metaId,
      'typeSpace': typeSpace,
      'depth': depth,
      'levels': levels,
      'parent': parent,
      'owner': owner,
      'startHeight': startHeight,
      'endHeight': endHeight,
      'alias': alias,
    };
  }

  NamespaceInfo.fromDTO(_namespaceInfoDTO value) {
    if (json == null) return;
    metaId = value.meta.id;
    active = value.meta.active;
    index = value.meta.index;
    owner =
        new PublicAccount.fromPublicKey(value.namespace.owner, value.namespace.type);
    startHeight = value.namespace.startHeight.toBigInt();
    endHeight = value.namespace.endHeight.toBigInt();
    depth = value.namespace.depth;
    levels = extractLevels(value);
    typeSpace = value.namespace.type;
    alias = new Alias.fromDTO(value.namespace.alias);
    if (value.namespace.parentId.higher != 0) {
      final p = new NamespaceInfo();
      p.namespaceId = value.namespace.parentId.toBigInt();
      parent = p;
    }
  }

  static List<NamespaceInfo> listFromDTO(List<dynamic> json) {
    return json == null
        ? new List<NamespaceInfo>()
        : json.map((value) => new NamespaceInfo.fromDTO(value)).toList();
  }
}

/// NewNamespaceIdFromName generate Id from namespaceName
BigInt NewNamespaceIdFromName(String namespaceName) {
  var id = _generateNamespaceId(namespaceName);

  return id;
}

class NamespaceIds {
  List<BigInt> namespaceIds = [];

  NamespaceIds();

  @override
  String toString() {
    return '{"namespaceIds":$namespaceIds}';
  }

  Map<String, dynamic> toJson() {
    List<String> nsIds = List(namespaceIds.length);

    for (int i = 0; i < namespaceIds.length; i++)
      nsIds[i] = bigIntegerToHex(namespaceIds[i]);

    return {
      'namespaceIds': nsIds,
    };
  }
}

class NamespaceName {
  BigInt parentId;

  BigInt namespaceId;

  String name = null;

  NamespaceName();

  @override
  String toString() {
    return '{ParentId:${bigIntegerToHex(parentId)}, NamespaceId:${bigIntegerToHex(namespaceId).toUpperCase()}, Name:$name}';
  }

  NamespaceName.fromDTO(_namespaceNameDTO value) {
    if (json == null) return;
    parentId = value.parentId == null ? value.parentId.toBigInt() : null;
    namespaceId = value.namespaceId.toBigInt();
    name = value.name;
  }

  static List<NamespaceName> listFromDTO(List<_namespaceNameDTO> json) {
    return json == null
        ? new List<NamespaceName>()
        : json.map((value) => new NamespaceName.fromDTO(value)).toList();
  }
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
  for (int i = 0; i < name.length; i++) p[i] = name.codeUnits[i];

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

String getPrettyJSONString(jsonObject) {
  var encoder = new JsonEncoder.withIndent(" ");
  return encoder.convert(jsonObject);
}
