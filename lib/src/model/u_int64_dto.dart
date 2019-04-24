part of nem2_sdk_dart;

class UInt64DTO {
  UInt64DTO();

  @override
  String toString() {
    return 'UInt64DTO[]';
  }

  UInt64DTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<UInt64DTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UInt64DTO>()
        : json.map((value) => new UInt64DTO.fromJson(value)).toList();
  }

  static Map<String, UInt64DTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UInt64DTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UInt64DTO.fromJson(value));
    }
    return map;
  }
}
