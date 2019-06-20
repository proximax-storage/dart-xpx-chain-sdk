part of xpx_chain_sdk;

class UInt64DTO {
  UInt64DTO([this.higher, this.lower]);

  UInt64DTO.fromJson(dynamic json) {
    if (json == null) return;
    higher = Int32(json[0] as int);
    lower = Int32(json[1] as int);
  }

  UInt64DTO.fromBigInt(BigInt v) {
    if (json == null) return;

    var u64 = v.toInt();
    higher = Int32(u64 & 0xFFFFFFFF);
    lower = Int32(u64 >> 32);
  }

  Int32 lower, higher;

  static List<UInt64DTO> listFromJson(List<dynamic> json) {
    return json == null
        ?  List<UInt64DTO>()
        : json.map((dynamic value) =>  UInt64DTO.fromJson(value)).toList();
  }

  static Map<String, UInt64DTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map =  Map<String, UInt64DTO>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] =  UInt64DTO.fromJson(value));
    }
    return map;
  }

  BigInt toBigInt() {
    if (this.lower == null || this.higher == null) {
      return null;
    }

    var buffer =  Buffer.BigEndian(8);

    buffer.writeInt32(this.lower.toInt());
    buffer.writeInt32(this.higher.toInt());

    return buffer.toBigInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['higher'] = this.higher;
    data['lower'] = this.lower;
    return data;
  }
}
