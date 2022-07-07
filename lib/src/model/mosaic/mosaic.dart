/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

/// A mosaic describes an instance of a [Mosaic].
/// Mosaics can be transferred by means of a transfer transaction.
class Mosaic {
  /// Creates a new Mosaic with the given [assetId] with the given [amount].
  ///
  /// The quantity is always given in smallest units for the mosaic. For example, if it has a
  /// divisibility of 3 the quantity is given in millis.
  Mosaic(this.assetId, this.amount) {
    if (amount.isZero) {
      throw errNullMosaicAmount;
    } else {
      assetId = assetId;
      amount = amount;
    }
  }

  factory Mosaic.fromDTO(MosaicDTO v) {
    final assetId = MosaicId(v.id!.toUint64());
    final amount = v.amount!.toUint64();
    return Mosaic(assetId, amount);
  }

  /// The mosaic [AssetId]. This can either be of type [MosaicId] or [NamespaceId].
  AssetId assetId;

  /// The mosaic amount.
  Uint64 amount;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = assetId.toHex();
    data['amount'] = amount;
    return data;
  }

  static List<Mosaic> listFromDTO(List<MosaicDTO>? json) =>
      json == null ? <Mosaic>[] : json.map(Mosaic.fromDTO).toList();
}
