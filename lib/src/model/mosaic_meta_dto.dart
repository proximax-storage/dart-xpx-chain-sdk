part of nem2_sdk_dart;

class MosaicMetaDTO {
  String id = null;

  MosaicMetaDTO();

  @override
  String toString() {
    return 'MosaicMetaDTO[id=$id, ]';
  }

  MosaicMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  static List<MosaicMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MosaicMetaDTO>()
        : json.map((value) => new MosaicMetaDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MosaicMetaDTO.fromJson(value));
    }
    return map;
  }
}
