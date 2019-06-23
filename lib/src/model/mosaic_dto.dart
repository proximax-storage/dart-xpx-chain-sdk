part of xpx_chain_sdk;

class _MosaicDTO {
  _MosaicDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    id = UInt64DTO.fromJson(json['id']);
    amount = UInt64DTO.fromJson(json['amount']);
  }

  UInt64DTO id;

  UInt64DTO amount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;

    return data;
  }

  static List<_MosaicDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _MosaicDTO.fromJson(value)).toList();

  static Map<String, _MosaicDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _MosaicDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _MosaicDTO.fromJson(value));
    }
    return map;
  }
}

class _MosaicInfoDTO {
  _MosaicInfoDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    meta = _MosaicMetaDTO.fromJson(json['meta']);

    mosaic = _MosaicDefinitionDTO.fromJson(json['mosaic']);
  }

  _MosaicMetaDTO meta;

  _MosaicDefinitionDTO mosaic;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['mosaic'] = mosaic;

    return data;
  }

  static List<_MosaicInfoDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _MosaicInfoDTO.fromJson(value)).toList();

  static Map<String, _MosaicInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _MosaicInfoDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _MosaicInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _MosaicMetaDTO {
  _MosaicMetaDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    id = json['id'];
  }

  String id;

  static List<_MosaicMetaDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _MosaicMetaDTO.fromJson(value)).toList();

  static Map<String, _MosaicMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _MosaicMetaDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _MosaicMetaDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() => {'id': id};
}

class _MosaicDefinitionDTO {
  _MosaicDefinitionDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    supply = UInt64DTO.fromJson(json['supply']);
    height = UInt64DTO.fromJson(json['height']);
    owner = json['owner'];
    revision = json['revision'];

    if (json['properties'] != null) {
      properties = [];
      for (int i = 0; i < 3; i++) {
        properties.add(UInt64DTO.fromJson(json['properties'][i]));
      }
    }
  }

  UInt64DTO mosaicId;
  UInt64DTO supply;
  UInt64DTO height;
  String owner;
  int revision;
  List<UInt64DTO> properties;

  Object levy;
}

class _MosaicNameDTO {
  _MosaicNameDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    names = List.from(json['names']);
  }

  UInt64DTO parentId;

  UInt64DTO mosaicId;

  List<String> names;

  static List<_MosaicNameDTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => _MosaicNameDTO.fromJson(value)).toList();

  static Map<String, _MosaicNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, _MosaicNameDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = _MosaicNameDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['mosaicId'] = mosaicId;
    data['names'] = names;

    return data;
  }
}

class _MosaicPropertiesDTO {
  _MosaicPropertiesDTO.fromJson(Map<String, dynamic> value) {
    id = value['id'];
    this.value = UInt64DTO.fromJson(value['value']);
  }

  int id;
  UInt64DTO value;

  static List<_MosaicPropertiesDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _MosaicPropertiesDTO.fromJson(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;

    return data;
  }
}

class _MosaicDefinitionTransactionInfoDTO {
  _MosaicDefinitionTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? _MosaicDefinitionTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _MosaicDefinitionTransactionDTO _transaction;

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

class _MosaicDefinitionTransactionDTO extends _AbstractTransactionDTO {
  _MosaicDefinitionTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      UInt64DTO mosaicId,
      int mosaicNonce,
      List<_MosaicPropertiesDTO> properties,
      UInt64DTO duration}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
    _mosaicId = mosaicId;
    _mosaicNonce = mosaicNonce;
    _properties = properties;
    _duration = duration;
  }

  _MosaicDefinitionTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _mosaicNonce = json['mosaicNonce'];
    _properties = _MosaicPropertiesDTO.listFromJson(json['properties']);
    _duration = UInt64DTO.fromJson(json['duration']);
  }

  UInt64DTO _mosaicId;
  int _mosaicNonce;
  List<_MosaicPropertiesDTO> _properties;
  UInt64DTO _duration;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;

    data['duration'] = _duration;
    return data;
  }
}

class _MosaicSupplyChangeTransactionInfoDTO {
  _MosaicSupplyChangeTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? _MosaicSupplyChangeTransactionDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _MosaicSupplyChangeTransactionDTO _transaction;

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

class _MosaicSupplyChangeTransactionDTO extends _AbstractTransactionDTO {
  _MosaicSupplyChangeTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      UInt64DTO mosaicId,
      int direction,
      UInt64DTO delta}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
    _mosaicId = mosaicId;
    _direction = direction;
    _delta = delta;
  }

  _MosaicSupplyChangeTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _direction = json['direction'];
    _delta = UInt64DTO.fromJson(json['delta']);
  }

  UInt64DTO _mosaicId;
  int _direction;
  UInt64DTO _delta;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['mosaicId'] = _mosaicId;
    data['direction'] = _direction;
    data['delta'] = _delta;
    return data;
  }
}
