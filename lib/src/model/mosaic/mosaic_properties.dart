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
      this.duration,
      [List<MosaicProperty>? optionalProperties]) {
    if (optionalProperties != null) {
      this.optionalProperties = optionalProperties;
    }
  }

  factory MosaicProperties.create(
          {required bool supplyMutable, required bool transferable, required int divisibility, Uint64? duration}) =>
      MosaicProperties._(supplyMutable, transferable, divisibility, duration);

  factory MosaicProperties.fromDTO(List<MosaicPropertyDTO> value) {
    Uint64? flags = Uint64.zero;

    var divisibility = 0;

    List<MosaicProperty> optionalProperties = [];

    for (MosaicPropertyDTO property in value) {
      switch (property.id) {
        case 0:
          flags = property.value!.toUint64();
          break;
        case 1:
          divisibility = property.value!.toUint64().toInt();
          break;
        case 2:
          optionalProperties = <MosaicProperty>[];
          break;
        default:
          throw errPropertyId;
      }
    }

    final supplyMutable = hasBits(flags!, getSupplyMutable);
    final transferable = hasBits(flags, getTransferable);

    return MosaicProperties._(supplyMutable, transferable, divisibility, null, optionalProperties);
  }

  /// The mosaic supply mutability. When set to `true`, allows the supply to be changed at
  /// later point.
  ///
  /// Default value is `false`.
  bool supplyMutable = false;

  /// The mosaic transferability. Defines if the mosaic is allowed for transfers among accounts
  /// other than the creator. When set to `false`, this mosaic can only be transferred to and from
  /// the creator of this mosaic. When set to `true` this mosaic can be transferred to and from
  /// arbitrary accounts.
  ///
  /// Default value is `true`.
  bool transferable = true;

  /// The divisibility determines the decimal place the mosaic can be divided into.
  ///
  /// Default value is 0.
  int divisibility;

  /// The duration in blocks a mosaic will become available.
  Uint64? duration;

  List<MosaicProperty> optionalProperties = <MosaicProperty>[];

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {
      'supplyMutable': supplyMutable,
      'transferable': transferable,
      'divisibility': divisibility
    };

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('duration', duration);

    if (optionalProperties.isNotEmpty) {
      val['optionalProperties'] = optionalProperties;
    }

    return val;
  }
}
