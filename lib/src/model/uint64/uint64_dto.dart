part of xpx_chain_sdk.uint64;

class UInt64DTO {
  UInt64DTO([this.higher, this.lower]);

  UInt64DTO.fromJson(json) {
    if (json == null) {
      return;
    }

    higher = Int32(json[0]);
    lower = Int32(json[1]);
  }

  UInt64DTO.fromBigInt(BigInt v) : assert(v != null, 'json must not be null') {
    final u64 = v.toInt();
    higher = Int32(u64 & 0xFFFFFFFF);
    lower = Int32(u64 >> 32);
  }

  Int32 lower, higher;

  static List<UInt64DTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => UInt64DTO.fromJson(value)).toList();

  static Map<String, UInt64DTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, UInt64DTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = UInt64DTO.fromJson(value));
    }
    return map;
  }

  Uint64 toUint64() {
    if (lower == null || higher == null) {
      return null;
    }
    return Uint64.fromDto(this);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['higher'] = higher;
    data['lower'] = lower;
    return data;
  }
}
