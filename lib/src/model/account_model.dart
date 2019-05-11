part of xpx_catapult_sdk;

const NUM_CHECKSUM_BYTES = 4;

// Create an Address from a given raw address
Address NewAddress(String address, int networkType) {
  address = address.replaceAll("-", "");
  var ad = new Address();
  ad.address = address.toUpperCase();
  ad.networkType = networkType;
  return ad;
}

Address NewAddressFromRaw(String address) {
  final nType = addressNet[address[0]];
  return NewAddress(address, nType);
}

Address NewAddressFromEncoded(String encoded) {
  final pH = HEX.decode(encoded);

  final parsed = base32.encode(pH);

  return NewAddressFromRaw(parsed);
}

// Create an Address from a given public key.
Address NewAddressFromPublicKey(String pKey, int networkType) {
  var ad = _generateEncodedAddress(pKey, networkType);
  return NewAddress(ad, networkType);
}

// Create an Account from a given raw address.
PublicAccount NewAccountFromPublicKey(String pKey, int networkType) {
  var ad = _generateEncodedAddress(pKey, networkType);
  var address = NewAddress(ad, networkType);
  var pa = new PublicAccount();
  pa.address = address;
  pa.publicKey = pKey;
  return pa;
}

String _generateEncodedAddress(String pKey, int version) {
  // step 1: sha3 hash of the public key
  var pKeyD = HEX.decode(pKey);

  var sha3PublicKeyHash = crypto.HashesSha3_256(pKeyD);

  // step 2: ripemd160 hash of (1)
  var ripemd160StepOneHash = crypto.HashesRipemd160(sha3PublicKeyHash);

  // step 3: add version byte in front of (2)
  var versionPrefixedRipemd160Hash =
      addUint8List(Uint8List.fromList([version]), ripemd160StepOneHash);

  // step 4: get the checksum of (3)
  var stepThreeChecksum = GenerateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  var concatStepThreeAndStepSix =
      addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

  // step 6: base32 encode (5)
  return base32.encode(concatStepThreeAndStepSix);
}

Uint8List GenerateChecksum(Uint8List b) {
  // step 1: sha3 hash of (input
  var sha3StepThreeHash = crypto.HashesSha3_256(b);

  // step 2: get the first NUM_CHECKSUM_BYTES bytes of (1)
  var p = sha3StepThreeHash.getRange(0, NUM_CHECKSUM_BYTES);
  Uint8List hash = Uint8List(NUM_CHECKSUM_BYTES);
  for (int i = 0; i < NUM_CHECKSUM_BYTES; i++) hash[i] = p.toList()[i];
  return hash;
}

// Create an Account from a given hex private key.
Account NewAccountFromPrivateKey(String sHex, int networkType) {
  var k = crypto.NewPrivateKeyFromHexString(sHex);
  var kp = crypto.NewKeyPair(k, null);

  var pa = NewAccountFromPublicKey(kp.publicKey.toString(), networkType);
  var account = new Account();
  account.publicAccount = pa;
  account.account = kp;
  return account;
}

Uint8List addUint8List(Uint8List a, Uint8List b) {
  Uint8List hash = Uint8List(b.length + a.length);
  for (int i = 0; i < a.length; i++) hash[i] = a[i];
  for (int i = 0; i < b.length; i++) hash[i + a.length] = b[i];
  return hash;
}

class Address {
  int networkType = null;
  String address = null;

  Address();
  @override
  String toString() {
    return '{\n'
        '\tNetworkType: $networkType,\n'
        '\tAddress=$address,\n'
        '\t}';
  }

  Map<String, dynamic> toJson() {
    return {
      'networkType': networkType,
      'address': address,
    };
  }
}

class PublicAccount {
  String publicKey = null;
  Address address = null;

  PublicAccount();
  @override
  String toString() {
    return '{\n'
        '\taddress: $address,\n'
        '\tpublicKey: $publicKey\n'
        '\t}';
  }
}

class Account {
  PublicAccount publicAccount = null;
  crypto.KeyPair account = null;

  Account();
  @override
  String toString() {
    return publicAccount.toString();
  }
}

class AccountInfo {
  Address address;
  BigInt addressHeight;
  String publicKey;
  BigInt publicKeyHeight;
  List<Mosaic> mosaics;
  int accountType;
  String linkedAccountKey;

  @override
  String toString() {
    return '{\n'
        '\t"Address": $address,\n'
        '\t"AddressHeight": $addressHeight,\n'
        '\t"PublicKey": $publicKey,\n'
        '\t"PublicKeyHeight": $publicKeyHeight,\n'
        '\t"AccountType": $accountType,\n'
        '\t"LinkedAccountKey": $linkedAccountKey,\n'
        '\t"Mosaics": $mosaics,\n'
        '}\n';
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'addressHeight': addressHeight,
      'publicKey': publicKey,
      'publicKeyHeight': publicKeyHeight,
      'accountType': accountType,
      'linkedAccountKey': linkedAccountKey,
      'mosaics': mosaics,
    };
  }

  AccountInfo.fromDTO(_accountInfoDTO v) {
    List<Mosaic> m = new List(v.account.mosaics.length);
    for (var i = 0; i < v.account.mosaics.length; i++) {
      m[i] = new Mosaic.fromDTO(v.account.mosaics[i]);
    }

    address = NewAddressFromEncoded(v.account.address);
    addressHeight = v.account.addressHeight.toBigInt();
    publicKey = v.account.publicKey;
    publicKeyHeight = v.account.publicKeyHeight.toBigInt();
    accountType = v.account.accountType;
    linkedAccountKey = v.account.linkedAccountKey;
    mosaics = m;
  }
}
