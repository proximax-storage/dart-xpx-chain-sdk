part of xpx_catapult_sdk;

class _mosaicDTO {
  UInt64DTO id = null;

  UInt64DTO amount = null;

  _mosaicDTO();

  @override
  String toString() {
    return '_mosaicDTO[id=$id, amount=$amount, ]';
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
  UInt64DTO mosaicId = null;

  UInt64DTO supply = null;

  UInt64DTO height = null;

  String owner = null;

  int revision = null;

  List<UInt64DTO> properties = null;

  Object levy = null;

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

class MosaicNameDTO {
  UInt64DTO parentId = null;

  UInt64DTO mosaicId = null;

  String name = null;

  MosaicNameDTO();

  @override
  String toString() {
    return 'MosaicNameDTO[parentId=$parentId, mosaicId=$mosaicId, name=$name, ]';
  }

  MosaicNameDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentId = new UInt64DTO.fromJson(json['parentId']);
    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'parentId': parentId, 'mosaicId': mosaicId, 'name': name};
  }

  static List<MosaicNameDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MosaicNameDTO>()
        : json.map((value) => new MosaicNameDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicNameDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MosaicNameDTO.fromJson(value));
    }
    return map;
  }
}
