/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

/// MosaicProperties  structure describes mosaic properties.
class MosaicProperties {
  MosaicProperties._(
      // ignore: avoid_positional_boolean_parameters
      this.supplyMutable,
      this.transferable,
      this.divisibility,
      Uint64? duration,
      [List<MosaicProperty>? optionalProperties]) {
    if (optionalProperties != null) {
      this.optionalProperties = optionalProperties;
    }
    this.duration = duration ?? Uint64.zero;
  }

  factory MosaicProperties.create(
          {required bool supplyMutable, required bool transferable, required int divisibility, Uint64? duration}) =>
      MosaicProperties._(supplyMutable, transferable, divisibility, duration);

  MosaicProperties.fromDTO(List<MosaicPropertyDTO> value) {
    Uint64? flags = Uint64.zero;

    divisibility = 0;

    for (MosaicPropertyDTO property in value) {
      switch (property.id) {
        case 0:
          flags = property.value!.toUint64();
          break;
        case 1:
          divisibility = property.value!.toUint64()!.toInt();
          break;
        case 2:
          optionalProperties = <MosaicProperty>[];
          break;
        default:
          throw errPropertyId;
      }
    }

    supplyMutable = hasBits(flags!, getSupplyMutable);
    transferable = hasBits(flags, getTransferable);
  }

  bool? supplyMutable;
  bool? transferable;
  int? divisibility;
  Uint64? duration;
  List<MosaicProperty> optionalProperties = <MosaicProperty>[];

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {};

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('supplyMutable', supplyMutable);
    writeNotNull('transferable', transferable);
    writeNotNull('divisibility', divisibility);

    if (optionalProperties.isNotEmpty) {
      val['optionalProperties'] = optionalProperties;
    }

    return val;
  }
}
