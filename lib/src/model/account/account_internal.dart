/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

String _generateEncodedAddress(String pKey, int networkType) {
  // step 1: sha3 hash of the public key
  final List<int> pKeyD = hex.decode(pKey);

  final sha3_256 = SHA3(256, SHA3_PADDING, 256);

  final sha3PublicKeyHash = sha3_256.update(pKeyD).digest();

  // step 2: ripemd160 hash of (1)
  final ripemd160 = Digest('RIPEMD-160');
  final ripemd160StepOneHash = ripemd160.process(Uint8List.fromList(sha3PublicKeyHash));

  // step 3: add network identifier byte in front of (2)
  final versionPrefixedRipemd160Hash = addUint8List(Uint8List.fromList([networkType]), ripemd160StepOneHash);

  // step 4: get the checksum of (3)
  final stepThreeChecksum = _generateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  final concatStepThreeAndStepSix = addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

  // step 6: base32 encode (5)
  return base32.encode(concatStepThreeAndStepSix);
}

Uint8List _generateChecksum(Uint8List b) {
  final sha3_256 = SHA3(256, SHA3_PADDING, 256);

  // step 1: sha3 hash of (input
  final sha3StepThreeHash = sha3_256.update(b).digest();

  // step 2: get the first numChecksumBytes bytes of (1)
  final p = sha3StepThreeHash.getRange(0, numChecksumBytes);
  final Uint8List hash = Uint8List(numChecksumBytes);
  for (int i = 0; i < numChecksumBytes; i++) {
    hash[i] = p.toList()[i];
  }
  return hash;
}

Uint8List addUint8List(Uint8List a, Uint8List b) {
  if (a.isEmpty) {
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
