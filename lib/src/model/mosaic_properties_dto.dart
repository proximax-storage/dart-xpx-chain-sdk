part of nem2_sdk_dart;

class MosaicPropertiesDTO {
  MosaicPropertiesDTO();

  @override
  String toString() {
    return 'MosaicPropertiesDTO[]';
  }

  MosaicPropertiesDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<MosaicPropertiesDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MosaicPropertiesDTO>()
        : json.map((value) => new MosaicPropertiesDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicPropertiesDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicPropertiesDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MosaicPropertiesDTO.fromJson(value));
    }
    return map;
  }
}
