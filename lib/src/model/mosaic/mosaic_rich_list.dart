/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

/// MosaicRichList  structure describes mosaic properties.
class MosaicRichList {
  MosaicRichList.fromDTO(MosaicRichListDTO dto) {
    address = Address.fromEncoded(dto.address);
    publicKey = dto.publicKey;
    amount = dto.amount.toUint64()!;
  }

  late final Address address;
  late final String publicKey;
  late final Uint64 amount;

  static List<MosaicRichList> listFromDTO(List<MosaicRichListDTO> json) =>
      json.isEmpty ? <MosaicRichList>[] : json.map(MosaicRichList.fromDTO).toList();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{'address': address, 'publicKey': publicKey, 'amount': amount};
    return val;
  }
}
