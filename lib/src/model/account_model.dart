part of xpx_chain_sdk;

class Address {
  Address._(this._address, this._networkType);

  Address.fromEncoded(String encoded) {
    final pH = hex.decode(encoded);
    final parsed = base32.encode(pH);
    final a = Address.fromRawAddress(parsed);
    _address = a.address;
    _networkType = a.networkType;
  }

  /// Create an Address from a given public key.
  Address.fromPublicKey(String pKey, int networkType) {
    if (networkType == null || NetworkType.getType(networkType) == 0) {
      throw ArgumentError('Network type unsupported');
    }

    _address = _generateEncodedAddress(pKey, networkType);
    _networkType = networkType;
  }

  int _networkType;

  String _address;

  int get networkType => _networkType;

  String get address => _address;

  String get pretty => _pretty(_address);

  /// Create an [Address] from a given raw address
  static Address fromRawAddress(String address) {
    final addressRaw = address.trim().replaceAll('-', '').toUpperCase();

    if (addressRaw.length != addressEncodeSize) {
      throw ArgumentError(
          'Address $addressRaw has to be $addressEncodeSize characters long');
    }

    return Address._(addressRaw, addressNet[addressRaw[0]]);
  }

  @override
  String toString() => '${toJson()}';

  static String _pretty(final String address) {
    final buffer = StringBuffer();

    for (int i = 0; i < 6; i++) {
      // ignore: use_string_buffers
      buffer.write(address.substring(i * 6, i * 6 + 6) + '-');
    }
    // ignore: join_return_with_assignment
    buffer.write(address.substring(address.length - 4));
    return buffer.toString();
  }

  Map<String, dynamic> toJson() =>
      {'networkType': networkType, 'address': address};
}

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
    kp.publicKey.Raw = Uint8List.fromList(hex.decode(_publicKey));

    return kp.verify(Uint8List.fromList(hex.decode(data)),
        Uint8List.fromList(hex.decode(signature)));
  }

  Map<String, dynamic> toJson() => {'address': address, 'publicKey': publicKey};
}

class Account {
  Account._(this._publicAccount, this._account);

  /// Create an Account from a given hex private key.
  Account.fromPrivateKey(String shex, int networkType) {
    final k = crypto.NewPrivateKeyFromHexString(shex);
    _account = crypto.NewKeyPair(k, null);
    _publicAccount =
        PublicAccount.fromPublicKey(_account.publicKey.toString(), networkType);
  }

  /// Create an Account from a given networkType.
  Account.random(int networkType) {
    final kp = crypto.NewRandomKeyPair();
    final acc = Account.fromPrivateKey(kp.privateKey.toString(), networkType);
    _publicAccount = acc._publicAccount;
    _account = acc._account;
  }

  PublicAccount _publicAccount;
  crypto.KeyPair _account;

  PublicAccount get publicAccount => _publicAccount;

  crypto.KeyPair get account => _account;

  @override
  String toString() => publicAccount.toString();

  Map<String, dynamic> toJson() =>
      {'publicAccount': publicAccount, 'account': account};

  SignedTransaction sign(Transaction tx) => _signTransactionWith(tx, this);
}

// ignore: public_member_api_docs
class AccountInfo {
  AccountInfo.fromDTO(_AccountInfoDTO v) {
    final List<Mosaic> mList = List(v.account.mosaics.length);
    for (var i = 0; i < v.account.mosaics.length; i++) {
      mList[i] = Mosaic.fromDTO(v.account.mosaics[i]);
    }

    address = Address.fromEncoded(v.account.address);
    addressHeight = v.account.addressHeight.toBigInt();
    publicKey = v.account.publicKey;
    publicKeyHeight = v.account.publicKeyHeight.toBigInt();
    accountType = v.account.accountType;
    linkedAccountKey = v.account.linkedAccountKey;
    mosaics = mList;
  }

  Address address;
  BigInt addressHeight;
  String publicKey;
  BigInt publicKeyHeight;
  List<Mosaic> mosaics;
  int accountType;
  String linkedAccountKey;

  @override
  String toString() => '{\n'
      '\t"address": $address,\n'
      '\t"addressHeight": $addressHeight,\n'
      '\t"publicKey": $publicKey,\n'
      '\t"publicKeyHeight": $publicKeyHeight,\n'
      '\t"accountType": $accountType,\n'
      '\t"linkedAccountKey": $linkedAccountKey,\n'
      '\t"mosaics": $mosaics,\n'
      '}\n';

  Map<String, dynamic> toJson() => {
        'address': address,
        'addressHeight': addressHeight,
        'publicKey': publicKey,
        'publicKeyHeight': publicKeyHeight,
        'accountType': accountType,
        'linkedAccountKey': linkedAccountKey,
        'mosaics': mosaics
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
