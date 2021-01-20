part of xpx_chain_sdk.namespace;

class NamespaceDTO {
  NamespaceDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    owner = json['owner'];
    ownerAddress = json['ownerAddress'];
    startHeight = UInt64DTO.fromJson(json['startHeight']);
    endHeight = UInt64DTO.fromJson(json['endHeight']);
    depth = json['depth'];
    level0 = UInt64DTO.fromJson(json['level0']);
    level1 = UInt64DTO.fromJson(json['level1']);
    level2 = UInt64DTO.fromJson(json['level2']);
    type = json['type'];
    alias = AliasDTO.fromJson(json['alias']);
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
  AliasDTO alias;
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

  static List<NamespaceDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => NamespaceDTO.fromJson(value)).toList();

  static Map<String, NamespaceDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceDTO.fromJson(value));
    }
    return map;
  }
}

class NamespaceInfoDTO {
  NamespaceInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    meta = NamespaceMetaDTO.fromJson(json['meta']);
    _namespace = NamespaceDTO.fromJson(json['namespace']);
  }

  NamespaceMetaDTO meta;

  NamespaceDTO _namespace;

  static List<NamespaceInfoDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => NamespaceInfoDTO.fromJson(value)).toList();

  static Map<String, NamespaceInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceInfoDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['namespace'] = _namespace;

    return data;
  }
}

class NamespaceMetaDTO {
  NamespaceMetaDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    id = json['id'];
    active = json['active'];
    index = json['index'];
  }

  String id;

  bool active;

  int index;

  static List<NamespaceMetaDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => NamespaceMetaDTO.fromJson(value)).toList();

  static Map<String, NamespaceMetaDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceMetaDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceMetaDTO.fromJson(value));
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

class NamespaceNameDTO {
  NamespaceNameDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    parentId = UInt64DTO.fromJson(json['parentId']);
    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    name = json['name'];
  }

  UInt64DTO parentId;

  UInt64DTO namespaceId;

  String name;

  static List<NamespaceNameDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => NamespaceNameDTO.fromJson(value)).toList();

  static Map<String, NamespaceNameDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NamespaceNameDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NamespaceNameDTO.fromJson(value));
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

class RegisterNamespaceTransactionInfoDTO {
  RegisterNamespaceTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? RegisterNamespaceTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  RegisterNamespaceTransactionDTO transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction.toJson();
    }
    return data;
  }
}

class RegisterNamespaceTransactionDTO extends AbstractTransactionDTO {
  RegisterNamespaceTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      this.namespaceId,
      this.namespaceType,
      this.name,
      UInt64DTO parenId,
      this.duration}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
    parentId = UInt64DTO.fromJson(parenId);
  }

  RegisterNamespaceTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);

    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
    namespaceType = json['namespaceType'];
    name = json['name'];
    parentId = json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    duration = json['duration'] != null ? UInt64DTO.fromJson(json['duration']) : null;
  }

  UInt64DTO namespaceId;
  int namespaceType;
  String name;
  UInt64DTO duration;
  UInt64DTO parentId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['namespaceId'] = namespaceId;
    data['namespaceType'] = namespaceType;
    data['name'] = name;
    data['duration'] = duration;
    return data;
  }
}
