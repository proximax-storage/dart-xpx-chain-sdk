part of xpx_chain_sdk.account;

class Account {
  Account._(this.publicAccount, this.account);

  /// Create an Account from a given hex private key.
  static Account fromPrivateKey(String shex, int networkType) {
    final account = crypto.KeyPair.fromHexString(shex);
    final publicAccount =
        PublicAccount.fromPublicKey(account.publicKey.toString(), networkType);
    return Account._(publicAccount, account);
  }

  /// Create an Account from a given networkType.
  static Account random(int networkType) {
    final kp = crypto.KeyPair.fromRandomKeyPair();
    final acc = Account.fromPrivateKey(kp.privateKey.toString(), networkType);
    final publicAccount = acc.publicAccount;
    final account = acc.account;
    return Account._(publicAccount, account);
  }

  PublicAccount publicAccount;
  crypto.KeyPair account;

  String get publicKey => publicAccount.publicKey;

  Address get address => publicAccount.address;

  @override
  String toString() => publicAccount.toString();

  Map<String, dynamic> toJson() =>
      {'publicAccount': publicAccount, 'account': account};

  SignedTransaction sign(Transaction tx, String generationHash) =>
      signTransactionWith(tx, this, generationHash);

  SignedTransaction signWithCosignatures(
          Transaction tx, List<Account> cosignatories, String generationHash) =>
      signTransactionWithCosignatures(tx, this, cosignatories, generationHash);

  CosignatureSignedTransaction signCosignatureTransaction(
          CosignatureTransaction tx) =>
      signCosignatureTransactionRwa(tx, this);
}

class PublicAccount {
  PublicAccount._(this.publicKey, this.address);

  /// Create an Account from a given publicKey hex string.
  static PublicAccount fromPublicKey(String publicKey, int networkType) {
    if (publicKey == null ||
        (publicKeySize != publicKey.length && 66 != publicKey.length)) {
      throw errInvalidPublicKey;
    }
    final address = Address.fromPublicKey(publicKey, networkType);
    return PublicAccount._(publicKey, address);
  }

  String publicKey;
  Address address;

  @override
  String toString() => '${toJson()}';

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

    final kp = crypto.KeyPair();
    kp.publicKey.raw = Uint8List.fromList(hex.decode(publicKey));

    return kp.verify(Uint8List.fromList(hex.decode(data)),
        Uint8List.fromList(hex.decode(signature)));
  }

  Map<String, dynamic> toJson() => {'address': address, 'publicKey': publicKey};
}

class AccountNames {
  AccountNames._(this.address, this.names);

  static AccountNames fromDto(AccountNamesDTO dto) {
    final address = Address.fromEncoded(dto.address);
    final names = (dto._names == null) ? null : dto._names.cast<String>();
    return AccountNames._(address, names);
  }

  /* The address of the account in hexadecimal. */
  Address address;

  /* The mosaic linked namespace names. */
  List<String> names;

  static List<AccountNames> listFromJson(List<AccountNamesDTO> json) =>
      json == null ? <AccountNames>[] : json.map(AccountNames.fromDto).toList();

  @override
  String toString() => '{\n'
      '\taddress: $address,\n'
      '\tnames: $names\n'
      ' }';
}

class AccountInfo {
  AccountInfo.fromDTO(AccountInfoDTO v) {
    final List<Mosaic> mList = List(v._account._mosaics.length);
    for (var i = 0; i < v._account._mosaics.length; i++) {
      mList[i] = Mosaic.fromDTO(v._account._mosaics[i]);
    }

    address = Address.fromEncoded(v._account.address);
    addressHeight = v._account.addressHeight.toUint64();
    publicKey = v._account._publicKey;
    publicKeyHeight = v._account._publicKeyHeight.toUint64();
    accountType = v._account._accountType;
    linkedAccountKey = v._account._linkedAccountKey;
    mosaics = mList;
  }

  Address address;
  Uint64 addressHeight;
  String publicKey;
  Uint64 publicKeyHeight;
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

  static List<AccountInfo> listFromDTO(List<AccountInfoDTO> dto) => dto == null
      ? null
      : dto.map((value) => AccountInfo.fromDTO(value)).toList();
}
