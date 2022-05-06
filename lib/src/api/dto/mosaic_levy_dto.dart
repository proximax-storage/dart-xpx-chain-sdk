/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class MosaicLevyDTO {
  MosaicLevyDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    type = json['type'] as int;
    recipient = json['recipient'] as String;
    mosaicId = UInt64DTO.fromJson(json['mosaicId']);
    fee = UInt64DTO.fromJson(json['fee']);
  }
  late final int type;
  late final String recipient;
  late final UInt64DTO mosaicId;
  late final UInt64DTO fee;
}
