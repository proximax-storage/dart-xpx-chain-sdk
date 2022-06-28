/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

class MosaicInfo {
  MosaicInfo(this.mosaicId, this.owner, this.revision, this.properties, {this.supply, this.height});

  factory MosaicInfo.fromDTO(MosaicInfoDTO dto) {
    final mosaicId = MosaicId(dto.mosaic!.mosaicId.toUint64());
    final owner = dto.mosaic!.owner;
    final revision = dto.mosaic!.revision;
    final properties = MosaicProperties.fromDTO(dto.mosaic!.properties);
    final supply = dto.mosaic!.supply.toUint64();
    final height = dto.mosaic!.height.toUint64();

    return MosaicInfo(mosaicId, owner!, revision!, properties, supply: supply, height: height);
  }

  /// The mosaic ID.
  MosaicId mosaicId;

  /// The account of the owner of this mosaic.
  String owner;

  /// The mosaic revision.
  int revision;

  /// The mosaic properties.
  MosaicProperties properties;

  /// The total supply of the mosaic.
  Uint64? supply;

  /// The block height the mosaic was created.
  Uint64? height;

  /// Returns the mosaic supply mutability.
  bool get isSupplyMutable => properties.supplyMutable;

  /// Returns the mosaic divisibility.
  int get divisibility => properties.divisibility;

  /// Returns the mosaic transferability.
  bool get isTransferable => properties.transferable;

  static List<MosaicInfo> listFromDTO(List<MosaicInfoDTO> json) =>
      json.isEmpty ? <MosaicInfo>[] : json.map(MosaicInfo.fromDTO).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'assetId': mosaicId.toHex(),
      'supply': supply.toString(),
      'owner': owner,
      'revision': revision,
      'properties': properties
    };

    if (height != null) {
      val['height'] = height;
    }

    return val;
  }
}
