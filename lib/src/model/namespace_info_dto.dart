part of nem2_sdk_dart;

class NamespaceInfoDTO {
  NamespaceMetaDTO meta = null;

  NamespaceDTO namespace = null;

  NamespaceInfoDTO();

  @override
  String toString() {
    return 'NamespaceInfoDTO[meta=$meta, namespace=$namespace, ]';
  }

  NamespaceInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    meta = new NamespaceMetaDTO.fromJson(json['meta']);
    namespace = new NamespaceDTO.fromJson(json['namespace']);
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta, 'namespace': namespace};
  }

  static List<NamespaceInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NamespaceInfoDTO>()
        : json.map((value) => new NamespaceInfoDTO.fromJson(value)).toList();
  }

  static Map<String, NamespaceInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NamespaceInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NamespaceInfoDTO.fromJson(value));
    }
    return map;
  }
}
