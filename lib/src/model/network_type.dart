part of xpx_chain_sdk;

// NetworkType enums
const Mijin = 96,
    MijinTest = 144,
    Public = 184,
    PublicTest = 168,
    Private = 200,
    PrivateTest = 176,
    NotSupportedNet = 0;

const Map<String, int> addressNet = {
  'M': Mijin,
  'S': MijinTest,
  'X': Public,
  'V': PublicTest,
  'Z': Private,
  'W': PrivateTest,
};

final networkType = networkTypeList;

class NetworkType {
  String name;

  String description;

  NetworkType();

  @override
  String toString() {
    return '{name:$name, description=$description}';
  }

  NetworkType.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }
}

/// Static class containing network type constants.
mixin networkTypeList {
  final NOTSUPPORTED_NET = 0,

      /// Public net network
      PUBLIC = 0xb8,

      /// Public Test net network
      PUBLIC_TEST = 0xa8,

      /// Private network
      PRIVATE = 0xc8,

      /// Private test network
      PRIVATE_TEST = 0xb0,

      /// Mijin net network
      MIJIN = 0x60,

      /// Mijin test net network
      MIJIN_TEST = 0x90;
}
