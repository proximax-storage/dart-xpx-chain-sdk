part of xpx_chain_sdk;

class NodeTime {
  NodeTime.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    communicationTimestamps =  CommunicationTimestamps.fromJson(
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['communicationTimestamps'] = this.communicationTimestamps;

    return data;
  }

  static List<NodeTime> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<NodeTime>()
        : json
            .map((dynamic value) =>
                 NodeTime.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, NodeTime> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, NodeTime>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  NodeTime.fromJson(value));
    }
    return map;
  }
}
