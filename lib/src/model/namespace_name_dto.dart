part of xpx_catapult_sdk ;

class NamespaceNameDTO {
  UInt64DTO parentId = null;

  UInt64DTO namespaceId = null;

  String name = null;

  NamespaceNameDTO();

  @override
  String toString() {
    return 'NamespaceNameDTO[parentId=$parentId, namespaceId=$namespaceId, name=$name, ]';
  }

  NamespaceNameDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    parentId = new UInt64DTO.fromJson(json['parentId']);
    namespaceId = new UInt64DTO.fromJson(json['namespaceId']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'parentId': parentId, 'namespaceId': namespaceId, 'name': name};
  }

  static List<NamespaceNameDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NamespaceNameDTO>()
        : json.map((value) => new NamespaceNameDTO.fromJson(value)).toList();
  }

  static Map<String, NamespaceNameDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NamespaceNameDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NamespaceNameDTO.fromJson(value));
    }
    return map;
  }
}
