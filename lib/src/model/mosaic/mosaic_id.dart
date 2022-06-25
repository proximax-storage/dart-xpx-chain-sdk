/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

class MosaicId extends AssetId {

  /// Creates a new [MosaicId] from an [Uint64] id.
  MosaicId(Uint64 uint64) : super(uint64);

  /// Creates a new [MosaicId] from a [bigInt].
  MosaicId.fromBigInt(BigInt bigInt): super(Uint64.fromBigInt(bigInt));

  /// Creates a new [MosaicId] from a [hex] string.
  MosaicId.fromHex(String hex) : super(Uint64.fromHex(hex));

  /// Creates a new [MosaicId] from a pair of 32-bit integers.
  MosaicId.fromInts(int lower, int higher) : super(Uint64.fromInts(lower, higher));

  /// Creates a new [MosaicId] from a given [MosaicNonce] and owner [PublicAccount].
  MosaicId.fromNonceAndOwner(MosaicNonce nonce, PublicAccount ownerPublicAccount)
      : super(_generateMosaicId(nonce, ownerPublicAccount));

  @override
  int get hashCode => 'MosaicId'.hashCode ^ super.hashCode;

  @override
  bool operator ==(final other) =>
      identical(this, other) || other is MosaicId && runtimeType == other.runtimeType && toHex() == other.toHex();
}
