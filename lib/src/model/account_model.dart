part of xpx_catapult_sdk;

const NUM_CHECKSUM_BYTES = 4;

class Address {
  int networkType = null;
  String address = null;

  /// Create an Address from a given raw address
  Address(String address, int networkType) {
    address = address.replaceAll("-", "");
    this.address = address.toUpperCase();
    this.networkType = networkType;
  }

  @override
  String toString() {
    return '${toJson()}';
  }

  Address.fromRaw(String address) {
    this.networkType = addressNet[address[0]];
    this.address = address;
  }

  Address.fromEncoded(String encoded) {
    final pH = HEX.decode(encoded);
    final parsed = base32.encode(pH);
    var a = Address.fromRaw(parsed);
    this.address = a.address;
    this.networkType = a.networkType;
  }

  /// Create an Address from a given public key.
  Address.fromPublicKey(String pKey, int networkType) {
    this.address = _generateEncodedAddress(pKey, networkType);
    this.networkType = networkType;
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

  PublicAccount(this.publicKey, this.address);
  @override
  String toString() {
    return '${toJson()}';
  }

  /// Create an Account from a given raw address.
  PublicAccount.fromPublicKey(String pKey, int networkType) {
    var ad = _generateEncodedAddress(pKey, networkType);
    var address = new Address(ad, networkType);
    this.address = address;
    this.publicKey = pKey;
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'publicKey': publicKey,
    };
  }
}

class Account {
  PublicAccount publicAccount = null;
  crypto.KeyPair account = null;

  Account(this.publicAccount, this.account);
  @override
  String toString() {
    return publicAccount.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'publicAccount': publicAccount,
      'account': account,
    };
  }

  /// Create an Account from a given hex private key.
  Account.fromPrivateKey(String sHex, int networkType) {
    var k = crypto.NewPrivateKeyFromHexString(sHex);
    var kp = crypto.NewKeyPair(k, null);

    var pa =
        new PublicAccount.fromPublicKey(kp.publicKey.toString(), networkType);
    this.publicAccount = pa;
    this.account = kp;
  }

  SignedTransaction sign(Transaction tx){
    return _signTransactionWith(tx, this);
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
        '\t"address": $address,\n'
        '\t"addressHeight": $addressHeight,\n'
        '\t"publicKey": $publicKey,\n'
        '\t"publicKeyHeight": $publicKeyHeight,\n'
        '\t"accountType": $accountType,\n'
        '\t"linkedAccountKey": $linkedAccountKey,\n'
        '\t"mosaics": $mosaics,\n'
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

    address = new Address.fromEncoded(v.account.address);
    addressHeight = v.account.addressHeight.toBigInt();
    publicKey = v.account.publicKey;
    publicKeyHeight = v.account.publicKeyHeight.toBigInt();
    accountType = v.account.accountType;
    linkedAccountKey = v.account.linkedAccountKey;
    mosaics = m;
  }
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
  var stepThreeChecksum = _generateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  var concatStepThreeAndStepSix =
      addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

  // step 6: base32 encode (5)
  return base32.encode(concatStepThreeAndStepSix);
}

Uint8List _generateChecksum(Uint8List b) {
  // step 1: sha3 hash of (input
  var sha3StepThreeHash = crypto.HashesSha3_256(b);

  // step 2: get the first NUM_CHECKSUM_BYTES bytes of (1)
  var p = sha3StepThreeHash.getRange(0, NUM_CHECKSUM_BYTES);
  Uint8List hash = Uint8List(NUM_CHECKSUM_BYTES);
  for (int i = 0; i < NUM_CHECKSUM_BYTES; i++) hash[i] = p.toList()[i];
  return hash;
}
