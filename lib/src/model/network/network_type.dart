part of xpx_chain_sdk.network;

// NetworkType enums
const mijin = 0x60,
    mijinTest = 0x90,
    public = 0xb8,
    publicTest = 0xa8,
    private = 0xc8,
    privateTest = 0xb0,
    notSupportedNet = 0;

const Map<String, int> addressNet = {
  'M': mijin,
  'S': mijinTest,
  'X': public,
  'V': publicTest,
  'Z': private,
  'W': privateTest,
};

class NetworkType {
  NetworkType.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    networkType = json['name'];
    description = json['description'];
  }

  String networkType;
  String description;

  int get networkIdentifier => getTypeNum(networkType);

  @override
  String toString() => '{\n'
      'networkIdentifier: $networkIdentifier\n'
      'networkType: $networkType,\n'
      'description: $description,\n'
      '}';

  static int getType(int networkType) {
    switch (networkType) {
      case mijin:
        return addressNet['M'];
      case mijinTest:
        return addressNet['S'];
      case public:
        return addressNet['X'];
      case publicTest:
        return addressNet['V'];
      case private:
        return addressNet['Z'];
      case privateTest:
        return addressNet['W'];
      default:
        return notSupportedNet;
    }
  }

  static int getTypeNum(String networkType) {
    switch (networkType) {
      case 'mijin':
        return addressNet['M'];
      case 'mijinTest':
        return addressNet['S'];
      case 'public':
        return addressNet['X'];
      case 'publicTest':
        return addressNet['V'];
      case 'private':
        return addressNet['Z'];
      case 'privateTest':
        return addressNet['W'];
      default:
        return notSupportedNet;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['networkType'] = networkType;
    data['description'] = description;
    data['networkIdentifier'] = networkIdentifier;
    return data;
  }
}

class NetworkVersion {
  NetworkVersion._(this.startedHeight, this.blockChainVersion);

  String startedHeight;
  String blockChainVersion;

  @override
  String toString() => '{\n'
      'startedHeight: $startedHeight,\n'
      'blockChainVersion: $blockChainVersion\n'
      '}';
}
