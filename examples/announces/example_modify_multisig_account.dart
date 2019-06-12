import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

const networkType = PublicTest;

/// Simple Account API AnnounceTransaction
void main() async {
  var config = new NewConfig(baseUrl, networkType);

  var client = NewClient(config, null);

  /// Create an Account from a given Private key.
  var account = new Account.fromPrivateKey(
      "C7724760A0C4E13723FF2EF491A51534D5EC45AE9A248E52DE52E91E2566ED16",
      networkType);

  print(account);
  final acc1 = new PublicAccount.fromPublicKey("6A3C6BA2975BD0C959F54BD2424CC2150C22F4137E1EFC097BBE768615FC36C7", networkType);
  final acc2 = new PublicAccount.fromPublicKey("5AACF12FC96E5A093F52F53F885B28D42349EF377C6DD857963E2DE9CF1F69D4", networkType);

  /// Create a new transaction type transfer
  var tx = new TransferTransaction(
      // The maximum amount of time to include the transaction in the blockchain.
      new Deadline(hours: 1),
      // The Address of the recipient account.
      acc1.address,
      // The List of mosaic to be sent.
      [XpxRelative(15)],
      // The transaction message of 1024 characters.
      new Message.PlainMessage("From ProximaX Dart SDK"),
      networkType);

  var stx = account.sign(tx);

//  var restTx = await client.Transaction.AnnounceTransaction(stx);
//  print(restTx);
//  print("Hash: ${stx.hash}");
//  print("Signer: ${account.publicAccount.publicKey}");
}
