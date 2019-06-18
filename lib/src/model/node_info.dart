part of xpx_chain_sdk;

class NodeInfo {
  NodeInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    publicKey = json['publicKey'] as String;
    port = json['port'] as int;
    networkIdentifier = json['networkIdentifier'] as int;
    version = json['version'] as int;
    roles = json['roles'] as int;
    host = json['host'] as String;
    friendlyName = json['friendlyName'] as String;
  }

  String publicKey;

  int port;

  int networkIdentifier;

  int version;

  int roles;

  String host;

  String friendlyName;

  @override
  String toString() {
    return '{\n'
        '\t"publicKey":$publicKey,\n'
        '\t"port":$port,\n'
        '\t"networkIdentifier":$networkIdentifier,\n'
        '\t"version":$version,\n'
        '\t"roles":$roles,\n'
        '\t"host":$host,\n'
        '\t"friendlyName":$friendlyName\n'
        '}\n';
  }

  static List<NodeInfo> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NodeInfo>()
        : json
            .map((dynamic value) =>
                new NodeInfo.fromJson(value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, NodeInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NodeInfo>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NodeInfo.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicKey'] = this.publicKey;
    data['port'] = this.port;
    data['networkIdentifier'] = this.networkIdentifier;
    data['version'] = this.version;
    data['roles'] = this.roles;
    data['host'] = this.host;
    data['friendlyName'] = this.friendlyName;

    return data;
  }
}

class CommunicationTimestamps {
  CommunicationTimestamps.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    final sRaw = new UInt64DTO.fromJson(json['sendTimestamp']);
    final rRaw = new UInt64DTO.fromJson(json['receiveTimestamp']);
    sendTimestamp = sRaw.toBigInt();
    receiveTimestamp = rRaw.toBigInt();
  }

  BigInt sendTimestamp;

  BigInt receiveTimestamp;

  @override
  String toString() {
    return '{\n'
        '\t"SendTimestamp":$sendTimestamp,\n'
        '\t"ReceiveTimestamp":$receiveTimestamp\n'
        '}\n';
  }

  static List<CommunicationTimestamps> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CommunicationTimestamps>()
        : json
            .map((dynamic value) => new CommunicationTimestamps.fromJson(
                value as Map<String, dynamic>))
            .toList();
  }

  static Map<String, CommunicationTimestamps> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CommunicationTimestamps>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CommunicationTimestamps.fromJson(value));
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sendTimestamp'] = this.sendTimestamp;
    data['receiveTimestamp'] = this.receiveTimestamp;

    return data;
  }
}
