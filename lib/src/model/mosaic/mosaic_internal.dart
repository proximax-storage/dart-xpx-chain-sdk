part of xpx_chain_sdk.mosaic;

final xpxMosaicId = MosaicId(id: Uint64(481110499, 231112638));

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

MosaicPropertyId getPropertyId(int value) {
  switch (value) {
    case 1:
      return MosaicPropertyId.mosaicPropertyFlagsId;
    case 2:
      return MosaicPropertyId.mosaicPropertyDivisibilityId;
    case 3:
      return MosaicPropertyId.mosaicPropertyDurationId;
    default:
      return null;
  }
}

Uint64 _generateMosaicId(int nonce, String ownerPublicKey) {
  final buffer = Uint8List(4).buffer;
  final nonceB = ByteData.view(buffer);

  nonceB.setUint32(0, nonce, Endian.little);

  final result = createSha3Digest(length: 32)..update(nonceB.buffer.asUint8List(), 0, nonceB.lengthInBytes);

  final ownerBytes = hex.decode(ownerPublicKey);

  final t = result.process(Uint8List.fromList(ownerBytes));

  return Uint64.fromBytes(t) & 0x7FFFFFFFFFFFFFFF;
}

int mosaicNonce() {
  final random = Random.secure();
  return random.nextInt(1000000000);
}

bool equalsBigInts(BigInt first, BigInt second) {
  if (first == null && second == null) {
    return true;
  }

  if (first != null) {
    return first.compareTo(second) == 0;
  }

  return second.compareTo(first) == 0;
}
