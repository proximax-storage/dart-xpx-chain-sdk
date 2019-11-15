part of xpx_chain_sdk;

class PublicAccount {
  PublicAccount._(this._publicKey, this._address);

  /// Create an Account from a given publicKey hex string.
  PublicAccount.fromPublicKey(String pKey, int networkType) {
    if (pKey == null || (publicKeySize != pKey.length && 66 != pKey.length)) {
      throw _errInvalidPublicKey;
    }
    _address = Address.fromPublicKey(pKey, networkType);
    _publicKey = pKey;
  }

  String _publicKey;
  Address _address;

  String get publicKey => _publicKey;

  Address get address => _address;

  @override
  String toString() => '${toJson()}';

  bool verify(String data, String signature) {
    if (signature == null) {
      throw _errNullSignature;
    }
    if (64 != (signature.length / 2)) {
      throw _errInvalidSignature;
    }
    if (signature.length % 2 != 0) {
      throw _errInvalidHexadecimal;
    }

    final kp = crypto.KeyPair();
    kp.publicKey.raw = Uint8List.fromList(hex.decode(_publicKey));

    return kp.verify(Uint8List.fromList(hex.decode(data)),
        Uint8List.fromList(hex.decode(signature)));
  }

  Map<String, dynamic> toJson() => {'address': address, 'publicKey': publicKey};
}

class Account {
  Account._(this._publicAccount, this._account);

  /// Create an Account from a given hex private key.
  Account.fromPrivateKey(String shex, int networkType) {
    _account = crypto.KeyPair.fromHexString(shex);
    _publicAccount =
        PublicAccount.fromPublicKey(_account.publicKey.toString(), networkType);
  }

  /// Create an Account from a given networkType.
  Account.random(int networkType) {
    final kp = crypto.KeyPair.fromRandomKeyPair();
    final acc = Account.fromPrivateKey(kp.privateKey.toString(), networkType);
    _publicAccount = acc._publicAccount;
    _account = acc._account;
  }

  PublicAccount _publicAccount;
  crypto.KeyPair _account;

  PublicAccount get publicAccount => _publicAccount;

  crypto.KeyPair get account => _account;

  String get publicKey => _publicAccount._publicKey;

  Address get address => _publicAccount.address;

  @override
  String toString() => publicAccount.toString();

  Map<String, dynamic> toJson() =>
      {'publicAccount': publicAccount, 'account': account};

  SignedTransaction sign(Transaction tx) => _signTransactionWith(tx, this);

  CosignatureSignedTransaction signCosignatureTransaction(
          CosignatureTransaction tx) =>
      _signCosignatureTransaction(tx, this);
}

// ignore: public_member_api_docs
class AccountInfo {
  AccountInfo._fromDTO(_AccountInfoDTO v) {
    final List<Mosaic> mList = List(v._account._mosaics.length);
    for (var i = 0; i < v._account._mosaics.length; i++) {
      mList[i] = Mosaic._fromDTO(v._account._mosaics[i]);
    }

    address = Address.fromEncoded(v._account._address);
    addressHeight = v._account._addressHeight.toBigInt();
    publicKey = v._account._publicKey;
    publicKeyHeight = v._account._publicKeyHeight.toBigInt();
    accountType = v._account._accountType;
    linkedAccountKey = v._account._linkedAccountKey;
    mosaics = mList;
  }

  Address address;
  BigInt addressHeight;
  String publicKey;
  BigInt publicKeyHeight;
  List<Mosaic> mosaics;
  int accountType;
  String linkedAccountKey;
  num reputation;

  @override
  String toString() => '{\n'
      '\t"address": $address,\n'
      '\t"addressHeight": $addressHeight,\n'
      '\t"publicKey": $publicKey,\n'
      '\t"publicKeyHeight": $publicKeyHeight,\n'
      '\t"accountType": $accountType,\n'
      '\t"linkedAccountKey": $linkedAccountKey,\n'
      '\t"mosaics": $mosaics,\n'
      '\t"reputation": $reputation,\n'
      '}\n';

  Map<String, dynamic> toJson() => {
        'address': address,
        'addressHeight': addressHeight,
        'publicKey': publicKey,
        'publicKeyHeight': publicKeyHeight,
        'accountType': accountType,
        'linkedAccountKey': linkedAccountKey,
        'mosaics': mosaics,
        'reputation': reputation
      };
}

String _generateEncodedAddress(String pKey, int version) {
  // step 1: sha3 hash of the public key
  final pKeyD = hex.decode(pKey);

  final sha3PublicKeyHash = crypto.HashesSha3_256(Uint8List.fromList(pKeyD));

  // step 2: ripemd160 hash of (1)
  final ripemd160StepOneHash = crypto.HashesRipemd160(sha3PublicKeyHash);

  // step 3: add version byte in front of (2)
  final versionPrefixedRipemd160Hash =
      addUint8List(Uint8List.fromList([version]), ripemd160StepOneHash);

  // step 4: get the checksum of (3)
  final stepThreeChecksum = _generateChecksum(versionPrefixedRipemd160Hash);

  // step 5: concatenate (3) and (4)
  final concatStepThreeAndStepSix =
      addUint8List(versionPrefixedRipemd160Hash, stepThreeChecksum);

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
