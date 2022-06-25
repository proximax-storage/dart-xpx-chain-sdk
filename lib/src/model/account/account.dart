/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.account;

class Account {
  Account._(this.publicAccount, this.account);

  /// Create an Account from a given hex private key.
  static Future<Account> fromPrivateKey(String shex, NetworkType networkType) async {
    final account = await crypto.KeyPair.fromPrivateKey(shex);

    final publicKey = ByteUtils.bytesToHex(account.publicKey.toList());

    final publicAccount = PublicAccount.fromPublicKey(publicKey, networkType);
    return Account._(publicAccount, account);
  }

  /// Create an Account from a given networkType.
  static Future<Account> random(NetworkType networkType) async {
    final kp = await crypto.KeyPair.random();
    final acc = await Account.fromPrivateKey(ByteUtils.bytesToHex(kp.secretKey), networkType);
    final publicAccount = acc.publicAccount;
    final account = acc.account;
    return Account._(publicAccount, account);
  }

  /// Creates an encrypted message from this account to the [recipientPublicAccount].
  Future<EncryptedMessage> encryptMessage(String plainTextMessage, PublicAccount recipientPublicAccount) async =>
      EncryptedMessage.create(plainTextMessage, ByteUtils.bytesToHex(account.secretKey),
          recipientPublicAccount.publicKey, HexUtils.isHex(plainTextMessage));

  /// Decrypts an encrypted message received by this account from [senderPublicAccount].
  Future<PlainMessage> decryptMessage(EncryptedMessage encryptedMessage, PublicAccount senderPublicAccount,
          [isHexMessage = false]) async =>
      EncryptedMessage.decrypt(
          encryptedMessage, ByteUtils.bytesToHex(account.secretKey), senderPublicAccount.publicKey, isHexMessage);

  PublicAccount publicAccount;
  crypto.KeyPair account;

  String get secretKey => hex.encode(account.secretKey);

  String get publicKey => publicAccount.publicKey;

  Address get address => publicAccount.address;

  NetworkType get networkType => address.networkType;

  @override
  String toString() => publicAccount.toString();

  Map<String, dynamic> toJson() => {'publicAccount': publicAccount, 'account': account};

  /// Signs raw data.
  Future<String> signData(String rawData) async {
    final String hex = HexUtils.utf8ToHex(rawData);
    final Uint8List data = HexUtils.hexToBytes(hex);
    final signedData = await account.sign(data);
    return ByteUtils.bytesToHex(signedData.bytes);
  }

  Future<SignedTransaction> signTransaction(Transaction tx, String generationHash) async =>
      signTransactionWith(tx, this, generationHash);

  Future<SignedTransaction> signWithCosignatures(
          Transaction tx, List<Account> cosignatories, String generationHash) async =>
      signTransactionWithCosignatures(tx, this, cosignatories, generationHash);

  Future<CosignatureSignedTransaction> signCosignatureTransaction(CosignatureTransaction tx) async =>
      signCosignatureTransactionRwa(tx, this);
}
