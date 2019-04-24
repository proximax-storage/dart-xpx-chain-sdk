part of nem2_sdk_dart;

class MosaicDTO {
  UInt64DTO id = null;

  UInt64DTO amount = null;

  MosaicDTO();

  @override
  String toString() {
    return 'MosaicDTO[id=$id, amount=$amount, ]';
  }

  MosaicDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = new UInt64DTO.fromJson(json['id']);
    amount = new UInt64DTO.fromJson(json['amount']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'amount': amount};
  }

  static List<MosaicDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<MosaicDTO>()
        : json.map((value) => new MosaicDTO.fromJson(value)).toList();
  }

  static Map<String, MosaicDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MosaicDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new MosaicDTO.fromJson(value));
    }
    return map;
  }
}
