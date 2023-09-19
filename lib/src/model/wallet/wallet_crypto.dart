part of xpx_chain_sdk.wallet;

class WalletCrypto {
  /*
  * Encrypt hex data using a key
  *
  * @param {string} data - A hex string
  * @param {Uint8List} key - An Uint8List key
  *
  * @return {Map} - The encrypted data
  */
  static Map<String, String> encrypt(String data, Uint8List key) {
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(Key(key)));
    Encrypted encrypted = encrypter.encrypt(data, iv: iv);

    return {
      'cipherText': encrypted.base16,
      'iv': iv.base16,
    };
  }

  /*
  * Encode a private key using a password
  *
  * @param {string} privateKey - A hex private key
  * @param {string} password - A password
  *
  * @return {Map} - The encoded data
  */
  static Map<String, String> encodePrivateKey(
      String privateKey, String password) {
    // Errors

    final pass = WalletCrypto.derivePassSha(password, 20);
    final r = WalletCrypto.encrypt(privateKey, HexUtils.hexToBytes(pass));
    // Result
    return {
      'cipherText': r['cipherText']!,
      'iv': r['iv']!,
    };
  }

  /*
    * Derive a private key from a password using count iterations of SHA3-256
    *
    * @param {string} password - A wallet password
    * @param {number} count - A number of iterations above 0
    *
    * @return {string} - The derived private key
    */
  static String derivePassSha(String password, int count) {
    if (count <= 0) {
      throw new Exception('Please provide a count number above 0');
    }
    // Processing
    SHA3 sha3 = SHA3(256, SHA3_PADDING, 256);
    List<int> wordArray = sha3.update(utf8.encode(password)).s!;
    for (var i = 1; i < count; ++i) {
      wordArray = sha3.update(wordArray).s!;
    }
    var hash = sha3.digest();
    return hex.encode(hash);
  }

  /*
  * Decrypt data
  *
  * @param {Map} data - An encrypted data object
  *
  * @return {string} - The decrypted hex string
  */
  static String decrypt(Map<String, String> data) {
    final encrypter = Encrypter(AES(Key(HexUtils.hexToBytes(data['key']!))));

    return encrypter.decrypt(Encrypted.fromBase16(data['cipherText']!),
        iv: IV.fromBase16(data['iv']!));
  }

  /*
  * Reveal the private key of an account or derive it from the wallet password
  *
  * @param {string} password- A wallet password
  * @param {string} encryptedKey - An encrypted key
  * @param {string} iv - Initialization vector used in the decrypt process
  * @param {WalletAlgorithm} algo - A wallet algorithm
  * @return { string } - The account private key
  */
  static String passwordToPrivateKey(
      String password, String encrypted, String iv, WalletAlgorithm algo) {
    if (algo == WalletAlgorithm.passBip32) {
      // Wallets from PRNG
      String pass = WalletCrypto.derivePassSha(password, 20);
      final data = {'cipherText': encrypted, 'iv': iv, 'key': pass};

      return WalletCrypto.decrypt(data);
    }
    throw Exception('Algorithm not supported');
  }
}
