/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.metadata;

/// MetadataEntry can be associated with an account/namespace/mosaic.
class MetadataEntry {
  MetadataEntry(this.version, this.compositeHash, this.sourceAddress, this.targetKey, this.scopedMetadataKey,
      this.targetId, this.metadataType, this.valueSize, this.value, this.id);

  factory MetadataEntry.fromDTO(MetadataV2InfoDTO dto) {
    final entryDto = dto.metadataEntry;

    final sourceAddress = Address.fromEncoded(entryDto.sourceAddress);
    final scopedMetadataKey = Uint64.fromDto(entryDto.scopedMetadataKey);
    final targetId = Uint64.fromDto(entryDto.targetId);
    final metadataType = entryDto.metadataType.toMetadataType;
    final value = ByteUtils.bytesToUtf8String(HexUtils.hexToBytes(entryDto.value));

    return MetadataEntry(entryDto.version, entryDto.compositeHash, sourceAddress, entryDto.targetKey, scopedMetadataKey,
        targetId, metadataType, entryDto.valueSize, value, dto.id);
  }

  static List<MetadataEntry> listFromDTO(List<MetadataV2InfoDTO> json) =>
      json.isEmpty ? <MetadataEntry>[] : json.map(MetadataEntry.fromDTO).toList();

  final int version;
  final String compositeHash;
  final Address sourceAddress;
  final String targetKey;
  final Uint64 scopedMetadataKey;
  final Uint64 targetId;
  final MetadataType metadataType;
  final int valueSize;
  final String value;
  final String id;

  bool isAccountMetadata() => metadataType == MetadataType.metadataAccount;

  bool isMosaicMetadata() => metadataType == MetadataType.metadataMosaic;

  bool isNamespaceMetadata() => metadataType == MetadataType.metadataNamespace;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {
      'version': version,
      'compositeHash': compositeHash,
      'sourceAddress': sourceAddress,
      'targetKey': targetKey,
      'scopedMetadataKey': scopedMetadataKey,
      'targetId': targetId.toHexString(),
      'metadataType': metadataType.getName,
      'valueSize': valueSize,
      'value': value,
      'id': id
    };

    return val;
  }
}
