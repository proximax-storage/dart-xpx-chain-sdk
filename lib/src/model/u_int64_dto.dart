part of xpx_catapult_sdk;

class UInt64DTO {
  Int64 lower, higher;

  UInt64DTO([this.higher, this.lower]);

  @override
  String toString() {
    return '[${higher}, ${lower}]';
  }

  UInt64DTO.fromJson(dynamic json) {
    if (json == null) return;
    higher = Int64(json[0]);
    lower = Int64(json[1]);
  }

  UInt64DTO.fromBigInt(BigInt v) {
    if (json == null) return;

    var u64 = v.toInt();
    higher = Int64(u64 & 0xFFFFFFFF);
    lower = Int64(u64 >> 32);
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
    if (this.lower == null || this.higher == null){
      return null;
    }

    var buffer = new Buffer.BigEndian(8);

    buffer.writeInt32(this.lower.toInt());
    buffer.writeInt32(this.higher.toInt());

    return buffer.toBigInt();
  }
}
