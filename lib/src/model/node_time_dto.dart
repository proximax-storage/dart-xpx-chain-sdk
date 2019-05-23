part of xpx_catapult_sdk;

class NodeTime {
  CommunicationTimestamps communicationTimestamps;

  NodeTime();

  @override
  String toString() {
    return '{\n'
        '\t"CommunicationTimestamps":${communicationTimestamps}'
        '}\n';
  }

  NodeTime.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    communicationTimestamps =
        new CommunicationTimestamps.fromJson(json['communicationTimestamps']);
  }

  Map<String, dynamic> toJson() {
    return {'communicationTimestamps': communicationTimestamps};
  }

  static List<NodeTime> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NodeTime>()
        : json.map((value) => new NodeTime.fromJson(value)).toList();
  }

  static Map<String, NodeTime> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NodeTime>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NodeTime.fromJson(value));
    }
    return map;
  }
}
