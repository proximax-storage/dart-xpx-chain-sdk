part of xpx_chain_sdk;

class NodeTime {
  NodeTime.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    communicationTimestamps = new CommunicationTimestamps.fromJson(
        json['communicationTimestamps'] as Map<String, dynamic>);
  }

  CommunicationTimestamps communicationTimestamps;

  @override
  String toString() {
    return '{\n'
        '\t"communicationTimestamps":$communicationTimestamps'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['communicationTimestamps'] = this.communicationTimestamps;

    return data;
  }

  static List<NodeTime> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NodeTime>()
        : json
            .map((dynamic value) =>
                new NodeTime.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, NodeTime> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NodeTime>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NodeTime.fromJson(value));
    }
    return map;
  }
}
