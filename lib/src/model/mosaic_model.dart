part of xpx_catapult_sdk;

class Mosaic {
  BigInt id = null;

  BigInt amount = null;

  Mosaic([this.id, this.amount]);

  @override
  String toString() {
    return '\n\t{\n'
        '\t"MosaicId": $id,\n'
        '\t"Amount": $amount\n'
        '\t}';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'amount': amount};
  }

  Mosaic.fromDTO(_mosaicDTO v) {
    id = v.id.toBigInt();
    amount = v.amount.toBigInt();
  }
}

BigInt NewMosaicIdFromNonceAndOwner(int nonce, String ownerPublicKey) {
  if (ownerPublicKey.length != 64) {
    throw ErrInvalidOwnerPublicKey;
  }

  return _generateMosaicId(nonce, ownerPublicKey);
}

Mosaic NewMosaic(BigInt mosaicId, amount) {
  if (mosaicId == null) {
    throw ErrNilMosaicId;
  }

  if (amount == null) {
    throw ErrNilMosaicAmount;
  }

  if (EqualsBigInts(amount, BigInt.zero)) {
    throw ErrNilMosaicAmount;
  }

  return new Mosaic(mosaicId, amount);
}

BigInt _generateMosaicId(int nonce, String ownerPublicKey) {
  var nonceB = new Buffer.LittleEndian(4);
  nonceB.writeInt32(nonce);

  var result = sha3.New256();

  result.update(nonceB.out, 0, nonceB.out.length);

  var ownerBytes = HEX.decode(ownerPublicKey);

  var t = result.process(ownerBytes);

  List<dynamic> raw() {
    return [
      EndianLittleUint32(t.getRange(0, 4).toList()),
      EndianLittleUint32(t.getRange(4, 8).toList()) & 0x7FFFFFFF
    ];
  }

  return new UInt64DTO.fromJson(raw()).toBigInt();
}
