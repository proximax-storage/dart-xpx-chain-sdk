/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class UInt64DTO {
  UInt64DTO([this.higher, this.lower]);

  UInt64DTO.fromJson(json) {
    if (json == null) {
      return;
    }

    higher = Int32(json[0]);
    lower = Int32(json[1]);
  }

  UInt64DTO.fromBigInt(BigInt v) {
    final u64 = v.toInt();
    higher = Int32(u64 & 0xFFFFFFFF);
    lower = Int32(u64 >> 32);
  }

  Int32? lower, higher;

  static List<UInt64DTO> listFromJson(List<dynamic> json) =>
      json.isEmpty ? <UInt64DTO>[] : json.map(UInt64DTO.fromJson).toList();

  static Map<String, UInt64DTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, UInt64DTO>{};
    if (json.isNotEmpty) {
      json.forEach((key, value) => map[key] = UInt64DTO.fromJson(value));
    }
    return map;
  }

  Uint64 toUint64() {
    if (lower == null || higher == null) {
      return Uint64.zero;
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
