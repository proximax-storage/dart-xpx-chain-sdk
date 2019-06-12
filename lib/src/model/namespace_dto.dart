part of xpx_chain_sdk;

class _namespaceDTO {
  String owner;
  String ownerAddress;
  UInt64DTO startHeight;
  UInt64DTO endHeight;
  int depth;
  UInt64DTO level0;
  UInt64DTO level1;
  UInt64DTO level2;
  int type;
  _aliasDTO alias;
  UInt64DTO parentId;

  _namespaceDTO();

  @override
  String toString() {
    return '_namespaceDTO[owner=$owner, ownerAddress=$ownerAddress, startHeight=$startHeight, endHeight=$endHeight, depth=$depth, level0=$level0, level1=$level1, level2=$level2, type=$type, alias=$alias, parentId=$parentId, ]';
  }

  _namespaceDTO.fromJson(Map<String, dynamic> json) {
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
    alias = new _aliasDTO.fromJson(json['alias']);
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

  static List<_namespaceDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_namespaceDTO>()
        : json.map((value) => new _namespaceDTO.fromJson(value)).toList();
  }

  static Map<String, _namespaceDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _namespaceDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _namespaceDTO.fromJson(value));
    }
    return map;
  }
}

class _namespaceInfoDTO {
  _namespaceMetaDTO meta;

  _namespaceDTO namespace;

  _namespaceInfoDTO();

  @override
  String toString() {
    return '_namespaceInfoDTO[meta=$meta, namespace=$namespace, ]';
  }

  _namespaceInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _namespaceMetaDTO.fromJson(json['meta']);
    namespace = new _namespaceDTO.fromJson(json['namespace']);
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

class _namespaceNameDTO {
  UInt64DTO parentId = null;

  UInt64DTO namespaceId = null;

  String name = null;

  _namespaceNameDTO();

  @override
  String toString() {
    return '_namespaceNameDTO[parentId=$parentId, namespaceId=$namespaceId, name=$name, ]';
  }

  _namespaceNameDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentId = new UInt64DTO.fromJson(json['parentId']);
    namespaceId = new UInt64DTO.fromJson(json['namespaceId']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'parentId': parentId, 'namespaceId': namespaceId, 'name': name};
  }

  static List<_namespaceNameDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_namespaceNameDTO>()
        : json.map((value) => new _namespaceNameDTO.fromJson(value)).toList();
  }

  static Map<String, _namespaceNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _namespaceNameDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _namespaceNameDTO.fromJson(value));
    }
    return map;
  }
}

class _registerNamespaceTransactionInfoDTO {
  _metaTransactionDTO _meta;
  _registerNamespaceTransactionDTO _transaction;

  Autogenerated(
      {_metaTransactionDTO meta,
      _registerNamespaceTransactionDTO transaction}) {
    this._meta = meta;
    this._transaction = transaction;
  }

  _metaTransactionDTO get meta => _meta;
  set meta(_metaTransactionDTO meta) => _meta = meta;
  _registerNamespaceTransactionDTO get transaction => _transaction;
  set transaction(_registerNamespaceTransactionDTO transaction) =>
      _transaction = transaction;

  _registerNamespaceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? new _metaTransactionDTO.fromJson(json['meta'])
        : null;
    _transaction = json['transaction'] != null
        ? new _registerNamespaceTransactionDTO.fromJson(json['transaction'])
        : null;
  }

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

class _registerNamespaceTransactionDTO extends _abstractTransactionDTO {
  UInt64DTO _namespaceId;
  int _namespaceType;
  String _name;
  UInt64DTO _duration;
  UInt64DTO _parentId;

  _registerNamespaceTransactionDTO(
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
    this.Signature = signature;
    this.Signer = signer;
    this.Version = version;
    this.Type = type;
    this.Fee = UInt64DTO.fromJson(maxFee);
    this.Deadline = UInt64DTO.fromJson(deadline);
    this._namespaceId = namespaceId;
    this._namespaceType = namespaceType;
    this._name = name;
    this._duration = duration;
    this._parentId = UInt64DTO.fromJson(deadline);
  }

  _registerNamespaceTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.Signature = json['signature'];
    this.Signer = json['signer'];
    this.Version = json['version'];
    this.Type = json['type'];
    this.Fee = UInt64DTO.fromJson(json['maxFee']);
    this.Deadline = UInt64DTO.fromJson(json['deadline']);
    this._namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    this._namespaceType = json['namespaceType'];
    this._name = json['name'];
    this._parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    this._duration =
        json['duration'] != null ? UInt64DTO.fromJson(json['duration']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signature'] = this.Signature;
    data['signer'] = this.Signer;
    data['version'] = this.Version;
    data['type'] = this.Type;
    data['maxFee'] = this.Fee;
    data['deadline'] = this.Deadline;
    data['namespaceId'] = this._namespaceId;
    data['namespaceType'] = this._namespaceType;
    data['name'] = this._name;
    data['duration'] = this._duration;
    return data;
  }
}
