part of nem2_sdk_dart;

class NamespaceMetaDTO {
  String id = null;

  bool active = null;

  int index = null;

  NamespaceMetaDTO();

  @override
  String toString() {
    return 'NamespaceMetaDTO[id=$id, active=$active, index=$index, ]';
  }

  NamespaceMetaDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    active = json['active'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'active': active, 'index': index};
  }

  static List<NamespaceMetaDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NamespaceMetaDTO>()
        : json.map((value) => new NamespaceMetaDTO.fromJson(value)).toList();
  }

  static Map<String, NamespaceMetaDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NamespaceMetaDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NamespaceMetaDTO.fromJson(value));
    }
    return map;
  }
}
