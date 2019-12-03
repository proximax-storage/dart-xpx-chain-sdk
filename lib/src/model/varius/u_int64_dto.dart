part of xpx_chain_sdk;

class UInt64DTO {
  UInt64DTO([this._higher, this._lower]);

  UInt64DTO.fromJson(json) {
    if (json == null) {
      return;
    }

    _higher = Int32(json[0]);
    _lower = Int32(json[1]);
  }

  UInt64DTO.fromBigInt(BigInt v)
      : assert(json != null, 'json must not be null') {
    final u64 = v.toInt();
    _higher = Int32(u64 & 0xFFFFFFFF);
    _lower = Int32(u64 >> 32);
  }

  Int32 _lower, _higher;

  static List<UInt64DTO> listFromJson(List<dynamic> json) => json == null
      ? null
      : json.map((value) => UInt64DTO.fromJson(value)).toList();

  static Map<String, UInt64DTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, UInt64DTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = UInt64DTO.fromJson(value));
    }
    return map;
  }

  BigInt toBigInt() {
    if (_lower == null || _higher == null) {
      return null;
    }
    final buffer = Buffer.bigEndian(8)
      ..writeInt32(_lower.toInt())
      ..writeInt32(_higher.toInt());

    return buffer.toBigInt();
  }

  int toInt() {
    if (_lower == null || _higher == null) {
      return 0;
    }
    final buffer = Buffer.bigEndian(8)
      ..writeInt32(_lower.toInt())
      ..writeInt32(_higher.toInt());

    return buffer.position;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['higher'] = _higher;
    data['lower'] = _lower;
    return data;
  }
}
