import 'package:xpx_catapult_sdk/xpx_sdk.dart';

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

  /// The namespace name.
  var parentNamespace = "dartnamespace";

  /// Create a new transaction type RegisterNamespaceTransaction.
  /// type RootNamespace.
  var tx = new RegisterNamespaceTransaction.createRoot(
      // The maximum amount of time to include the transaction in the blockchain.
      new Deadline(hours: 1),
      // The namespace name.
      parentNamespace,
      // The duration of the namespace.
      new BigInt.from(1000),
      // The network type
      networkType);
  var stx = account.sign(tx);

  var restTx = await client.Transaction.AnnounceTransaction(stx);
  print(restTx);
  print("Hash: ${stx.hash}");
  print("Signer: ${account.publicAccount.publicKey}");

  /// Create a new transaction type RegisterNamespaceTransaction.
  /// type SubNamespace.
  var tx2 = new RegisterNamespaceTransaction.createSub(
      new Deadline(hours: 1),
      "ven",
      parentNamespace,
      networkType);
  var stx2 = account.sign(tx2);

  var restTx2 = await client.Transaction.AnnounceTransaction(stx2);
  print(restTx2);
  print("Hash: ${stx2.hash}");
  print("Signer: ${account.publicAccount.publicKey}");
}
