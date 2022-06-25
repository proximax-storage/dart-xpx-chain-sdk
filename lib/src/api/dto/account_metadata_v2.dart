/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class MetaDataEntryDTO {
  MetaDataEntryDTO.fromJson(Map<String, dynamic> json) : assert(json.isNotEmpty, 'json must not be empty') {
    targetKey = json['targetKey'] as String;
    scopedMetadataKey = UInt64DTO.fromJson(json['scopedMetadataKey']);
    valueSizeDelta = json['valueSizeDelta'] as int;
    valueSize = json['valueSize'] as int;
    value = json['value'] as int;
  }

  String? targetKey;
  UInt64DTO? scopedMetadataKey;
  int? valueSizeDelta;
  int? valueSize;
  int? value;
}
