/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

final xpxMosaicId = MosaicId.fromInts(481110499, 231112638);

enum MosaicSupplyType { decrease, increase }

const decrease = MosaicSupplyType.decrease, increase = MosaicSupplyType.increase;

const getSupplyMutable = 0x01;

const getTransferable = 0x02;

const xpxDivisibility = 1000000;

const xpxMaxValue = xpxMaxRelativeValue * xpxDivisibility;

const xpxMaxRelativeValue = 9000000000;

bool hasBits(Uint64 number, int bits) => number.toInt() & bits == bits;

// Create xpx with using xpx as unit
Mosaic xpx(int amount) {
  if (amount > xpxMaxValue) {
    throw ArgumentError('Maximum xpx value must be $xpxMaxValue');
  }
  return Mosaic(xpxNamespaceId, Uint64(amount));
}

Mosaic xpxRelative(int amount) {
  if (amount > xpxMaxRelativeValue) {
    throw ArgumentError('Maximum xpx relative value must be $xpxMaxRelativeValue');
  }
  return xpx(amount * xpxDivisibility);
}

MosaicPropertyId? getPropertyId(int? value) {
  switch (value) {
    case 1:
      return MosaicPropertyId.mosaicPropertyFlags;
    case 2:
      return MosaicPropertyId.mosaicPropertyDivisibility;
    case 3:
      return MosaicPropertyId.mosaicPropertyDuration;
    default:
      return null;
  }
}

Uint64 _generateMosaicId(MosaicNonce nonce, PublicAccount ownerPublicAccount) {
  final sha3_256 = SHA3(256, SHA3_PADDING, 256);

  final result = sha3_256.update(nonce.nonce);

  final List<int> ownerBytes = hex.decode(ownerPublicAccount.publicKey);

  final t = result.update(Uint8List.fromList(ownerBytes));

  return Uint64.fromHex((Int64.fromBytes(t.digest()) ^ 1 << 63).toHexString());
}

Uint8List randombytesArray(Uint8List x) => randombytesArrayLen(x, x.length);

Uint8List randombytes(int len) => randombytesArray(Uint8List(len));

Uint8List randombytesArrayLen(Uint8List x, int len) {
  final jrandom = Random.secure();

  final int ret = len % 4;
  Int64 rnd;
  for (int i = 0; i < len - ret; i += 4) {
    rnd = Int64(jrandom.nextInt(1 << 32));
    x[i + 0] = rnd.shiftRightUnsigned(0).toInt();
    x[i + 1] = rnd.shiftRightUnsigned(8).toInt();
    x[i + 2] = rnd.shiftRightUnsigned(16).toInt();
    x[i + 3] = rnd.shiftRightUnsigned(24).toInt();
  }
  if (ret > 0) {
    rnd = Int64(jrandom.nextInt(1 << 32));
    for (int i = len - ret; i < len; i++) x[i] = rnd.shiftRightUnsigned(8 * i).toInt();
  }
  return x;
}

bool equalsBigInts(BigInt first, BigInt second) {
  if (first == second) {
    return true;
  }
  if (first.compareTo(second) == 0) {
    return true;
  }

  return second.compareTo(first) == 0;
}
