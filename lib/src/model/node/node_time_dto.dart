part of xpx_chain_sdk.node;

class NodeTime {
  NodeTime.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    _communicationTimestamps = CommunicationTimestamps.fromJson(json['communicationTimestamps']);
  }

  CommunicationTimestamps _communicationTimestamps;

  @override
  String toString() => '{\n'
      '\t"communicationTimestamps": $_communicationTimestamps'
      '}\n';

  Map<String, dynamic> toJson() => {'communicationTimestamps': _communicationTimestamps};

  static List<NodeTime> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => NodeTime.fromJson(value)).toList();

  static Map<String, NodeTime> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NodeTime>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NodeTime.fromJson(value));
    }
    return map;
  }
}
