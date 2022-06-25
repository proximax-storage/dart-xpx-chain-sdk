/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

enum MosaicPropertyId {
  mosaicPropertyFlags,
  mosaicPropertyDivisibility,
  mosaicPropertyDuration,
}

extension MosaicPropertyIdExt on MosaicPropertyId {
  int get toInt => index;

  String get name {
    switch (this) {
      case MosaicPropertyId.mosaicPropertyFlags:
        return 'mosaicPropertyFlags';
      case MosaicPropertyId.mosaicPropertyDivisibility:
        return 'mosaicPropertyDivisibility';
      case MosaicPropertyId.mosaicPropertyDuration:
        return 'mosaicPropertyDuration';
    }
  }
}

class MosaicProperty {
  MosaicProperty(this.id, this.value);

  MosaicProperty.fromDTO(MosaicPropertyDTO dto) {
    id = getPropertyId(dto.id);
    value = dto.value!.toUint64();
  }

  MosaicPropertyId? id;

  Uint64? value;

  static List<MosaicProperty> listFromDTO(List<MosaicPropertyDTO> json) =>
      json.isEmpty ? <MosaicProperty>[] : json.map(MosaicProperty.fromDTO).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() => {'id': id!.name, 'value': value};
}
