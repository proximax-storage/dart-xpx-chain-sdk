part of xpx_chain_sdk;

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
  NetworkType._(this.name, this.description);

  NetworkType.fromJson(Map<String, dynamic> json)
      : assert(json != null, 'json must not be null') {
    name = json['name'];
    description = json['description'];
  }

  String name;

  String description;

  @override
  String toString() => '{name:$name, description=$description}';

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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;

    return data;
  }
}
