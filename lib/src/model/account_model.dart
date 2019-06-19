part of xpx_chain_sdk;

class Address {
  Address._(this._address, this._networkType);

  Address.fromEncoded(String encoded) {
    final pH = hex.decode(encoded);
    final parsed = base32.encode(pH);
    var a = Address.fromRawAddress(parsed);
    this._address = a.address;
    this._networkType = a.networkType;
  }

  /// Create an Address from a given public key.
  Address.fromPublicKey(String pKey, int networkType) {
    if (networkType == null || NetworkType.getType(networkType) == 0) {
      throw new ArgumentError('Network type unsupported');
    }

    this._address = _generateEncodedAddress(pKey, networkType);
    this._networkType = networkType;
  }

  int _networkType;

  String _address;

  int get networkType => _networkType;

  String get address => _address;

  String get pretty => _pretty(this._address);

  /// Create an [Address] from a given raw address
  static Address fromRawAddress(String address) {
    address = address.trim().replaceAll("-", "").toUpperCase();

    if (address.length != addressEncodeSize) {
      throw new ArgumentError(
          'Address $address has to be $addressEncodeSize characters long');
    }

    return new Address._(address, addressNet[address[0]]);
  }

  @override
  String toString() {
    return '${toJson()}';
  }

  static String _pretty(final String address) {
    var res = "";

    for (int i = 0; i < 6; i++) {
      res += address.substring(i * 6, i * 6 + 6) + "-";
    }
    res += address.substring(address.length - 4);
    return res;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['networkType'] = networkType;
    data['address'] = address;

    return data;
  }
}

class PublicAccount {
  PublicAccount._(this._publicKey, this._address);

  /// Create an Account from a given publicKey hex string.
  PublicAccount.fromPublicKey(String pKey, int networkType) {
    if (pKey == null || (publicKeySize != pKey.length && 66 != pKey.length)) {
      throw errInvalidPublicKey;
    }
    this._address = new Address.fromPublicKey(pKey, networkType);
    this._publicKey = pKey;
  }

  String _publicKey;
  Address _address;

  String get publicKey => _publicKey;

  Address get address => _address;

  @override
  String toString() {
    return '${toJson()}';
  }

  bool verify(String data, String signature) {
    if (signature == null) {
      throw errNullSignature;
    }
    if (64 != (signature.length / 2)) {
      throw errInvalidSignature;
    }
    if (signature.length % 2 != 0) {
      throw errInvalidHexadecimal;
    }

    var kp = new crypto.KeyPair();
    kp.publicKey.Raw = Uint8List.fromList(hex.decode(this._publicKey));

    return kp.verify(Uint8List.fromList(hex.decode(data)),
        Uint8List.fromList(hex.decode(signature)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = address;
    data['publicKey'] = publicKey;

    return data;
  }
}

class Account {
  Account._(this._publicAccount, this._account);

  /// Create an Account from a given hex private key.
  Account.fromPrivateKey(String shex, int networkType) {
    var k = crypto.NewPrivateKeyFromHexString(shex);
    var kp = crypto.NewKeyPair(k, null);

    var pa =
        new PublicAccount.fromPublicKey(kp.publicKey.toString(), networkType);
    this._publicAccount = pa;
    this._account = kp;
  }

  /// Create an Account from a given networkType.
  Account.random(int networkType) {
    var kp = crypto.NewRandomKeyPair();
    final acc = Account.fromPrivateKey(kp.privateKey.toString(), networkType);
    this._publicAccount = acc._publicAccount;
    this._account = acc._account;
  }

  PublicAccount _publicAccount;
  crypto.KeyPair _account;

  PublicAccount get publicAccount => _publicAccount;

  crypto.KeyPair get account => _account;

  @override
  String toString() {
    return publicAccount.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicAccount'] = publicAccount;
    data['account'] = account;

    return data;
  }

  SignedTransaction sign(Transaction tx) {
    return _signTransactionWith(tx, this);
  }
}

class AccountInfo {
  AccountInfo.fromDTO(_AccountInfoDTO v) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = address;
    data['addressHeight'] = addressHeight;
    data['publicKey'] = publicKey;
    data['publicKeyHeight'] = publicKeyHeight;
    data['accountType'] = accountType;
    data['linkedAccountKey'] = linkedAccountKey;
    data['mosaics'] = mosaics;

    return data;
  }
}

String _generateEncodedAddress(String pKey, int version) {
  // step 1: sha3 hash of the public key
  var pKeyD = hex.decode(pKey);

  var sha3PublicKeyHash = crypto.HashesSha3_256(Uint8List.fromList(pKeyD));

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

  // step 2: get the first numChecksumBytes bytes of (1)
  var p = sha3StepThreeHash.getRange(0, numChecksumBytes);
  Uint8List hash = Uint8List(numChecksumBytes);
  for (int i = 0; i < numChecksumBytes; i++) hash[i] = p.toList()[i];
  return hash;
}
