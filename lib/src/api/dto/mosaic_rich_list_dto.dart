/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class MosaicRichListDTO {
  MosaicRichListDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    address = json['address'] as String;
    publicKey = json['address'] as String;
    amount = UInt64DTO.fromJson(json['amount']);
  }

  late final String address;
  late final String publicKey;
  late final UInt64DTO amount;
}
