/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

class PublicAccount {
  PublicAccount._(this.publicKey, this.address);

  /// Create an Account from a given publicKey hex string.
  static PublicAccount fromPublicKey(String? publicKey, NetworkType networkType) {
    if (publicKey == null || (publicKeySize != publicKey.length && 66 != publicKey.length)) {
      throw errInvalidPublicKey;
    }
    final address = Address.fromPublicKey(publicKey, networkType);
    return PublicAccount._(publicKey, address);
  }

  String publicKey;
  Address address;

  @override
  String toString() => encoder.convert(this);

  /// Verifies a signature.
  Future<bool> verifySignature(String data, String signature) async {
    if (signature.isEmpty) {
      throw errNullSignature;
    }
    if (64 != (signature.length / 2)) {
      throw errInvalidSignature;
    }
    if (signature.length % 2 != 0) {
      throw errInvalidHexadecimal;
    }

    final _publicKey = crypto.SimplePublicKey(hex.decode(publicKey), type: crypto.KeyPairType.ed25519);

    final String hexData = HexUtils.utf8ToHex(data);

    final crypto.Signature _signature = crypto.Signature(hex.decode(signature), publicKey: _publicKey);

    return crypto.KeyPair.verify(
        data: Uint8List.fromList(hex.decode(hexData)),
        publicKey: Uint8List.fromList(_publicKey.bytes),
        signature: _signature);
  }

  Map<String, dynamic> toJson() => {'address': address, 'publicKey': publicKey};
}
