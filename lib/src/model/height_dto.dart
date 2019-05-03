part of nem2_sdk_dart;

class HeightDTO {
  UInt64DTO height = null;

  HeightDTO();

  @override
  String toString() {
    return 'Height[${height.h}, ${height.l}]';
  }

  HeightDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    height = new UInt64DTO.fromJson(json['height']);
  }

  Map<String, dynamic> toJson() {
    return {'height': height};
  }

  static List<HeightDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<HeightDTO>()
        : json.map((value) => new HeightDTO.fromJson(value)).toList();
  }

  static Map<String, HeightDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, HeightDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new HeightDTO.fromJson(value));
    }
    return map;
  }
}
