part of nem2_sdk_dart;

class MosaicInfoDTO {
  
  MosaicMetaDTO meta = null;
  

  MosaicDefinitionDTO mosaic = null;
  
  MosaicInfoDTO();

  @override
  String toString() {
    return 'MosaicInfoDTO[meta=$meta, mosaic=$mosaic, ]';
  }

  MosaicInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta =
      
      
      new MosaicMetaDTO.fromJson(json['meta'])
;
    mosaic =
      
      
      new MosaicDefinitionDTO.fromJson(json['mosaic'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta,
      'mosaic': mosaic
     };
  }

  static List<MosaicInfoDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<MosaicInfoDTO>() : json.map((value) => new MosaicInfoDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MosaicInfoDTO.fromJson(value));
    }
    return map;
  }
}

