part of nem2_sdk_dart;

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
    parentId =
      
      
      new UInt64DTO.fromJson(json['parentId'])
;
    mosaicId =
      
      
      new UInt64DTO.fromJson(json['mosaicId'])
;
    name =
        json['name']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'mosaicId': mosaicId,
      'name': name
     };
  }

  static List<MosaicNameDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<MosaicNameDTO>() : json.map((value) => new MosaicNameDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicNameDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicNameDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MosaicNameDTO.fromJson(value));
    }
    return map;
  }
}

