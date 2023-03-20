import 'package:xpx_chain_sdk/src/model/wallet.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  //new wallet with random account
  final wallet = await SimpleWallet.create(
      'sirius_wallet', Password('abcd1234'), NetworkType.PUBLIC_TEST);

  //decrypt wallet with password
  final account = await wallet.open(Password('abcd1234'));

  print('Secret key: ${account.secretKey}');
  print('Public account: ${account.publicAccount}');

  //new wallet with given private key
  final walletFromKey = await SimpleWallet.createFromPrivateKey(
      'sirius_wallet_clone',
      Password('efgh5678'),
      account.secretKey,
      NetworkType.PUBLIC_TEST);

  //decrypt wallet with password
  final same_account = await walletFromKey.open(Password('efgh5678'));

  print('Same Secret key: ${same_account.secretKey}');
  print('Same Public account: ${same_account.publicAccount}');
}
