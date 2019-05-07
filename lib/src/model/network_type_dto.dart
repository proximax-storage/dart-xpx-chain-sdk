part of xpx_catapult_sdk;

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

final NetworkType = new NetworkTypeList();

class NetworkTypeDTO {
  String name = null;

  String description = null;

  NetworkTypeDTO();

  @override
  String toString() {
    return 'NetworkTypeDTO[name=$name, description=$description, ]';
  }

  NetworkTypeDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }

  static List<NetworkTypeDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<NetworkTypeDTO>()
        : json.map((value) => new NetworkTypeDTO.fromJson(value)).toList();
  }

  static Map<String, NetworkTypeDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, NetworkTypeDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new NetworkTypeDTO.fromJson(value));
    }
    return map;
  }
}

/// Static class containing network type constants.
class NetworkTypeList {
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

  NetworkTypeList();
}
