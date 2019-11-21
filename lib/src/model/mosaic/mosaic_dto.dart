part of xpx_chain_sdk;

class _MosaicDTO {
  _MosaicDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _id = UInt64DTO.fromJson(json['id']);
    _amount = UInt64DTO.fromJson(json['amount']);
  }

  UInt64DTO _id;

  UInt64DTO _amount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = _id;
    data['amount'] = _amount;

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
    _meta = _MosaicMetaDTO.fromJson(json['meta']);
    _mosaic = _MosaicDefinitionDTO.fromJson(json['mosaic']);
  }

  _MosaicMetaDTO _meta;

  _MosaicDefinitionDTO _mosaic;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = _meta;
    data['mosaic'] = _mosaic;

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
    _id = json['id'];
  }

  String _id;

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

  Map<String, dynamic> toJson() => {'id': _id};
}

class _MosaicDefinitionDTO {
  _MosaicDefinitionDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _supply = UInt64DTO.fromJson(json['supply']);
    _height = UInt64DTO.fromJson(json['height']);
    _owner = json['owner'];
    _revision = json['revision'];

    if (json['properties'] != null) {
      _properties = [];
      for (int i = 0; i < 3; i++) {
        _properties.add(_MosaicPropertyDTO.fromJson(json['properties'][i]));
      }
    }
  }

  UInt64DTO _mosaicId;
  UInt64DTO _supply;
  UInt64DTO _height;
  String _owner;
  int _revision;
  List<_MosaicPropertyDTO> _properties;

  Object _levy;
}

class _MosaicNameDTO {
  _MosaicNameDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _parentId =
        json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _names = List.from(json['names']);
  }

  UInt64DTO _parentId;

  UInt64DTO _mosaicId;

  List<String> _names;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = _parentId;
    data['mosaicId'] = _mosaicId;
    data['names'] = _names;

    return data;
  }
}

class _MosaicPropertyDTO {
  _MosaicPropertyDTO.fromJson(Map<String, dynamic> value) {
    _id = value['id'];
    _value = UInt64DTO.fromJson(value['value']);
  }

  int _id;
  UInt64DTO _value;

  static List<_MosaicPropertyDTO> listFromJson(List<dynamic> json) =>
      json == null
          ? null
          : json.map((value) => _MosaicPropertyDTO.fromJson(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = _id;
    data['value'] = _value;

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
      List<_MosaicPropertyDTO> properties,
      UInt64DTO duration}) {
    _signature = signature;
    _signer = signer;
    _version = version;
    _type = type;
    _deadline = UInt64DTO.fromJson(deadline);
    _fee = UInt64DTO.fromJson(maxFee);
    _mosaicId = mosaicId;
    _mosaicNonce = mosaicNonce;
    _properties = properties;
    _duration = duration;
  }

  _MosaicDefinitionTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _mosaicNonce = json['mosaicNonce'];
    _properties = _MosaicPropertyDTO.listFromJson(json['properties']);
    _duration = UInt64DTO.fromJson(json['duration']);
  }

  UInt64DTO _mosaicId;
  int _mosaicNonce;
  List<_MosaicPropertyDTO> _properties;
  UInt64DTO _duration;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = _signature;
    data['signer'] = _signer;
    data['version'] = _version;
    data['type'] = _type;
    data['maxFee'] = _fee;
    data['deadline'] = _deadline;
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
    _signature = signature;
    _signer = signer;
    _version = version;
    _type = type;
    _deadline = UInt64DTO.fromJson(deadline);
    _fee = UInt64DTO.fromJson(maxFee);
    _mosaicId = mosaicId;
    _direction = direction;
    _delta = delta;
  }

  _MosaicSupplyChangeTransactionDTO.fromJson(Map<String, dynamic> json) {
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _deadline = UInt64DTO.fromJson(json['deadline']);
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
    data['signature'] = _signature;
    data['signer'] = _signer;
    data['version'] = _version;
    data['type'] = _type;
    data['maxFee'] = _fee;
    data['deadline'] = _deadline;
    data['mosaicId'] = _mosaicId;
    data['direction'] = _direction;
    data['delta'] = _delta;
    return data;
  }
}

class _MosaicAliasTransactionInfoDTO {
  _MosaicAliasTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? _MetaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? _MosaicAliasDTO.fromJson(json['transaction'])
        : null;
  }

  _MetaTransactionDTO _meta;
  _MosaicAliasDTO _transaction;

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

class _MosaicAliasDTO extends _AbstractTransactionDTO {
  _MosaicAliasDTO.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    _deadline = UInt64DTO.fromJson(json['deadline']);
    _signature = json['signature'];
    _signer = json['signer'];
    _version = json['version'];
    _type = json['type'];
    _fee = UInt64DTO.fromJson(json['maxFee']);
    _aliasAction = json['aliasAction'];
    _mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _namespaceId = UInt64DTO.fromJson(json['namespaceId']);
  }

  int _aliasAction;
  UInt64DTO _mosaicId;
  UInt64DTO _namespaceId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = _aliasAction;
    data['mosaicId'] = _mosaicId;
    data['namespaceId'] = _namespaceId;
    return data;
  }
}
