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

  static NamespaceId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw ArgumentError('invalid hex');
    }
    final BigInt bigInt = BigInt.parse(hex, radix: 16);
    return NamespaceId._(bigInt);
  }

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
  NamespaceName._fromDTO(_NamespaceNameDTO value)
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
  String toString() {
    final sb = StringBuffer()..writeln('\n{');
    if (parentId != null) {
      sb.writeln('\tparentId: ${parentId.toHex()},');
    }
    sb.writeln('\tnamespaceId: ${namespaceId.toHex()},');
    sb.writeln('\tname: $name,');
    sb.writeln('\n{');
    return sb.toString();
  }

  static List<NamespaceName> listFromDTO(List<_NamespaceNameDTO> json) =>
      json == null
          ? null
          : json.map((value) => NamespaceName._fromDTO(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (parentId != null) {
      data['parentId'] = parentId.toHex();
    }
    data['namespaceId'] = namespaceId.toHex();
    data['name'] = name;

    return data;
  }
}

class NamespaceInfo {
  NamespaceInfo();

  NamespaceInfo._fromDTO(_NamespaceInfoDTO value)
      : assert(json != null, 'json must not be null') {
    metaId = value._meta.id;
    active = value._meta.active;
    index = value._meta.index;

    final _ownerAddress = Address.fromEncoded(value._namespace._ownerAddress);

    owner = PublicAccount.fromPublicKey(
        value._namespace._owner, _ownerAddress.networkType);

    startHeight = value._namespace._startHeight.toBigInt();
    endHeight = value._namespace._endHeight.toBigInt();
    depth = value._namespace._depth;
    levels = extractLevels(value);
    typeSpace = value._namespace._type;

    alias = value._namespace._alias._address != null
        ? Alias._(
            address: Address.fromEncoded(value._namespace._alias._address))
        : null;
    if (value._namespace._parentId.toBigInt().toInt() != 0) {
      namespaceId = NamespaceId._(levels[0]);
      parent = NamespaceInfo()
        ..namespaceId = NamespaceId._(value._namespace._parentId.toBigInt());
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
      : json.map((value) => NamespaceInfo._fromDTO(value)).toList();

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

  NamespaceIds.fromList(List<NamespaceId> list)
      : assert(list != null, 'list must not be null') {
    _list = list.map((item) => item).toList();
  }

  List<NamespaceId> _list = [];

  @override
  String toString() => '{"namespaceIds":$_list}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    final List<String> nsIds = List(_list.length);

    for (int i = 0; i < _list.length; i++) {
      nsIds[i] = bigIntegerToHex(_list[i].toBigInt());
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
    namespaceId = _generateId('$i', namespaceId);

    path.add(namespaceId);
  }

  return path;
}

List<BigInt> extractLevels(_NamespaceInfoDTO ref) {
  final List<BigInt> levels = [];

  if (ref._namespace._level0._higher != null) {
    final nsName = ref._namespace._level0.toBigInt();
    levels.add(nsName);
  }

  if (ref._namespace._level1._higher != null) {
    final nsName = ref._namespace._level1.toBigInt();
    levels.add(nsName);
  }

  if (ref._namespace._level2._higher != null) {
    final nsName = ref._namespace._level2.toBigInt();
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
