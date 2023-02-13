/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

class MetadataV2InfoDTO {
  MetadataV2InfoDTO(
    this.metadataEntry,
    this.id,
  );

  MetadataV2InfoDTO.fromJson(Map<String, dynamic> json) : assert(json.isNotEmpty, 'json must not be empty') {
    metadataEntry = MetadataEntryDto.fromJson(json['metadataEntry']);
    print(json);
    id = json['meta'] != null ? json['meta']['id'] : json['id'];
  }

  late final MetadataEntryDto metadataEntry;
  late final String id;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['metadataEntry'] = metadataEntry.toJson();
    _data['id'] = id;
    return _data;
  }
}

class MetadataEntryDto {
  MetadataEntryDto({
    required this.version,
    required this.compositeHash,
    required this.sourceAddress,
    required this.targetKey,
    required this.scopedMetadataKey,
    required this.targetId,
    required this.metadataType,
    required this.valueSize,
    required this.value,
  });

  MetadataEntryDto.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    compositeHash = json['compositeHash'];
    sourceAddress = json['sourceAddress'];
    targetKey = json['targetKey'];
    scopedMetadataKey = UInt64DTO.fromJson(json['scopedMetadataKey']);
    targetId = UInt64DTO.fromJson(json['targetId']);
    metadataType = json['metadataType'];
    valueSize = json['valueSize'];
    value = json['value'];
  }

  late final int version;
  late final String compositeHash;
  late final String sourceAddress;
  late final String targetKey;
  late final UInt64DTO scopedMetadataKey;
  late final UInt64DTO targetId;
  late final int metadataType;
  late final int valueSize;
  late final String value;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['compositeHash'] = compositeHash;
    _data['sourceAddress'] = sourceAddress;
    _data['targetKey'] = targetKey;
    _data['scopedMetadataKey'] = scopedMetadataKey;
    _data['targetId'] = targetId;
    _data['metadataType'] = metadataType;
    _data['valueSize'] = valueSize;
    _data['value'] = value;
    return _data;
  }
}
