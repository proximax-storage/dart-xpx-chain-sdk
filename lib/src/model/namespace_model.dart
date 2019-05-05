part of xpx_catapult_sdk ;

class NamespaceInfo {
  BigInt namespaceId = null;

  String fullName = null;

  bool active = null;

  int index = null;

  String metaId = null;

  int typeSpace = null;

  int depth = null;

  List<BigInt> levels = null;

  NamespaceInfo parent = null;

  String owner = null;

  BigInt startHeight = null;

  BigInt endHeight = null;

  AliasDTO alias = null;

  NamespaceInfo();

//  @override
//  String toString() {
//    return 'NamespaceInfo[owner=$owner, ownerAddress=$ownerAddress, startHeight=$startHeight, endHeight=$endHeight, depth=$depth, level0=$level0, level1=$level1, level2=$level2, type=$type, alias=$alias, parentId=$parentId, ]';
//  }

//  NamespaceInfo.fromDTO(_namespaceInfoDTO value) {
//
//    if (json == null) return;
//    namespaceId = value.namespace.na;
//    ownerAddress = json['ownerAddress'];
//    startHeight = new UInt64DTO.fromJson(json['startHeight']);
//    endHeight = new UInt64DTO.fromJson(json['endHeight']);
//    depth = json['depth'];
//    level0 = new UInt64DTO.fromJson(json['level0']);
//    level1 = new UInt64DTO.fromJson(json['level1']);
//    level2 = new UInt64DTO.fromJson(json['level2']);
//    type = json['type'];
//    alias = new AliasDTO.fromJson(json['alias']);
//    parentId = new UInt64DTO.fromJson(json['parentId']);
//  }

//  NamespaceInfo.fromJson(Map<String, dynamic> json) {
//
//    if (json == null) return;
//    owner = json['owner'];
//    ownerAddress = json['ownerAddress'];
//    startHeight = new UInt64DTO.fromJson(json['startHeight']);
//    endHeight = new UInt64DTO.fromJson(json['endHeight']);
//    depth = json['depth'];
//    level0 = new UInt64DTO.fromJson(json['level0']);
//    level1 = new UInt64DTO.fromJson(json['level1']);
//    level2 = new UInt64DTO.fromJson(json['level2']);
//    type = json['type'];
//    alias = new AliasDTO.fromJson(json['alias']);
//    parentId = new UInt64DTO.fromJson(json['parentId']);
//  }
//
//  Map<String, dynamic> toJson() {
//    return {
//      'owner': owner,
//      'ownerAddress': ownerAddress,
//      'startHeight': startHeight,
//      'endHeight': endHeight,
//      'depth': depth,
//      'level0': level0,
//      'level1': level1,
//      'level2': level2,
//      'type': type,
//      'alias': alias,
//      'parentId': parentId
//    };
//  }

//  static List<NamespaceInfo> listFromJson(List<dynamic> json) {
//    return json == null
//        ? new List<NamespaceInfo>()
//        : json.map((value) => new NamespaceInfo.fromJson(value)).toList();
//  }
//
//  static Map<String, NamespaceInfo> mapFromJson(
//      Map<String, Map<String, dynamic>> json) {
//    var map = new Map<String, NamespaceInfo>();
//    if (json != null && json.length > 0) {
//      json.forEach((String key, Map<String, dynamic> value) =>
//      map[key] = new NamespaceInfo.fromJson(value));
//    }
//    return map;
//  }
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

