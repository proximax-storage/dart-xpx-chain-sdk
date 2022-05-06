/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

const int defaultMosaicLevyOnePercentValue =
    100000; // default amount that represent 1% of native currency

/// MosaicLevy  structure describes mosaic Levy.
class MosaicLevy {
  MosaicLevy(this.type, this.recipient, this.mosaicId, this.fee);

  MosaicLevy.fromDTO(MosaicLevyDTO dto) {
    type = dto.type.toLevyType;
    recipient = Address.fromEncoded(dto.recipient);
    mosaicId = MosaicId.fromId(dto.mosaicId.toUint64()!);
    fee = dto.fee.toUint64()!;
  }

  static MosaicLevy createWithPercentageFee(Address recipient,
          MosaicId mosaicId, int percentage, int? mosaicOnePercentValue) =>
      MosaicLevy(
          MosaicLevyType.levyPercentileFee,
          recipient,
          mosaicId,
          MosaicLevy.createLevyFeePercentile(
              percentage, mosaicOnePercentValue));

  static MosaicLevy createWithAbsoluteFee(
          Address recipient, MosaicId mosaicId, int amount) =>
      MosaicLevy(MosaicLevyType.levyAbsoluteFee, recipient, mosaicId,
          Uint64.fromInt(amount));

  static Uint64 createLevyFeePercentile(
      int percentage, num? mosaicOnePercentValue) {
    if (mosaicOnePercentValue != null) {
      return Uint64.fromInt(percentage * mosaicOnePercentValue as int);
    }
    return Uint64.fromInt(percentage * defaultMosaicLevyOnePercentValue);
  }

  late final MosaicLevyType type;
  late final Address recipient;
  late final MosaicId mosaicId;
  late final Uint64 fee;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'type': type,
      'recipient': recipient,
      'mosaicId': mosaicId,
      'fee': fee
    };
    return val;
  }
}
