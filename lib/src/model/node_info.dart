part of xpx_catapult_sdk;

class NodeInfo {
  String publicKey;

  int port;

  int networkIdentifier;

  int version;

  int roles;

  String host;

  String friendlyName;

  NodeInfo();

  @override
  String toString() {
    return '{\n'
        '\t"PublicKey":$publicKey,\n'
        '\t"Port":$port,\n'
        '\t"NetworkIdentifier":$networkIdentifier,\n'
        '\t"Version":$version,\n'
        '\t"Roles":$roles,\n'
        '\t"Host":$host,\n'
        '\t"FriendlyName":$friendlyName\n'
        '}\n';
  }

  NodeInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    publicKey = json['publicKey'];
    port = json['port'];
    networkIdentifier = json['networkIdentifier'];
    version = json['version'];
    roles = json['roles'];
    host = json['host'];
    friendlyName = json['friendlyName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'publicKey': publicKey,
      'port': port,
      'networkIdentifier': networkIdentifier,
      'version': version,
      'roles': roles,
      'host': host,
      'friendlyName': friendlyName
    };
  }

  static List<NodeInfo> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NodeInfo>()
        : json.map((value) => new NodeInfo.fromJson(value)).toList();
  }

  static Map<String, NodeInfo> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NodeInfo>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NodeInfo.fromJson(value));
    }
    return map;
  }
}

class CommunicationTimestamps {
  BigInt sendTimestamp;

  BigInt receiveTimestamp;

  CommunicationTimestamps();

  @override
  String toString() {
    return '{\n'
        '\t"SendTimestamp":$sendTimestamp,\n'
        '\t"ReceiveTimestamp":$receiveTimestamp\n'
        '}\n';
  }

  CommunicationTimestamps.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    final sRaw = new UInt64DTO.fromJson(json['sendTimestamp']);
    final rRaw = new UInt64DTO.fromJson(json['receiveTimestamp']);
    sendTimestamp = sRaw.toBigInt();
    receiveTimestamp = rRaw.toBigInt();
  }

  Map<String, dynamic> toJson() {
    return {
      'sendTimestamp': sendTimestamp,
      'receiveTimestamp': receiveTimestamp
    };
  }

  static List<CommunicationTimestamps> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CommunicationTimestamps>()
        : json
        .map((value) => new CommunicationTimestamps.fromJson(value))
        .toList();
  }

  static Map<String, CommunicationTimestamps> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CommunicationTimestamps>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
      map[key] = new CommunicationTimestamps.fromJson(value));
    }
    return map;
  }
}
