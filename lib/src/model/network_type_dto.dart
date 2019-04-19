part of nem2_sdk_dart;

class NetworkTypeDTO {
  
  String name = null;
  

  String description = null;
  
  NetworkTypeDTO();

  @override
  String toString() {
    return 'NetworkTypeDTO[name=$name, description=$description, ]';
  }

  NetworkTypeDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    description =
        json['description']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description
     };
  }

  static List<NetworkTypeDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<NetworkTypeDTO>() : json.map((value) => new NetworkTypeDTO.fromJson(value)).toList();
  }

  static Map<String, NetworkTypeDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NetworkTypeDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new NetworkTypeDTO.fromJson(value));
    }
    return map;
  }
}

