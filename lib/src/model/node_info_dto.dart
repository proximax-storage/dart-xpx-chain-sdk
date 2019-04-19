part of nem2_sdk_dart;

class NodeInfoDTO {
  
  String publicKey = null;
  

  int port = null;
  

  int networkIdentifier = null;
  

  int version = null;
  

  int roles = null;
  

  String host = null;
  

  String friendlyName = null;
  
  NodeInfoDTO();

  @override
  String toString() {
    return 'NodeInfoDTO[publicKey=$publicKey, port=$port, networkIdentifier=$networkIdentifier, version=$version, roles=$roles, host=$host, friendlyName=$friendlyName, ]';
  }

  NodeInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    publicKey =
        json['publicKey']
    ;
    port =
        json['port']
    ;
    networkIdentifier =
        json['networkIdentifier']
    ;
    version =
        json['version']
    ;
    roles =
        json['roles']
    ;
    host =
        json['host']
    ;
    friendlyName =
        json['friendlyName']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'publicKey': publicKey,
      'port': port,
      'networkIdentifier': networkIdentifier,
      'version': version,
      'roles': roles,
      'host': host,
      'friendlyName': friendlyName
     };
  }

  static List<NodeInfoDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<NodeInfoDTO>() : json.map((value) => new NodeInfoDTO.fromJson(value)).toList();
  }

  static Map<String, NodeInfoDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NodeInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new NodeInfoDTO.fromJson(value));
    }
    return map;
  }
}

