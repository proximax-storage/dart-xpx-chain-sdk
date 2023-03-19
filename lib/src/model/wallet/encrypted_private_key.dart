part of xpx_chain_sdk.wallet;

/// EncryptedPrivateKey model

class EncryptedPrivateKey {
  /*
  * Encrypted private key data
  */
  late final String encryptedKey;
  /*
  * Initialization vector used in the decrypt process
  */
  late final String iv;

  /*
  * @internal
  * @param encryptedKey
  * @param iv
  */
  EncryptedPrivateKey(this.encryptedKey, this.iv);

  /*
  * @internal
  * Decrypt an encrypted private key
  * @param password
  */
  String decrypt(Password password) => WalletCrypto.passwordToPrivateKey(
      password.value, encryptedKey, iv, WalletAlgorithm.passBip32);
}
