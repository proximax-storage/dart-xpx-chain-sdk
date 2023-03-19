import 'package:xpx_chain_sdk/src/model/wallet/password.dart';
import 'package:xpx_chain_sdk/src/model/wallet/wallet_algorithm.dart';
import 'package:xpx_chain_sdk/src/model/wallet/wallet_crypto.dart';

class EncryptedPrivateKey {
  late String encryptedKey;
  late String iv;
  EncryptedPrivateKey(this.encryptedKey, this.iv);

  String decrypt(Password password) => WalletCrypto.passwordToPrivateKey(
      password.value, encryptedKey, iv, WalletAlgorithm.passBip32);
}
