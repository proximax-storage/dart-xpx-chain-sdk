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

  /// Create an Address from a given Public key.
  var recipient = new Address.fromPublicKey(
      "68f50e10e5b8be2b7e9ddb687a667d6e94dd55fe02b4aed8195f51f9a242558b",
      networkType);

  final deadline = new Deadline(hours: 1);
  /// Create a new transaction type transfer
  var ttxOne = new TransferTransaction(
    // The maximum amount of time to include the transaction in the blockchain.
      deadline,
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [Xpx(52)],
      // The transaction message of 1024 characters.
      new Message.PlainMessage("From ProximaX Dart SDK UNO"),
      networkType);

  /// Create a new transaction type transfer
  var ttxTwo = new TransferTransaction(
    // The maximum amount of time to include the transaction in the blockchain.
      deadline,
      // The Address of the recipient account.
      recipient,
      // The List of mosaic to be sent.
      [Xpx(28)],
      // The transaction message of 1024 characters.
      new Message.PlainMessage("From ProximaX Dart SDK DOS"),
      networkType);

  ttxOne.ToAggregate(account.publicAccount);
  ttxTwo.ToAggregate(account.publicAccount);

  // Create Aggregate complete transaction.
  var aggregateTransaction = new AggregateTransaction(deadline, [ttxOne, ttxTwo], networkType);

  var stx = account.sign(aggregateTransaction);
  print(stx.payload);

  var restTx = await client.Transaction.AnnounceTransaction(stx);
  print(restTx);
  print("Hash: ${stx.hash}");
  print("Signer: ${account.publicAccount.publicKey}");
}
