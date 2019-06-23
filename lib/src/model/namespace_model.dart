part of xpx_chain_sdk;

class NamespaceId extends Id {
  factory NamespaceId({final BigInt id}) {
    if (id == null) {
      throw _errNullId;
    }

    return NamespaceId._(id);
  }

  const NamespaceId._(final BigInt id) : super(id);

  /// NewNamespaceIdFromName generate Id from namespaceName
  NamespaceId.fromName(String namespaceName)
      : super(_generateNamespaceId(namespaceName));

  NamespaceId.fromId(final BigInt id) : super(id);

  NamespaceId.fromBigInt(final BigInt bigInt) : super(bigInt);

  @override
  String toString() => '${toHex()}';

  @override
  int get hashCode => 'NamespaceId'.hashCode ^ id.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) ||
      other is NamespaceId &&
          runtimeType == other.runtimeType &&
          id == other.id;
}

class NamespaceName {
  NamespaceName.fromDTO(_NamespaceNameDTO value)
      : assert(json != null, 'json must not be null') {
    parentId = value.parentId == null
        ? NamespaceId._(value.parentId.toBigInt())
        : null;
    namespaceId = NamespaceId._(value.namespaceId.toBigInt());
    name = value.name;
  }

  NamespaceId parentId;

  NamespaceId namespaceId;

  String name;

  @override
  String toString() => '{\n'
      '\tparentId:${parentId?.toHex()},\n'
      '\tnamespaceId:${namespaceId?.toHex()},\n'
      '\tname:$name\n'
      '}\n';

  static List<NamespaceName> listFromDTO(List<_NamespaceNameDTO> json) =>
      json == null
          ? null
          : json.map((value) => NamespaceName.fromDTO(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = parentId.toHex();
    data['namespaceId'] = namespaceId.toHex();
    data['name'] = name;

    return data;
  }
}

class NamespaceInfo {
  NamespaceInfo();

  NamespaceInfo.fromDTO(_NamespaceInfoDTO value)
      : assert(json != null, 'json must not be null') {
    metaId = value.meta.id;
    active = value.meta.active;
    index = value.meta.index;

    final _ownerAddress = Address.fromEncoded(value.namespace.ownerAddress);

    owner = PublicAccount.fromPublicKey(
        value.namespace.owner, _ownerAddress.networkType);

    startHeight = value.namespace.startHeight.toBigInt();
    endHeight = value.namespace.endHeight.toBigInt();
    depth = value.namespace.depth;
    levels = extractLevels(value);
    typeSpace = value.namespace.type;
    alias = Alias.fromDTO(value.namespace.alias);
    if (value.namespace.parentId.toBigInt().toInt() != 0) {
      namespaceId = NamespaceId._(levels[0]);
      parent = NamespaceInfo()
        ..namespaceId = NamespaceId._(value.namespace.parentId.toBigInt());
    } else {
      namespaceId = NamespaceId._(levels[0]);
    }
  }

  bool active;

  int index;

  NamespaceId namespaceId;

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

  @override
  String toString() => '{\n'
      '\tnamespaceId: $namespaceId,\n'
      '\tactive: $active,\n'
      '\tindex: $index,\n'
      '\tmetaId: $metaId,\n'
      '\ttypeSpace: $typeSpace,\n'
      '\tdepth: $depth,\n'
      '\tlevels: $levels,\n'
      '\tparent: $parent,\n'
      '\talias: $alias,\n'
      '\towner:$owner,\n'
      '\tstartHeight: $startHeight,\n'
      '\tendHeight: $endHeight\n'
      '}\n';

  static List<NamespaceInfo> listFromDTO(List<dynamic> json) => json == null
      ? null
      : json.map((value) => NamespaceInfo.fromDTO(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['active'] = active;
    data['index'] = index;
    data['namespaceId'] = namespaceId;
    data['fullName'] = fullName;
    data['metaId'] = metaId;
    data['typeSpace'] = typeSpace;
    data['depth'] = depth;
    data['levels'] = levels;
    data['parent'] = parent;
    data['owner'] = owner;
    data['startHeight'] = startHeight;
    data['endHeight'] = endHeight;
    data['alias'] = alias;

    return data;
  }
}

class NamespaceIds {
  List<NamespaceId> namespaceIds = [];

  @override
  String toString() => '{"namespaceIds":$namespaceIds}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    final List<String> nsIds = List(namespaceIds.length);

    for (int i = 0; i < namespaceIds.length; i++) {
      nsIds[i] = bigIntegerToHex(namespaceIds[i].toBigInt());
    }

    data['namespaceIds'] = nsIds;
    return data;
  }
}

/// GenerateNamespacePath create list NamespaceId from string
List<BigInt> generateNamespacePath(String name) {
  final parts = name.split('.');
  if (parts.isEmpty) {
    throw _errInvalidNamespaceName;
  }
  if (parts.length > 3) {
    throw _errInvalidNamespaceName;
  }

  var namespaceId = BigInt.zero;
  final List<BigInt> path = [];

  for (final i in parts) {
    if (!regValidNamespace.hasMatch('$i')) {
      throw _errInvalidNamespaceName;
    }
    namespaceId = _generateId('$i', BigInt.zero);
    path.add(namespaceId);
  }

  return path;
}

List<BigInt> extractLevels(_NamespaceInfoDTO ref) {
  final List<BigInt> levels = [];

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
