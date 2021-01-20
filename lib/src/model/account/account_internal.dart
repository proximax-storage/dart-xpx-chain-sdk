part of xpx_chain_sdk.account;

String _generateEncodedAddress(String pKey, int version) {
  // step 1: sha3 hash of the public key
  final pKeyD = hex.decode(pKey);

  final sha3PublicKeyHash = crypto.HashesSha3_256(Uint8List.fromList(pKeyD));

  // step 2: ripemd160 hash of (1)
  final ripemd160StepOneHash = crypto.HashesRipemd160(sha3PublicKeyHash);

  // step 3: add version byte in front of (2)
  final versionPrefixedRipemd160Hash = addUint8List(Uint8List.fromList([version]), ripemd160StepOneHash);

  // step 4: get the checksum of (3)
  final stepThreeChecksum = _generateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  final concatStepThreeAndStepSix = addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

  // step 6: base32 encode (5)
  return base32.encode(concatStepThreeAndStepSix);
}

Uint8List _generateChecksum(Uint8List b) {
  // step 1: sha3 hash of (input
  final sha3StepThreeHash = crypto.HashesSha3_256(b);

  // step 2: get the first numChecksumBytes bytes of (1)
  final p = sha3StepThreeHash.getRange(0, numChecksumBytes);
  final Uint8List hash = Uint8List(numChecksumBytes);
  for (int i = 0; i < numChecksumBytes; i++) {
    hash[i] = p.toList()[i];
  }
  return hash;
}

Uint8List addUint8List(Uint8List a, Uint8List b) {
  if (a == null) {
    return b;
  }

  final Uint8List hash = Uint8List(b.length + a.length);
  for (int i = 0; i < a.length; i++) {
    hash[i] = a[i];
  }

  for (int i = 0; i < b.length; i++) {
    hash[i + a.length] = b[i];
  }

  return hash;
}
