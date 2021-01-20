part of xpx_chain_sdk.mosaic;

class MosaicDTO {
  MosaicDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
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

  static List<MosaicDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MosaicDTO.fromJson(value)).toList();
}

class MosaicInfoDTO {
  MosaicInfoDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    meta = MosaicMetaDTO.fromJson(json['meta']);
    _mosaic = MosaicDefinitionDTO.fromJson(json['mosaic']);
  }

  MosaicMetaDTO meta;

  MosaicDefinitionDTO _mosaic;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['meta'] = meta;
    data['mosaic'] = _mosaic;

    return data;
  }
}

class MosaicMetaDTO {
  MosaicMetaDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _id = json['id'];
  }

  String _id;

  Map<String, dynamic> toJson() => {'id': _id};
}

class MosaicDefinitionDTO {
  MosaicDefinitionDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
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

  UInt64DTO mosaicId;
  UInt64DTO _supply;
  UInt64DTO _height;
  String _owner;
  int _revision;
  List<_MosaicPropertyDTO> _properties;
}

class MosaicNameDTO {
  MosaicNameDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _parentId = json['parentId'] != null ? UInt64DTO.fromJson(json['parentId']) : null;

    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    _names = List.from(json['names']);
  }

  UInt64DTO _parentId;

  UInt64DTO mosaicId;

  List<String> _names;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parentId'] = _parentId;
    data['mosaicId'] = mosaicId;
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
      json == null ? null : json.map((value) => _MosaicPropertyDTO.fromJson(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = _id;
    data['value'] = _value;

    return data;
  }
}

class MosaicDefinitionTransactionInfoDTO {
  MosaicDefinitionTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;
    transaction = json['transaction'] != null ? MosaicDefinitionTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  MosaicDefinitionTransactionDTO transaction;

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

class MosaicDefinitionTransactionDTO extends AbstractTransactionDTO {
  MosaicDefinitionTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      this.mosaicId,
      this.mosaicNonce,
      this.properties,
      this.duration}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  MosaicDefinitionTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    mosaicNonce = json['mosaicNonce'];
    properties = _MosaicPropertyDTO.listFromJson(json['properties']);
    duration = UInt64DTO.fromJson(json['duration']);
  }

  UInt64DTO mosaicId;
  int mosaicNonce;
  List<_MosaicPropertyDTO> properties;
  UInt64DTO duration;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['duration'] = duration;
    return data;
  }
}

class MosaicSupplyChangeTransactionInfoDTO {
  MosaicSupplyChangeTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null ? _MosaicSupplyChangeTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  _MosaicSupplyChangeTransactionDTO transaction;

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

class _MosaicSupplyChangeTransactionDTO extends AbstractTransactionDTO {
  _MosaicSupplyChangeTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      this.mosaicId,
      this.direction,
      this.delta}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  _MosaicSupplyChangeTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    direction = json['direction'];
    delta = UInt64DTO.fromJson(json['delta']);
  }

  UInt64DTO mosaicId;
  int direction;
  UInt64DTO delta;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['mosaicId'] = mosaicId;
    data['direction'] = direction;
    data['delta'] = delta;
    return data;
  }
}

class MosaicAliasTransactionInfoDTO {
  MosaicAliasTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction = json['transaction'] != null ? MosaicAliasDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  MosaicAliasDTO transaction;

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

class MosaicAliasDTO extends AbstractTransactionDTO {
  MosaicAliasDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    deadline = UInt64DTO.fromJson(json['deadline']);
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    aliasAction = json['aliasAction'];
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    namespaceId = UInt64DTO.fromJson(json['namespaceId']);
  }

  int aliasAction;
  UInt64DTO mosaicId;
  UInt64DTO namespaceId;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aliasAction'] = aliasAction;
    data['mosaicId'] = mosaicId;
    data['namespaceId'] = namespaceId;
    return data;
  }
}
