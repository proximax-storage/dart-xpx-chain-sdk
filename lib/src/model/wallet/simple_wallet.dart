/*
 * Copyright 2023 ProximaX
 * Copyright 2018 NEM
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of xpx_chain_sdk.wallet;

/*
 * Simple wallet model generates a private key from a PRNG
 */
class SimpleWallet extends Wallet {
  /*
  * The encrypted private key and information to decrypt it
  */
  late final EncryptedPrivateKey encryptedPrivateKey;
  /*
     * @internal
     * @param name
     * @param network
     * @param address
     * @param creationDate
     * @param encryptedPrivateKey
     */
  SimpleWallet._(
      String name,
      /**
       * The wallet's network
       */
      NetworkType network,
      /**
       * The wallet's publicAccount
       */
      PublicAccount publicAccount,
      /**
       * The wallet's creation date
       */
      LocalDateTime creationDate,
      /**
       * Wallet schema number
       */
      EncryptedPrivateKey encryptedKey)
      : super(name, network, publicAccount, creationDate, 'simple_v2') {
    encryptedPrivateKey = encryptedKey;
  }

  /*
  * Create a Simple wallet
  * @param name - Wallet name
  * @param password - Password to encrypt wallet
  * @param network - Network id
  * @param {SignSchema} signSchema The Sign Schema. (KECCAK_REVERSED_KEY / SHA3)
  * @returns {SimpleWallet}
  */
  static Future<SimpleWallet> create(
      String name, Password password, NetworkType network) async {
    //create a random account
    final account = await Account.random(network);

    //create public account from public key
    final PublicAccount publicAccount =
        PublicAccount.fromPublicKey(account.publicKey, network);

    // Encrypt private key using password
    final encrypted =
        WalletCrypto.encodePrivateKey(account.secretKey, password.value);

    final encryptedPrivateKey =
        new EncryptedPrivateKey(encrypted['cipherText']!, encrypted['iv']!);

    return new SimpleWallet._(
        name, network, publicAccount, LocalDateTime.now(), encryptedPrivateKey);
  }

  /*
  * Create a SimpleWallet from private key
  * @param name - Wallet name
  * @param password - Password to encrypt wallet
  * @param privateKey - Wallet private key
  * @param network - Network id
  * @param {SignSchema} signSchema The Sign Schema. (KECCAK_REVERSED_KEY / SHA3)
  * @returns {SimpleWallet}
  */
  static Future<SimpleWallet> createFromPrivateKey(String name,
      Password password, String privateKey, NetworkType network) async {
    // Create account from private key

    final account = await Account.fromPrivateKey(privateKey, network);

    // Create publicAccount from public key
    final PublicAccount publicAccount =
        PublicAccount.fromPublicKey(account.publicKey, network);

    // Encrypt private key using password
    final encrypted = WalletCrypto.encodePrivateKey(privateKey, password.value);

    final encryptedPrivateKey =
        new EncryptedPrivateKey(encrypted['cipherText']!, encrypted['iv']!);

    return new SimpleWallet._(
        name, network, publicAccount, LocalDateTime.now(), encryptedPrivateKey);
  }

  /*
  * Create a SimpleWallet from private key
  * @param name - Wallet name
  * @param encryptedPrivateKey - EncryptedPrivateKey
  * @param publicKey - Public Key
  * @param network - Network id
  * @param {SignSchema} signSchema The Sign Schema. (KECCAK_REVERSED_KEY / SHA3)
  * @returns {SimpleWallet}
  */
  @override
  Future<Account> open(Password password) async => await Account.fromPrivateKey(
      encryptedPrivateKey.decrypt(password), network);
}
