part of xpx_chain_sdk;

class _NamespaceDTO {
  _NamespaceDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    owner = json['owner'] as String;
    ownerAddress = json['ownerAddress'] as String;
    startHeight = new UInt64DTO.fromJson(json['startHeight']);
    endHeight = new UInt64DTO.fromJson(json['endHeight']);
    depth = json['depth'] as int;
    level0 = new UInt64DTO.fromJson(json['level0']);
    level1 = new UInt64DTO.fromJson(json['level1']);
    level2 = new UInt64DTO.fromJson(json['level2']);
    type = json['type'] as int;
    alias = new _AliasDTO.fromJson(json['alias'] as Map<String, dynamic>);
    parentId = new UInt64DTO.fromJson(json['parentId']);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner'] = this.owner;
    data['ownerAddress'] = this.ownerAddress;
    data['startHeight'] = this.startHeight;
    data['endHeight'] = this.endHeight;
    data['depth'] = this.depth;
    data['level0'] = this.level0;
    data['level1'] = this.level1;
    data['level2'] = this.level2;
    data['type'] = this.type;
    data['alias'] = this.alias;
    data['parentId'] = this.parentId;

    return data;
  }

  static List<_NamespaceDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_NamespaceDTO>()
        : json
            .map((dynamic value) =>
                new _NamespaceDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _NamespaceDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _NamespaceDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _NamespaceDTO.fromJson(value));
    }
    return map;
  }
}

class _NamespaceInfoDTO {
  _NamespaceInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _NamespaceMetaDTO.fromJson(json['meta'] as Map<String, dynamic>);
    namespace =
        new _NamespaceDTO.fromJson(json['namespace'] as Map<String, dynamic>);
  }

  _NamespaceMetaDTO meta;

  _NamespaceDTO namespace;

  static List<_NamespaceInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_NamespaceInfoDTO>()
        : json
            .map((dynamic value) =>
                new _NamespaceInfoDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _NamespaceInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _NamespaceInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _NamespaceInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meta'] = this.meta;
    data['namespace'] = this.namespace;

    return data;
  }
}

class _NamespaceMetaDTO {
  _NamespaceMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'] as String;
    active = json['active'] as bool;
    index = json['index'] as int;
  }

  String id;

  bool active;

  int index;

  static List<_NamespaceMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_NamespaceMetaDTO>()
        : json
            .map((dynamic value) =>
                new _NamespaceMetaDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _NamespaceMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _NamespaceMetaDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _NamespaceMetaDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['index'] = this.index;

    return data;
  }
}

class _NamespaceNameDTO {
  _NamespaceNameDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentId = new UInt64DTO.fromJson(json['parentId']);
    namespaceId = new UInt64DTO.fromJson(json['namespaceId']);
    name = json['name'] as String;
  }

  UInt64DTO parentId;

  UInt64DTO namespaceId;

  String name;

  static List<_NamespaceNameDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_NamespaceNameDTO>()
        : json
            .map((dynamic value) =>
                new _NamespaceNameDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _NamespaceNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _NamespaceNameDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _NamespaceNameDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentId'] = this.parentId;
    data['namespaceId'] = this.namespaceId;
    data['name'] = this.name;

    return data;
  }
}

class _RegisterNamespaceTransactionInfoDTO {
  _RegisterNamespaceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? new _MetaTransactionDTO.fromJson(json['meta'] as Map<String, dynamic>)
        : null;
    _transaction = json['transaction'] != null
        ? new _RegisterNamespaceTransactionDTO.fromJson(
            json['transaction'] as Map<String, dynamic>)
        : null;
  }

  _MetaTransactionDTO _meta;
  _RegisterNamespaceTransactionDTO _transaction;

  _MetaTransactionDTO get meta => _meta;
  set meta(_MetaTransactionDTO meta) => _meta = meta;
  _RegisterNamespaceTransactionDTO get transaction => _transaction;
  set transaction(_RegisterNamespaceTransactionDTO transaction) =>
      _transaction = transaction;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._meta != null) {
      data['meta'] = this._meta.toJson();
    }
    if (this._transaction != null) {
      data['transaction'] = this._transaction.toJson();
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
    this.fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    this._namespaceId = namespaceId;
    this._namespaceType = namespaceType;
    this._name = name;
    this._duration = duration;
    this._parentId = UInt64DTO.fromJson(deadline);
  }

  _RegisterNamespaceTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.signature = json['signature'] as String;
    this.signer = json['signer'] as String;
    this.version = json['version'] as int;
    this.type = json['type'] as int;
    this.fee = UInt64DTO.fromJson(json['maxFee']);
    this.deadline = UInt64DTO.fromJson(json['deadline']);
    this._namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    this._namespaceType = json['namespaceType'] as int;
    this._name = json['name'] as String;
    this._parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    this._duration =
        json['duration'] != null ? UInt64DTO.fromJson(json['duration']) : null;
  }

  UInt64DTO _namespaceId;
  int _namespaceType;
  String _name;
  UInt64DTO _duration;
  UInt64DTO _parentId;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signature'] = this.signature;
    data['signer'] = this.signer;
    data['version'] = this.version;
    data['type'] = this.type;
    data['maxFee'] = this.fee;
    data['deadline'] = this.deadline;
    data['namespaceId'] = this._namespaceId;
    data['namespaceType'] = this._namespaceType;
    data['name'] = this._name;
    data['duration'] = this._duration;
    return data;
  }
}
