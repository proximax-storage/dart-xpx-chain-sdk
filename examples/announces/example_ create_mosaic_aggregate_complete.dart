import 'package:xpx_chain_sdk/xpx_sdk.dart';

const baseUrl = "http://bctestnet1.xpxsirius.io:3000";

const networkType = PublicTest;

/// Simple Account API AnnounceTransaction
void main() async {
  var config = new NewConfig(baseUrl, networkType);

  var client = NewClient(config, null);

  /// Create an Account from a given Private key.
  var account = new Account.fromPrivateKey(
      "1ACE45EAD3C2F0811D9F4355F35BF78483324975083BE4E503EA49DFFEA691A0",
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
