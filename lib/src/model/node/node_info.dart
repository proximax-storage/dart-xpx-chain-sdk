part of xpx_chain_sdk.node;

class NodeInfo {
  NodeInfo.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    publicKey = json['publicKey'];
    port = json['port'];
    networkIdentifier = json['networkIdentifier'];
    version = json['version'];
    roles = json['roles'];
    host = json['host'];
    friendlyName = json['friendlyName'];
  }

  String publicKey;

  int port;

  int networkIdentifier;

  int version;

  int roles;

  String host;

  String friendlyName;

  @override
  String toString() => '{\n'
      '\t"publicKey":$publicKey,\n'
      '\t"port":$port,\n'
      '\t"networkIdentifier":$networkIdentifier,\n'
      '\t"version":$version,\n'
      '\t"roles":$roles,\n'
      '\t"host":$host,\n'
      '\t"friendlyName":$friendlyName\n'
      '}\n';

  static List<NodeInfo> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => NodeInfo.fromJson(value)).toList();

  static Map<String, NodeInfo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, NodeInfo>{};
    if (json != null && json.isNotEmpty) {
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
  CommunicationTimestamps.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    final sRaw = UInt64DTO.fromJson(json['sendTimestamp']);
    final rRaw = UInt64DTO.fromJson(json['receiveTimestamp']);
    sendTimestamp = sRaw.toUint64();
    receiveTimestamp = rRaw.toUint64();
  }

  Uint64 sendTimestamp;

  Uint64 receiveTimestamp;

  @override
  String toString() => '{\n'
      '\t"sendTimestamp": $sendTimestamp,\n'
      '\t"receiveTimestamp": $receiveTimestamp\n'
      '}\n';

  static List<CommunicationTimestamps> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => CommunicationTimestamps.fromJson(value)).toList();

  static Map<String, CommunicationTimestamps> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, CommunicationTimestamps>{};
    if (json != null && json.isNotEmpty) {
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
