part of xpx_catapult_sdk ;

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
