/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

class MosaicInfo {
  MosaicInfo.fromDTO(MosaicInfoDTO dto) {
    mosaicId = MosaicId(id: dto.mosaic!.mosaicId.toUint64());
    supply = dto.mosaic!.supply.toUint64();
    height = dto.mosaic!.height.toUint64();
    owner = dto.mosaic!.owner;
    revision = dto.mosaic!.revision;
    properties = MosaicProperties.fromDTO(dto.mosaic!.properties);
  }

  late MosaicId mosaicId;
  Uint64? supply;
  Uint64? height;
  String? owner;
  int? revision;
  MosaicProperties? properties;

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
