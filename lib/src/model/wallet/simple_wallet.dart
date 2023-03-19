import 'package:convert/convert.dart';
import 'package:time_machine/time_machine.dart';
import 'package:xpx_chain_sdk/src/model/wallet/encrypted_private_key.dart';
import 'package:xpx_chain_sdk/src/model/wallet/password.dart';
import 'package:xpx_chain_sdk/src/model/wallet/sign_schema.dart';
import 'package:xpx_chain_sdk/src/model/wallet/wallet.dart';
import 'package:xpx_chain_sdk/src/model/wallet/wallet_crypto.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';
import 'package:xpx_crypto/xpx_crypto.dart';

class SimpleWallet extends Wallet {
  late final EncryptedPrivateKey encryptedPrivateKey;

  SimpleWallet(
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

  static Future<SimpleWallet> createFromPrivateKey(
      String name, Password password, String privateKey, NetworkType network,
      [SignSchema signSchema = SignSchema.sha3]) async {
    // Create KeyPair from hash key

    final KeyPair kp = await KeyPair.fromPrivateKey(privateKey);

    // Create publicAccount from public key

    final PublicAccount publicAccount =
        PublicAccount.fromPublicKey(hex.encode(kp.publicKey), network);

    // Encrypt private key using password
    final encrypted = WalletCrypto.encodePrivateKey(privateKey, password.value);

    final encryptedPrivateKey =
        new EncryptedPrivateKey(encrypted['cipherText']!, encrypted['iv']!);

    return new SimpleWallet(
        name, network, publicAccount, LocalDateTime.now(), encryptedPrivateKey);
  }

  @override
  Future<Account> open(Password password) async => await Account.fromPrivateKey(
      encryptedPrivateKey.decrypt(password), network);
}
