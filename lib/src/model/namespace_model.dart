part of xpx_chain_sdk;

class NamespaceId extends Id {
  const NamespaceId._(final BigInt id) : super(id);

  factory NamespaceId({final BigInt id}) {
    if (id == null) {
      throw errNullId;
    }

    return new NamespaceId._(id);
  }

  static NamespaceId fromId(final BigInt id) {
    return new NamespaceId(id: id);
  }

  static NamespaceId fromBigInt(final BigInt bigInt) {
    if (bigInt == null) {
      throw errNullBigInt;
    }
    return new NamespaceId(id: bigInt);
  }

  @override
  String toString() {
    return '${this.toHex()}';
  }

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
  NamespaceName.fromDTO(_NamespaceNameDTO value) {
    if (json == null) return;
    parentId = value.parentId == null
        ? new NamespaceId._(value.parentId.toBigInt())
        : null;
    namespaceId = new NamespaceId._(value.namespaceId.toBigInt());
    name = value.name;
  }

  NamespaceId parentId;

  NamespaceId namespaceId;

  String name;

  @override
  String toString() {
    return '{\n'
        '\tparentId:${parentId?.toHex()},\n'
        '\tnamespaceId:${namespaceId?.toHex()},\n'
        '\tname:$name\n'
        '}\n';
  }

  static List<NamespaceName> listFromDTO(List<_NamespaceNameDTO> json) {
    return json == null
        ? new List<NamespaceName>()
        : json.map((value) => new NamespaceName.fromDTO(value)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentId'] = this.parentId.toHex();
    data['namespaceId'] = this.namespaceId.toHex();
    data['name'] = this.name;

    return data;
  }
}

class NamespaceInfo {
  NamespaceInfo();

  NamespaceInfo.fromDTO(_NamespaceInfoDTO value) {
    if (json == null) return;
    metaId = value.meta.id;
    active = value.meta.active;
    index = value.meta.index;

    final _ownerAddress = Address.fromEncoded(value.namespace.ownerAddress);

    owner = new PublicAccount.fromPublicKey(
        value.namespace.owner, _ownerAddress.networkType);

    startHeight = value.namespace.startHeight.toBigInt();
    endHeight = value.namespace.endHeight.toBigInt();
    depth = value.namespace.depth;
    levels = extractLevels(value);
    typeSpace = value.namespace.type;
    alias = new Alias.fromDTO(value.namespace.alias);
    if (value.namespace.parentId.toBigInt().toInt() != 0) {
      this.namespaceId = new NamespaceId._(levels[0]);
      parent = new NamespaceInfo();
      parent.namespaceId =
          new NamespaceId._(value.namespace.parentId.toBigInt());
    } else {
      this.namespaceId = new NamespaceId._(levels[0]);
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
  String toString() {
    return '{\n'
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
  }

  static List<NamespaceInfo> listFromDTO(List<dynamic> json) {
    return json == null
        ? new List<NamespaceInfo>()
        : json
            .map((dynamic value) =>
                new NamespaceInfo.fromDTO(value as _NamespaceInfoDTO))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['index'] = this.index;
    data['namespaceId'] = this.namespaceId;
    data['fullName'] = this.fullName;
    data['metaId'] = this.metaId;
    data['typeSpace'] = this.typeSpace;
    data['depth'] = this.depth;
    data['levels'] = this.levels;
    data['parent'] = this.parent;
    data['owner'] = this.owner;
    data['startHeight'] = this.startHeight;
    data['endHeight'] = this.endHeight;
    data['alias'] = this.alias;

    return data;
  }
}

class NamespaceIds {
  List<NamespaceId> namespaceIds = [];

  @override
  String toString() {
    return '{"namespaceIds":$namespaceIds}';
  }

  Map<String, dynamic> toJson() {
    List<String> nsIds = List(namespaceIds.length);

    for (int i = 0; i < namespaceIds.length; i++)
      nsIds[i] = bigIntegerToHex(namespaceIds[i].toBigInt());

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['namespaceIds'] = nsIds;
    return data;
  }
}

/// NewNamespaceIdFromName generate Id from namespaceName
NamespaceId NewNamespaceIdFromName(String namespaceName) {
  return NamespaceId._(_generateNamespaceId(namespaceName));
}

/// GenerateNamespacePath create list NamespaceId from string
List<BigInt> generateNamespacePath(String name) {
  var parts = name.split(".");
  if (parts.isEmpty) {
    throw errInvalidNamespaceName;
  }
  if (parts.length > 3) {
    throw errInvalidNamespaceName;
  }

  var namespaceId = BigInt.zero;
  List<BigInt> path = [];

  for (final i in parts) {
    if (!regValidNamespace.hasMatch('$i')) {
      throw errInvalidNamespaceName;
    }
    ;
    namespaceId = _generateId('$i', BigInt.zero);
    path.add(namespaceId);
  }

  return path;
}

List<BigInt> extractLevels(_NamespaceInfoDTO ref) {
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

BigInt _generateId(String name, BigInt parentId) {
  var b = new Uint8List(8);
  if (parentId.toInt() != 0) {
    b = crypto.encodeBigInt(parentId);
  }

  b = new Uint8List.fromList(b.reversed.toList());

  var result = sha3.New256();

  result.update(b, 0, b.length);

  var p = new Uint8List(name.length);
  for (int i = 0; i < name.length; i++) p[i] = name.codeUnits[i];

  var t = result.process(p);

  List<dynamic> raw() {
    return <dynamic>[
      EndianLittleUint32(t.getRange(0, 4).toList()),
      EndianLittleUint32(t.getRange(4, 8).toList()) | 0x80000000
    ];
  }

  return new UInt64DTO.fromJson(raw()).toBigInt();
}

/// generateNamespaceId create NamespaceId from namespace string name (ex: prx or domain.subdom.subdome)
BigInt _generateNamespaceId(String namespaceName) {
  var list = generateNamespacePath(namespaceName);
  return list[list.length - 1];
}
