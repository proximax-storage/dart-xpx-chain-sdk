part of xpx_chain_sdk;

class _mosaicDTO {
  UInt64DTO id;

  UInt64DTO amount;

  _mosaicDTO();

  @override
  String toString() {
    return '{id:$id, amount:$amount}';
  }

  _mosaicDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = new UInt64DTO.fromJson(json['id']);
    amount = new UInt64DTO.fromJson(json['amount']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'amount': amount};
  }

  static List<_mosaicDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_mosaicDTO>()
        : json.map((value) => new _mosaicDTO.fromJson(value)).toList();
  }

  static Map<String, _mosaicDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _mosaicDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _mosaicDTO.fromJson(value));
    }
    return map;
  }
}

class _mosaicInfoDTO {
  _mosaicMetaDTO meta = null;

  _mosaicDefinitionDTO mosaic = null;

  _mosaicInfoDTO();

  @override
  String toString() {
    return '_mosaicInfoDTO[meta=$meta, mosaic=$mosaic, ]';
  }

  _mosaicInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new _mosaicMetaDTO.fromJson(json['meta']);
    mosaic = new _mosaicDefinitionDTO.fromJson(json['mosaic']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'mosaic': mosaic};
  }

  static List<_mosaicInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_mosaicInfoDTO>()
        : json.map((value) => new _mosaicInfoDTO.fromJson(value)).toList();
  }

  static Map<String, _mosaicInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _mosaicInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _mosaicInfoDTO.fromJson(value));
    }
    return map;
  }
}

class _mosaicMetaDTO {
  String id = null;

  _mosaicMetaDTO();

  @override
  String toString() {
    return '_mosaicMetaDTO[id=$id, ]';
  }

  _mosaicMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  static List<_mosaicMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_mosaicMetaDTO>()
        : json.map((value) => new _mosaicMetaDTO.fromJson(value)).toList();
  }

  static Map<String, _mosaicMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _mosaicMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _mosaicMetaDTO.fromJson(value));
    }
    return map;
  }
}

class _mosaicDefinitionDTO {
  UInt64DTO mosaicId;
  UInt64DTO supply;
  UInt64DTO height;
  String owner;
  int revision;
  List<UInt64DTO> properties;

  Object levy;

  _mosaicDefinitionDTO();

  @override
  String toString() {
    return '{MosaicId=$mosaicId, Supply=$supply, Height=$height, Owner=$owner, Revision=$revision, Properties=$properties}';
  }

  _mosaicDefinitionDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    } else {
      properties = new List(json['properties'].length);
    }

    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    supply = new UInt64DTO.fromJson(json['supply']);
    height = new UInt64DTO.fromJson(json['height']);
    owner = json['owner'];
    revision = json['revision'];
    for (int i = 0; i < 3; i++)
      properties[i] = (UInt64DTO.fromJson(json['properties'][i]));
  }
}

class _mosaicNameDTO {
  UInt64DTO parentId = null;

  UInt64DTO mosaicId = null;

  List<String> names = null;

  _mosaicNameDTO();

  @override
  String toString() {
    return '_mosaicNameDTO[parentId=$parentId, mosaicId=$mosaicId, names=$names, ]';
  }

  _mosaicNameDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentId = new UInt64DTO.fromJson(json['parentId']);
    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    names = List.from(json['names']);
  }

  Map<String, dynamic> toJson() {
    return {'parentId': parentId, 'mosaicId': mosaicId, 'names': names};
  }

  static List<_mosaicNameDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_mosaicNameDTO>()
        : json.map((value) => new _mosaicNameDTO.fromJson(value)).toList();
  }

  static Map<String, _mosaicNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, _mosaicNameDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new _mosaicNameDTO.fromJson(value));
    }
    return map;
  }
}

class _mosaicPropertiesDTO {
  int id;
  UInt64DTO value;

  _mosaicPropertiesDTO(this.id, this.value);

  @override
  String toString() {
    return '{\n'
        '\t"id": $id,\n'
        '\t"value": $value,\n'
        '\t}';
  }

  _mosaicPropertiesDTO.fromJson(Map<String, dynamic> value) {
    this.id = value["id"];
    this.value = UInt64DTO.fromJson(value["value"]);
  }

  static List<_mosaicPropertiesDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<_mosaicPropertiesDTO>()
        : json.map((value)=> new _mosaicPropertiesDTO.fromJson(value))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'value': value};
  }
}

class _mosaicDefinitionTransactionInfoDTO {
  _metaTransactionDTO _meta;
  _mosaicDefinitionTransactionDTO _transaction;

  Autogenerated(
      {_metaTransactionDTO meta, _mosaicDefinitionTransactionDTO transaction}) {
    this._meta = meta;
    this._transaction = transaction;
  }

  _metaTransactionDTO get meta => _meta;
  set meta(_metaTransactionDTO meta) => _meta = meta;
  _mosaicDefinitionTransactionDTO get transaction => _transaction;
  set transaction(_mosaicDefinitionTransactionDTO transaction) =>
      _transaction = transaction;

  _mosaicDefinitionTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? new _metaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? new _mosaicDefinitionTransactionDTO.fromJson(json['transaction'])
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

class _mosaicDefinitionTransactionDTO extends _abstractTransactionDTO {
  UInt64DTO _mosaicId;
  int _mosaicNonce;
  List<_mosaicPropertiesDTO> _properties;
  UInt64DTO _duration;

  _mosaicDefinitionTransactionDTO(
      {String signature,
      String signer,
      int version,
      int type,
      List<int> maxFee,
      List<int> deadline,
      UInt64DTO mosaicId,
      int mosaicNonce,
      List<_mosaicPropertiesDTO> properties,
      UInt64DTO duration}) {
    this.Signature = signature;
    this.Signer = signer;
    this.Version = version;
    this.Type = type;
    this.Fee = UInt64DTO.fromJson(maxFee);
    this.Deadline = UInt64DTO.fromJson(deadline);
    this._mosaicId = mosaicId;
    this._mosaicNonce = mosaicNonce;
    this._properties = properties;
    this._duration = duration;
  }

  _mosaicDefinitionTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.Signature = json['signature'];
    this.Signer = json['signer'];
    this.Version = json['version'];
    this.Type = json['type'];
    this.Fee = UInt64DTO.fromJson(json['maxFee']);
    this.Deadline = UInt64DTO.fromJson(json['deadline']);
    this._mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    this._mosaicNonce = json['mosaicNonce'];
    this._properties = _mosaicPropertiesDTO.listFromJson(json['properties']);
    this._duration = UInt64DTO.fromJson(json['duration']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signature'] = this.Signature;
    data['signer'] = this.Signer;
    data['version'] = this.Version;
    data['type'] = this.Type;
    data['maxFee'] = this.Fee;
    data['deadline'] = this.Deadline;

    data['duration'] = this._duration;
    return data;
  }
}

class _mosaicSupplyChangeTransactionInfoDTO {
  _metaTransactionDTO _meta;
  _mosaicSupplyChangeTransactionDTO _transaction;

  Autogenerated(
      {_metaTransactionDTO meta, _mosaicSupplyChangeTransactionDTO transaction}) {
    this._meta = meta;
    this._transaction = transaction;
  }

  _metaTransactionDTO get meta => _meta;
  set meta(_metaTransactionDTO meta) => _meta = meta;
  _mosaicSupplyChangeTransactionDTO get transaction => _transaction;
  set transaction(_mosaicSupplyChangeTransactionDTO transaction) =>
      _transaction = transaction;

  _mosaicSupplyChangeTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    _meta = json['meta'] != null
        ? new _metaTransactionDTO.fromJson(json['meta'])
        : null;

    _transaction = json['transaction'] != null
        ? new _mosaicSupplyChangeTransactionDTO.fromJson(json['transaction'])
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

class _mosaicSupplyChangeTransactionDTO extends _abstractTransactionDTO {
  UInt64DTO _mosaicId;
  int _direction;
  UInt64DTO _delta;

  _mosaicSupplyChangeTransactionDTO(
      {String signature,
        String signer,
        int version,
        int type,
        List<int> maxFee,
        List<int> deadline,
        UInt64DTO mosaicId,
        int direction,
        UInt64DTO delta}) {
    this.Signature = signature;
    this.Signer = signer;
    this.Version = version;
    this.Type = type;
    this.Fee = UInt64DTO.fromJson(maxFee);
    this.Deadline = UInt64DTO.fromJson(deadline);
    this._mosaicId = mosaicId;
    this._direction = direction;
    this._delta = delta;
  }

  _mosaicSupplyChangeTransactionDTO.fromJson(Map<String, dynamic> json) {
    this.Signature = json['signature'];
    this.Signer = json['signer'];
    this.Version = json['version'];
    this.Type = json['type'];
    this.Fee = UInt64DTO.fromJson(json['maxFee']);
    this.Deadline = UInt64DTO.fromJson(json['deadline']);
    this._mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    this._direction = json['direction'];
    this._delta = UInt64DTO.fromJson(json['delta']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signature'] = this.Signature;
    data['signer'] = this.Signer;
    data['version'] = this.Version;
    data['type'] = this.Type;
    data['maxFee'] = this.Fee;
    data['deadline'] = this.Deadline;
    data['mosaicId'] = this._mosaicId;
    data['direction'] = this._direction;
    data['delta'] = this._delta;
    return data;
  }
}
