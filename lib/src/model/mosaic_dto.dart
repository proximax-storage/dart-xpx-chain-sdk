part of xpx_chain_sdk;

class _MosaicDTO {
  _MosaicDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =  UInt64DTO.fromJson(json['id']);
    amount =  UInt64DTO.fromJson(json['amount']);
  }

  UInt64DTO id;

  UInt64DTO amount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;

    return data;
  }

  static List<_MosaicDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_MosaicDTO>()
        : json
            .map((dynamic value) =>
                 _MosaicDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MosaicDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _MosaicDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _MosaicDTO.fromJson(value));
    }
    return map;
  }
}

class _MosaicInfoDTO {
  _MosaicInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta =  _MosaicMetaDTO.fromJson(json['meta'] as Map<String, dynamic>);

    mosaic =  _MosaicDefinitionDTO.fromJson(
        json['mosaic'] as Map<String, dynamic>);
  }

  _MosaicMetaDTO meta;

  _MosaicDefinitionDTO mosaic;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['meta'] = meta;
    data['mosaic'] = mosaic;

    return data;
  }

  static List<_MosaicInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_MosaicInfoDTO>()
        : json
            .map((dynamic value) =>
                 _MosaicInfoDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MosaicInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _MosaicInfoDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _MosaicInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _MosaicMetaDTO {
  _MosaicMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'] as String;
  }

  String id;

  static List<_MosaicMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_MosaicMetaDTO>()
        : json
            .map((dynamic value) =>
                 _MosaicMetaDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MosaicMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _MosaicMetaDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _MosaicMetaDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    return data;
  }
}

class _MosaicDefinitionDTO {
  _MosaicDefinitionDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    mosaicId =  UInt64DTO.fromJson(json['mosaicId']);
    supply =  UInt64DTO.fromJson(json['supply']);
    height =  UInt64DTO.fromJson(json['height']);
    owner = json['owner'] as String;
    revision = json['revision'] as int;

    if (json['properties'] != null) {
      properties = [];
      for (int i = 0; i < 3; i++)
        properties.add(UInt64DTO.fromJson(json['properties'][i]));
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
  _MosaicNameDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentId =  UInt64DTO.fromJson(json['parentId']);
    mosaicId =  UInt64DTO.fromJson(json['mosaicId']);
    names = List.from(json['names'] as Iterable);
  }

  UInt64DTO parentId;

  UInt64DTO mosaicId;

  List<String> names;

  static List<_MosaicNameDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_MosaicNameDTO>()
        : json
            .map((dynamic value) =>
                 _MosaicNameDTO.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, _MosaicNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, _MosaicNameDTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  _MosaicNameDTO.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['parentId'] = parentId;
    data['mosaicId'] = mosaicId;
    data['names'] = names;

    return data;
  }
}

class _MosaicPropertiesDTO {
  _MosaicPropertiesDTO.fromJson(Map<String, dynamic> value) {
    this.id = value["id"] as int;
    this.value = UInt64DTO.fromJson(value["value"]);
  }

  int id;
  UInt64DTO value;

  static List<_MosaicPropertiesDTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<_MosaicPropertiesDTO>()
        : json
            .map((dynamic value) =>  _MosaicPropertiesDTO.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['value'] = value;

    return data;
  }
}

class _MosaicDefinitionTransactionInfoDTO {
  _MosaicDefinitionTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ?  _MetaTransactionDTO.fromJson(json['meta'] as Map<String, dynamic>)
        : null;

    _transaction = json['transaction'] != null
        ?  _MosaicDefinitionTransactionDTO.fromJson(
            json['transaction'] as Map<String, dynamic>)
        : null;
  }

  _MetaTransactionDTO _meta;
  _MosaicDefinitionTransactionDTO _transaction;

  _MetaTransactionDTO get meta => _meta;
  set meta(_MetaTransactionDTO meta) => _meta = meta;
  _MosaicDefinitionTransactionDTO get transaction => _transaction;
  set transaction(_MosaicDefinitionTransactionDTO transaction) =>
      _transaction = transaction;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this._meta != null) {
      data['meta'] = this._meta.toJson();
    }
    if (this._transaction != null) {
      data['transaction'] = this._transaction.toJson();
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
    this.fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    this._mosaicId = mosaicId;
    this._mosaicNonce = mosaicNonce;
    this._properties = properties;
    this._duration = duration;
  }

  _MosaicDefinitionTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.signature = json['signature'] as String;
    this.signer = json['signer'] as String;
    this.version = json['version'] as int;
    this.type = json['type'] as int;
    this.fee = UInt64DTO.fromJson(json['maxFee']);
    this.deadline = UInt64DTO.fromJson(json['deadline']);
    this._mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    this._mosaicNonce = json['mosaicNonce'] as int;
    this._properties =
        _MosaicPropertiesDTO.listFromJson(json['properties'] as List<dynamic>);
    this._duration = UInt64DTO.fromJson(json['duration']);
  }

  UInt64DTO _mosaicId;
  int _mosaicNonce;
  List<_MosaicPropertiesDTO> _properties;
  UInt64DTO _duration;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['signature'] = this.signature;
    data['signer'] = this.signer;
    data['version'] = this.version;
    data['type'] = this.type;
    data['maxFee'] = this.fee;
    data['deadline'] = this.deadline;

    data['duration'] = this._duration;
    return data;
  }
}

class _MosaicSupplyChangeTransactionInfoDTO {
  _MosaicSupplyChangeTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ?  _MetaTransactionDTO.fromJson(json['meta'] as Map<String, dynamic>)
        : null;

    _transaction = json['transaction'] != null
        ?  _MosaicSupplyChangeTransactionDTO.fromJson(
            json['transaction'] as Map<String, dynamic>)
        : null;
  }

  _MetaTransactionDTO _meta;
  _MosaicSupplyChangeTransactionDTO _transaction;

  _MetaTransactionDTO get meta => _meta;
  set meta(_MetaTransactionDTO meta) => _meta = meta;
  _MosaicSupplyChangeTransactionDTO get transaction => _transaction;
  set transaction(_MosaicSupplyChangeTransactionDTO transaction) =>
      _transaction = transaction;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this._meta != null) {
      data['meta'] = this._meta.toJson();
    }
    if (this._transaction != null) {
      data['transaction'] = this._transaction.toJson();
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
    this.fee = UInt64DTO.fromJson(maxFee);
    this.deadline = UInt64DTO.fromJson(deadline);
    this._mosaicId = mosaicId;
    this._direction = direction;
    this._delta = delta;
  }

  _MosaicSupplyChangeTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.signature = json['signature'] as String;
    this.signer = json['signer'] as String;
    this.version = json['version'] as int;
    this.type = json['type'] as int;
    this.fee = UInt64DTO.fromJson(json['maxFee']);
    this.deadline = UInt64DTO.fromJson(json['deadline']);
    this._mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    this._direction = json['direction'] as int;
    this._delta = UInt64DTO.fromJson(json['delta']);
  }

  UInt64DTO _mosaicId;
  int _direction;
  UInt64DTO _delta;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['signature'] = this.signature;
    data['signer'] = this.signer;
    data['version'] = this.version;
    data['type'] = this.type;
    data['maxFee'] = this.fee;
    data['deadline'] = this.deadline;
    data['mosaicId'] = this._mosaicId;
    data['direction'] = this._direction;
    data['delta'] = this._delta;
    return data;
  }
}
