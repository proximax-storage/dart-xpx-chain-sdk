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

  final deadline = new Deadline(hours: 1);

  /// Create a Mosaic definition transaction.
  var mosaicDefinition = new MosaicDefinitionTransaction(
    // The maximum amount of time to include the transaction in the blockchain.
      new Deadline(hours: 1),
      MosaicNonce(),
      account.publicAccount.publicKey,
      new MosaicProperties(true, true, true, 4, BigInt.from(1000)),
      new BigInt.from(1000),
      // The network type
      networkType);

  /// Create a Mosaic Supply Change transaction.
  var mosaicSupplyChange = new MosaicSupplyChangeTransaction(
    // The maximum amount of time to include the transaction in the blockchain.
      new Deadline(hours: 1),
      Increase,
      mosaicDefinition.mosaicId,
      new BigInt.from(10000),
      // The network type
      networkType);

  mosaicDefinition.ToAggregate(account.publicAccount);
  mosaicSupplyChange.ToAggregate(account.publicAccount);

  // Create Aggregate complete transaction.
  var aggregateTransaction = new AggregateTransaction(deadline, [mosaicDefinition, mosaicSupplyChange], networkType);

  var stx = account.sign(aggregateTransaction);
  print(stx.payload);

  var restTx = await client.Transaction.AnnounceTransaction(stx);
  print(restTx);
  print("Hash: ${stx.hash}");
  print("Signer: ${account.publicAccount.publicKey}");
}
