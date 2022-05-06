/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

class Mosaic {
  Mosaic(this.assetId, this.amount) {
    if (assetId == null) {
      throw errNullMosaicId;
    } else if (amount == null) {
      throw errNullMosaicAmount;
    } else if (amount!.isZero) {
      throw errNullMosaicAmount;
    } else {
      assetId = assetId;
      amount = amount;
    }
  }

  Mosaic.fromDTO(MosaicDTO v) {
    assetId = MosaicId.fromId(v.id!.toUint64());
    amount = v.amount!.toUint64();
  }

  AssetId? assetId;
  Uint64? amount;

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = assetId!.toHex();
    data['amount'] = amount;
    return data;
  }

  static List<Mosaic> listFromDTO(List<MosaicDTO>? json) =>
      json == null ? <Mosaic>[] : json.map(Mosaic.fromDTO).toList();
}
