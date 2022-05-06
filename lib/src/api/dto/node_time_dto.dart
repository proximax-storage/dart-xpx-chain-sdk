/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class NodeTime {
  NodeTime.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    _communicationTimestamps =
        CommunicationTimestamps.fromJson(json['communicationTimestamps']);
  }

  CommunicationTimestamps? _communicationTimestamps;

  @override
  String toString() => '{\n'
      '\t"communicationTimestamps": $_communicationTimestamps'
      '}\n';

  Map<String, dynamic> toJson() =>
      {'communicationTimestamps': _communicationTimestamps};

  static List<NodeTime> listFromJson(List<Map> json) =>
      json.isEmpty ? <NodeTime>[] : json.map(NodeTime.fromJson).toList();

  static Map<String, NodeTime> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, NodeTime>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NodeTime.fromJson(value));
    }
    return map;
  }
}
