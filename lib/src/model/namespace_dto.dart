part of xpx_catapult_sdk ;

class NamespaceDTO {
  String owner = null;

  String ownerAddress = null;

  UInt64DTO startHeight = null;

  UInt64DTO endHeight = null;

  int depth = null;

  UInt64DTO level0 = null;

  UInt64DTO level1 = null;

  UInt64DTO level2 = null;

  int type = null;

  AliasDTO alias = null;

  UInt64DTO parentId = null;

  NamespaceDTO();

  @override
  String toString() {
    return 'NamespaceDTO[owner=$owner, ownerAddress=$ownerAddress, startHeight=$startHeight, endHeight=$endHeight, depth=$depth, level0=$level0, level1=$level1, level2=$level2, type=$type, alias=$alias, parentId=$parentId, ]';
  }

  NamespaceDTO.fromJson(Map<String, dynamic> json) {

    if (json == null) return;
    owner = json['owner'];
    ownerAddress = json['ownerAddress'];
    startHeight = new UInt64DTO.fromJson(json['startHeight']);
    endHeight = new UInt64DTO.fromJson(json['endHeight']);
    depth = json['depth'];
    level0 = new UInt64DTO.fromJson(json['level0']);
    level1 = new UInt64DTO.fromJson(json['level1']);
    level2 = new UInt64DTO.fromJson(json['level2']);
    type = json['type'];
    alias = new AliasDTO.fromJson(json['alias']);
    parentId = new UInt64DTO.fromJson(json['parentId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'ownerAddress': ownerAddress,
      'startHeight': startHeight,
      'endHeight': endHeight,
      'depth': depth,
      'level0': level0,
      'level1': level1,
      'level2': level2,
      'type': type,
      'alias': alias,
      'parentId': parentId
    };
  }

  static List<NamespaceDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NamespaceDTO>()
        : json.map((value) => new NamespaceDTO.fromJson(value)).toList();
  }

  static Map<String, NamespaceDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NamespaceDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NamespaceDTO.fromJson(value));
    }
    return map;
  }
}

class _namespaceInfoDTO {
  _namespaceMetaDTO meta = null;

  NamespaceDTO namespace = null;

  _namespaceInfoDTO();

  @override
  String toString() {
    return '_namespaceInfoDTO[meta=$meta, namespace=$namespace, ]';
  }

  _namespaceInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _namespaceMetaDTO.fromJson(json['meta']);
    namespace = new NamespaceDTO.fromJson(json['namespace']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'namespace': namespace};
  }

  static List<_namespaceInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_namespaceInfoDTO>()
        : json.map((value) => new _namespaceInfoDTO.fromJson(value)).toList();
  }

  static Map<String, _namespaceInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _namespaceInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new _namespaceInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _namespaceMetaDTO {
  String id = null;

  bool active = null;

  int index = null;

  _namespaceMetaDTO();

  @override
  String toString() {
    return '_namespaceMetaDTO[id=$id, active=$active, index=$index, ]';
  }

  _namespaceMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    active = json['active'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'active': active, 'index': index};
  }

  static List<_namespaceMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_namespaceMetaDTO>()
        : json.map((value) => new _namespaceMetaDTO.fromJson(value)).toList();
  }

  static Map<String, _namespaceMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _namespaceMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new _namespaceMetaDTO.fromJson(value));
    }
    return map;
  }
}