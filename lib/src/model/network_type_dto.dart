part of nem2_sdk_dart;

// NetworkType enums
const MainNet = 104;

const TestNet = 152;

const Mijin = 96;

const MijinTest = 144;

const NotSupportedNet = 0;

typedef num NetworkType();

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
//
//// ExtractNetworkType return networkType from version
//int ExtractNetworkType(Int64 version) {
//binary.LittleEndian.PutUint64(b, version)
//
//a := binary.LittleEndian.Uint16(sampleA)
//// If you need int16:
//a2 := int16(a)
//
//return NetworkType(b[1])
//}
