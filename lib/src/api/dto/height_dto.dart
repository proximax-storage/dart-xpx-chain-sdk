/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class HeightDTO {
  HeightDTO(this.height);

  HeightDTO.fromJson(Map<String, dynamic> json) : assert(json.isNotEmpty, 'json must not be empty') {
    height = UInt64DTO.fromJson(json['height']);
  }

  UInt64DTO? height;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    return data;
  }
}
