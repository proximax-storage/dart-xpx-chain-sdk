part of xpx_catapult_sdk ;

class MosaicDefinitionDTO {
  UInt64DTO mosaicId = null;

  UInt64DTO supply = null;

  UInt64DTO height = null;

  String owner = null;

  int revision = null;

  MosaicPropertiesDTO properties = null;

  Object levy = null;

  MosaicDefinitionDTO();

  @override
  String toString() {
    return 'MosaicDefinitionDTO[mosaicId=$mosaicId, supply=$supply, height=$height, owner=$owner, revision=$revision, properties=$properties, levy=$levy, ]';
  }

  MosaicDefinitionDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    mosaicId = new UInt64DTO.fromJson(json['mosaicId']);
    supply = new UInt64DTO.fromJson(json['supply']);
    height = new UInt64DTO.fromJson(json['height']);
    owner = json['owner'];
    revision = json['revision'];
    properties = new MosaicPropertiesDTO.fromJson(json['properties']);
//    levy =
//      new Object.fromJson(json['levy'])
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'mosaicId': mosaicId,
      'supply': supply,
      'height': height,
      'owner': owner,
      'revision': revision,
      'properties': properties,
      'levy': levy
    };
  }

  static List<MosaicDefinitionDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MosaicDefinitionDTO>()
        : json.map((value) => new MosaicDefinitionDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicDefinitionDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicDefinitionDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MosaicDefinitionDTO.fromJson(value));
    }
    return map;
  }
}
