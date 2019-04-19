part of nem2_sdk_dart;

class NamespaceIds {
  
  List<String> namespaceIds = [];
  
  NamespaceIds();

  @override
  String toString() {
    return 'NamespaceIds[namespaceIds=$namespaceIds, ]';
  }

  NamespaceIds.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    namespaceIds =
        (json['namespaceIds'] as List).map((item) => item as String).toList()
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'namespaceIds': namespaceIds
     };
  }

  static List<NamespaceIds> listFromJson(List<dynamic> json) {
    return json == null ? new List<NamespaceIds>() : json.map((value) => new NamespaceIds.fromJson(value)).toList();
  }

  static Map<String, NamespaceIds> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NamespaceIds>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new NamespaceIds.fromJson(value));
    }
    return map;
  }
}

