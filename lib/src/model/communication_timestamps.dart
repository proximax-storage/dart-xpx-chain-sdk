part of nem2_sdk_dart;

class CommunicationTimestamps {
  
  UInt64DTO sendTimestamp = null;
  

  UInt64DTO receiveTimestamp = null;
  
  CommunicationTimestamps();

  @override
  String toString() {
    return 'CommunicationTimestamps[sendTimestamp=$sendTimestamp, receiveTimestamp=$receiveTimestamp, ]';
  }

  CommunicationTimestamps.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    sendTimestamp =
      
      
      new UInt64DTO.fromJson(json['sendTimestamp'])
;
    receiveTimestamp =
      
      
      new UInt64DTO.fromJson(json['receiveTimestamp'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'sendTimestamp': sendTimestamp,
      'receiveTimestamp': receiveTimestamp
     };
  }

  static List<CommunicationTimestamps> listFromJson(List<dynamic> json) {
    return json == null ? new List<CommunicationTimestamps>() : json.map((value) => new CommunicationTimestamps.fromJson(value)).toList();
  }

  static Map<String, CommunicationTimestamps> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CommunicationTimestamps>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CommunicationTimestamps.fromJson(value));
    }
    return map;
  }
}

