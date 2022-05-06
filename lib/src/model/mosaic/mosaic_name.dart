/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

class MosaicName {
  MosaicName.fromDTO(MosaicNameDTO dto) {
    mosaicId = MosaicId.fromId(dto.mosaicId!.toUint64());
    names = dto.names != null ? List.from(dto.names!) : null;
  }

  late MosaicId mosaicId;

  List<String>? names;

  static List<MosaicName> listFromDTO(List<MosaicNameDTO>? json) =>
      json == null ? <MosaicName>[] : json.map(MosaicName.fromDTO).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{'assetId': mosaicId.toHex(), 'names': names};
    return val;
  }
}
