/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

class MosaicId extends AssetId {
  factory MosaicId({final Uint64? id}) {
    if (id == null) {
      throw errNullId;
    }

    return MosaicId._(id);
  }

  const MosaicId._(final Uint64 id) : super(id);

  MosaicId.fromId(final Uint64? id) : super(id);

  MosaicId.fromUint64(final Uint64? bigInt) : super(bigInt);

  static MosaicId fromHex(final String hex) {
    if (hex.isEmpty) {
      throw ArgumentError('The hexString must not be null or empty');
    }

    if (0 != (hex.length % 2)) {
      throw ArgumentError('invalid hex');
    }
    final Uint64 bigInt = Uint64.fromHex(hex);
    return MosaicId._(bigInt);
  }

  static MosaicId fromNonceAndOwner(
          MosaicNonce nonce, PublicAccount ownerPublicAccount) =>
      MosaicId._(_generateMosaicId(nonce, ownerPublicAccount));

  @override
  String toString() => '${toHex()}';

  @override
  int get hashCode => 'MosaicId'.hashCode ^ super.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) ||
      other is MosaicId &&
          runtimeType == other.runtimeType &&
          toBytes() == other.toBytes();
}
