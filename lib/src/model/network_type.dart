part of xpx_chain_sdk;

// NetworkType enums
const Mijin = 0x60,
    MijinTest = 0x90,
    Public = 0xb8,
    PublicTest = 0xa8,
    Private = 0xc8,
    PrivateTest = 0xb0,
    NotSupportedNet = 0;

const Map<String, int> addressNet = {
  'M': Mijin,
  'S': MijinTest,
  'X': Public,
  'V': PublicTest,
  'Z': Private,
  'W': PrivateTest,
};

class NetworkType {
  String name;

  String description;

  NetworkType._(this.name, this.description);

  @override
  String toString() {
    return '{name:$name, description=$description}';
  }

  NetworkType.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    this.name = json['name'];
    this.description = json['description'];
  }

  static int getType(int networkType) {
    switch (networkType) {
      case Mijin:
        return addressNet["M"];
      case MijinTest:
        return addressNet["S"];
      case Public:
        return addressNet["X"];
      case PublicTest:
        return addressNet["V"];
      case Private:
        return addressNet["Z"];
      case PrivateTest:
        return addressNet["W"];
      default:
        return NotSupportedNet;
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }
}
