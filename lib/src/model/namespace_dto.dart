part of xpx_chain_sdk;

class _NamespaceDTO {
  _NamespaceDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _owner = json['owner'];
    _ownerAddress = json['ownerAddress'];
    _startHeight = UInt64DTO.fromJson(json['startHeight']);
    _endHeight = UInt64DTO.fromJson(json['endHeight']);
    _depth = json['depth'];
    _level0 = UInt64DTO.fromJson(json['level0']);
    _level1 = UInt64DTO.fromJson(json['level1']);
    _level2 = UInt64DTO.fromJson(json['level2']);
    _type = json['type'];
    _alias = _AliasDTO.fromJson(json['alias']);
    _parentId = UInt64DTO.fromJson(json['parentId']);
  }

  String _owner;
  String _ownerAddress;
  UInt64DTO _startHeight;
  UInt64DTO _endHeight;
  int _depth;
  UInt64DTO _level0;
  UInt64DTO _level1;
  UInt64DTO _level2;
  int _type;
  _AliasDTO _alias;
  UInt64DTO _parentId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['owner'] = _owner;
    data['ownerAddress'] = _ownerAddress;
    data['startHeight'] = _startHeight;
    data['endHeight'] = _endHeight;
    data['depth'] = _depth;
    data['level0'] = _level0;
    data['level1'] = _level1;
    data['level2'] = _level2;
    data['type'] = _type;
    data['alias'] = _alias;
    data['parentId'] = _parentId;

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
    _meta = _NamespaceMetaDTO.fromJson(json['meta']);
    _namespace = _NamespaceDTO.fromJson(json['namespace']);
  }

  _NamespaceMetaDTO _meta;

  _NamespaceDTO _namespace;

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
    data['meta'] = _meta;
    data['namespace'] = _namespace;

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
    _signature = signature;
    _signer = signer;
    _version = version;
    _type = type;
    _deadline = UInt64DTO.fromJson(deadline);
    _fee = UInt64DTO.fromJson(maxFee);
    _namespaceId = namespaceId;
    _namespaceType = namespaceType;
    _name = name;
    _duration = duration;
    _parentId = UInt64DTO.fromJson(parenId);
  }

  _RegisterNamespaceTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
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
    data['signature'] = _signature;
    data['signer'] = _signer;
    data['version'] = _version;
    data['type'] = _type;
    data['maxFee'] = _fee;
    data['deadline'] = _deadline;
    data['namespaceId'] = _namespaceId;
    data['namespaceType'] = _namespaceType;
    data['name'] = _name;
    data['duration'] = _duration;
    return data;
  }
}
