part of nem2_sdk_dart;

class NodeTimeDTO {
  
  CommunicationTimestamps communicationTimestamps = null;
  
  NodeTimeDTO();

  @override
  String toString() {
    return 'NodeTimeDTO[communicationTimestamps=$communicationTimestamps, ]';
  }

  NodeTimeDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    communicationTimestamps =
      
      
      new CommunicationTimestamps.fromJson(json['communicationTimestamps'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'communicationTimestamps': communicationTimestamps
     };
  }

  static List<NodeTimeDTO> listFromJson(List<dynamic> json) {
    return json == null ? new List<NodeTimeDTO>() : json.map((value) => new NodeTimeDTO.fromJson(value)).toList();
  }

  static Map<String, NodeTimeDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NodeTimeDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new NodeTimeDTO.fromJson(value));
    }
    return map;
  }
}

