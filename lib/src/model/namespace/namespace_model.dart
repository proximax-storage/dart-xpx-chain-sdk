part of xpx_chain_sdk.namespace;

class NamespaceId extends Id {
  factory NamespaceId({final Uint64 id}) {
    if (id == null) {
      throw errNullId;
    }

    return NamespaceId._(id);
  }

  const NamespaceId._(final Uint64 id) : super(id);

  /// NewNamespaceIdFromName generate Id from namespaceName
  NamespaceId.fromName(String namespaceName)
      : super(generateNamespacePath(namespaceName));

  NamespaceId.fromId(final Uint64 id) : super(id);

  NamespaceId.fromBigInt(final Uint64 bigInt) : super(bigInt);

  static NamespaceId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw ArgumentError('invalid hex');
    }
    final Uint64 bigInt = Uint64.fromHex(hex);
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
  NamespaceName.fromDTO(NamespaceNameDTO value)
      : assert(value != null, 'json must not be null') {
    parentId = value.parentId == null
        ? NamespaceId._(value.parentId.toUint64())
        : null;
    namespaceId = NamespaceId._(value.namespaceId.toUint64());
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

  static List<NamespaceName> listFromDTO(List<NamespaceNameDTO> json) =>
      json == null
          ? null
          : json.map((value) => NamespaceName.fromDTO(value)).toList();

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

  NamespaceInfo.fromDTO(NamespaceInfoDTO value)
      : assert(value != null, 'json must not be null') {
    metaId = value.meta.id;
    active = value.meta.active;
    index = value.meta.index;

    final _ownerAddress = Address.fromEncoded(value._namespace.ownerAddress);

    owner = PublicAccount.fromPublicKey(
        value._namespace.owner, _ownerAddress.networkType);

    startHeight = value._namespace.startHeight.toUint64();
    endHeight = value._namespace.endHeight.toUint64();
    depth = value._namespace.depth;
    levels = extractLevels(value);
    typeSpace = value._namespace.type;

    alias = value._namespace.alias.address != null
        ? Alias(address: Address.fromEncoded(value._namespace.alias.address))
        : null;
    if (value._namespace.parentId.toUint64().toInt() != 0) {
      namespaceId = NamespaceId._(levels[0]);
      parent = NamespaceInfo()
        ..namespaceId = NamespaceId._(value._namespace.parentId.toUint64());
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

  List<Uint64> levels;

  NamespaceInfo parent;

  PublicAccount owner;

  Uint64 startHeight;

  Uint64 endHeight;

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
      nsIds[i] = _list[i].toHex();
    }

    data['namespaceIds'] = nsIds;
    return data;
  }
}
