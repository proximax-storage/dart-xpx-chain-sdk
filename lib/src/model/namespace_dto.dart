part of xpx_chain_sdk;

class _NamespaceDTO {
  _NamespaceDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    owner = json['owner'];
    ownerAddress = json['ownerAddress'];
    startHeight = UInt64DTO.fromJson(json['startHeight']);
    endHeight = UInt64DTO.fromJson(json['endHeight']);
    depth = json['depth'];
    level0 = UInt64DTO.fromJson(json['level0']);
    level1 = UInt64DTO.fromJson(json['level1']);
    level2 = UInt64DTO.fromJson(json['level2']);
    type = json['type'];
    alias = _AliasDTO.fromJson(json['alias']);
    parentId = UInt64DTO.fromJson(json['parentId']);
  }

  String owner;
  String ownerAddress;
  UInt64DTO startHeight;
  UInt64DTO endHeight;
  int depth;
  UInt64DTO level0;
  UInt64DTO level1;
  UInt64DTO level2;
  int type;
  _AliasDTO alias;
  UInt64DTO parentId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['owner'] = owner;
    data['ownerAddress'] = ownerAddress;
    data['startHeight'] = startHeight;
    data['endHeight'] = endHeight;
    data['depth'] = depth;
    data['level0'] = level0;
    data['level1'] = level1;
    data['level2'] = level2;
    data['type'] = type;
    data['alias'] = alias;
    data['parentId'] = parentId;

    return data;
  }

  static List<_NamespaceDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _NamespaceDTO.fromJson(value)).toList();

  static Map<String, _NamespaceDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _NamespaceDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _NamespaceDTO.fromJson(value));
    }
    return map;
  }
}

class _NamespaceInfoDTO {
  _NamespaceInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    meta = _NamespaceMetaDTO.fromJson(json['meta']);
    namespace = _NamespaceDTO.fromJson(json['namespace']);
  }

  _NamespaceMetaDTO meta;

  _NamespaceDTO namespace;

  static List<_NamespaceInfoDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _NamespaceInfoDTO.fromJson(value)).toList();

  static Map<String, _NamespaceInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _NamespaceInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _NamespaceInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['namespace'] = namespace;

    return data;
  }
}

class _NamespaceMetaDTO {
  _NamespaceMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    id = json['id'];
    active = json['active'];
    index = json['index'];
  }

  String id;

  bool active;

  int index;

  static List<_NamespaceMetaDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _NamespaceMetaDTO.fromJson(value)).toList();

  static Map<String, _NamespaceMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _NamespaceMetaDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _NamespaceMetaDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['index'] = index;

    return data;
  }
}

class _NamespaceNameDTO {
  _NamespaceNameDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    parentId = UInt64DTO.fromJson(json['parentId']);
    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    name = json['name'];
  }

  UInt64DTO parentId;

  UInt64DTO namespaceId;

  String name;

  static List<_NamespaceNameDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _NamespaceNameDTO.fromJson(value)).toList();

  static Map<String, _NamespaceNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _NamespaceNameDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (key, value) => map[key] = _NamespaceNameDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['namespaceId'] = namespaceId;
    data['name'] = name;

    return data;
  }
}

class _RegisterNamespaceTransactionInfoDTO {
  _RegisterNamespaceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;
    _transaction = json['transaction'] != null
        ? _RegisterNamespaceTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _RegisterNamespaceTransactionDTO _transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (_meta != null) {
      data['meta'] = _meta.toJson();
    }
    if (_transaction != null) {
      data['transaction'] = _transaction.toJson();
    }
    return data;
  }
}

class _RegisterNamespaceTransactionDTO extends _AbstractTransactionDTO {
  _RegisterNamespaceTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      UInt64DTO namespaceId,
      int namespaceType,
      String name,
      UInt64DTO parenId,
      UInt64DTO duration}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
    _namespaceId = namespaceId;
    _namespaceType = namespaceType;
    _name = name;
    _duration = duration;
    _parentId = UInt64DTO.fromJson(parenId);
  }

  _RegisterNamespaceTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    _namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    _namespaceType = json['namespaceType'];
    _name = json['name'];
    _parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    _duration =
        json['duration'] != null ? UInt64DTO.fromJson(json['duration']) : null;
  }

  UInt64DTO _namespaceId;
  int _namespaceType;
  String _name;
  UInt64DTO _duration;
  UInt64DTO _parentId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['namespaceId'] = _namespaceId;
    data['namespaceType'] = _namespaceType;
    data['name'] = _name;
    data['duration'] = _duration;
    return data;
  }
}
