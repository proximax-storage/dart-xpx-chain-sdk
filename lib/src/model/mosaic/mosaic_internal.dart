part of xpx_chain_sdk.mosaic;

final xpxMosaicId = MosaicId.fromBigInt(
    UInt64DTO(Int32(481110499), Int32(231112638)).toBigInt());

enum MosaicSupplyType { decrease, increase }

const decrease = MosaicSupplyType.decrease,
    increase = MosaicSupplyType.increase;

const _supplyMutable = 0x01;

const _transferable = 0x02;

bool hasBits(BigInt number, int bits) => number.toInt() & bits == bits;

// Create xpx with using xpx as unit
Mosaic xpx(int amount) => Mosaic(xpxNamespaceId, BigInt.from(amount));

Mosaic xpxRelative(int amount) =>
    xpx((BigInt.from(1000000) * BigInt.from(amount)).toInt());

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

BigInt _generateMosaicId(int nonce, String ownerPublicKey) {
  final nonceB = Buffer.littleEndian(4)..writeInt32(nonce);

  final result = sha3.New256()..update(nonceB.out, 0, nonceB.out.length);

  final ownerBytes = hex.decode(ownerPublicKey);

  final t = result.process(Uint8List.fromList(ownerBytes));

  List<dynamic> raw() => <dynamic>[
        endianLittleUint32(t.getRange(0, 4).toList()),
        endianLittleUint32(t.getRange(4, 8).toList()) & 0x7FFFFFFF
      ];

  return UInt64DTO.fromJson(raw()).toBigInt();
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
