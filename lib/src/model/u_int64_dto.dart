part of nem2_sdk_dart;

class UInt64DTO {
  Int32 h, l;

  UInt64DTO();

  @override
  String toString() {
    return 'UInt64DTO[${h}, ${l}]';
  }

  UInt64DTO.fromJson(dynamic json) {
    if (json == null) return;

    h = Int32(json[0]);
    l = Int32(json[1]);
  }

  UInt64DTO.fromBigInt(BigInt v) {
    if (json == null) return;

    var u64 = v.toInt();
    h = Int32(u64 & 0xFFFFFFFF);
    l = Int32(u64 >> 32);
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<UInt64DTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<UInt64DTO>()
        : json.map((value) => new UInt64DTO.fromJson(value)).toList();
  }

  static Map<String, UInt64DTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UInt64DTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UInt64DTO.fromJson(value));
    }
    return map;
  }

  BigInt toBigInt() {
    var buffer = new Uint8List(8).buffer;
    var bdata = new ByteData.view(buffer);
    bdata.setInt32(0, this.l.toInt());
    bdata.setInt32(4, this.h.toInt());

    return new BigInt.from(bdata.getInt64(0));
  }
}
