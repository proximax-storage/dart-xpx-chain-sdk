/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.node;

class NodeInfo {
  NodeInfo.fromJson(Map json) : assert(json.isNotEmpty, 'json must not be empty') {
    publicKey = json['publicKey'];
    port = json['port'];
    networkIdentifier = json['networkIdentifier'];
    version = json['version'];
    roles = json['roles'];
    host = json['host'];
    friendlyName = json['friendlyName'];
  }

  String? publicKey;

  int? port;

  int? networkIdentifier;

  int? version;

  int? roles;

  String? host;

  String? friendlyName;

  @override
  String toString() => encoder.convert(this);

  static List<NodeInfo> listFromJson(List<Map> json) =>
      json.isEmpty ? <NodeInfo>[] : json.map(NodeInfo.fromJson).toList();

  static Map<String, NodeInfo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NodeInfo>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = NodeInfo.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['publicKey'] = publicKey;
    data['port'] = port;
    data['networkIdentifier'] = networkIdentifier;
    data['version'] = version;
    data['roles'] = roles;
    data['host'] = host;
    data['friendlyName'] = friendlyName;

    return data;
  }
}

class CommunicationTimestamps {
  CommunicationTimestamps.fromJson(Map json) : assert(json.isNotEmpty, 'json must not be empty') {
    final sRaw = UInt64DTO.fromJson(json['sendTimestamp']);
    final rRaw = UInt64DTO.fromJson(json['receiveTimestamp']);
    sendTimestamp = sRaw.toUint64();
    receiveTimestamp = rRaw.toUint64();
  }

  Uint64? sendTimestamp;

  Uint64? receiveTimestamp;

  @override
  String toString() => '{\n'
      '\t"sendTimestamp": $sendTimestamp,\n'
      '\t"receiveTimestamp": $receiveTimestamp\n'
      '}\n';

  static List<CommunicationTimestamps> listFromJson(List<Map> json) =>
      json.isEmpty ? <CommunicationTimestamps>[] : json.map(CommunicationTimestamps.fromJson).toList();

  static Map<String, CommunicationTimestamps> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, CommunicationTimestamps>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = CommunicationTimestamps.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sendTimestamp'] = sendTimestamp;
    data['receiveTimestamp'] = receiveTimestamp;

    return data;
  }
}
